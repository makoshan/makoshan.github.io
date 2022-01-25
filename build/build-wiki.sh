#!/bin/bash

# sync-gwern.net.sh: shell script which automates a full build and sync of Gwern.net. A simple build can be done using 'runhaskell hakyll.hs build', but that is slow, semi-error-prone (did you remember to delete all intermediates?), and does no sanity checks or optimizations like compiling the MathJax to static CSS/fonts (avoiding multi-second JS delays).
#
# This script automates all of that: it cleans up, compiles a hakyll binary for faster compilation, generates a sitemap XML file, optimizes the MathJax use, checks for many kinds of errors, uploads, and cleans up.
#
# Author: Gwern Branwen
# Date: 2016-10-01
# When:  Time-stamp: "2019-09-15 14:38:14 gwern"
# License: CC-0

bold() { echo -e "\033[1m$@\033[0m"; }
red() { echo -e "\e[41m$@\e[0m"; }
## function to wrap checks and print red-highlighted warning if non-zero output (self-documenting):
wrap() { OUTPUT=$($1 2>&1)
         WARN="$2"
         if [ -n "$OUTPUT" ]; then
             red "$WARN";
             echo -e "$OUTPUT";
         fi; }

# key dependencies: GHC, Hakyll, s3cmd, emacs, curl, tidy (HTML5 version), urlencode ('gridsite-clients' package), linkchecker, fdupes, ImageMagick, exiftool, mathjax-node-page (eg `npm i -g mathjax-node-page`), parallel, xargs, php7…

if ! [[ -n $(command -v ghc) && -n $(command -v git) && -n $(command -v rsync) && -n $(command -v curl) && -n $(command -v ping) && \
          -n $(command -v tidy) && -n $(command -v linkchecker) && -n $(command -v du) && -n $(command -v rm) && -n $(command -v find) && \
          -n $(command -v fdupes) && -n $(command -v urlencode) && -n $(command -v sed) && -n $(command -v parallel) && -n $(command -v xargs) && \
          -n $(command -v file) && -n $(command -v exiftool) && -n $(command -v identify) && -n $(command -v pdftotext) && \
          -n $(command -v /home/firday/.npm-global/lib/node_modules/mathjax-node-page/bin/mjpage) && -n $(command -v ./link-extractor.hs) && \
          -n $(command -v ./anchor-checker.php) && -n $(command -v php) && -n $(command -v ./generateDirectory.hs) && \
          -n $(command -v ./generateBacklinks.hs) ]] && \
       [ -z "$(pgrep hakyll)" ];
then
    red "Dependencies missing or Hakyll already running?"
else
    set -e


    ## Update the directory listing index pages: there are a number of directories we want to avoid, like the various mirrors or JS projects, or directories just of data like CSVs, or dumps of docs, so we'll use a whitelist of directories which have files which may have decent annotations & be worth browsing:
    ## stack ghc --package base --package bytestring --package containers --package text --package directory --package pandoc --package MissingH --package aeson --package tagsoup --package arxiv --package hakyll --package filestore --package utf8-string --package temporary --package HTTP --package network-uri --package pandoc-types --package filepath --package split --package http-conduit --package pretty-show --resolver lts-18.3 hakyll.hs
    bold "Building directory indexes…"
    (./generateDirectory docs/ ) # &

    bold "Updating annotations..."
   ## (stack ghc --package base --package bytestring --package containers --package text --package directory --package pandoc --package MissingH --package aeson --package tagsoup --package arxiv --package hakyll --package filestore --package utf8-string --package temporary --package HTTP --package network-uri --package pandoc-types --package filepath --package split --package http-conduit --package pretty-show --resolver lts-18.3 hakyll.hs -e 'do { md <- readLinkMetadata; am <- readArchiveMetadata; writeAnnotationFragments am md; }' &> /dev/null) # &

