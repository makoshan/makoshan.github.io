---
title: 东方音乐的数据分析
description: 收集音乐元数据并寻找规律
tags: statistics, sociology, Haskell
created: 28 Feb 2013
status: in progress
belief: possible
...

<!-- TODO: from Culture is not about esthetics: mv here?
[^touhou]: This is a general assertion that is fairly hard to prove, but an example may be suggestive. The [Touhou](!Wikipedia "Touhou Project") doujinshi-game phenomenon has a [fair amount of music](http://touhou.wikia.com/wiki/Category:Music), but to get a sense of the true scale, we can look at some numbers. From the talk ["Riding on Fans' Energy: Touhou, Fan Culture, and Grassroot Entertainment"](http://cardcaptor.moekaku.com/?p=112) ([Barcamp](!Wikipedia) Bangkok 2 on August 31, 2008):

    > Touhou is [ZUN](!Wikipedia "Team Shanghai Alice#Member")'s work as much as it is a gigantic repertoire of fan-made manga, games, music, and video clips. I estimate that there are roughly at least three thousands short manga, five hundred music rearrangement albums, and one hundred derivative games created since 2003. These works are traded mainly in conventions dedicated to them, and some commercial firms are starting to capitalize on their popularity. Doujinshi shops like [Tora no Ana](!Wikipedia "Comic Toranoana") and [Mandarake](!Wikipedia) have shelves dedicate to Touhou comics. And Amazon.co.jp are carrying CDs of arranged/sampled Touhou music (but not ZUN's originals). More and more people are attracted to the franchise because its diverse derivative works provide a variety of entry points for potential fans. In fact, Touhou's popularity skyrocketed when it became one of the killer content of [Nico Nico Douga](!Wikipedia), a Japanese equivalent of YouTube launched one year and a half earlier. There, Touhou content spread like wild fire and gave rise to many recurring memes and tens of thousands of mashup videos. To give a sense of how popular Touhou is in Nico Nico Douga, 18 of 100 most viewed videos are Touhou-related, and the best Touhou video ranks the 6th. [[5]](http://cardcaptor.moekaku.com/?p=112#touhou-popularity-in-nico-nico-douga)

    For a recent estimate, we can turn to [TV Tropes](!Wikipedia)'s [article](http://tvtropes.org/pmwiki/pmwiki.php/CrowningMusic/TouhouProject) on Touhou music:

    > The Touhou Project really gets a lot of great pieces of music for [the music] being [originally] made up by a single guy with a synthesizer. To put the sheer number of remix CDs in perspective, there is a torrent with over 870.4 gigabytes of over 3000 Touhou remixes, and that only includes the ones that the (English-speaking) maintainers of the torrent have added.

    (This is outdated; the October 2011 lossless torrent is [1,020 gigabytes](http://www.nyaa.eu/?page=torrentinfo&tid=255825). Personally, [I](http://www.reddit.com/r/TOUHOUMUSIC/search?q=author%3A%27gwern%27&restrict_sr=on) enjoy the orchestral pieces like the [WAVE](http://www.circle-wave.net/) group's [Luna Forest (第七楽章)](http://www.youtube.com/watch?v=xhDNC12hWKc).)
-->

<!--
16:19:10 <@gwern> Speed: it is difficult to explain. also, it's much more than 44k
16:19:23 < klfwip> speed, touhou is a video game franchise which has one of the best fan bases in the world.
16:19:24 <@gwern> that's just that one highly incomplete torrent
16:19:28 < Speed> I've found the Touhou Project on wikipedia
16:19:40 < Speed> but that one seems to list maybe 10 CD's
16:19:48 < klfwip> they have multiple festivals per year in japan almost completely devoted to selling touhou music and other collectables
16:21:13 <@gwern> klfwip: actually, I'm not entirely sure about that... I think zun may've put out his stuff under a custom license
16:21:58 <@gwern> http://cardcaptor.moekaku.com/?p=125 eg
16:22:08 <@gwern> http://en.touhouwiki.net/wiki/Touhou_Wiki:Copyrights#Copyright_status.2FTerms_of_Use_of_the_Touhou_Project
16:22:40 <@gwern> this seems pretty unusual for doujin works, but both touhou and vocaloid are big enough that they've'd to've make things more explicit
16:24:23 <@gwern> Speed: nope. I think it's heavily biased toward recent music, the growth seems too rapid
16:24:44 < Speed> how much Touhou music does then exist by your estimations?
16:25:56 <@gwern> Speed: I'm not sure yt. I haven't cleaned the data enough to get a good idea of the counts, and I can't run a capture-recapture estimate of the total universe until the data has improved
16:26:09 <@gwern> Speed: I wouldn't be too surprised if it were >100k though
16:26:30 < klfwip> for every big artist who releases dozens of albums, I suspect there are thousands who post one vocaloid mix of a touhou song to niconico
                   video.
16:26:39 < Siod> how is most touhou music made?
16:27:23 < Speed> I'm still not entirely able to believe that many derivatives could have been made from just a few soundtracks
16:27:39 < Siod> what? it's all derived from soundtracks?
16:27:41 < klfwip> speed, there are hundreds of original touhou songs.
16:27:47 < Speed> klfwip: since you have a collection, can you give me a few samples of the music?
16:27:58 < klfwip> electro, classical, metal, what do you want?
16:28:04 <@gwern> Speed: oh come on, that's like saying 'I don't know how there can be thousands of apocrypha when there's onyl like a hundred canonical books
                  in the bible'
16:28:25 <@gwern> or, 'I don't know how there can be 300m+ books in total'
16:28:26 < klfwip> and some of them honestly have very little in comon with the source except a melody.
16:28:38  * gwern links Speed to https://xkcd.com/915/
16:31:55 <@gwern> Burninate: remixes, distant inspirations, borrowing a hook or melody... they can be remixes in the same way Book of Mormon is a remix of
                  Zoroastrianism
16:32:34 < quanticle> gwern: More apropos, it's like saying, "I don't know how a single 5-second drum and bass solo can give rise to an entire genre of music."
                      http://en.wikipedia.org/wiki/Amen_break
16:33:46 < quanticle> gwern: Yeah. Pretty much the entire DNB scene is made up of derivatives and riffs on Amen Break.
16:35:59 < Speed> gwern: so, how does one then classify something as Touhou music or not?
16:36:02 <@gwern> but it's only 'indie' because zun can make a living off it
16:37:04 <@gwern> Speed: well, obviously if something is a rearrangement of an existing Zun track like 'Shanghai Teahouse', it's touhou, but there are a lot of
                  marginal cases where it's simply social - does the creator consider it touhou? did they use touhou-related artowkr or characters? do they
                  thank zun?
16:37:38 < klfwip> some really big names in the touhou scene also have succesful careers are pro musicians outside of it.
16:37:49 <@gwern> nothing stops people from writing their own music without reference to the canonical Zun melodies or themes and simply branding it as Touhou
16:37:57 < klfwip> if they don't call a particular album a touhou remix album, I would just assume it not to be.
16:38:14 < Burninate> So Zun made 15 games.  Himself.  Without involving a studio (dojin).
16:38:28 < Burninate> and then fans made a bunch of derivatives of those 15 games
16:38:42 <@gwern> Burninate: hm, wasn't the last one or two a collaboration with another group? is that 15 counting the collaborations?
16:38:44 < Burninate> songs, other games, anime, comics
16:38:46 <@gwern> novels
16:38:48 < klfwip> correct
16:39:01 < Burninate> the descriptions are confusing as fuck
16:39:05  * Tuxedage would like to add that Zun is insanely talented
16:39:07 < Tuxedage> Except for the art
16:39:10 < klfwip> gwern, also the earliest games were not under his control, remember.
-->

<!-- "Videos containing Touhou tag  Total Hits: 153,553" http://www.nicovideo.jp/tag/Touhou TODO: scrape niconico -->

构想：将东方音乐的产出量与日本青年失业率进行关联分析——以秒数衡量的音乐总产量是否会随失业率上升而增加？

相反观点认为，经济衰退反而会抑制产出（或许因为人们工作更辛苦，即使其他人失业了自己也没有多少空闲时间？）http://www.gamesetwatch.com/2009/12/sound_current_yokohamas_mediam.php

> While the turnout at M3 remains strong, at the same time an economic recession cannot help but touch a community whose activities rely on having free time. Furthermore while previously many hobbyists dreamed of someday breaking into the industry, more recently many also fear that game companies will begin cracking down on unlicensed tributes.

# 数据
## 失业率数据来源

使用了 FRED 的[日本青年（15-24岁）经调整失业率 (JPNURYNAA)](http://research.stlouisfed.org/fred2/series/JPNURYNAA)；下载为 CSV 格式，年度百分比数据涵盖 2000-2011 年

~~~{.R}
jpn <- read.table(stdin(),header=TRUE)
      DATE VALUE
2000-01-01   8.9
2001-01-01   9.1
2002-01-01   9.5
2003-01-01   9.6
2004-01-01   9.0
2005-01-01   8.1
2006-01-01   7.5
2007-01-01   7.5
2008-01-01   7.0
2009-01-01   8.9
2010-01-01   9.0
2011-01-01   8.1
~~~

## 东方音乐数据来源

TODO 建议来源：http://www.reddit.com/r/TOUHOUMUSIC/comments/19hh2m/touhou_music_databases_comprehensive_easily/ http://boards.4chan.org/jp/res/10559057

其他备选来源

- [VGMdb 东方条目](http://vgmdb.net/product/9) 规模较小，仅有不到 1389 张专辑的元数据
- 开源替代方案是 [MusicBrainz](!Wikipedia)；看起来[有约 190 张专辑](http://musicbrainz.org/tag/touhou/release)，但其中 90% 以上链接到 VGMdb，所以我不确定是否值得纳入（浪费精力，而且如果几年前有人只是把 VGMdb 全部复制过来，对任何总体规模的标记-重捕分析来说都会产生严重误导）。
- [Touhouwiki.net](http://en.touhouwiki.net/wiki/Doujin_circles) 另一个来源，不到 1182 张专辑
- "東方音団録 ～ Arrange Circle Database ver.3.0"；[主页](http://www16.atwiki.jp/toho) 和 [发布信息](http://www16.atwiki.jp/toho/pages/727.html)（[讨论](http://www16.atwiki.jp/toho/pages/13.html)、[聊天](http://www16.atwiki.jp/toho/pages/948.html)），[商品页面](http://www.toranoana.jp/bl/article/04/0030/04/86/040030048682.html)，j-subculture.com 报价部分总计约 15 美元，加上 Paypal 和国际运费后约 30 美元！（其他代购包括 [Yokatta](http://yokattaweb.jp/index.html)。）

   策略：首先在 wiki 聊天室请求下载 Arrange CD 数据库；然后查找运营者的邮箱直接联系；再看看日本有没有欠我人情或愿意帮忙的人；然后打听更便宜的转运商；如果以上全部失败，就付 j-subculture 可能高达 25 美元的天价费用。

   2013 年 3 月 1 日发出的邮件到 5 月 27 日未获任何回复；随后在 `/r/TOUHOUMUSIC` 上[发帖求购](http://www.reddit.com/r/TOUHOUMUSIC/comments/1f61p6/request_anyone_ordering_from_tora_no_ana_soon/ "[request] Anyone ordering from Tora no Ana soon? (self.TOUHOUMUSIC)")。

需要更多数据库来进行标记-重捕分析！

<!--
The ISO file seems to be broken: `file` just calls it 'data', and when I mount it as a loopback iso9660 file, `mount` throws an error. I redownloaded it and compared it, but the copies were identical.

The good news is that the zip file seems to work fine. The data is in a .accdb file in a subfolder, which turns out to be the latest Microsoft Access database format. Unfortunately, this turns out to be almost entirely unsupported by anything on Linux (except for a Java library), but fortunately, an acquaintance had an Office 365 subscription and re-exported the .accdb file as a .mdb file (the older Access format) which was successfully read and converted to CSV by `mdb-tools`. The entries look like this:

$ mdb-tables Toho_arrange_circle_database-gwern.mdb
アレンジサークルリスト
$ mdb-export Toho_arrange_circle_database-gwern.mdb `mdb-tables Toho_arrange_circle_database-gwern.mdb` > Toho_arrange_circle_database-gwern.csv
$ head Toho_arrange_circle_database-gwern.csv
    ID,pin,サークル名,ふりがな,URL,ジャンル,Vocal,主な頒布CD,原曲アレンジの程度,一言,memo
    1,,"っ´Д｀)っゼロ式の処刑場（っ´Д｀)っゼロ式の家・DESTRUCTIVE ANGEL）","ぜろしきのしょけいじょう","http://shinzanzeroshiki.fc2web.com/","メタル","男","Crazy Trancy Ecstasy","原曲維持","重厚感あふれる荘厳なメタル。（Black）",
    2,,"α music","あるふぁみゅーじっく","http://www19.atpages.jp/tatu4/","オーケストラ、ピアノ",,"東方風水華月","原曲維持",,
    3,,"凸凹えんたーていめんとすたじお","でこぼこえんたーていめんとすたじお","http://3rd.geocities.jp/deko_boko_es/index/","リコーダー、ゲームミュージック",,"Electronic Magus","原曲維持","8ビットあり、リコーダー生演奏ありと多彩。（Black）",
    4,,"[4989]","しくはっく","http://4989mm.littlestar.jp/","ロック","男女","musick for me","原曲維持","スローなロック風アレンジにハイトーン男声ボーカル、エレクトロも混ざったインストも。ドラマCDあり。（Black）",
    5,,"[ kapparecords])","かっぱれこーず","http://www5f.biglobe.ne.jp/~kapparecords/","ハードロック","男","SCARLET FANTASIA","原曲維持","生演奏ギタードラムベースと男声ボーカルがんばれ。（Black）",
    6,,"＜echo＞PROJECT","えこぷろじぇくと","http://echoproject.3rin.net/","ダンス、ポップス、ロック","女","eclat:","原曲重視～維持","女性ボーカルを軸にしてジャンルは何でもアレンジ。（Black）",
    7,,"#039","しゃーぷさんきゅー","http://sharp039.web.fc2.com/",,,"EMERGENCE",,,
    8,,"#ゆうかりんちゃんねる","ゆうかりんちゃんねる","http://yuukach.web.fc2.com/","オーケストラ、クラシック、ピアノ、エレクトロ、ロック",,"ゴリラ人間のための華麗なる大幻想曲集","原曲維持","クラシカルな構成と管弦を散りばめたオーケストラ、クラシック風インスト。バイオリンの倍音の響きが印象的。（Black）",
    9,,"10-GALLON(Digit Smith)","てんがろん","http://10-gallon.net/","ロック、エレクトロ、ハードロック","女","悪魔城レミリア","原曲維持","原曲メロをミドルテンポなロックとエレクトロに乗せて。（Black）",
$ tail -1 Toho_arrange_circle_database-gwern.csv
    1316,,"侘助","わびすけ","http://ameblo.jp/wa-bi-su-ke/","エレクトロ、ロック","女","東方乙女椿","原曲維持","速めのエレクトロ、ロックアレンジが多め。女声ボーカル。（Black）",

I am a little surprised that there are only 1316 entries. Either I've overestimated their thoroughness or this is limited to a specific convention or something like that... Need to look into this more.
-->

### 种子文件

音乐来源：[Touhou lossy music collection v.15.2](http://www.nyaa.eu/?page=torrentinfo&tid=387790)（源自 [Touhou lossless music collection](http://www.tlmc.eu/) 合集），共 265.2GB，包含来自不到 1264 个社团（"circles"）的 4952 张专辑中的 44421 首曲目。

~~~{.Bash}
$ find ~/torrent/Touhou\ lossy\ music\ collection/ -type f -name "*.mp3" | wc
  44421
$ ls torrent/Touhou\ lossy\ music\ collection/ | wc
   1264
$ ls torrent/Touhou\ lossy\ music\ collection/*/ | wc
   7477
~~~

文件名、音乐时长和元数据中的年份（如有）使用 `exiftool` 提取：

活动列表：
例大祭["","SP","SP2",2-9]：年度例大祭
M3*：年度 Media Mix Market，例如 http://polymetrica.wordpress.com/2009/10/09/things-i-am-excited-about-04-m324/
C[63-82]：半年一度的 Comiket
サンクリ[28-50]：年度？Sunshine Creation http://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AA%E3%82%A8%E3%82%A4%E3%82%B7%E3%83%A7%E3%83%B3_%28%E5%90%8C%E4%BA%BA%E5%8D%B3%E5%A3%B2%E4%BC%9A%29
東方紅楼夢[?2-8]：年度 Koromu
月の宴?2-5：年度？月之宴
紅のひろば?2-6：半年一度 红色广场
東方不敗小町?2-6, SP, ぷちこまち：Komachi
杜の奇跡[15-16]
東方杜郷想[2-3]
幺樂団カァニバル！?2-3
東方幻楽祭[2]：半年一度
コミコミ[12-14]
FF[9-17] ?
こみトレ[12-17]
COMIC1☆2-6
COMIC CITY大阪[63,73]
恋魔理?2-3
東方椰麟祭?2-3
東方名華祭2

exiftool; json

`exiftool` 的时长近似值可靠吗？是的，它似乎总是在完整的 `mp3info` 结果的几秒之内：

~~~{.Bash}
$ find "/home/gwern/torrent/Touhou lossy music collection/" -type f -name "*.mp3" \
        -exec mp3info -F -p "0:%02m:%02s " {} \; -exec exiftool -Duration {} \;
0:00:23 Duration                        : 23.12 s (approx)
0:04:28 Duration                        : 0:04:28 (approx)
0:02:44 Duration                        : 0:02:44 (approx)
0:04:52 Duration                        : 0:04:52 (approx)
0:03:56 Duration                        : 0:03:56 (approx)
0:01:44 Duration                        : 0:01:44 (approx)
0:04:34 Duration                        : 0:04:34 (approx)
0:02:30 Duration                        : 0:02:30 (approx)
0:03:02 Duration                        : 0:03:02 (approx)
0:03:43 Duration                        : 0:03:42 (approx)
0:03:23 Duration                        : 0:03:23 (approx)
0:03:11 Duration                        : 0:03:11 (approx)
0:04:22 Duration                        : 0:04:22 (approx)
0:03:13 Duration                        : 0:03:13 (approx)
0:04:04 Duration                        : 0:04:04 (approx)
0:03:58 Duration                        : 0:03:57 (approx)
0:05:24 Duration                        : 0:05:24 (approx)
0:04:17 Duration                        : 0:04:17 (approx)
0:03:14 Duration                        : 0:03:14 (approx)
0:01:59 Duration                        : 0:01:58 (approx)
0:03:21 Duration                        : 0:03:21 (approx)
0:02:35 Duration                        : 0:02:35 (approx)
0:04:20 Duration                        : 0:04:20 (approx)
...
~~~

~~~{.R}
# 生成、解析和清理数据
#
# 约需 30 分钟：
# R> system("exiftool -extension mp3 -json -forcePrint
#           -Title -Year -Album -Artist -Duration -Genre -Track -Directory -FileName -FileSize -AudioBitrate
#           ~/torrent/Touhou\\ lossy\\ music\\ collection/*/* > ~/touhou.json")
library(rjson)
# 从 http://www.gwern.net/docs/touhou/2013-torrent.json.xz 下载并用 xz 解压
json_data <- fromJSON(paste(readLines("2013-gwern-touhoutorrent.json"), collapse=""))
touhou <- data.frame(matrix(unlist(json_data), ncol=12, byrow=TRUE))
colnames(touhou) <- c("SourceFile", "Title", "Year", "Album", "Artist", "Length", "Genre",
                      "Track", "Directory", "FileName", "FileSize", "AudioBitrate")
# 删除 SourceFile 列；与 Directory/FileName 重复
touhou <- touhou[,-1]
touhou$Directory <- sub("/home/gwern/torrent/Touhou lossy music collection/", "",
                         as.character(touhou$Directory))
touhou[touhou==""] <- NA
touhou[touhou=="-"] <- NA
touhou$Year <- as.integer(as.character(touhou$Year))
# 种子不包含 2013 年的音乐，而 PC-98 游戏之前的音乐根本不存在……
touhou$Year[touhou$Year<1990] <- NA
touhou$Year[touhou$Year>2012] <- NA
# Genre 是 "None" 或 " "？都是无用且错误的（谢谢标签器）；所以也删掉：
touhou$Genre[touhou$Genre=="None"] <- NA
touhou$Genre[touhou$Genre==" "] <- NA
# 将曲目时长和比特率转换为可用的数字，统一单位（秒和 MB）
touhou$Length <- gsub(" \\(approx\\)","",as.character(touhou$Length))
touhou$AudioBitrate <- as.integer(sub(" kbps","",as.character(touhou$AudioBitrate)))
# exiftool 输出 "16 s"；如果是这样，去掉 " s" 并转为整数
# 否则格式为 "0:04:37"；按冒号分割，
# 小时乘以 3600 秒，分钟乘以 60，秒数不变；然后求和
interval <- function(x) { if (!is.na(x)) { if (grepl(" s",x)) as.integer(sub(" s","",x))
                                           else { y <- unlist(strsplit(x, ":"));
                                                  as.integer(y[[1]])*3600 + as.integer(y[[2]])*60 + as.integer(y[[3]]); }
                                                  }
                          else NA
                          }
touhou$Length <- sapply(touhou$Length,interval)
filesize <- function(x) { if (grepl(" kB",x)) (as.integer(sub(" kB","",x))/1000) else as.integer(sub(" MB","",x))}
touhou$FileSize <- sapply(touhou$FileSize, filesize)
# 重头戏：将 Directory 中编码的信息转换为可用的列。非胆小者勿入。
#
# Directory 列的格式如 "[twith1450]/2009.03.08 TOHOMOHO [例大祭6]"
# 编码规则为 "[社团]/活动日期 专辑名 [活动]"
#
# "[Angelic Quasar]/2006.01.29 [AQSH-0003] Racial Ethnic Nation"
# "[Alstroemeria Records]/[ARCD0001] The regret of stars, but stars shine bright (C65) (mp3)"
# "[Aqua Style／ひえろぐらふ]/2010.05.24 [AQUA-0031] 春宵一刻値千金 -シュンショウイッコク　アタイセンキン-"
brackets <- function(b) sub("\\]","", sub("\\[","",b))
# 第一步简单：解析出开头的社团名称（总是存在的，以正斜杠结尾）作为新列
touhou$Circle <- sapply(touhou$Directory, function(x) brackets(unlist(strsplit(as.character(x), "/"))[1]))
# 破坏性更新：移除社团名称，以简化下一步
# 这使 Directory 变成类似 "2009.06.07 [PAER-0007] #01 -LILITH- [東方幻楽祭2]"
# 或 "[ARCD0001] The regret of stars, but stars shine bright (C65) (mp3)"
touhou$Directory <- sapply(touhou$Directory, function(x) unlist(strsplit(as.character(x), "/"))[2])
touhou$Date <- as.Date(sapply(touhou$Directory, function(x) substring(x, 1, 10)), format="%Y.%m.%d")
# 同样地，去掉已解析的活动日期，剩下如 "ピアノのための東方小品集 Op.1-1 [御射宮司祭]"
# 或 "月遊 [例大祭8]" 或 "[AQUA-0031] 春宵一刻値千金 -シュンショウイッコク　アタイセンキン-"
touhou$Directory <- sapply(touhou$Directory, function(x) substring(x, 12))
# 提取下一个参数——专辑发布的活动名称——更加困难
library(stringr)
# 如果目录不以右方括号结尾，则没有活动信息，应返回空值
# 否则用正则表达式抓取最后一对方括号（前面有空格，排除专辑编号方案）并修剪
# 如果失败了？那么它一定是没有空格在括号前的目录格式，不加前导空格重试
touhou$Event <- sapply(touhou$Directory, function(x) { if (str_sub(x,start=-1) == "]") { res <- brackets(unlist(str_split(x, " \\["))[2]); if (!is.na(res)) res else brackets(unlist(str_split(x, "\\["))[2]) } else x})
# 检查 Event 列会发现充满错误条目。我列出了 19 个活动名称前缀（希望是完整的），
# 用作白名单，删除所有不包含这 19 个前缀的条目。
isPrefix <- function(x,y) grepl(paste0("^",x), y)
events <- c("例大祭","M3","C","サンクリ","東方紅楼夢","月の宴","紅のひろば","東方不敗小町","杜の奇跡","東方杜郷想",
            "幺樂団カァニバル！","東方幻楽祭","コミコミ","FF","こみトレ","COMIC1","COMIC CITY大阪","恋魔理","東方椰麟祭","東方名華祭")
touhou$Event <- sapply(as.character(touhou$Event),
                       function(target) if (sum(sapply(events, function(e) isPrefix(e,target))) != 0) target else NA)
# 这个白名单覆盖了几乎整个样本，所以我认为效果很好：
## R> sum(!is.na(touhou$Event))
## [1] 39190
## R> length(touhou$Event)
## [1] 41866
#
# 最后一件事，由于（几乎）所有目录都有日期而并非所有文件都有年份；
# 根据刚提取的日期覆盖缺失的年份
touhou$Year <- as.integer(format(touhou$Date, "%Y"))
touhou$Directory <- NULL # 清理
# 带着战利品逃跑：
write.csv(touhou, file="2013-gwern-touhoumusic-torrent.csv", row.names=FALSE)
~~~

## VGMdb

[东方项目页面](http://vgmdb.net/product/9)实际上并不完整：每个条目都需要手动标注为与东方相关。有人给我指了一个[搜索查询](http://vgmdb.net/search?do=results&id=161863)，通过在"games"字段中查找包含"Touhou"字符串的页面，找到了更多结果。

VGMdb 管理员友好地给予了我对其 MySQL 数据库的只读访问权限。我从 VGMdb 主数据库中导出了 `vgmdb_albums` 和 `vgmdb_tracks` 两张完整的表；导出为逗号分隔的 2 个 CSV 文件，分别命名为 `2013-vgmdb-albums.csv` 和 `2013-vgmdb-tracks.csv`。在加载导出文件之前，我必须删除所有转义引号；R 的默认 CSV 解析器无法处理它们。曲目行是一首曲目对应一个专辑 ID，因此要将每个曲目记录/行转换为与种子文件行等效的格式，我需要根据专辑表填充信息。

~~~{.R}
albums <- read.csv("http://www.gwern.net/docs/touhou/2013-vgmdb.csv")
albums <- with(albums,
           data.frame(albumid,reldate,publisher,game,albumtitles))
albums <- albums[grepl("ouhou", albums$game),]; albums$game <- NULL

tracks <- read.csv("2013-vgmdb-tracks.csv")
tracks$tracklistid <- NULL; tracks$trackid <- NULL; tracks$disctitle <- NULL; tracks$disc <- NULL
tracks$length[tracks$length==0] <- NA # 0 是 VGMdb 架构中的默认值
tracks <- tracks[tracks$albumid %in% albums$albumid,]
touhou <- merge(tracks, albums)
touhou$albumid <- NULL; albums <- NULL; tracks <- NULL
# 处理 41 个格式为 "2005-09-00" 的日期（第 0 个月或日不存在……）
touhou$date <- as.Date(sub("-00","-01",as.character(touhou$reldate)))
touhou$reldate <- NULL
touhou$year <- as.integer(format(touhou$date, "%Y"))
# 大写并重新排列为种子文件的列顺序
colnames(touhou) <- c("Track","Title","Length","Circle","Album","Date","Year")
touhou <- touhou[c(2,7,5,3,1,4,6)]
write.csv(touhou, file="2013-vgmdb-touhou.csv", row.names=FALSE)
~~~

## `touhouwiki.net`

## 个人下载
### 4chan /jp/ C83 主题帖

一群松散的 [4chan](!Wikipedia) 用户在 [/jp/](https://boards.4chan.org/jp/) 子版块每次 Comiket 期间合作上传和分发该次 Comiket 发布的同人漫画、游戏和音乐；有些由 Comiket 参加者上传，有些从 [Comic Toranoana](!Wikipedia) 等经销商购买，许多文件则从日本 P2P 文件共享网络如 [Winny](!Wikipedia)/[Share](!Wikipedia "Share (P2P)")/[Perfect Dark](!Wikipedia "Perfect Dark (P2P)") 收集而来。我从 [/r/TouhouMusic](http://www.reddit.com/r/TOUHOUMUSIC/comments/15pp33/c83_resource_thread/) 的 C83 主题帖（主要来自 4chan 链接）和博客 [All Doujin Music](http://alldoujinmusic.wordpress.com) 中汇编了约 400 个文件的列表，并在 2013 年 1 月至 3 月间逐步下载。去除死链后，剩余 400-500 个文件。其中很多不是音乐，甚至与东方无关，因此我手动筛选专辑，寻找东方同人作品的特征（致谢 ZUN、封面中的东方角色、我认出的东方主题等）；当我不确定时，宁可排除。[最终合集](/docs/touhou/2013-c83-downloads.txt)产出 3503 个文件（大致均分：1776 个东方 vs 1728 个"其他"），其中有 953 个东方音乐文件。

~~~{.R}
# exiftool -extension ogg -json -forcePrint -Title -Year -Album -Artist -Duration -Genre -TrackNumber -Directory
# -FileName -FileSize -NominalBitrate -Date -recurse
# ~/c83/touhou/ ~/c83/touhou/*/** ~/c83/touhou/*/*/** ~/c83/touhou/*/*/*/** > ~/2013-c83-downloads.json

library(rjson)
# 从 http://www.gwern.net/docs/touhou/2013-torrent.json.xz 下载并用 xz 解压
json_data <- fromJSON(paste(readLines("2013-c83-downloads.json"), collapse=""))
touhou <- data.frame(matrix(unlist(json_data), ncol=13, byrow=TRUE))
colnames(touhou) <- c("SourceFile", "Title", "Year", "Album", "Artist", "Length", "Genre",
                      "Track", "Directory", "FileName", "FileSize", "AudioBitrate", "Date")
# 删除 SourceFile 列；与 Directory/FileName 重复
touhou <- touhou[,-1]
for (filter in c("/home/gwern/c83/touhou/", "\\[touhou.vnsharing.net\\]", " \\(320K\\+BK\\)", "/mp3",
                 " MP3v0", " v0", " \\(flac\\+scans\\)", " \\(128K\\)", " \\(V0\\)", " \\(320\\)",
                 " \\(mp3 320\\)", " \\(v0\\+jpg\\)"))
 { touhou$Directory <- sub(filter, "", as.character(touhou$Directory)) }
touhou[touhou==""] <- NA
touhou[touhou=="-"] <- NA
~~~

播放时长：

~~~{.Bash}
find c83/touhou/ -name "*.ogg" -exec ogginfo {} \;|fgrep "Playback length"
~~~

### 4chan /jp/ C84 主题帖

591 个东方音乐文件：

/docs/touhou/2013-c84-downloads.json

### 4chan /jp/ C85 主题帖

449 个东方音乐文件：

/docs/touhou/2013-c85-download.json

### 4chan /jp/ 例大祭10 主题帖

与上述类似，参考 [/r/TouhouMusic](http://www.reddit.com/r/TOUHOUMUSIC/comments/1f3ikk/the_reitaisai_10_resource_thread/) 的讨论，手动去除重复和非东方内容后，得到 491 个音乐文件。

~~~{.Bash}
exiftool -extension ogg -json -forcePrint -Title -Year -Album -Artist -Duration -Genre -TrackNumber -Directory -FileName -FileSize -NominalBitrate -Date */*.ogg > ~/2013-reitaisai-downloads.json
~~~

### 例大祭10 种子

2013 年 5 月和 6 月，一位匿名人士汇编了 67 张专辑，发布了两个例大祭10 专辑种子（[第1卷](http://www.nyaa.se/?page=view&tid=438733)、[第2卷](http://www.nyaa.se/?page=view&tid=440787)）

~~~{.Bash}
exiftool -extension ogg -json -forcePrint -Title -Year -Album -Artist -Duration -Genre -TrackNumber -Directory -FileName -FileSize -NominalBitrate -Date */*.ogg > ~/2013-reitaisai-downloads-torrent.json
~~~

# 分析

~~~{.R}
touhou <- read.csv("http://www.gwern.net/docs/touhou/2013-torrent.csv",
                   colClasses=c("character", "integer", "factor", "character", "integer", "factor",
                                "character", "character", "numeric", "integer", "factor", "Date"))

# 对数据进行分析
# 总体相关性
t <- data.frame(touhou$Year, touhou$Length, touhou$FileSize, touhou$AudioBitrate)
cor(t,use="pairwise.complete.obs")
#                     touhou.Year touhou.Length touhou.FileSize touhou.AudioBitrate
# touhou.Year
# touhou.Length          -0.01091
# touhou.FileSize         0.04484       0.93915
# touhou.AudioBitrate     0.19188       0.11091         0.35499

# 检验高比特率与大文件之间的相关性：
cor.test(touhou$FileSize, touhou$AudioBitrate)

# 流派元数据毫无用处！
sort(table(touhou$Genre), decreasing=TRUE)

# 箱线图：每年平均时长
plot(touhou$Length ~ factor(touhou$Year))
~~~

经济学建模：

~~~{.R}
jpn <- read.csv(stdin(),header=TRUE)
DATE,VALUE
2000-01-01,8.9
2001-01-01,9.1
2002-01-01,9.5
2003-01-01,9.6
2004-01-01,9.0
2005-01-01,8.1
2006-01-01,7.5
2007-01-01,7.5
2008-01-01,7.0
2009-01-01,8.9
2010-01-01,9.0
2011-01-01,8.1

# 每年作品数量不相关：
cor.test(jpn$VALUE[3:12], table(touhou$Year)[1:10])
    Pearson`s product-moment correlation

data:  jpn$VALUE[3:12] and table(touhou$Year)[1:10]
t = -0.3053, df = 8, p-value = 0.768
alternative hypothesis: true correlation is not equal to 0
95% confidence interval:
 -0.6903  0.5602
sample estimates:
    cor
-0.1073

model <- lm(table(touhou$Year)[1:10] ~ c(2002:2011) + jpn$VALUE[3:12]); summary(model)
Call:
lm(formula = table(touhou$Year)[1:10] ~ c(2002:2011) + jpn$VALUE[3:12])

Residuals:
    Min      1Q  Median      3Q     Max
-2128.6  -716.4    52.4   632.6  2253.4

Coefficients:
                Estimate Std. Error t value Pr(>|t|)
(Intercept)     -2775278     342171   -8.11  8.3e-05
c(2002:2011)        1379        170    8.13  8.2e-05
jpn$VALUE[3:12]     1450        567    2.56    0.038

Residual standard error: 1400 on 7 degrees of freedom
Multiple R-squared: 0.905,  Adjusted R-squared: 0.878
F-statistic: 33.5 on 2 and 7 DF,  p-value: 0.00026



logModel <- lm(log(table(touhou$Year)[1:10]) ~ c(2002:2011) + jpn$VALUE[3:12])
summary(logModel)
Call:
lm(formula = log(table(touhou$Year)[1:10]) ~ c(2002:2011) + jpn$VALUE[3:12])

Residuals:
   Min     1Q Median     3Q    Max
-1.218 -0.632  0.108  0.551  0.982

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)
(Intercept)     -1295.060    207.535   -6.24  0.00043
c(2002:2011)        0.652      0.103    6.34  0.00039
jpn$VALUE[3:12]    -0.725      0.344   -2.11  0.07301

Residual standard error: 0.849 on 7 degrees of freedom
Multiple R-squared: 0.906,  Adjusted R-squared: 0.879
F-statistic: 33.8 on 2 and 7 DF,  p-value: 0.000253

plot(c(2002:2011),table(touhou$Year)[1:10])
points(c(2002:2011),exp(predict(logModel)),type='l',col='blue')
~~~

## 随时间增长

东方音乐语料库的增长速度有多快？

恒定增长模型：第一款游戏发布于 1996 年，对吧？因此有 17 年时间积累了 1.26TB 即 1260GB，年均 74.1GB。截图显示下载速度为 0kb/s，这没什么参考价值，但它显示还需 2640 天，所以可以估算他的下载速度为每天 0.47GB（`1260/2640`），一年则为 174GB，是年均 74GB 的 2.35 倍。因此按这个年增速，发帖者*不会*永远追不上，实际上是可以赶上的。

指数增长模型：这就有点棘手了，因为不能仅从累计总量和经过时间推导出公式。我需要更多数据。所以使用我 2012 年的 Touhou Lossy Torrent 数据，我可以尝试对年度数量拟合指数曲线……但等等！音乐数量似乎并没有呈指数增长！

    R> touhou <- read.csv("http://www.gwern.net/docs/touhou/2013-torrent.csv",
    +                    colClasses=c("character", "integer", "factor", "character",
    +                                         "integer", "factor", "character",
    +                                         "character", "numeric", "integer",
    +                                         "factor", "Date"))
    R> summary(touhou$Year)
    R> perYear <- table(touhou$Year); perYear; plot(perYear)

     2002  2003  2004  2005  2006  2007  2008  2009  2010  2011  2012
       13    23   255  1241  2070  2599  5073 10278  9765  7494  2999

图表：http://i.imgur.com/23fMA5c.png

看起来东方音乐的增长在 2009 年达到峰值；这可能反映了种子的不完整性，但种子来自 2012 年，你会期望到那时 2010 年或 2011 年的覆盖率应该相当好了。所以种子*整体*的增长看起来更像是 S 形曲线或对数曲线：

    R> runningTotal <- cumsum(table(touhou$Year)); runningTotal; plot(runningTotal)
     2002  2003  2004  2005  2006  2007  2008  2009  2010  2011  2012
       13    36   291  1532  3602  6201 11274 21552 31317 38811 41810

http://i.imgur.com/Lv9vHrZ.png

所以更好的问法可能是：如果 2012 年的增长速率持续下去，与他的下载速度之比是多少？

2012 年为种子增加了 19.5GB：

    R> # FileSize 单位为兆字节，转为吉字节
    R> sum(touhou[touhou$Year==2012,]$FileSize, na.rm=TRUE) / 1000
    [1] 19.5

# 附录
## `touhouwiki.net` 爬虫代码

使用 [Tagsoup](http://hackage.haskell.org/package/tagsoup) 和 [split](http://hackage.haskell.org/package/split) 包；向标准输出发送 CSV。这是一堆拼凑的代码，我有点不好意思公开，可能对你不起作用。

~~~{.Haskell}
import Text.HTML.TagSoup (fromAttrib, fromTagText, isTagOpen, isTagText,
                          parseTags, (~/=), Tag(TagComment, TagOpen,TagText))
import Network.HTTP (getResponseBody, getRequest, simpleHTTP)
import Data.List (isInfixOf, isPrefixOf, nub, sort, stripPrefix)
import Data.Char (isSpace)
import Codec.Binary.UTF8.String (decodeString)
import Data.Maybe (fromMaybe, isJust, listToMaybe)
import Data.List.Split (keepDelimsL, split, whenElt)
import Control.Monad (join, unless)

main :: IO ()
main = do albums1 <- getAlbums "http://en.touhouwiki.net/wiki/List_by_Groups"
          albums2 <- getAlbums "http://en.touhouwiki.net/wiki/List_of_Old_Touhou_Arrangement_Groups"
          let albumURLs = map ("http://en.touhouwiki.net"++) $ nub $ sort $ albums1 ++ albums2
          putStrLn header
          mapM_ getAlbum albumURLs

getAlbums :: String -> IO [String]
getAlbums index = do touhou <- openURL index
                     return $ drop 22 $ reverse [link | (TagOpen "a" ((ref, link):_)) <- parseTags touhou,
                                                        ref=="href",
                                                        "/wiki/" `isPrefixOf` link,
                                                        let fltr x = not (x `isInfixOf` link),
                                                        fltr "_Groups", fltr "Touhou_Wiki:", fltr "Special:",
                                                        fltr "Template:", fltr "Category:", fltr "Talk:"]

type Album = [Track]
data Track = Track { title :: String, year :: Int, date :: String,artist :: String,
                     album :: String, event :: String, circle :: String, duration :: Maybe Int,
                     track :: Int } deriving Show
empty :: Track
empty = Track {title="",year=0,date="",album="",event="",circle="",artist="",duration=Nothing,track=0}

header :: String
header = "Title,Year,Date,Album,Event,Circle,Duration,Track"
convert :: Track -> String
convert t = "\"" ++ dequote (title t) ++ "\"," ++ show (year t) ++ "," ++ show (date t) ++ ",\"" ++ dequote (album t) ++ "\",\"" ++
             event t ++ "\",\"" ++ circle t ++ "\"," ++ maybe "" show (duration t) ++ "," ++ show (track t)

-- You are not expected to understand this.
getAlbum :: String -> IO ()
getAlbum a = do t <- fmap parseTags $ openURL a
                --TagText "Released",TagClose "th",TagOpen "td" [],TagText "\n2007-03-23"
                let dt = let target = dropWhile (TagText "Released" ~/=) t
                         in if null target then ""
                            else deleteParens $ fromTagText $ head $ tail $ filter isTagText target
                -- TagText "Released",TagClose "th",TagOpen "td" [],TagText "\n2009/02/08 (",
                -- TagOpen "a" [("href","/wiki/Category:Sunshine_Creation_42"),("title","Category:Sunshine Creation 42")],
                -- TagText "Sunshine Creation 42",TagClose "a",TagText ")",TagClose "td"
                let evnt = let stream = filter isTagText $ dropWhile (TagText "Released" ~/=) t
                           in if '(' == last (fromTagText $ head $ take 5 $ drop 1 stream) -- )
                              then fromTagText (filter isTagText (dropWhile (TagText "Released" ~/=) t) !! 2)
                              else ""
                -- "2007-03-23"
                let yr = if null dt then 0 else read (take 4 dt)::Int
                -- TagText "Album by CODE ZTS LABEL"
                let hasCrcl = [cl | TagText cl <- t, "Album by " `isPrefixOf` cl]
                unless (null hasCrcl || (yr==0 && null dt)) $ do
                    let crcl = lookForCircle t
                    -- TagText "Selfregards2 - Touhou Wiki - Characters, games, locations, and more"
                    let albm = reverse $ drop 55 $ reverse $ head [al | TagText al <- t,
                                 " - Touhou Wiki - Characters, games, locations, and more" `isInfixOf` al]
                    let dflt = empty { date = dt, year = yr, circle = crcl, album = albm, event = evnt }
                    let table = filter (\x -> not ("Disc" `isInfixOf` x || " CD" `isInfixOf` x)) $
                                 filter (not . all isSpace) $
                                  map (trim . fromTagText) $ filter isTagText $
                                   drop 5 $ takeWhile (TagOpen "table"
                                     [("class","navbox"),("cellspacing","0"),
                                      ("style","background:#FFFBEE;border-color:#A8A077;")] ~/=) $
                                       takeWhile (TagComment "" ~/=) $
                                        dropWhile (TagOpen "span"
                                         [("class","mw-headline"),("id","Tracks")] ~/=) t
                    let tracks = filter (not . null) $
                                  split (keepDelimsL $ whenElt
                                   (\x -> length x==3 && "." `isInfixOf` x &&  isJust(maybeRead x :: Maybe Int))) table
                    mapM_ (putStrLn . convert . trackToTrack dflt) tracks

-- TagText "Album by ",TagOpen "a"
-- [("href","/wiki/ALiCE%27S_EMOTiON"),("title","ALiCE'S EMOTiON")],TagText
-- "ALiCE'S EMOTiON",TagClose "a"
lookForCircle :: [Tag String] -> String
lookForCircle t = let c = head [cl | TagText cl <- t, "Album by " `isPrefixOf` cl]
                      res = if c == "Album by " then (let tg = (dropWhile (TagText "Album by " ~/=) t !! 2)
                        in if isTagText tg then fromTagText tg else
                            (if isTagOpen tg then fromAttrib "title" tg else "") ) else drop 9 c
                      in if "(page does not exist)" `isInfixOf` res then takeWhile (/='(') res else res -- )

-- ["01.","The mom","(04:07)","arrangement: ZTS","composition: ZTS","original title: The mom","source: Parhelia"]
trackToTrack :: Track -> [String] -> Track
trackToTrack tr t = tr { track = fromMaybe 0 (maybeRead (head t) :: Maybe Int),
                         title = t !! 1,
                         duration = if length t >=3 then Just (timeConverter $ deleteParens (t !! 2)) else Nothing,
                         artist =  lookForAnArtist t }

lookForAnArtist :: [String] -> String
lookForAnArtist t = let targets = dropWhile (\x -> not ("arrangement:" `isPrefixOf` x || "composition:" `isPrefixOf` x)) t
                        target
                            | null targets = ""
                            | last (head targets) == ':' = head targets ++ (targets !! 1)
                            | otherwise = head targets
                    in trim $ fromMaybe "" $ join $ fmap (stripPrefix "arrangement:") $ stripPrefix "composition:" target

-- 工具函数
openURL :: String -> IO String
openURL url = fmap decodeString (simpleHTTP (getRequest url) >>= getResponseBody)
deleteParens, trim, dequote :: String -> String
deleteParens = trim . filter (\x -> x /= '(' && x /= ')')
trim = reverse . dropWhile isSpace . reverse . dropWhile isSpace
dequote = map (\x -> if x=='"' then '\'' else x) -- "')
timeConverter :: String -> Int
timeConverter n = let (m,s) = break (==':') n
                      m' = maybeRead m :: Maybe Int
                      s' = maybeRead (drop 1 s) :: Maybe Int
                  in (fromMaybe 0 m' * 60) + fromMaybe 0 s'
maybeRead :: Read a => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads
~~~

## VGMdb 爬虫代码

以下是一个用于爬取 VGMdb 上东方专辑的有缺陷的程序；它只能在有限的专辑页面子集上运行，存在数量不明的致命 bug。在我获得只读数据库访问权限后便放弃了它，实际上我用的是数据库访问来获取 VGMdb 数据。留在这里以备将来需要。

~~~{.haskell}
import Text.HTML.TagSoup (fromTagText, isTagOpenName, isTagText, Tag(TagOpen,TagText), parseTags)
import Network.HTTP (getResponseBody, getRequest, simpleHTTP)
import Data.List (isPrefixOf, sort)
import Data.Char (isSpace)
import Codec.Binary.UTF8.String (decodeString)

main :: IO ()
main = do albumsURLs <- getAlbums
          albums <- mapM openURL (sort albumsURLs)
          let metadata = map toAlbum albums
          writeFile "vgmdb.csv" $ unlines (header : concatMap (map convert) metadata)

type Album = [Track]
data Track = Track { title :: String,
                     year :: Int,
                     date :: String,
                     album :: String,
                     circle :: String,
                     duration :: Maybe Int,
                     track :: Int } deriving Show
empty :: Track
empty = Track {title="",year=0,date="",album="",circle="",duration=Nothing,track=0}
header :: String
header = "Title,Year,Date,Album,Circle,Duration,Track"
convert :: Track -> String
convert t = "\"" ++ title t ++ "\"," ++ show(year t) ++ "," ++ show (date t) ++ ",\"" ++
              album t ++ "\",\"" ++ circle t ++ "\"," ++ maybe "" show(duration t) ++ "," ++ show (track t)

-- 示例专辑链接：'TagOpen "a" [("class","albumtitle album-doujin"),
--                                   ("href","http://vgmdb.net/album/36901"),
--                                   ("title","Majo to Ringo to Samayou Kimi to")]'
getAlbums :: IO [String]
getAlbums = do touhou <- openURL "http://vgmdb.net/product/9"
               return [snd(atts !! 1) | TagOpen "a" atts <- parseTags touhou, snd(head atts)=="albumtitle album-doujin"]

-- 需要 'decodeString' 来处理日文字符；参见 http://stackoverflow.com/questions/10558003/how-to-get-utf8-rss-feed
openURL :: String -> IO String
openURL url = fmap decodeString (simpleHTTP (getRequest url) >>= getResponseBody)

toAlbum :: String -> Album
toAlbum page = let tags = parseTags page
                   (yr,dt) = extractDate tags
                   albm = extractAlbum tags
                   crcl = extractCircle tags
                   files = extractMusic tags
               in map (\t -> Track {title = title t, year = yr, date = dt,
                                    album = albm, circle = crcl, duration = duration t,
                                    track = track t}) files


-- TagOpen "a" [("title","View albums released on Dec 30, 2011"),("href","/db/calendar.php?year=2011&month=12#20111230")]
extractDate :: [Tag String] -> (Int,String)
extractDate t = let (a:b:_) = map snd $ head [atts | TagOpen "a" atts <- t,
                                       let ttle = snd(head atts),
                                       "View albums released on " `isPrefixOf` ttle]
        in (read(reverse $ take 4 $ reverse a)::Int,
           tail$ snd $ break (=='#') b)

-- TagOpen "title" [],TagText "Gensou Rashinban - VGMdb",TagClose "title",
extractAlbum :: [Tag String] -> String
extractAlbum t = (\(TagText x) -> reverse $ drop 8 $ reverse x) (dropWhile (not . isTagOpenName "title") t !! 1)

-- [TagText "Published by",TagClose "b",TagClose "span",TagClose "td",TagText "\r\n",
-- TagOpen "td" [],TagOpen "a" [("href","/org/217")],TagOpen "span"
-- [("class","productname"),("lang","en"),("style","display:inline")],TagText "PopKorn"]
extractCircle :: [Tag String] -> String
extractCircle t = fromTagText(head (drop 8 (dropWhile (\x -> not(isTagText x && (fromTagText x)=="Published by")) t)))

extractMusic :: [Tag String] -> [Track]
extractMusic t = let tracks = filter (not . all isSpace) $
                               tail $ dropWhile (\z -> z /= "Disc 1") $
                                map fromTagText $ filter isTagText $
                                 takeWhile (\y -> not(isTagText y && (fromTagText y)=="Disc length")) $
                                  dropWhile (\x -> not(isTagText x && (fromTagText x)=="Tracklist")) t
                   in if length tracks `rem` 3 == 0 then threezip tracks else twozip tracks
       where
       twozip,threezip :: [String] -> [Track]
       threezip [] = []
       threezip (a:b:c:d) = empty {title=b,duration=Just (timeConverter c),track=read a} : threezip d
       threezip _ = []
       twozip [] = []
       twozip (a:b:d) = empty {title=b,duration=Nothing,track=read a} : twozip d
       twozip _ = []
       timeConverter :: String -> Int
       timeConverter n = let (m,s) = break (==':') n in ((read m :: Int) * 60) + (read (tail s) :: Int)
~~~
