---
title: 重新排序媒体评分 (Resorting Media Ratings)
description: 提供交互式统计成对排名和项目排序的命令行工具
created: 2015-09-07
modified: 2018-08-15
status: finished
confidence: likely
importance: 3
css-extension: dropcaps-yinit
...

<div class="abstract">
> 用户创建的基于序数尺度（如媒体评分）的数据集往往会向极端漂移或“结块”，且无法尽可能多地提供信息，容易受天花板效应的影响，难以区分平庸与优秀。
>
> 这可以通过重新评估数据集来建立均匀（因此也是信息丰富的）评分分布来抵消——但这种人工重新评估是困难的。
>
> 我提供了一个随时的 CLI 程序 `resorter`，用 R 编写（应该是跨平台的，但只在 Linux 上测试过），它跟踪比较，假设它们在类似于 ELO 的 [Bradley-Terry 模型](!W) 中存在噪声，从而推断潜在的评分，并以交互方式智能地向用户查询当前评分最不确定的媒体的比较，直到用户结束会话并输出一组完全重新调整的评分。
</div>

**Resorter** 读取一个 CSV 文件，其中包含名称（可选的第二列评分），然后，通过一系列选项，将询问用户具体的比较，直到用户认为排名可能足够准确（与标准比较排序不同，比较允许有噪声！），并退出交互式会话，此时推断出潜在的排名，并打印或写出一组均匀分布的重新排名的评分。

# 使用 (Use)

可用功能：

~~~{.Bash}
$ ./resorter --help
# usage: resorter [--help] [--verbose] [--no-scale] [--no-progress] [--opts OPTS] [--input INPUT] [--output OUTPUT] [--queries QUERIES]
#                 [--levels LEVELS] [--quantiles QUANTILES]
#
# sort a list using comparative rankings under the Bradley-Terry statistical model; see https://gwern.net/resorter
#
#
# flags:
#   -h, --help            show this help message and exit
#   -v, --verbose         whether to print out intermediate statistics
#   --no-scale           Do not discretize/bucket the final estimated latent ratings into 1-l levels/ratings; print out inferred latent scores.
#   --no-progress         Do not print out mean standard error of items
#
# optional arguments:
#   -x, --opts OPTS           RDS file containing argument values
#   -i, --input INPUT         input file: a CSV file of items to sort: one per line, with up to two columns. (eg. both 'Akira\n' and 'Akira, 10\n' are valid).
#   -o, --output OUTPUT           output file: a file to write the final results to. Default: printing to stdout.
#   -n, --queries QUERIES         Maximum number of questions to ask the user; if already rated, 𝒪(items) is a good max, but the more items and more levels in
#                                 the scale, the more comparisons are needed. [default: 2147483647]
#   -l, --levels LEVELS            The highest level; rated items will be discretized into 1-l levels, so l=5 means items are bucketed into 5 levels: [1,2,3,4,5],
#                                  etc. [default: 5]
#   -q, --quantiles QUANTILES         What fraction to allocate to each level; space-separated; overrides `--levels`. This allows making one level of ratings
#                                     narrower (and more precise) than the others, at their expense; for example, one could make 3-star ratings rarer with quantiles
#                                      like `--quantiles '0 0.25 0.8 1'`. Default: uniform distribution (1--5 → '0.0 0.2 0.4 0.6 0.8 1.0').
~~~

下面是一个示例，演示如何使用 `resorter` 让用户进行 10 次比较，将分数重新调整为 1--3 的评分（其中 3 是罕见的），并将新的排名写入文件：

~~~{.Bash .collapse}
$ cat anime.txt
# "Cowboy Bebop", 10
# "Monster", 10
# "Neon Genesis Evangelion: The End of Evangelion", 10
# "Gankutsuou", 10
# "Serial Experiments Lain", 10
# "Perfect Blue", 10
# "Jin-Rou", 10
# "Death Note", 10
# "Last Exile", 9
# "Fullmetal Alchemist", 9
# "Gunslinger Girl", 9
# "RahXephon", 9
# "Trigun", 9
# "Fruits Basket", 9
# "FLCL", 9
# "Witch Hunter Robin", 7
# ".hack//Sign", 7
# "Chobits", 7
# "Full Metal Panic!", 7
# "Mobile Suit Gundam Wing", 7
# "El Hazard: The Wanderers", 7
# "Mai-HiME", 6
# "Kimi ga Nozomu Eien", 6
$ ./resorter.R --input anime.txt --output new-ratings.txt --queries 10 --quantiles '0 0.33 0.9 1'
# Comparison commands: 1=yes, 2=tied, 3=second is better, p=print estimates, s=skip, q=quit
# Mean stderr: 70182  | Do you like 'RahXephon' better than 'Perfect Blue'? 2
# Mean stderr: 21607  | Do you like 'Monster' better than 'Death Note'? 1
# Mean stderr: 13106  | Do you like 'Kimi ga Nozomu Eien' better than 'Gunslinger Girl'? 3
# Mean stderr: 13324  | Do you like 'Kimi ga Nozomu Eien' better than 'Gankutsuou'? p
#                                           Media         Estimate              SE
#                                        Mai-HiME −2.059917500e+01 18026.307910587
#                             Kimi ga Nozomu Eien −2.059917500e+01 18026.308021536
#                              Witch Hunter Robin −1.884110950e-15     2.828427125
#                                     .hack//Sign −7.973125767e-16     2.000000000
#                                         Chobits  0.000000000e+00     0.000000000
#                               Full Metal Panic!  2.873961741e-15     2.000000000
#                         Mobile Suit Gundam Wing  5.846054261e-15     2.828427125
#                        El Hazard: The Wanderers  6.694628513e-15     3.464101615
#                                      Last Exile  1.911401531e+01 18026.308784841
#                             Fullmetal Alchemist  1.960906858e+01 18026.308743986
#                                 Gunslinger Girl  2.010412184e+01 18026.308672318
#                                            FLCL  2.059917511e+01 18026.308236990
#                                   Fruits Basket  2.059917511e+01 18026.308347939
#                                       RahXephon  2.059917511e+01 18026.308569837
#                                          Trigun  2.059917511e+01 18026.308458888
#                                         Jin-Rou  2.109422837e+01 18026.308740073
#                                      Death Note  2.109422837e+01 18026.308765943
#                                    Perfect Blue  2.109422837e+01 18026.308672318
#                         Serial Experiments Lain  2.158928163e+01 18026.308767629
#                                      Gankutsuou  2.208433490e+01 18026.308832127
#  Neon Genesis Evangelion: The End of Evangelion  2.257938816e+01 18026.308865814
#                                    Cowboy Bebop  2.307444143e+01 18026.308979636
#                                         Monster  2.307444143e+01 18026.308868687
# Mean stderr: 13324  | Do you like 'Monster' better than 'Jin-Rou'? s
# Mean stderr: 13324  | Do you like 'Last Exile' better than 'Death Note'? 3
# Mean stderr: 13362  | Do you like 'Mai-HiME' better than 'Serial Experiments Lain'? 3
# Mean stderr: 16653  | Do you like 'Trigun' better than 'Kimi ga Nozomu Eien'? 1
# Mean stderr: 14309  | Do you like 'Death Note' better than 'Kimi ga Nozomu Eien'? 1
# Mean stderr: 12644  | Do you like 'Trigun' better than 'Monster'? 3
$ cat new-ratings.txt
# "Media","Quantile"
# "Cowboy Bebop","3"
# "Monster","3"
# "Neon Genesis Evangelion: The End of Evangelion","3"
# "Death Note","2"
# "FLCL","2"
# "Fruits Basket","2"
# "Fullmetal Alchemist","2"
# "Gankutsuou","2"
# "Gunslinger Girl","2"
# "Jin-Rou","2"
# "Last Exile","2"
# "Perfect Blue","2"
# "RahXephon","2"
# "Serial Experiments Lain","2"
# "Trigun","2"
# "Chobits","1"
# "El Hazard: The Wanderers","1"
# "Full Metal Panic!","1"
# ".hack//Sign","1"
# "Kimi ga Nozomu Eien","1"
# "Mai-HiME","1"
# "Mobile Suit Gundam Wing","1"
# "Witch Hunter Robin","1"
~~~

