#!/bin/bash



# Sync:

bold () { echo -e "\033[1m$@\033[0m"; }

set -e
## sync to Hetzner server: (`--size-only` because Hakyll rebuilds mean that timestamps will always be different, forcing a slower rsync)
## If any links are symbolic links (such as to make the build smaller/faster), we make rsync follow the symbolic link (as if it were a hard link) and copy the file using `--copy-links`.
## NOTE: we skip time/size syncs because sometimes the infrastructure changes values but not file size, and it's confusing when JS/CSS doesn't get updated; since the infrastructure is so small (compared to eg docs/*), just force a hash-based sync every time:
bold "Syncing static/…"
rsync --exclude=".*" --chmod='a+r' --recursive --checksum --copy-links --verbose --itemize-changes --stats ./static/ root@149.248.6.135:"/home/thursday/www/wiki/static"
## Likewise, force checks of the Markdown pages but skip symlinks (ie non-generated files):
bold "Syncing pages…"
rsync --exclude=".*" --chmod='a+r' --recursive --checksum --quiet --info=skip0 ./_site/  root@149.248.6.135:"/home/thursday/www/wiki/"
## Randomize sync type—usually, fast, but occasionally do a regular slow hash-based rsync which deletes old files:
bold "Syncing everything else…"
SPEED=""; if ((RANDOM % 100 < 99)); then SPEED="--size-only"; else SPEED="--delete --checksum"; fi;
rsync --exclude=".*" --chmod='a+r' --recursive $SPEED --copy-links --verbose --itemize-changes --stats ./_site/  root@149.248.6.135:"/home/thursday/www/wiki/"
set +e