##    bold "Updating backlinks..."
##    find . -name "*.page" -or -wholename "./metadata/annotations/*.html" | egrep -v -e '/index.page' -e '_site/' -e './metadata/annotations/backlinks/' | sort | ./generateBacklinks
    bold "Check/update VCS…"

    bold "Building Hakyll…"
    # Build:
    ## Gwern.net is big and Hakyll+Pandoc is slow, so it's worth the hassle of compiling:
    ## ghc -tmpdir /tmp/ -Wall -rtsopts -threaded --make hakyll.hs
    cd ./static/build/
    ## stack ghc --package base --package bytestring --package containers --package text --package directory --package pandoc --package MissingH --package aeson --package tagsoup --package arxiv --package hakyll --package filestore --package utf8-string --package temporary --package HTTP --package network-uri --package pandoc-types --package filepath --package split --package http-conduit --package pretty-show --resolver lts-18.3 hakyll.hs
    ## Parallelization:
    N="$(if [ ${#} == 0 ]; then echo 16; else echo "$1"; fi)"
    cd ../../ # go to site root
    bold "Building site…"
    ## ./hakyll build +RTS -N"$N" -RTS || (red "Hakyll errored out!"; exit 1)
    ## stack ghc --package base --package bytestring --package containers --package text --package directory --package pandoc --package MissingH --package aeson --package tagsoup --package arxiv --package hakyll --package filestore --package utf8-string --package temporary --package HTTP --package network-uri --package pandoc-types --package filepath --package split --package http-conduit --package pretty-show --resolver lts-18.3 hakyll.hs
    ./hakyll build
    # cleanup post: (note that if Hakyll crashes and we exit in the previous line, the compiled Hakyll binary & intermediates hang around for faster recovery)
    # rm --recursive --force -- ./static/build/hakyll ./static/build/*.o ./static/build/*.hi || true

    ## WARNING: this is a crazy hack to insert a horizontal rule 'in between' the first 3 sections on /index (Newest/Popular/Notable), and the rest (starting with Statistics); the CSS for making the rule a block dividing the two halves just doesn't work in any other way, but Pandoc Markdown doesn't let you write stuff 'in between' sections, either. So… a hack.


    bold "Building sitemap.xml…"
    ## generate a sitemap file for search engines:
    ## possible alternative implementation in hakyll: https://www.rohanjain.in/hakyll-sitemap/
    (echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">"
     ## very static files which rarely change: PDFs, images, site infrastructure:
     find -L _site/docs/ _site/images/ _site/static/ -not -name "*.page" -type f | fgrep --invert-match -e 'docs/www/' -e 'metadata/' -e '.git' | \
         sort | xargs urlencode -m | sed -e 's/%20/\n/g' | \
         sed -e 's/_site\/\(.*\)/\<url\>\<loc\>https:\/\/www\.gwern\.net\/\1<\/loc><changefreq>never<\/changefreq><\/url>/'
     ## Everything else changes once in a while:
     find -L _site/ -not -name "*.page" -type f | fgrep --invert-match -e 'static/' -e 'docs/' -e 'images/' -e 'Fulltext' -e 'metadata/' -e '-768px.' | \
         sort | xargs urlencode -m | sed -e 's/%20/\n/g' | \
         sed -e 's/_site\/\(.*\)/\<url\>\<loc\>https:\/\/www\.gwern\.net\/\1<\/loc><changefreq>monthly<\/changefreq><\/url>/'
     echo "</urlset>") >> ./_site/sitemap.xml

    # 1. turn "As per Foo et al 2020, we can see." → "<p>As per Foo et al 2020, we can see.</p>" (&nbsp;); likewise for 'Foo 2020' or 'Foo & Bar 2020'
    # 2. add non-breaking character to punctuation after links to avoid issues with links like '[Foo](/bar);' where ';' gets broken onto the next line (this doesn't happen in regular text, but only after links, so I guess browsers have that builtin but only for regular text handling?), (U+2060 WORD JOINER (HTML &#8288; · &NoBreak; · WJ))
    # 3. add thin space ( U+2009   THIN SPACE (HTML &#8201; · &thinsp;, &ThinSpace;)) in slash-separated links or quotes, to avoid overlap of '/' with curly-quote
    bold "Adding non-breaking spaces…"
    nonbreakSpace () { sed -i -e 's/\([a-zA-Z]\) et al \([1-2]\)/\1 et al \2/g' \
                              -e 's/\([A-Z][a-zA-Z]\+\) \([1-2]\)/\1 \2/g' \
                              -e 's/\([A-Z][a-zA-Z]\+\) \&amp\; \([A-Z][a-zA-Z]\+\) \([1-2]\)/\1 \&amp\;_\2 \3/g' \
                              -e 's/<\/a>;/<\/a>\⁠;/g' -e 's/<\/a>,/<\/a>\⁠,/g' -e 's/<\/a>\./<\/a>\⁠./g' -e 's/<\/a>\//<\/a>\⁠\//g' \
                              -e 's/\/<wbr><a /\/ <a /g' -e 's/\/<wbr>"/\/ "/g' \
                            "$@"; }; export -f nonbreakSpace;
    find ./ -path ./_site -prune -type f -o -name "*.page" | sort | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/' | parallel --max-args=100 nonbreakSpace || true
    find ./_site/metadata/annotations/ -type f -name "*.html" | sort | parallel --max-args=100 nonbreakSpace || true

    ## generate a syntax-highlighted HTML fragment (not whole standalone page) version of source code files for popup usage:
    ### We skip .json/.jsonl/.csv because they are too large & Pandoc will choke;
    bold "Generating syntax-highlighted versions of source code files…"
    syntaxHighlight() {
        declare -A extensionToLanguage=( ["R"]="R" ["c"]="C" ["py"]="Python" ["css"]="CSS" ["hs"]="Haskell" ["js"]="Javascript" ["patch"]="Diff" ["diff"]="Diff" ["sh"]="Bash" ["html"]="HTML" ["conf"]="Bash" ["php"]="PHP" ["opml"]="Xml" ["xml"]="Xml" )
        for FILE in "$@"; do
            FILENAME=$(basename -- "$FILE")
            EXTENSION="${FILENAME##*.}"
            LANGUAGE=${extensionToLanguage[$EXTENSION]}
            (echo -e "~~~{.$LANGUAGE}"; cat $FILE; echo -e "\n~~~") | pandoc -w html >> $FILE.html
        done
    }
    export -f syntaxHighlight
    set +e
    find _site/static/ -type f,l -name "*.html" | sort | parallel syntaxHighlight # NOTE: run .html first to avoid duplicate files like 'foo.js.html.html'
    find _site/ -type f,l -name "*.R" -or -name "*.css" -or -name "*.hs" -or -name "*.js" -or -name "*.patch" -or -name "*.sh" -or -name "*.php" -or -name "*.conf" -or -name "*.opml" | sort | fgrep -v -e 'mountimprobable.com/assets/app.js' -e 'jquery.min.js' -e 'static/js/tablesorter.js' -e 'metadata/backlinks.hs' -e 'metadata/archive.hs' | parallel syntaxHighlight &
        # Pandoc fails on embedded Unicode/regexps in JQuery
    set -e

    ## use https://github.com/pkra/mathjax-node-page/ to statically compile the MathJax rendering of the MathML to display math instantly on page load
    ## background: https://joashc.github.io/posts/2015-09-14-prerender-mathjax.html ; installation: `npm install --prefix ~/src/ mathjax-node-page`
    bold "Compiling LaTeX HTML into static CSS…"
    staticCompileMathJax () {
        if [[ $(fgrep -e '<span class="math inline"' -e '<span class="math display"' "$@") ]]; then
            TARGET=$(mktemp /tmp/XXXXXXX.html)
            cat "$@" | nice ~/src/node_modules/mathjax-node-page/bin/mjpage --output CommonHTML --fontURL '/static/font/mathjax' | \
            ## WARNING: experimental CSS optimization: can't figure out where MathJax generates its CSS which is compiled,
            ## but it potentially blocks rendering without a 'font-display: swap;' parameter (which is perfectly safe since the user won't see any math early on)
                sed -e 's/^\@font-face {/\@font-face {font-display: swap; /' >> "$TARGET";

            if [[ -s "$TARGET" ]]; then
                mv "$TARGET" "$@" && echo "$@ succeeded";
            else red "$@ failed MathJax compilation";
            fi
        fi
    }
    export -f staticCompileMathJax
    (find ./ -path ./_site -prune -type f -o -name "*.page" | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/'; find _site/metadata/annotations/ -name '*.html') | shuf | parallel --jobs 32 --max-args=1 staticCompileMathJax

    # Testing compilation results:
    set +e

    λ(){ VISIBLE_N=$(cat ./_site/sitemap.xml | wc --lines); [ "$VISIBLE_N" -le 13040 ] && echo "$VISIBLE_N" && exit 1; }
    wrap λ "Sanity-check number-of-public-site-files in sitemap.xml failed"

    λ(){ COMPILED_N="$(find -L ./_site/ -type f | wc --lines)"
         [ "$COMPILED_N" -le 21000 ] && echo "File count: $COMPILED_N" && exit 1;
         COMPILED_BYTES="$(du --summarize --total --dereference --bytes ./_site/ | tail --lines=1 | cut --field=1)"
         [ "$COMPILED_BYTES" -le 41000000000 ] && echo "Total filesize: $COMPILED_BYTES" && exit 1; }
    wrap λ "Sanity-check: number of files & file-size"

    λ(){ fgrep --color=always '\\' ./static/css/*.css; }
    wrap λ "Warning: stray backslashes in CSS‽ (Dangerous interaction with minification!)"

    λ(){ find ./ -type f -name "*.page" | fgrep --invert-match '_site' | sort | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/'  | parallel --max-args=100 fgrep --with-filename --color=always -e '!Wikipedia' -e '!Margin:'; }
    wrap λ "Stray interwiki links"

    λ(){ PAGES=$(find ./ -type f -name "*.page" | fgrep --invert-match '_site' | sort | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/')
       for PAGE in $PAGES; do fgrep --color=always -e '<span class="smallcaps-auto"><span class="smallcaps-auto">' "$PAGE"; done; }
    wrap λ "Smallcaps-auto regression"

    λ(){ PAGES="$(find ./ -type f -name "*.page" | fgrep --invert-match '_site' | sort | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/') $(find _site/metadata/annotations/ -type f -name '*.html' | sort)"
         echo "$PAGES" | xargs fgrep -l --color=always -e '<span class="math inline">' -e '<span class="math display">' -e '<span class="mjpage">' | \
                                     fgrep --invert-match -e '/docs/cs/1955-nash' -e '/Backstop' -e '/Death-Note-Anonymity' -e '/Differences' \
                                                          -e '/Lorem' -e '/Modus' -e '/Order-statistics' -e '/Conscientiousness-and-online-education' \
                                -e 'docs%2Fmath%2F2001-borwein.pdf' -e 'statistical_paradises_and_paradoxes.pdf' -e '1959-shannon.pdf' \
             -e '/The-Existential-Risk-of-Mathematical-Error' -e '/Replication' \
             -e '%2Fperformance-pay-nobel.html' -e '/docs/cs/index' -e '/docs/math/index' -e '/Coin-flip' \
             -e '/nootropics/Magnesium';
       }
    wrap λ "Warning: unauthorized LaTeX users"

    λ(){ find ./ -type f -name "*.page" -type f -exec egrep --color=always -e 'cssExtension: [a-c,e-z]' {} \; ; }
    wrap λ "Incorrect drop caps"

    λ(){ find -L . -type f -size 0  -printf 'Empty file: %p %s\n' | fgrep -v '.git/FETCH_HEAD'; }
    wrap λ "Empty files"

    λ(){ find ./_site/ -type f -not -name "*.*" -exec grep --quiet --binary-files=without-match . {} \; -print0 | parallel --null --max-args=100 "fgrep --color=always --with-filename -- '————–'"; }
    wrap λ "Broken table"

    λ(){ find ./ -type f -name "*.page" | fgrep --invert-match '_site' | sort | sed -e 's/\.page$//' -e 's/\.\/\(.*\)/_site\/\1/'  | parallel --max-args=100 "fgrep --with-filename -- '<span class=\"er\">'" | fgrep -v '<span class="er">foo!'; } # NOTE: filtered out Lorem.page's deliberate CSS test-case use of it
    wrap λ "Broken code"

    λ(){ egrep --color=always -e '<div class="admonition .*">[^$]' -e '<div class="epigrah">' **/*.page; }
    wrap λ "Broken admonition paragraph or epigraph."

    λ(){ egrep --color=always '^"~/' ./static/redirects/nginx.conf; }
    wrap λ "Warning: tilde-less Nginx redirect rule (dangerous—matches anywhere in URL!)"

    λ(){ egrep --color=always -e '[a-zA-Z]- ' -e 'PsycInfo Database Record' -e 'https://wiki.v2eth.com' -e '/home/gwern/' -- ./metadata/*.yaml; }
    wrap λ "Check possible typo in YAML metadata database"

    λ(){ fgrep --color=always -e '**' -e 'amp#' -- ./metadata/custom.yaml;
         egrep -e ',[A-Za-z]' -- ./metadata/custom.yaml | fgrep -v -e 'N,N-DMT' -e 'E,Z-nepetalactone';
         egrep --color=always -e '^- - /doc/.*' -e '^  -  ' -e "\. '$" -e '[a-zA-Z]\.[0-9]+ [A-Z]' \
               -e 'href="[a-ce-gi-ln-zA-Z]' -e '>\.\.[a-zA-Z]' -e '\]\([0-9]' -- ./metadata/*.yaml;
         fgrep --color=always -e ']{.smallcaps-auto}' -e ']{.smallcaps}' -e 'id="cb1"' -e '<dd>' -e '<dl>' \
               -e '&lgt;/a>' -e '</a&gt;' -e '&lgt;/p>' -e '</p&gt;' -e '<i><i' -e '</e>' \
               -e '<abstract' -e '<em<' -e '<center' -e '<p/>' -e '</o>' -e '< sub>' -e '< /i>' \
               -e '</i></i>' -e '<i><i>' -e 'font-style:italic' -e '<p><p>' -e '</p></p>' -e 'fnref' \
               -e '<figure class="invertible">' -e '</a<' -e 'href="%5Bhttps' -e '<jats:inline-graphic' \
               -e '<figure-inline' -e '<small></small>' -e '<inline-formula' -e '<inline-graphic' -e '<ahref='  \
               -e '](/' -e '-, ' -e '<abstract abstract-type="' -e 'thumb|' -e ' - 20[0-9][0-9]:[0-9][0-9]:[0-9][0-9]' \
               -e '<sec ' -e '<list' -e '</list>' -e '<wb<em>r</em>' -e '<abb<em>' -e '<ext-link' -e '<title>' -e '</title>' \
               -e ' {{' -e '<<' -e '[Formula: see text]' -e '<p><img' -e '<p> <img' -e '- - /./' -e '[Keyword' -e '[KEYWORD' \
               -e '[Key word' -e '<strong>[Keywords:' -e 'href="$"' -e 'en.m.wikipedia.org' -e '<em>Figure' \
               -e '<strongfigure' -e ' ,' -e ' ,' -e 'href="Wikipedia"' -e 'href="(' -e '>/em>' -e '<figure>[' \
               -e '<figcaption></figcaption>' -e '&Ouml;' -e '&uuml;' -e '&amp;gt;' -e '&amp;lt;' -e '&amp;ge;' -e '&amp;le;' \
               -e '<ul class="columns"' -e '<ol class="columns"' -e ',/div>' -e '](https://' -e ' the the ' \
               -e 'Ꜳ' -e 'ꜳ'  -e 'ꬱ' -e 'Ꜵ' -e 'ꜵ' -e 'Ꜷ' -e 'ꜷ' -e 'Ꜹ' -e 'ꜹ' -e 'Ꜻ' -e 'ꜻ' -e 'Ꜽ' -e 'ꜽ' \
               -e '🙰' -e 'ꭁ' -e 'ﬀ' -e 'ﬃ' -e 'ﬄ' -e 'ﬁ' -e 'ﬂ' -e 'ﬅ' -e 'ﬆ ' -e 'ᵫ' -e 'ꭣ' -e ']9h' -e ']9/' \
               -e ']https' -- ./metadata/*.yaml; }
    wrap λ "Check possible syntax errors in YAML metadata database"

    λ(){ egrep --color=always -v '^- - ' -- ./metadata/*.yaml | fgrep --color=always -e ' -- ' -e '---'; }
    wrap λ "Markdown hyphen problems in YAML metadata database"

    λ(){ egrep --color=always -e '^- - https://en\.wikipedia\.org/wiki/' -- ./metadata/*.yaml; }
    wrap λ "Wikipedia annotations in YAML metadata database, but will be ignored by popups! Override with non-WP URL?"

    λ(){ egrep --color=always -e '^- - /[12][0-9][0-9]-[a-z]\.pdf$' -- ./metadata/*.yaml; }
    wrap λ "Wrong filepaths in YAML metadata database—missing prefix?"

    λ(){ fgrep --color=always -e 'backlinks/' -e 'metadata/annotations/' -- ./metadata/backlinks.hs; }
    wrap λ "Bad paths in backlinks databases: metadata paths are being annotated when they should not be!"

    λ(){ egrep --color=always -e '[0-9]*[02456789]th' -e '[0-9]*[3]rd' -e '[0-9]*[2]nd' -e '[0-9]*[1]st'  -- ./metadata/*.yaml | \
             fgrep -v -e '%' -e figure -e http -e '- - /' -e "- - ! '" -e 'src=' -e "- - '#"; }
    wrap λ "Missing superscripts in YAML metadata database"

    λ(){ egrep --color=always -e '<p><img ' -e '<img src="http' -e '<img src="[^h/].*"'  ./metadata/*.yaml; }
    wrap λ "Check <figure> vs <img> usage, image hotlinking, non-absolute relative image paths in YAML metadata database"

    λ(){ fgrep --color=always -e ' significant'  ./metadata/custom.yaml; }
    wrap λ "Misleading language in custom.yaml"

    λ() {
        set +e;
        IFS=$(echo -en "\n\b");
        PAGES="$(find . -type f -name "*.page" | fgrep -v -e '_site/' -e 'index' | sort -u)"
        OTHERS="$(find ./_site/tags/ -type f | sed -e 's/\.\/_site//'; find metadata/annotations/ -maxdepth 1 -name "*.html"; echo index)"
        for PAGE in $PAGES $OTHERS ./static/404.html; do
            HTML="${PAGE%.page}"
            TIDY=$(tidy -quiet -errors --doctype html5 ./_site/"$HTML" 2>&1 >/dev/null | \
                       fgrep --invert-match -e '<link> proprietary attribute ' -e 'Warning: trimming empty <span>' \
                             -e "Error: missing quote mark for attribute value" -e 'Warning: <img> proprietary attribute "loading"' \
                             -e 'Warning: <svg> proprietary attribute "alt"' -e 'Warning: <source> proprietary attribute "alt"' \
                             -e 'Warning: missing <!DOCTYPE> declaration' -e 'Warning: inserting implicit <body>' \
                             -e "Warning: inserting missing 'title' element" -e 'Warning: <img> proprietary attribute "decoding"' )
            if [[ -n $TIDY ]]; then echo -e "\n\e[31m$PAGE\e[0m:\n$TIDY"; fi
        done
        ## anchor-checker.php doesn't work on HTML fragments, like the metadata annotations, and those rarely ever have within-fragment anchor links anyway, so skip those:
        for PAGE in $PAGES ./static/404.html; do
            HTML="${PAGE%.page}"
            ANCHOR=$(./anchor-checker.php ./_site/"$HTML")
            if [[ -n $ANCHOR ]]; then echo -e "\n\e[31m$PAGE\e[0m:\n$ANCHOR"; fi
        done;
        set -e; }
    wrap λ "Markdown→HTML pages don't validate as HTML5"

    ## Is the Internet up?
    ping -q -c 5 baidu.com  &> /dev/null

    # Sync:
    ## make sure nginx user can list all directories (x) and read all files (r)
    chmod a+x $(find ~/wiki/ -type d)
    chmod --recursive a+r ~/wiki/*

    λ(){ find . -xtype l -printf 'Broken symbolic link: %p\n'; }
    wrap λ "Broken symbolic links"

    ## set -e
    ## ping -q -c5 baidu.com
    ## sync to Hetzner server: (`--size-only` because Hakyll rebuilds mean that timestamps will always be different, forcing a slower rsync)
    ## If any links are symbolic links (such as to make the build smaller/faster), we make rsync follow the symbolic link (as if it were a hard link) and copy the file using `--copy-links`.
    ## NOTE: we skip time/size syncs because sometimes the infrastructure changes values but not file size, and it's confusing when JS/CSS doesn't get updated; since the infrastructure is so small (compared to eg docs/*), just force a hash-based sync every time:
    ## bold "Syncing static/…"
   ## rsync --exclude=".*" --chmod='a+r' --recursive --checksum --copy-links --verbose --itemize-changes --stats ./static/ gwern@78.46.86.149:"/home/gwern/gwern.net/static"
    ## Likewise, force checks of the Markdown pages but skip symlinks (ie non-generated files):
    ## bold "Syncing pages…"
   ## rsync --exclude=".*" --chmod='a+r' --recursive --checksum --quiet --info=skip0 ./_site/  gwern@78.46.86.149:"/home/gwern/gwern.net"
    ## Randomize sync type—usually, fast, but occasionally do a regular slow hash-based rsync which deletes old files:
    ## bold "Syncing everything else…"
   ## SPEED=""; if ((RANDOM % 100 < 99)); then SPEED="--size-only"; else SPEED="--delete --checksum"; fi;
   ##  rsync --exclude=".*" --chmod='a+r' --recursive $SPEED --copy-links --verbose --itemize-changes --stats ./_site/  gwern@78.46.86.149:"/home/gwern/gwern.net"
   ## set +e

    # bold "Expiring ≤100 updated files…"
    # # expire CloudFlare cache to avoid hassle of manual expiration: (if more than 100, we've probably done some sort of major systemic change & better to flush whole cache or otherwise investigate manually)
    # EXPIRE="$(find . -type f -mtime -1 -not -wholename "*/\.*/*" -not -wholename "*/_*/*" | fgrep -v 'images/thumbnails/' | sed -e 's/\.page$//' -e 's/^\.\/\(.*\)$/https:\/\/wiki\.v2eth\.com\/\1/' | sort | head -100) https://wiki.v2eth.com/sitemap.xml https://wiki.v2eth.com/index"
    # for URL in $EXPIRE; do
    #     echo -n "Expiring: $URL "
    #     ( curl --silent --request POST "https://api.cloudflare.com/client/v4/zones/57d8c26bc34c5cfa11749f1226e5da69/purge_cache" \
    #         --header "X-Auth-Email:gwern@gwern.net" \
    #         --header "Authorization: Bearer $CLOUDFLARE_CACHE_TOKEN" \
    #         --header "Content-Type: application/json" \
    #         --data "{\"files\":[\"$URL\"]}" > /dev/null; ) &
    # done
    # echo

    # # test a random page modified in the past month for W3 validation & dead-link/anchor errors (HTML tidy misses some, it seems, and the W3 validator is difficult to install locally):
    # CHECK_RANDOM=$(find . -type f -mtime -31 -name "*.page" | sed -e 's/\.page$//' -e 's/^\.\/\(.*\)$/https:\/\/www\.gwern\.net\/\1/' \
    #                    | shuf | head -1 | xargs urlencode)
    # ( curl --silent --request POST "https://api.cloudflare.com/client/v4/zones/57d8c26bc34c5cfa11749f1226e5da69/purge_cache" \
    #         --header "X-Auth-Email:gwern@gwern.net" \
    #         --header "Authorization: Bearer $CLOUDFLARE_CACHE_TOKEN" \
    #         --header "Content-Type: application/json" \
    #         --data "{\"files\":[\"$CHECK_RANDOM\"]}" > /dev/null; )
    # # wait a bit for the CF cache to expire so it can refill with the latest version to be checked:
    # (sleep 20s && $X_BROWSER "https://validator.w3.org/nu/?doc=$CHECK_RANDOM"; $X_BROWSER "https://validator.w3.org/checklink?uri=$CHECK_RANDOM"; )

    # Testing post-sync:
    bold "Checking MIME types, redirects, content…"
    c() { curl --compressed --silent --output /dev/null --head "$@"; }
    λ(){ cr() { [[ "$2" != $(c --location --write-out '%{url_effective}' "$1") ]] && echo "$1" "$2"; }
 }
    wrap λ "Check that some redirects go where they should"
    λ() { cm() { [[ "$1" != $(c --write-out '%{content_type}' "$2") ]] && echo "$1" "$2"; }
          ### check key pages:
          ## check every possible extension:
          ## check some random ones:
          cm "application/epub+zip" 'https://wiki.v2eth.com/docs/eva/2002-takeda-notenkimemoirs.epub'
          cm "application/font-sfnt" 'https://wiki.v2eth.com/static/font/drop-cap/kanzlei/Kanzlei-Initialen-M.ttf'
          cm "application/javascript" 'https://wiki.v2eth.com/docs/statistics/order/beanmachine-multistage/script.js'
          cm "application/javascript" 'https://wiki.v2eth.com/static/js/rewrite.js'
          cm "application/javascript" 'https://wiki.v2eth.com/static/js/sidenotes.js'
          cm "application/json" 'https://wiki.v2eth.com/docs/touhou/2013-c84-downloads.json'
          cm "application/msaccess" 'https://wiki.v2eth.com/docs/touhou/2013-06-08-acircle-tohoarrange.mdb'
          cm "application/msword" 'https://wiki.v2eth.com/docs/iq/2014-tenijenhuis-supplement.doc'
          cm "application/octet-stream" 'https://wiki.v2eth.com/docs/zeo/firmware-v2.6.3R-zeo.img'
          cm "application/pdf" 'https://wiki.v2eth.com/docs/cs/2010-bates.pdf'
          cm "application/pdf" 'https://wiki.v2eth.com/docs/history/1694-gregory.pdf'
          cm "application/vnd.ms-excel" 'https://wiki.v2eth.com/docs/dnb/2012-05-30-kundu-dnbrapm.xls'
          cm "application/vnd.oasis.opendocument.spreadsheet" 'https://wiki.v2eth.com/docs/genetics/heritable/1980-osborne-twinsblackandwhite-appendix.ods'
          cm "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" 'https://wiki.v2eth.com/docs/cs/2010-nordhaus-nordhaus2007twocenturiesofproductivitygrowthincomputing-appendix.xlsx'
          cm "application/vnd.openxmlformats-officedocument.wordprocessingml.document" 'https://wiki.v2eth.com/docs/genetics/heritable/2015-mosing-supplement.docx'
          cm "application/vnd.rn-realmedia" 'https://wiki.v2eth.com/docs/rotten.com/library/bio/crime/serial-killers/elmer-wayne-henley/areyouguilty.rm'
          cm "application/x-maff" 'https://wiki.v2eth.com/docs/eva/2001-pulpmag-hernandez-2.html.maff'
          cm "application/x-shockwave-flash" 'https://wiki.v2eth.com/docs/rotten.com/library/bio/entertainers/comic/patton-oswalt/patton.swf'
          cm "application/x-tar" 'https://wiki.v2eth.com/docs/dnb/2011-zhong.tar'
          cm "application/x-xz" 'https://wiki.v2eth.com/docs/personal/2013-09-25-gwern-googlealertsemails.tar.xz'
          cm "application/zip" 'https://wiki.v2eth.com/docs/statistics/bayes/2014-tenan-supplement.zip'
          cm "audio/mpeg" 'https://wiki.v2eth.com/docs/history/1969-schirra-apollo11flighttothemoon.mp3'
          cm "audio/wav" 'https://wiki.v2eth.com/docs/rotten.com/library/bio/entertainers/comic/david-letterman/letterman_any_sense.wav'
          cm "image/gif" 'https://wiki.v2eth.com/docs/gwern.net-gitstats/arrow-none.gif'
          cm "image/gif" 'https://wiki.v2eth.com/docs/rotten.com/library/religion/creationism/creationism6.GIF'
          cm "image/jpeg" 'https://wiki.v2eth.com/docs/personal/2011-gwern-yourmorals.org/schwartz_process.php_files/schwartz_graph.jpg'
          cm "image/jpeg" 'https://wiki.v2eth.com/docs/rotten.com/library/bio/pornographers/al-goldstein/goldstein-fuck-you.jpeg'
          cm "image/jpeg" 'https://wiki.v2eth.com/docs/rotten.com/library/religion/heresy/circumcellions/circumcellions-augustine.JPG'
          cm "image/png" 'https://wiki.v2eth.com/docs/statistics/order/beanmachine-multistage/beanmachine-demo.png'
          cm "image/png" 'https://wiki.v2eth.com/static/img/logo/logo.png'
          cm "image/svg+xml" 'https://wiki.v2eth.com/images/spacedrepetition/forgetting-curves.svg'
          cm "image/x-icon" 'https://wiki.v2eth.com/static/img/favicon.ico'
          cm "image/x-ms-bmp" 'https://wiki.v2eth.com/docs/rotten.com/library/bio/hackers/robert-morris/morris.bmp'
          cm "image/x-xcf" 'https://wiki.v2eth.com/docs/personal/businesscard-front-draft.xcf'
          cm "message/rfc822" 'https://wiki.v2eth.com/docs/linkrot/2009-08-20-b3ta-fujitsuhtml.mht'
          cm "text/css" 'https://wiki.v2eth.com/docs/gwern.net-gitstats/gitstats.css'
          cm "text/css" 'https://wiki.v2eth.com/docs/statistics/order/beanmachine-multistage/offsets.css'
          cm "text/css" 'https://wiki.v2eth.com/docs/statistics/order/beanmachine-multistage/style.css'
          cm "text/css" 'https://wiki.v2eth.com/static/css/default.css'
          cm "text/css" 'https://wiki.v2eth.com/static/css/fonts.css'
          cm "text/css" 'https://wiki.v2eth.com/static/css/initial.css'
          cm "text/css" 'https://wiki.v2eth.com/static/css/links.css'
          cm "text/csv; charset=utf-8" 'https://wiki.v2eth.com/docs/statistics/2013-google-index.csv'
          cm "text/html" 'https://wiki.v2eth.com/atom.xml'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/docs/cs/2012-terencetao-anonymity.html'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/docs/sr/2013-06-07-premiumdutch-profile.htm'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/index'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/notes/Attention'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/notes/Faster'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/reviews/Anime'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/reviews/Anime'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/reviews/Movies'
          cm "text/html; charset=utf-8" 'https://wiki.v2eth.com/docs/xrisks/1985-hofstadter'
          cm "text/markdown; charset=utf-8" 'https://wiki.v2eth.com/2014-spirulina.page'
          cm "text/plain; charset=utf-8" 'https://wiki.v2eth.com/docs/personal/2009-sleep.txt'
          cm "text/plain; charset=utf-8" 'https://wiki.v2eth.com/static/redirects/nginx.conf'
          cm "text/x-adobe-acrobat-drm" 'https://wiki.v2eth.com/docs/dnb/2012-zhong.ebt'
          cm "text/x-haskell; charset=utf-8" 'https://wiki.v2eth.com/static/build/hakyll.hs'
          cm "text/x-opml; charset=utf-8" 'https://wiki.v2eth.com/docs/personal/rss-subscriptions.opml'
          cm "text/x-patch; charset=utf-8" 'https://wiki.v2eth.com/docs/ai/music/2019-12-22-gpt2-preferencelearning-gwern-abcmusic.patch'
          cm "text/x-r; charset=utf-8" 'https://wiki.v2eth.com/static/build/linkAbstract.R'
          cm "text/plain; charset=utf-8" 'https://wiki.v2eth.com/static/build/linkArchive.sh'
          cm "text/yaml; charset=utf-8" 'https://wiki.v2eth.com/metadata/custom.yaml'
          cm "video/mp4" 'https://wiki.v2eth.com/images/genetics/selection/2019-coop-illinoislongtermselectionexperiment-responsetoselection-animation.mp4'
          cm "video/webm" 'https://wiki.v2eth.com/images/statistics/2003-murray-humanaccomplishment-region-proportions-bootstrap.webm'
        }
    wrap λ "The live MIME types are incorrect"

    ## known-content check:
    λ(){ curl --silent 'https://wiki.v2eth.com/index' | tr -d '­' | fgrep --quiet 'This is the website</span> of <strong>Gwern Branwen</strong>' || echo "Content-check failed"
         curl --silent 'https://wiki.v2eth.com/Zeo'   | tr -d '­' | fgrep --quiet 'lithium orotate' || echo "Content-check failed"; }
    wrap λ "Known-content check of index/Zeo"

    ## did any of the key pages mysteriously vanish from the live version?
    linkchecker --threads=5 --check-extern --recursion-level=1 'https://wiki.v2eth.com/index'
    ## - traffic checks/alerts are done in Google Analytics: alerts on <900 pageviews/daily, <40s average session length/daily.
    ## - latency/downtime checks are done in `updown.io` (every 1h, 1s response-time for /index)
    set +e

    # Cleanup post:
    ## rm --recursive --force -- ~/wiki/_cache/ ~/wiki/_site/ || true

    # Testing files, post-sync
    bold "Checking for file anomalies…"
    λ(){ fdupes --quiet --sameline --size --nohidden $(find ~/wiki/ -type d | egrep -v -e 'static' -e '.git' -e 'gwern/wiki/$' -e 'docs/www/' -e 'metadata/annotations/backlinks') | fgrep --invert-match -e 'bytes each' -e 'trimfill.png' ; }
    wrap λ "Duplicate file check"

    λ() { find . -perm u=r -path '.git' -prune; }
    wrap λ "Read-only file check" ## check for read-only outside ./.git/ (weird but happened):

    λ(){ fgrep --color=always -e 'RealObjects' -e '404 Not Found Error: No Page' -e ' may refer to:' ./metadata/auto.yaml; }
    wrap λ "Broken links, corrupt authors', or links to Wikipedia disambiguation pages in auto.yaml."

    λ(){ (find . -type f -name "*--*"; find . -type f -name "*~*"; ) | fgrep -v -e images/thumbnails/ -e metadata/annotations/; }
    wrap λ "No files should have double hyphens or tildes in their names."

    bold "Checking for HTML/PDF/image anomalies…"
    λ(){ BROKEN_HTMLS="$(find ./ -type f -name "*.html" | fgrep --invert-match 'static/' | \
                         parallel --max-args=100 "fgrep --ignore-case --files-with-matches \
                         -e '404 Not Found' -e '<title>Sign in - Google Accounts</title'" | sort)"
         for BROKEN_HTML in $BROKEN_HTMLS;
         do grep --before-context=3 "$BROKEN_HTML" ./metadata/archive.hs | fgrep --invert-match -e 'Right' -e 'Just' ;
         done; }
    wrap λ "Archives of broken links"

    λ(){ BROKEN_PDFS="$(find ./ -type f -name "*.pdf" | sort | parallel --max-args=100 file | grep -v 'PDF document' | cut -d ':' -f 1)"
         for BROKEN_PDF in $BROKEN_PDFS; do
             echo "$BROKEN_PDF"; grep --before-context=3 "$BROKEN_PDF" ./metadata/archive.hs;
         done; }
    wrap λ "Corrupted or broken PDFs"

    λ(){
        checkSpamHeader() {
            HEADER=$(pdftotext -f 1 -l 1 "$@" - 2> /dev/null | \
                         fgrep -e 'INFORMATION TO USERS' -e 'Your use of the JSTOR archive indicates your acceptance of JSTOR' \
                               -e 'This PDF document was made available from www.rand.org as a public' -e 'A journal for the publication of original scientific research' \
                               -e 'This is a PDF file of an unedited manuscript that has been accepted for publication.' \
                               -e 'Additional services and information for ' -e 'Access to this document was granted through an Emerald subscription' \
                               -e 'PLEASE SCROLL DOWN FOR ARTICLE' -e 'ZEW Discussion Papers')
            if [ "$HEADER" != "" ]; then echo "Header: $@"; fi;
        }
        export -f checkSpamHeader
    }
    wrap λ "Remove junk from PDF & add metadata"

    λ(){ find ./ -type f -name "*.jpg" | parallel --max-args=100 file | fgrep --invert-match 'JPEG image data'; }
    wrap λ "Corrupted JPGs"

    λ(){ find ./ -type f -name "*.png" | parallel --max-args=100 file | fgrep --invert-match 'PNG image data'; }
    wrap λ "Corrupted PNGs"

    λ(){  find ./ -name "*.png" | fgrep -v '/static/img/' | sort | xargs identify -format '%F %[opaque]\n' | fgrep ' false'; }
    wrap λ "Partially transparent PNGs (may break in dark mode, convert with 'mogrify -background white -alpha remove -alpha off')"

    ## 'file' throws a lot of false negatives on HTML pages, often detecting XML and/or ASCII instead, so we whitelist some:
    λ(){ find ./ -type f -name "*.html" | fgrep --invert-match -e 4a4187fdcd0c848285640ce9842ebdf1bf179369 -e 5fda79427f76747234982154aad027034ddf5309 \
                                                -e f0cab2b23e1929d87f060beee71f339505da5cad -e a9abc8e6fcade0e4c49d531c7d9de11aaea37fe5 \
                                                -e 2015-01-15-outlawmarket-index.html -e ac4f5ed5051405ddbb7deabae2bce48b7f43174c.html \
                                                -e %3FDaicon-videos.html \
             | parallel --max-args=100 file | fgrep --invert-match -e 'HTML document, ' -e 'ASCII text'; }
    wrap λ "Corrupted HTMLs"

    # λ(){ checkEncryption () { ENCRYPTION=$(exiftool -quiet -quiet -Encryption "$@");
    #                           if [ "$ENCRYPTION" != "" ]; then echo "Encrypted: $@"; fi; }
    #      export -f checkEncryption
    #      find ./ -type f -name "*.pdf" | parallel checkEncryption; }
    # wrap λ "'Encrypted' PDFs (fix with pdftk: `pdftk $PDF input_pw output foo.pdf`)" &

    ## DjVu is deprecated (due to SEO: no search engines will crawl DjVu, turns out!):
    λ(){ find ./ -type f -name "*.djvu"; }
    wrap λ "DjVu detected (convert to PDF)"

    ## having noindex tags causes conflicts with the robots.txt and throws SEO errors; except in the ./docs/www/ mirrors, where we don't want them to be crawled:
    λ(){ find ./ -type f -name "*.html" | fgrep --invert-match -e './docs/www/' -e './static/404.html' | xargs fgrep --files-with-matches 'noindex'; }
    wrap λ "Noindex tags detected in HTML pages"

    λ() { find ./ -type f -name "*.gif" | fgrep --invert-match -e 'static/img/' -e 'images/thumbnails/' | parallel --max-args=100 identify | egrep '\.gif\[[0-9]\] '; }
    wrap λ "Animated GIF is deprecated; GIFs should be converted to WebMs/MP4"

    λ() {  find ./ -type f -name "*.jpg" | parallel --max-args=100 "identify -format '%Q %F\n'" {} | sort --numeric-sort | egrep -e '^[7-9][0-9] ' -e '^6[6-9]' -e '^100'; }
    wrap λ "Compress JPGs to ≤65% quality"

    ## Find JPGS which are too wide (1600px is an entire screen width on even widee monitors, which is too large for a figure/illustration):
    λ() { for IMAGE in $(find ./images/ -type f -name "*.jpg" -or -name "*.png" | fgrep --invert-match -e 'images/ai/gpt/2020-07-19-oceaninthemiddleofanisland-gpt3-chinesepoetrytranslation.png' -e 'images/gan/2020-05-22-caji9-deviantart-stylegan-ahegao.png' -e 'images/ai/2021-meme-virginvschad-journalpapervsblogpost.png' -e 'tadne-l4rz-kmeans-k256-n120k-centroidsamples.jpg' | sort); do
              SIZE_W=$(identify -format "%w" "$IMAGE")
              if (( $SIZE_W > 1600  )); then echo "Too wide image: $IMAGE $SIZE_W"; fi;
          done; }
    wrap λ "Too-wide images (downscale)"

    # if the first of the month, download all pages and check that they have the right MIME type and are not suspiciously small or redirects.
    if [ $(date +"%d") == "1" ]; then

        bold "Checking all MIME types…"
        PAGES=$(cd ~/wiki/ && find . -type f -name "*.page" | sed -e 's/\.\///' -e 's/\.page$//' | sort)
        c() { curl --compressed --silent --output /dev/null --head "$@"; }
        for PAGE in $PAGES; do
            MIME=$(c --max-redirs 0 --write-out '%{content_type}' "https://wiki.v2eth.com/$PAGE")
            if [ "$MIME" != "text/html; charset=utf-8" ]; then red "$PAGE : $MIME"; exit 2; fi

            SIZE=$(curl --max-redirs 0 --compressed --silent "https://wiki.v2eth.com/$PAGE" | wc --bytes)
            if [ "$SIZE" -lt 7500 ]; then red "$PAGE : $SIZE : $MIME" && exit 2; fi
        done

        # check for any pages that could use multi-columns now:
        λ() { (find . -name "*.page"; find ./metadata/annotations/ -maxdepth 1 -name "*.html") | shuf | \
            parallel --max-args=100 runhaskell -istatic/build/ ./static/build/Columns.hs --print-filenames; }
        wrap λ "Multi-columns use?"
    fi
    # if the end of the month, expire all of the annotations to get rid of stale ones:
    if [ $(date +"%d") == "31" ]; then
        rm ./metadata/annotations/*
    fi

    # once a year, check all on-site local links to make sure they point to the true current URL; this avoids excess redirects and various possible bugs (such as an annotation not being applied because it's defined for the true current URL but not the various old ones, or going through HTTP nginx redirects first)
    if [ $(date +"%j") == "002" ]; then
        bold "Checking all URLs for redirects…"
        for URL in $(find . -type f -name "*.page" | parallel --max-args=100 runhaskell -istatic/build/ static/build/link-extractor.hs | \
                         egrep -e '^/' | sort -u); do
            echo "$URL"
            MIME=$(curl --silent --max-redirs 0 --output /dev/null --write '%{content_type}' "https://wiki.v2eth.com$URL");
            if [[ "$MIME" == "" ]]; then red "redirect! $URL"; fi;
        done

        for URL in $(find . -type f -name "*.page" | parallel --max-args=100 runhaskell -istatic/build/ static/build/link-extractor.hs | \
                         egrep -e '^https://wiki.v2eth.com' | sort -u); do
            MIME=$(curl --silent --max-redirs 0 --output /dev/null --write '%{content_type}' "$URL");
            if [[ "$MIME" == "" ]]; then red "redirect! $URL"; fi;
        done
    fi

    bold "Sync successful"
fi