# 源代码 (Source code)

此 R 脚本需要 [BradleyTerry2](https://cran.r-project.org/web/packages/BradleyTerry2/index.html) 和 [argparser](https://bitbucket.org/djhshih/argparser) 库可用或可安装。
([Andrew Quinn 的 Github 版本](https://github.com/hiAndrewQuinn/resorter) 可能更容易安装。)

<div class="admonition warning">
<div class="admonition-title">Dependency Compile Errors: install packages</div>
与任何用户安装的语言一样，您在安装依赖项时可能会遇到编译错误。

寻找缺失的 C 库作为 root 进行系统范围的安装，或者查看您的包管理器是否已经提供了某个依赖项的预编译二进制文件，这样您就可以 `apt-get install r-cran-bradleyterry2` 或 `apt-get install r-cran-lme4` 来绕过任何编译错误。
</div>

将其作为脚本保存在您的 `$PATH` 中的某个位置，命名为 `resorter`，并使用 `chmod +x resorter` 使其可执行。

~~~{.R}
#!/usr/bin/Rscript

# attempt to load a library implementing the Bradley-Terry model for inferring rankings based on
# comparisons; if it doesn't load, try to install it through R's in-language package management;
# otherwise, abort and warn the user
# https://www.jstatsoft.org/index.php/jss/article/download/v048i09/601
loaded <- library(BradleyTerry2, quietly=TRUE, logical.return=TRUE)
if (!loaded) { write("warning: R library 'BradleyTerry2' unavailable; attempting to install locally...", stderr())
              install.packages("BradleyTerry2")
              loadedAfterInstall <- library(BradleyTerry2, quietly=TRUE, logical.return=TRUE)
              if(!loadedAfterInstall) { write("error: 'BradleyTerry2' unavailable and cannot be installed. Aborting.", stderr()); quit() }
}
# similarly, but for the library to parse command line arguments:
loaded <- library(argparser, quietly=TRUE, logical.return=TRUE)
if (!loaded) { write("warning: R library 'argparser' unavailable; attempting to install locally...", stderr())
              install.packages("argparser")
              loadedAfterInstall <- library(argparser, quietly=TRUE, logical.return=TRUE)
              if(!loadedAfterInstall) { write("error: 'argparser' unavailable and cannot be installed. Aborting.", stderr()); quit() }
}
p <- arg_parser("sort a list using comparative rankings under the Bradley-Terry statistical model; see https://gwern.net/resorter", name="resorter")
p <- add_argument(p, "--input", short="-i",
                  "input file: a CSV file of items to sort: one per line, with up to two columns. (eg. both 'Akira\\n' and 'Akira, 10\\n' are valid).", type="character")
p <- add_argument(p, "--output", "output file: a file to write the final results to. Default: printing to stdout.")
p <- add_argument(p, "--verbose", "whether to print out intermediate statistics", flag=TRUE)
p <- add_argument(p, "--queries", short="-n", default=NA,
                  "Maximum number of questions to ask the user; defaults to N*log(N) comparisons. If already rated, 𝒪(n) is a good max, but the more items and more levels in the scale and more accuracy desired, the more comparisons are needed.")
p <- add_argument(p, "--levels", short="-l", default=5, "The highest level; rated items will be discretized into 1–l levels, so l=5 means items are bucketed into 5 levels: [1,2,3,4,5], etc. Maps onto quantiles; valid values: 2–100.")
p <- add_argument(p, "--quantiles", short="-q", "What fraction to allocate to each level; space-separated; overrides `--levels`. This allows making one level of ratings narrower (and more precise) than the others, at their expense; for example, one could make 3-star ratings rarer with quantiles like `--quantiles '0 0.25 0.8 1'`. Default: uniform distribution (1--5 → '0.0 0.2 0.4 0.6 0.8 1.0').")
p <- add_argument(p, "--no-scale", flag=TRUE, "Do not discretize/bucket the final estimated latent ratings into 1-l levels/ratings; print out inferred latent scores.")
p <- add_argument(p, "--progress", flag=TRUE, "Print out mean standard error of items")
argv <- parse_args(p)

# read in the data from either the specified file or stdin:
if(!is.na(argv$input)) { ranking <- read.csv(file=argv$input, stringsAsFactors=TRUE, header=FALSE); } else {
    ranking <- read.csv(file=file('stdin'), stringsAsFactors=TRUE, header=FALSE); }

# turns out noisy sorting is fairly doable in 𝒪(n * log(n)), so do that plus 1 to round up:
if (is.na(argv$queries)) { n <- nrow(ranking)
                           argv$queries <- round(n * log(n) + 1) }

# if user did not specify a second column of initial ratings, then put in a default of '1':
if(ncol(ranking)==1) { ranking$Rating <- 1; }
colnames(ranking) <- c("Media", "Rating")
# A set of ratings like 'foo,1\nbar,2' is not comparisons, though. We *could* throw out everything except the 'Media' column
# but we would like to accelerate the interactive querying process by exploiting the valuable data the user has given us.
# So we 'seed' the comparison dataset based on input data: higher rating means +1, lower means −1, same rating == tie (0.5 to both)
comparisons <- NULL
for (i in 1:(nrow(ranking)-1)) {
 rating1 <- as.numeric(ranking[i,]$Rating) ## HACK: crashes on reading its own output due to "?>? not meaningful for factors" if we do not coerce from factor to number?
 media1 <- ranking[i,]$Media
 rating2 <- as.numeric(ranking[i+1,]$Rating)
 media2 <- ranking[i+1,]$Media
 if (rating1 == rating2)
  {
     comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=0.5, "win2"=0.5))
  } else { if (rating1 > rating2)
           {
            comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=1, "win2"=0))
            } else {
              comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=0, "win2"=1))
                   } } }
# the use of '0.5' is recommended by the BT2 paper, despite causing quasi-spurious warnings:
# > In several of the data examples (eg. `?CEMS`, `?springall`, `?sound.fields`), ties are handled by the crude but
# > simple device of adding half of a 'win' to the tally for each player involved; in each of the examples where this
# > has been done it is found that the result is similar, after a simple re-scaling, to the more sophisticated
# > analyses that have appeared in the literature. Note that this device when used with `BTm` typically gives rise to
# > warnings produced by the back-end glm function, about non-integer 'binomial' counts; such warnings are of no
# > consequence and can be safely ignored. It is likely that a future version of `BradleyTerry2` will have a more
# > general method for handling ties.
suppressWarnings(priorRankings <- BTm(cbind(win1, win2), Media.1, Media.2, data = comparisons))

if(argv$verbose) {
  print("higher=better:")
  print(summary(priorRankings))
  print(sort(BTabilities(priorRankings)[,1]))
}

set.seed(2015-09-10)
cat("Comparison commands: 1=yes, 2=tied, 3=second is better, p=print estimates, s=skip, q=quit\n")
for (i in 1:argv$queries) {

 # with the current data, calculate and extract the new estimates:
 suppressWarnings(updatedRankings <- BTm(cbind(win1, win2), Media.1, Media.2, br=TRUE, data = comparisons))
 coefficients <- BTabilities(updatedRankings)
 # sort by latent variable 'ability':
 coefficients <- coefficients[order(coefficients[,1]),]

 if(argv$verbose) { print(i); print(coefficients); }

 # select two media to compare: pick the media with the highest standard error and the media above or below it with the highest standard error:
 # which is a heuristic for the most informative pairwise comparison. BT2 appears to get caught in some sort of a fixed point with greedy selection,
 # so every few rounds pick a random starting point:
 media1N <- if (i %% 3 == 0) { which.max(coefficients[,2]) } else { sample.int(nrow(coefficients), 1) }
 media2N <- if (media1N == nrow(coefficients)) { nrow(coefficients)-1; } else { # if at the top & 1st place, must compare to 2nd place
   if (media1N == 1) { 2; } else { # if at the bottom/last place, must compare to 2nd-to-last
    # if neither at bottom nor top, then there are two choices, above & below, and we want the one with highest SE; if equal, arbitrarily choose the better:
    if ( (coefficients[,2][media1N+1]) > (coefficients[,2][media1N-1])  ) { media1N+1 } else { media1N-1 } } }

 targets <- row.names(coefficients)
 media1 <- targets[media1N]
 media2 <- targets[media2N]

 if (argv$`progress`) { cat(paste0("Mean stderr: ", round(mean(coefficients[,2]))), " | "); }
 cat(paste0("Is '", as.character(media1), "' greater than '", as.character(media2), "'? "))
 rating <- scan("stdin", character(), n=1, quiet=TRUE)

 switch(rating,
        "1" = { comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=1, "win2"=0)) },
        "3" = { comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=0, "win2"=1)) },
        "2" = { comparisons <- rbind(comparisons, data.frame("Media.1"=media1, "Media.2"=media2, "win1"=0.5, "win2"=0.5))},
        "p" = { estimates <- data.frame(Media=row.names(coefficients), Estimate=coefficients[,1], SE=coefficients[,2]);
                print(comparisons)
                print(warnings())
                print(summary(updatedRankings))
                print(estimates[order(estimates$Estimate),], row.names=FALSE) },
        "s" = {},
        "q" = { break; }
        )
}

# results of all the questioning:
if(argv$verbose) { print(comparisons); }

suppressWarnings(updatedRankings <- BTm(cbind(win1, win2), Media.1, Media.2, ~ Media, id = "Media", data = comparisons))
coefficients <- BTabilities(updatedRankings)
if(argv$verbose) { print(rownames(coefficients)[which.max(coefficients[2,])]);
                 print(summary(updatedRankings))
                 print(sort(coefficients[,1])) }

ranking2 <- as.data.frame(BTabilities(updatedRankings))
ranking2$Media <- rownames(ranking2)
rownames(ranking2) <- NULL

if(!(argv$`no_scale`)) {

    # if the user specified a bunch of buckets using `--quantiles`, parse it and use it,
    # otherwise, take `--levels` and make a uniform distribution
    levels <- max(2,min(100,argv$levels+1)) ## needs to be 2–100
    quantiles <- if (!is.na(argv$quantiles)) { (sapply(strsplit(argv$quantiles, " "), as.numeric))[,1]; } else {
      seq(0, 1, length.out=levels); }
    ranking2$Quantile <- with(ranking2, cut(ability,
                                    breaks=quantile(ability, probs=quantiles),
                                    labels=1:(length(quantiles)-1),
                                    include.lowest=TRUE))
    df <- subset(ranking2[order(ranking2$Quantile, decreasing=TRUE),], select=c("Media", "Quantile"));
    if (!is.na(argv$output)) { write.csv(df, file=argv$output, row.names=FALSE) } else { print(df); }
} else { # return just the latent continuous scores:
         df <- data.frame(Media=rownames(coefficients), Estimate=coefficients[,1]);
         if (!is.na(argv$output)) { write.csv(df[order(df$Estimate, decreasing=TRUE),], file=argv$output, row.names=FALSE); } else {
             print(finalReport); }
       }

cat("\nResorting complete")
~~~

# 背景 (Background)

## 评分膨胀 (Rating Inflation)

在像 [GoodReads](!W)、亚马逊、[MyAnimeList](https://myanimelist.net/)、[Uber/Lyft](https://www.youtube.com/watch?v=iu6eWy7BKKI "'吉格经济中的服务质量', Athey 等人 2018")、[自由职业市场](https://gwern.net/doc/statistics/order/comparison/2022-filippas.pdf "'声誉膨胀', Filippas 等人 2018") 等评论网站上对数百种媒体进行评分时，分布往往会变得“结块”并集中在少数几个可能的最高评分上：如果是 10 分制，你通常不会看到很多低于 7 分的，或者如果是 5 星制，[那么任何](https://xkcd.com/325/) [低于 4 星的都表示极度厌恶](https://xkcd.com/1098/)，导致 J 形分布和互联网版本的 [分数膨胀](!W)。
经过足够长的时间和膨胀后，评级已经退化为无信息的二元评级量表，一些网站认识到了这一点，放弃了伪装，如 [YouTube](https://blog.youtube/news-and-events/five-stars-dominate-ratings/ "五星主导评级") 或 [Netflix 从 5 星切换到喜欢/不喜欢](https://variety.com/2017/digital/news/netflix-thumbs-vs-stars-1202010492/ "Netflix 用拇指向上和拇指向下取代星级评级")。
现有评级中的自我选择和其他问题，如 [发表偏差](https://datacolada.org/72 "Metacritic 有一个（抽屉）问题") 会产生一些反常的后果：例如，获奖实际上可能 *降低* 一本书的 Good<!-- -->Reads 平均评分，因为该奖项导致更广泛、更不包容的受众去阅读这本书 ([Kovács & Sharkey 2014](https://gwern.net/doc/culture/2014-kovacs.pdf "宣传的悖论：奖项如何负面影响质量评估"))。

如果你想向其他人提供评分和评论并表明你的真实偏好，这是不幸的；当我在 [MALgraph](https://anime.plus/gwern/ratings,anime) 上点赞并看到我的一半以上的动漫评分都在 8--10 范围内时，那么，我的评分已经退化为大约 1--3 的量表（垃圾/好/很棒），这使得很难看出哪些真正值得一看，以及哪些我可能想回去重看。
因此，评级所携带的信息比人们可能从量表中猜测的要少得多（10 分制在每个评级中有 3.32 位信息，但如果它实际上退化为 3 分制，那么信息量已减半至 1.58 位）。
如果相反，我的评分均匀分布在 1--10 的范围内，使得 10% 被评为 1，10% 被评为 2，依此类推，那么我的评分将包含更多信息，我的观点也会更清晰。
（也许是第一世界的问题，但仍然很烦人。）

## 评分 *应该* 是什么分布？

如果 J 形分布不好，那么一个人的评分应该是什么分布？

正态分布有一定的美感，也很常见，但这并不是理由。
首先，没有太多理由认为媒体本身应该正态分布。
正态分布的普遍性来自 [中心极限定理](!W "Central limit theorem")，以及许多变量相加往往会产生正态分布；然而，艺术作品仅仅是 *各部分的总和* 吗？
我会说不：它们更像是各部分的乘积，而许多随机变量相乘往往会产生类似 [对数正态分布](!W) 的东西。
如果艺术真的是正态分布的，为什么我们经常看一部动漫并说，“那有着非常棒的艺术和音乐以及配音，但是... 情节 *太* 愚蠢了，我完全无法享受它，我不得不给它一个低分，并且永远不会再看它了”？毕竟，如果它们只是相加，所有其他变量都足以使整体分数变得很棒。同时，一部这就各方面都做得很好的作品可能会仅仅因为没有任何缺陷而实现伟大——这一切都以超过各部分之和的方式结合在一起。
其次，我们不是在观看从整体分布中抽取的随机样本，我们通常试图从质量的右尾抽取高度偏差的样本（即只看好的）。
如果我们做得很好，我们的评分样本看起来一点也不像整体分布，就像 NBA 的身高图表看起来一点也不像美国人口的身高图表一样。

均匀分布也有类似的问题。
它的优势如上所述，在于它包含更多信息：正态分布将评分聚集在中间，大多数落在 5，只有少数达到 1 或 10，而均匀分布使信息最大化——最差的 10% 被评为 1，依此类推，最好的 10% 被评为 10。
如果你从均匀分布中得知某样东西是 5，你会学到更多（它在 50--60% 的范围内），而不是如果是正态分布（它是 50±??%）。

但是，如果评论家使用正态分布而不是均匀分布，我想我宁愿看他们的评分。
为什么？因为，正如我所说，我们通常试图看 *好* 的东西，如果我看到某样东西被评为 10，我知道它在顶部的百分之一或二，而均匀分布的选择性要低 5--10 倍，那里的 10 只告诉我它在顶部十分位数，这并没有太大的选择性。
如果一位评论家认为某样东西在顶部的百分之一，我会注意；但顶部十分位数并没有太大用处帮助我找到我可能想要的东西。

所以，我认为我们的目标分布应该最大化 *有用性*：这只是对其不可知的潜在分布的总结，我们将其实用地总结为评分，因此 [像评分这样的统计数据](/research-criticism "'How Should We Critique Research?', Gwern 2019") 只有在它们定义的预期用途中才分对错。
在一个评分网站上，我们对在平庸或垃圾中进行细微区分不感兴趣。
我们正在寻找有趣的新候选者来考虑，我们正在寻找最好的。
偏斜最大化了在可能推荐的感兴趣区域向读者提供的信息。
所以我们的分布应该把大部分评分扔进一个无信息的“meh”桶里，并在右尾极端花更多时间：我们认为一部给定的作品是空前的杰作，还是例外的，或者仅仅是好的？

我们要的是一个 *反 J 形分布*：其中大多数评分都是最低的，只有少数是最高的。
（对于较小的评分集，那么不那么极端的偏斜会有用：如果大多数评分几乎是空的，那就没用了。人们可能还会努力去，甚至使用成对评分，表达这样精确的百分位数，并回退到最小规模，比如 5%。）

就百分位数而言，以我观看/放弃的约 458 部动漫为例，我可以这样划分：

<div class="columns">
#. 0--50% (_n_ = 231)
#. 51--75% (_n_ = 112)
#. 76%--89% (_n_ = 62)
#. 90--93% (_n_ = 16)
#. 94--95% (_n_ = 11)
#. 96% (_n_ = 7)
#. 97% (_n_ = 6)
#. 98% (_n_ = 6)
#. 99% (_n_ = 5)
#. \>99.5% (_n_ = 2)
</div>

那将对应于使用选项 `--quantiles '0 0.5 0.75 0.89 0.93 0.95 0.96 0.97 0.98 0.99 0.995'`。

## 重新缩放 (Rescaling)

### 通过排序进行交互式排名 (Interactive Ranking Through Sorting)

对于只有 10 或 20 个评分，很容易手动审查和重新调整评分并解决歧义（哪个 '8' 比其他 '8' 差，应该被降到 7？），但由于判断是如此脆弱和主观，以及 ['选择疲劳'](!W "Decision fatigue") 开始出现，我发现自己不得不反复扫描列表并问自己“X *真的* 比 Y 好吗...？嗯...”。
所以不出所料，对于像我的 408 部动漫或 2059 本书这样的大型语料库，我从来没有费心去尝试这样做——更不用说随着评分的漂移偶尔做一次了。

如果我有某种程序可以反复询问我新的评分，存储结果，然后吐出一个关于究竟如何更改评分的综合列表，那么我可能能够，在极少数情况下，纠正我的评分。
这将帮助我们重新评估现有的媒体语料库，但它也可以帮助我们对其他事物进行排序：例如，我们可以尝试通过获取所有我们标记为“待读”的书籍或电影，然后进行比较来对每个项目进行优先排序，根据我们对它的兴奋程度或重要性或我们想多快阅读它来进行排名。
（如果我们有太多的事情要做，我们也可以通过这种方式对我们的整体待办事项列表进行排序，但很可能很容易手动排序。）

但它不能要求我给出绝对评分，因为如果我能轻易地给出均匀分布的评分，我就不会有这个问题了！
所以它应该计算排名，然后采取最终排名并将其分布在量表中的任何桶中：如果我为 MAL 的 1--10 排名对 100 部动漫进行评分，那么它将把底部的 10 部放入 '1' 桶，第 10--20^th^ 部放入 '2' 桶，依此类推。
这不能自动完成。

如何获得排名：如果有 1,000 种媒体，我不可能明确地将一本书排名为 '#952' 或 '#501'。没有人有那么强的掌控力。
也许让它让我比较成对的媒体会更好？
比较更自然，不那么疲劳，并通过提醒我还有什么其他媒体以及我是如何看待它们的来帮助我判断——当一部糟糕的电影与一部伟大的电影相提并论时，它会提醒你为什么一部糟糕而另一部伟大。
比较也立即暗示了一种实现，即经典的比较排序算法，如快速排序或归并排序，其中比较参数是一个 IO 函数，只是简单地调用用户；产生合理的 𝒪(n · log(_n_)) 数量的查询（如果我们要么拥有预先存在的评分并可以将其视为 [自适应排序](!W)，则可能少得多，𝒪(_n_)）。
所以我们可以用任何像 Python 这样体面的编程语言编写一个简单的脚本来解决这个问题，这种重新排序由像 [Flickchart](https://www.flickchart.com/Splash.aspx?return=%2f) 这样的网站提供。

### 噪声排序 (Noisy Sorting)

比较排序算法在这种情况下做出了一个极不现实的假设：它们假设比较是 100% 准确的。

也就是说，假设你有两个排序列表，各 1,000 个元素，你将一个列表中的最低元素与另一个列表中的最高元素进行比较，如果第一个更高，那么第一个列表中的所有 1,000 个项目都高于第二个列表中的所有 1,000 个项目，即在 (<span class="subsup"><sub>2</sub><sup>1,000</sup></span>) = 499,500 可能的成对比较中，排序算法假设没有一个项目错位，没有一个成对比较是不正确的。
这种假设在编程中很好，因为 CPU 擅长比较位的相等性，并且可能会进行数万亿次操作而不会犯一个错误；但期望人类在任何任务中都有这种可靠性是荒谬的，更不用说在这个任务中，我们笨拙地感受着我们灵魂对伟大艺术家的反应。

我们要对电影、书籍或音乐进行的比较 *是* 容易出错的，所以我们需要某种统计排序算法。
这有多大伤害？我们会得到某种更糟糕的样本效率吗？

不。
事实证明，“噪声排序”设置与比较排序设置没有太大区别：那里的最佳渐近性能也是 𝒪(_n_ · log(_n_))。
来自比较错误率 _p_ 的惩罚只是被折叠到常数中（因为随着 _p_ 接近 0，它变得更容易并转化为常规比较排序）。

一些参考文献：

- Slater 1961, ["Inconsistencies in a schedule of paired comparisons"](https://gwern.net/doc/statistics/order/comparison/1961-slater.pdf)
- David 1963, ["The method of paired comparisons"](https://apps.dtic.mil/sti/pdfs/ADA417190.pdf#page=15)
- Adler et al 1994, ["Selection in the presence of noise: The design of playoff systems"](http://www-cgi.cs.cmu.edu/afs/cs.cmu.edu/Web/People/harchol/Papers/SODA94-ranking.pdf)
- Feige et al 1994, ["Computing with noisy information"](https://cadmo.ethz.ch/education/lectures/HS18/SAADS/papers/computing_noisy_information.pdf)
- Glickman 1999, ["Parameter estimation in large dynamic paired comparison experiments"](https://math.bu.edu/individual/mg/research/glicko.pdf)
- Pelc 2002, ["Searching games with errors---fifty years of coping with liars"](https://gwern.net/doc/statistics/order/comparison/2002-pelc.pdf)
- Chu & Ghahramani 2005, ["Preference learning with Gaussian processes"](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.437.20&rep=rep1&type=pdf)
- Karp & Kleinberg 2007, ["Noisy binary search and its application"](https://gwern.net/doc/statistics/order/comparison/2007-karp.pdf "‘Noisy binary search and its applications’, Karp & Kleinberg 2007")
- Radlinski & Joachims 2007, ["Active exploration for learning rankings from clickthrough data"](https://www.cs.cornell.edu/~tj/publications/radlinski_joachims_07a.pdf)
- Kenyon-Mathieu & Schudy 2007, ["How to rank with few errors"](https://cs.brown.edu/research/pubs/theses/masters/2007/schudy.pdf)
- Ailon et al 2008, ["Aggregating inconsistent information: ranking and clustering"](https://gwern.net/doc/statistics/order/comparison/2008-ailon.pdf "'Aggregating inconsistent information: Ranking and clustering', Ailon et al 2008")
- Braverman & Mossel 2008, ["Noisy sorting without resampling"](https://arxiv.org/abs/0707.1051 "'Noisy Sorting Without Resampling', Braverman & Mossel 2007") / Braverman & Mossel 2009, ["Sorting from noisy information"](https://arxiv.org/abs/0910.1191 "'Sorting from Noisy Information', Braverman & Mossel 2009")
- Yue & Joachims 2011, ["Beat the mean bandit"](http://www.yisongyue.com/publications/icml2011_beat_the_mean.pdf)
- Houlsby et al 2011, ["Bayesian Active Learning for Classification and Preference Learning"](https://arxiv.org/abs/1112.5745)
- Yue et al 2012, ["The _K_-armed dueling bandits problem"](https://www.learningtheory.org/colt2009/papers/006.pdf)
- Busa-Fekete et al 2014, ["Preference-based rank elicitation using statistical models: The case of Mallows"](https://inria.hal.science/hal-01079369/document)
- Szorenyi et al 2015, ["Online Rank Elicitation for Plackett-Luce: A Dueling Bandits Approach"](https://proceedings.neurips.cc/paper/2015/file/7eacb532570ff6858afd2723755ff790-Paper.pdf)
- Maystre & Grossglauser 2015, ["Just Sort It! A Simple and Effective Approach to Active Preference Learning"](https://arxiv.org/abs/1502.05556)
- Christiano et al 2017, ["Deep reinforcement learning from human preferences"](https://arxiv.org/abs/1706.03741#openai); Henderson et al 2017, ["OptionGAN: Learning Joint Reward-Policy Options using Generative Adversarial Inverse Reinforcement Learning"](https://arxiv.org/abs/1709.06683)
- Le et al 2017, ["Analogical-based Bayesian Optimization"](https://arxiv.org/abs/1709.06390)
- Chen et al 2017, ["Spectral Method and Regularized MLE Are Both Optimal for Top-_K_ Ranking"](https://arxiv.org/abs/1707.09971 "'Spectral Method and Regularized MLE Are Both Optimal for Top-<em>K</em> Ranking', Chen et al 2017")
- Kazemi et al 2018, ["Comparison Based Learning from Weak Oracles"](https://arxiv.org/abs/1802.06942)
- Liu et al 2018, ["Model-based learning from preference data"](https://hal.science/hal-01972948/document#pdf)

## 实现 (Implementation)

所以我们想要一个命令行工具，它使用成对的媒体和评分列表，然后用成对的媒体反复询问用户，以获得用户对哪个更好的评分，以某种方式对潜在得分进行建模，同时允许用户在多次比较中出错，理想情况下选择任何“信息最丰富”的下一对来询问，以便尽可能快地收敛到准确的排名，并在足够多的问题之后，对所有媒体的完整排名进行最终推断，并将其映射到特定评分量表上的均匀分布。

看待这个问题的自然方式是将每个竞争者视为在一个基数尺度上具有未被观察到的 [潜在变量](!W) '质量' 或 '能力' 或 '技能'，该变量通过比较以误差来衡量，然后削弱传递性来连接我们的比较：如果 A 击败 B 且 B 击败 C，那么 *可能* A 击败 C，这取决于我们观察到的击败次数以及我们对 A-C 潜在变量估计的精确度。

成对或基于比较的数据在竞争环境中经常出现，例如著名的 [Elo 评级系统](!W) 或贝叶斯 [TrueSkill](!W)。
处理它的一个通用模型是 Bradley-Terry 模型。

R 中至少有两个用于处理 Bradley-Terry 模型的包，[`BradleyTerry2`](https://www.jstatsoft.org/index.php/jss/article/download/v048i09/601 "Bradley-Terry Models in R: The BradleyTerry2 Package") 和 [`prefmod`](https://www.jstatsoft.org/index.php/jss/article/download/v048i10/602 "prefmod: An R Package for Modeling Preferences Based on Paired Comparisons, Rankings, or Ratings")。
后者支持比前者更复杂的分析，但它希望其数据格式不方便，而 `BradleyTerry2` 更容易增量更新。
（我想将我的数据以媒体/媒体/评级的长三元组列表的形式提供给库，这可以通过简单地向底部添加另一个三元组来轻松地使用用户输入进行更新；但 `prefmod` 希望为每种可能的媒体提供一列，这在一开始就很尴尬，如果有 1,000 多种媒体可供比较，情况会变得更糟。）

我们从两个向量开始：媒体列表和原始评分列表。
原始评分虽然不够平滑且需要改进，但仍然是不容忽视的有用信息；如果 BT-2 是一个贝叶斯库，我们可以将它们用作信息先验，但它不是，所以我采用了一种黑客手段，即程序运行列表，将每部动漫与下一部动漫进行比较，如果相等，则视为平局，否则记录为胜/负——所以即使从一开始，我们在推断它们的潜在得分方面也取得了很大进展。

然后一个循环询问用户 _n_ 次比较；我们想询问估计最不确定的媒体，一种估计方法是查看哪些媒体具有最大的 [标准误差](!W)。
你可能会认为只询问当前标准误差最大的两个媒体将是最好的探索策略（因为这对应于强化学习和多臂老虎机方法，你从探索最不确定的事情开始），但令人惊讶的是，这导致一次又一次地询问同一个媒体，即使标准误差直线下降。
我不确定为什么会发生这种情况，但我认为这与先验信息在所有媒体上创建排序或层次结构有关，然后最大似然估计导致一次又一次地重复相同的问题，以在基数尺度上下移动排序（无论估计如何上移或下移，我们离散化的评级都将是不变的）。
所以相反，我们在询问具有最大标准误差的媒体（选择最近的邻居，向上或向下，具有较大的标准误差）和偶尔随机选择之间交替，所以它通常专注于最不确定的媒体，但偶尔也会询问其他媒体。
（类似于 RL 中的固定 epsilon 探索。）

在所有问题都问完之后，进行最终估计，媒体按排名排序，并映射回用户指定的评分量表。

### 为什么不是贝叶斯？ (Why Not Bayes?)
#### 贝叶斯改进 (Bayesian Improvements)

这种方法有两个问题：

#. 它没有任何原则性的不确定性指示，
#. 结果是，它可能并没有提出最佳问题。

第一个是最大的问题，因为我们无法知道何时停止。
也许在 10 个问题之后，*真正的* 不确定性仍然很高，我们的最终评分仍然会错位；或者也许收益递减已经出现，需要更多的问题才能消除错误，以至于我们更愿意只是手动纠正少数错误的评分。
而且我们不想仅仅因为排序不足的可能性就将问题数量增加到像 200 这样繁重的程度。
相反，我们想要一些可理解的概率，即每个媒体都被分配到了正确的桶中，也许还有总体误差的界限：例如，如果我可以指定像“所有媒体至少在其正确的桶中的概率为 90%”之类的东西，我会很满意。^[我认为这可以通过对后验进行采样来完成：从每个媒体的后验中抽取估计分数的随机样本并将它们全部离散化；这样做，比如说，100 次；比较 100 个离散化的结果，看看任何媒体改变类别的频率。如果每个媒体都在同一个桶里，比如说，在这些样本中的 95 个里——_教父_ 在 100 个样本中的 95 个里都在 5 星桶里，在其他 5 个里都在 4 星桶里——那么估计分数的剩余不确定性一定很小。]

由于 BF-2 本质上是一个频率主义库，它永远不会给我们这种答案；它在这方面所能提供的只有 _p_ 值——这是对我从未问过的问题的回答——以及标准误差，这 *某种程度上* 是不确定性的指标，比没有好，但仍然不完美。
在我们对顺序试验方法的兴趣和我们对产生有意义的误差概率的兴趣（以及我自己对贝叶斯方法的偏好）之间，这激发了寻找贝叶斯实现的动力。

Bradley-Terry 模型可以在 JAGS/Stan 中轻松拟合；两个较少和较详尽的例子分别在 [Jim Albert 的实现](https://web.archive.org/web/20160102165131/http://bayes.bgsu.edu/webinar.11.2012/R%20output/Rcode.part4.html "Part 4: Introduction to JAGS") 和 [Shawn E. Hallinan](https://gwern.net/doc/statistics/order/comparison/2005-hallinan.pdf "Paired Comparison Models for Ranking National Soccer Teams")，以及 [`btstan`](https://github.com/nxskok/btstan/blob/master/R/btstan.R) 中。
虽然它没有实现带有平局的扩展 B-T，但 Albert 的例子很容易修改，我们可以尝试像这样推断排名：

~~~{.R}
comparisons2 <- comparisons[!(comparisons$win1==0.5),]

teamH = as.numeric(comparisons2$Media.1)
teamA = as.numeric(comparisons2$Media.2)
y = comparisons2$win1
n = comparisons2$win1 + comparisons2$win2
N = length(y)
J = length(levels(comparisons$Media.1))
data = list(y = y, n = n, N = N, J = J, teamA = teamA, teamH = teamH)
data ## reusing the baseball data for this example:
# $y
#  [1] 4 4 4 6 4 6 3 4 4 6 6 4 2 4 2 4 4 6 3 5 2 4 4 6 5 2 3 4 5 6 2 3 3 4 4 2 2 1 1 2 1 3
#
# $n
#  [1] 7 6 7 7 6 6 6 6 7 6 7 7 7 7 6 7 6 6 6 6 7 7 6 7 6 7 6 6 7 6 7 6 7 7 6 6 7 6 7 6 7 7
#
# $N
# [1] 42
#
# $J
# [1] 7
#
# $teamA
#  [1] 4 7 6 2 3 1 5 7 6 2 3 1 5 4 6 2 3 1 5 4 7 2 3 1 5 4 7 6 3 1 5 4 7 6 2 1 5 4 7 6 2 3
#
# $teamH
#  [1] 5 5 5 5 5 5 4 4 4 4 4 4 7 7 7 7 7 7 6 6 6 6 6 6 2 2 2 2 2 2 3 3 3 3 3 3 1 1 1 1 1 1
#
model1 <- "model {
    for (i in 1:N){
        logit(p[i]) <- a[teamH[i]] - a[teamA[i]]
        y[i] ~ dbin (p[i], n[i])
    }
    for (j in 1:J){
        a[j] ~ dnorm(0, tau)
    }
    tau <- pow(sigma, -2)
    sigma ~ dunif (0, 100)
}"
library(runjags)
j1 <- autorun.jags(model=model1, monitor=c("a", "y"), data=data); j1
~~~

（这重用了之前的将先验转换为数据的技巧。）
这将产生合理的评分，但 MCMC 与快速迭代的最大似然算法相比不可避免地有开销，后者只估计参数——在示例数据上运行大约需要 1 秒。
这种开销大部分来自 JAGS 的设置和解释模型，也许通过使用 Stan 可以减半（因为它缓存编译的模型），但无论如何，0.5 秒对于特别愉快的交互式使用来说太长了（从响应到下一个问题的总时间应 <0.1 秒以获得最佳用户体验），但如果我们可以获得更好的问题，这就值得付出吗？
可能会有加速的方法；这涉及到估计潜在的正态/高斯变量，这通常有快速的实现。
例如，如果发现贝叶斯推断可以通过解析解在 MCMC 之外完成，或者更有可能的是，通过拉普拉斯近似，例如在支持 [潜在高斯](https://gwern.net/doc/statistics/order/comparison/2010-martino.pdf "'Case Studies in Bayesian Computation using INLA', Martino & Rue 2010") 的 [INLA](https://www.r-inla.org/) 中实现的，我不会感到惊讶。
最近，Stan 支持基于优化的 [梯度下降](!W) 贝叶斯推断（[变分推断](!W)），它提供了足够准确的后验，同时对于交互式使用来说足够快。

#### 最优探索 (Optimal Exploration)

继续，通过 MCMC 实现，我们可以看看如何以最佳方式采样数据。
在这种情况下，因为我们正在收集数据，并且用户可以随时停止，所以我们并不太关心损失函数，而是最大化信息增益——弄清楚哪对媒体产生最高的“预期信息增益”。

一种可能的方法是重复我们的启发式方法：估计每个媒体的熵，选择熵最高/后验分布最宽的那个，并选择一个随机比较。
更好的方法可能是改变这种做法：选择重叠最多的两个媒体（使用潜在变量的后验样本比仅使用置信区间更直截了当，因为置信区间毕竟并不意味着“真实变量以 95% 的概率在这个范围内”）。
这看起来好得多，但仍然可能不是最优的，因为它忽略了任何下游效应——我们可能会通过在一个大类的电影中间采样来减少不确定性，而不是采样彼此靠近的两个异常值。

正式的 EI 在实现层面上没有太多文档记录，但算法的最一般形式似乎是：对于每个可能的动作（在本例中，每一对可能的媒体），从作为一个假设动作的后验中抽取一个样本（从 MCMC 对象，抽取两个媒体的分数估计并比较哪个更高），重新运行并更新分析（将比较结果添加到数据集并在其上再次运行 MCMC 以产生一个新的 MCMC 对象），在这两个旧的和新的 MCMC 对象上，计算分布的熵（在这种情况下，每个可能的媒体对中较高的概率的所有对数的总和？），并用新的减去旧的；对每个动作做大约 10 次，以便熵的估计变化相当稳定；然后找到熵变化最大的可能动作，并执行它。

##### 计算要求 (Computational Requirement)

如果不实现它，这是不可行的。
从计算的角度来看：有 (<span class="subsup"><sub>2</sub><sup><em>media</em></sup></span>) 种可能的动作；每次 MCMC 运行大约需要 1 秒；必须有 10 次 MCMC 运行；并且熵计算需要一点时间。
对于仅 20 个媒体，那将需要 ((<span class="subsup"><sub>2</sub><sup>20</sup></span>) × 10 × 1) / 60 = (190 × 10) / 60 = 31 分钟。

我们可以并行运行这些^[我们也可以在等待用户进行当前评分时推测性地执行，因为只有 3 种可能的选择（更好/更差/平局），我们最终必须计算其中之一；如果我们为通过所有 3 种假设选择计算最佳的下一个选择，那么我们已经知道接下来要问什么，那么就用户而言，它可能看起来是瞬间的，零延迟。]，可以尝试进一步减少 MCMC 迭代并冒偶尔不收敛的风险，可以尝试仅计算有限数量的选择（也许是 20 个随机选择的选项）的 EI，或者寻找一些闭式解析解（也许假设正态分布？）——但很难看到如何将总运行时间降低到 0.5 秒——更不用说 ~0.1 秒了。
而且在打包方面，要求用户根本安装 JAGS（更不用说 Stan）会使 `resorter` 更难安装，并且更有可能出现不透明的运行时错误。

如果要求用户比较两件事是罕见且昂贵的数据，如果我们绝对必须最大化每个问题的信息价值，如果我们正在进行硬核科学，如 [天文观测](https://hosting.astro.cornell.edu/~loredo/bayes/bae.pdf "'Bayesian Adaptive Exploration', Loredo & Chernoff 2003")，其中每一分钟的望远镜时间可能以数千美元来衡量，那么 1 小时的运行时间来优化问题选择是可以的。但我们不是。
如果用户需要被多问 5 个问题，因为标准误差探索启发式算法是次优的，那会花费他们几秒钟。没什么大不了的。
如果我们不利用贝叶斯方法的额外力量，为什么要从 BF-2 切换到 JAGS 呢？

# 另请参阅 (See Also)

- [使用 GPT-2 进行偏好学习](/gpt-2-preference-learning "'GPT-2 Preference Learning for Music Generation', Gwern 2019"){.backlink-not}

# 外部链接 (External Links)

- [效用函数提取器：简单的比较投票来创建效用函数](https://forum.effectivealtruism.org/posts/9hQFfmbEiAoodstDA/simple-comparison-polling-to-create-utility-functions)
- ["fullrank：一个基于噪声比较的列表排名贝叶斯推断的交互式 CLI 工具和 Python 库。"](https://github.com/max-niederman/fullrank "‘<code>fullrank</code>: An interactive CLI tool and Python library for Bayesian inference of list rankings based on noisy comparisons’, Niederman 2025") ([博客](https://www.lesswrong.com/posts/ojZL2iSgFnASmRNnN/fullrank-bayesian-noisy-sorting-1 "‘Fullrank: Bayesian Noisy Sorting’, Niederman 2025"){#niederman-2025-blog})
