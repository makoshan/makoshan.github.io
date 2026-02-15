---
title: Google Alerts 的结果变化
description: Google Alerts 近几年返回更少结果吗？一项统计调查
thumbnail: /doc/technology/google/alerts/gwern-linksperemail.png
thumbnail-text: 每封 Google Alerts 邮件中的链接数，随时间变化（2007–2013）
created: 2013-07-01
modified: 2013-11-26
status: finished
confidence: likely
importance: 4
css-extension: dropcaps-yinit
...

<div class="abstract">
> Google Alerts 近几年是否发回更少结果？是的。回应其是否会终止服务的谣言，我分析了个人 Google Alerts 通知（2007–2013）中的结果数量，发现直到 [2011 年中](#it-was-mid-2011)之前并没有整体下降趋势，但在那里出现了结果显著下滑。我推测了其 [原因](#panda) 以及对 Alerts 未来的 [含义](#conclusion)。
</div>

在研究我那篇关于 Google 服务寿命分布的文章《[预测 Google 关闭](/google-shutdown "Predicting Google closures")》（Gwern, 2013）时，我看到 [Google Alerts](!W)（代你运行查询并邮件推送新匹配页面——这是跟进主题的极佳工具，也是 Google 最古老的服务之一）在 2012 年间被传言[坏掉了](https://searchengineland.com/google-alerts-arent-working-148642 "Dear Google Alerts: Why Aren't You Working?")[“不正常地坏掉”](https://searchengineland.com/google-alerts-still-broken-152444 "Google Alerts: Still Broken")[到不能用了](https://web.archive.org/web/20131218052436/https://thefinancialbrand.com/28346/google-alerts-broken/ "An Open Letter to Google: Google Alerts Broken, Now Useless To Financial Marketers")。看到这点时，我想起自己的 Alerts 似乎也没以前好用，但不确定是服务问题还是我搜索词本身变得不活跃。Google 对该问题的官方回应极少。[^official-reply]

[^official-reply]: [“Google Alerts 到底怎么了？这个小而实用的服务似乎在走下坡路。一个研究者用实证方式回答了 Google 不愿回答的问题。”]，出自 _BuzzFeed_：

    > Google 一直拒绝说明衰退原因。今天，Google 发言人告诉 BuzzFeed，“我们始终在改进产品——会继续更新 Google Alerts，让它对用户更有用。” 换句话说，这是一个礼貌的拒答。

在我看来，若 Alerts 挂掉会很麻烦，因为我自 2007-01-28（2347 天）以来长期使用它（目前有 23 个 Alerts，过去还更多），在总计 501,662 封邮件里有 3,815 封是 Alerts；而且我似乎也没有发现可替代方案^[我看过一些替代服务，如 [Yahoo! Search Alerts](https://www.ghacks.net/2013/06/29/yahoo-search-alerts-a-google-alerts-alternative/)、[talkwalker](https://www.talkwalker.com/) 和 [Mention](https://mention.com/en/)，但都没真正使用；后两者在[与 Google Alerts 的比较](https://moz.com/blog/google-alerts-vs-mention-vs-talkwalker "Google Alerts VS Mention VS Talkwalker")里表现都还不错]。更麻烦的是，从 2013 年 [7 月](https://googlesystem.blogspot.com/2013/07/google-alerts-drops-rss-feeds.html "Google Alerts Drops RSS Feeds") 到 [9 月](https://thenextweb.com/news/google-alerts-regains-rss-delivery-option-it-lost-after-google-readers-demise "Google Alerts regains RSS delivery option it lost after Google Reader's demise")，Alerts 的 RSS 推送一度不可用。

后来我做的生存模型显示 Alerts 有很大概率能够长期存在，我也就把这件事放了一边。后来我又想到，既然用了这么多年、收了这么多邮件，我其实可以直接验算：*Alerts 的结果是不是突然暴跌了？* 这其实是个直接的问题：抽取每封 Alerts 邮件的主题、日期和链接数，按不同提醒分层，再做时间回归。于是我就做了。

# 数据

按我的备份流程，我把 Gmail 每日邮件通过 [`getmail4`](https://pyropus.ca./software/getmail/) 存进一个 [maildir](!W)。Alerts 的主题行固定为如 `Subject: Google Alert - "Frank Herbert" -mason`，因此很容易找出所有相关邮件并分离出来。

~~~{.Bash}
find ~/mail/ -type f -exec grep -F -l {} 'Google Alert -' \;
# /home/gwern/mail/new/1282125775.M532208P12203Q683Rb91205f53b0fec0d.craft
# /home/gwern/mail/new/1282125789.M55800P12266Q737Rd98db4aa1e58e9ed.craft
# ...
find ~/mail/ -type f -exec grep -F -l 'Google Alert -' {} \; > alerts.txt
mkdir 2013-09-25-gwern-googlealertsemails/
mv `cat alerts.txt` 2013-09-25-gwern-googlealertsemails/
~~~

<!-- find 2013-09-25-gwern-googlealertsemails/ -type f -exec grep -l aaktgeb {} \; | xargs rm -->

我删除了几条涉及隐私的提醒；剩下 72MB 邮件打包在 [`2013-09-25-gwern-googlealertsemails.tar.xz`](/doc/personal/2013-09-25-gwern-googlealertsemails.tar.xz)。然后我写了个临时 shell 脚本，提取每封邮件的主题、日期和其中 `"http://"` 的出现次数：

~~~{.Bash}
cd 2013-09-25-gwern-googlealertsemails/

echo "Search,Date,Links" >> alerts.csv # set up the header
for EMAIL in *.craft *.elan; do

    SUBJECT="`grep -E '^Subject: Google Alert - ' $EMAIL  | sed -e 's/Subject: Google Alert - //'`"
    DATE="`grep -E '^Date: ' $EMAIL | cut -d ' ' -f 3-5 | sed -e 's/<b>..*/ /'`"
    COUNT="`grep -F --no-filename --count 'http://' $EMAIL`"

    echo $SUBJECT,$DATE,$COUNT >> alerts.csv
done
~~~

脚本并不完美，我还删掉了几行脏数据后，才把它导入 R 并整理为干净 CSV：

~~~{.R}
alerts <- read.csv("alerts.csv", quote=c(), colClasses=c("character","character","integer"))
alerts$Date <- as.Date(alerts$Date, format="%d %b %Y")
write.csv(alerts, file="2013-09-25-gwern-googlealerts.csv", row.names=FALSE)
~~~

# 分析
## 描述性统计

~~~{.R}
alerts <- read.csv("https://gwern.net/doc/personal/2013-09-25-gwern-googlealerts.csv",
                   colClasses=c("factor","Date","integer"))
summary(alerts)
#                      Search          Date                Links
#  wikipedia              : 255   Min.   :2007-01-28   Min.   :  0.0
#  Neon Genesis Evangelion: 247   1st Qu.:2008-12-29   1st Qu.: 10.0
#  "Gene Wolfe"           : 246   Median :2011-02-07   Median : 22.0
#  "Nick Bostrom"         : 224   Mean   :2010-10-06   Mean   : 37.9
#  modafinil              : 186   3rd Qu.:2012-06-15   3rd Qu.: 44.0
#  "Frank Herbert" -mason : 184   Max.   :2013-09-25   Max.   :563.0
#  (Other)                :2585

# 之所以如此分散，是因为我已经删掉了许多不再关注的话题，
# 同时也收紧了其他查询条件
length(unique(alerts$Search))
# [1] 68

plot(Links ~ Date, data=alerts)
~~~

![每封邮件中的链接数，按时间绘图](/doc/technology/google/alerts/gwern-linksperemail.png){.width-full}

第一眼可以看到两件事：其一，链接数似乎随时间上升，2010 年中有一次峰值；其二，不同邮件差异很大——多数在 0 附近，但也有高到 300 的；其三，早期出现一个奇怪异常：有些邮件显示 0 链接；查看这些邮件后发现它们无端以 [base64](!W) 编码，之后后续邮件才变成更常规的 HTML/文本格式。难道这是 Google 的一次失败实验？我说不清楚。最大值是 563，虽然不算很大，因此即便分布偏态明显我也没把 `Links` 做对数变换。

## 线性模型

这种“尖峰”促使我先按月汇总，以平滑发送频率差异，再叠加线性回归：

~~~
library(lubridate)
alerts$Date <- floor_date(alerts$Date, "month")
alerts <- aggregate(Links ~ Search + Date, alerts, "sum")

# 简单线性模型显示每月有个*小*幅增长，但仍有大量解释不了的波动
lm <- lm(Links ~ Date, data=alerts); summary(lm)
# ...
# Residuals:
#    Min     1Q Median     3Q    Max
# -175.8 -110.0  -60.5   43.3  992.6
#
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)
# (Intercept) -4.13e+02   1.10e+02   -3.76  0.00018
# Date         3.73e-02   7.38e-03    5.06  4.9e-07
#
# Residual standard error: 175 on 1046 degrees of freedom
# Multiple R-squared:  0.0239,    Adjusted R-squared:  0.023
# F-statistic: 25.6 on 1 and 1046 DF,  p-value: 4.89e-07

plot(Links ~ Date, data=alerts)
abline(lm)
~~~

![每月按检索词汇总的总链接数](/doc/technology/google/alerts/gwern-linkspermonth.jpg){.width-full}

与原始图一致：总体仍是上升趋势。这个回归的关键问题是：这种增长是来自我订阅的提醒数量增加、我每个提醒返回更多结果的参数调整（从旧提醒切到新提醒），还是每个**独立提醒**返回更多链接？我们只关心最后一种解释，但这三者或其他机制都可能造成上升。

### 每个提醒

我们可以将每个提醒单独做线性回归，再和全体数据的回归结果对比。

~~~{.R}
library(ggplot2)
qplot(Date, Links, color=Search, data=alerts) +
    stat_smooth(method="lm", se=FALSE, fullrange=TRUE, size=0.2) +
    geom_abline(aes(intercept=lm$coefficients[1], slope=lm$coefficients[2], color=c()), size=1) +
    ylim(0,1130) +
    theme(legend.position = "none")
~~~

![按提醒拆分后分别回归](/doc/technology/google/alerts/gwern-monthlylinks-individuallinearregression.png){.width-full}

结果十分混乱。各提醒指向方向各异。把全部提醒混在一起回归会掩盖问题，而分别回归也无法给出一致结论。我们需要一种中间方法：既承认提醒之间行为不同，又能给出总体上有意义的结论。

## 多层模型

我们希望看每个独立提醒的时间变化斜率，并将这些斜率汇总为一个总斜率。数据存在层级结构：总体斜率影响每个提醒的斜率，反过来每个提醒偏差影响各自数据点的分布。

这可用[多层模型](!W)完成，利用 [`lme4`](https://cran.r-project.org/web/packages/lme4/index.html)：

先拟合并比较两个模型：

#. 只有截距在不同提醒间变化，但所有提醒共享同一增减速率
#. 截距与斜率都在提醒间变化

~~~{.R}
library(lme4)
mlm1 <- lmer(Links ~ Date + (1|Search), alerts); mlm1
#
# Random effects:
#  Groups   Name        Variance Std.Dev.
#  Search   (Intercept) 28943    170
#  Residual             12395    111
# Number of obs: 1048, groups: Search, 68
#
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept) 427.93512  139.76994    3.06
# Date         -0.01984    0.00928   -2.14
#
# Correlation of Fixed Effects:
#      (Intr)
# Date -0.988

mlm2 <- lmer(Links ~ Date + (1+Date|Search), alerts); mlm2
#
# Random effects:
#  Groups   Name        Variance Std.Dev. Corr
#  Search   (Intercept) 6.40e+06 2529.718
#           Date        2.78e-02    0.167 -0.998
#  Residual             8.36e+03   91.446
# Number of obs: 1048, groups: Search, 68
#
# Fixed effects:
#             Estimate Std. Error t value
# (Intercept) 295.5469   420.0588    0.70
# Date         -0.0090     0.0278   -0.32
#
# Correlation of Fixed Effects:
#      (Intr)
# Date -0.998

# 比较两模型：模型 2 是否值得一试？
anova(mlm1, mlm2)
#
# mlm1: Links ~ Date + (1 | Search)
# mlm2: Links ~ Date + (1 + Date | Search)
#      Df   AIC   BIC logLik deviance Chisq Chi Df Pr(>Chisq)
# mlm1  4 13070 13089  -6531    13062
# mlm2  6 12771 12801  -6379    12759   303      2     <2e-16
~~~

模型 2 在拟合与复杂度上都更优，于是我们继续看它：

~~~{.R}
coef(mlm2)
# $Search
#                                                                (Intercept)      Date
#                                                                     763.48 -0.046763
# adult iodine supplementation (IQ OR intelligence OR cognitive)      718.80 -0.043157
# AMD pacifica virtualization                                        -836.63  0.062123
# (anime OR manga) (half-Japanese OR hafu OR half-American)           956.52 -0.059438
# caloric restriction                                               -2023.10  0.153667
# "Death Note" (script OR live-action OR Parlapanides)                866.63 -0.051314
# "dual _n_-back"                                                      4212.59 -0.266879
# dual _n_-back                                                        1213.85 -0.073265
# electric sheep screensaver                                         -745.78  0.055937
# "Frank Herbert"                                                     -93.28  0.013636
# "Frank Herbert" -mason                                            10815.19 -0.676188
# freenet project                                                   -1154.14  0.087199
# "Gene Wolfe"                                                        496.01 -0.026575
# Gene Wolfe                                                         1178.36 -0.072681
# ...
# wikileaks                                                         -3080.74  0.227583
# WikiLeaks                                                          -388.34  0.031441
# wikipedia                                                         -1668.94  0.133976
# Xen                                                                 390.01 -0.017209
~~~

`Date` 是按月计数，因此 Xen 的斜率为 -0.02，意味着每年少 1 条链接。

~~~{.R}
max(abs(coef(mlm2)$Search$Date))
# [1] 0.6762
~~~

这一最大斜率来自 `"Frank Herbert" -mason` 的搜索，可能因为这个关键词比较新，或者因为我给原始 `"Frank Herbert"` 搜索增加了过滤规则。总体来看斜率非常接近，正负斜率的数量也大体均衡；在二层模型里整体斜率是轻微负值（约 -0.01），但毛毛虫图显示大多数提醒的斜率区间都远离 0：

![`qqmath(ranef(mlm2, postVar=TRUE))`](/doc/technology/google/alerts/gwern-mlm2-slopes.png){.width-full}

这让我认为各提醒内部并没有文章中描述的“大幅时间变化”，但确实有某种东西在起作用。叠加总体回归与单提醒回归后可见：

~~~{.R}
fixParam <- fixef(mlm2)
ranParam <- ranef(mlm2)$Search
params   <- cbind(ranParam[1]+fixParam[1], ranParam[2]+fixParam[2])
p <- qplot(Date, Links, color=Search, data=alerts)
p +
  geom_abline(aes(intercept=`(Intercept)`, slope=Date, color=rownames(params)), data=params, size=0.2) +
  geom_abline(aes(intercept=fixef(mlm2)[1], slope=fixef(mlm2)[2], color=c()), size=1) +
  ylim(0,1130) +
  theme(legend.position = "none")
~~~

![多层回归的总体拟合与个体拟合](/doc/technology/google/alerts/gwern-monthlylinks-individualmlm.png){.width-full}

这比逐个提醒回归更合理，因为当样本邮件只有少量时，极端斜率会被整体回归“拉回”——这避免了过度陡峭的回归。我们也看不到提醒整体上存在统计上显著的显著变化：有些提醒上升，有些下降，总体上只有微小下滑，可能更像 Google 内部问题造成的影响。

<!--
### 鲁棒性检验

这微弱的负相关到底可靠吗？可做后验检验：从模型生成随机数据，看看固定效应 Date 的符号有多常变正负：

~~~{.R}
library(arm)
mlm2.sim <- sim(mlm2,  n.sims = 100000)
fixef.mlm2.sim <- fixef(mlm2.sim)
quantile(fixef.mlm2.sim[,2], probs = c(0, 0.025, 0.975, 1))
#       0%     2.5%    97.5%     100%
# -0.12879 -0.04986  0.06343  0.12596

hist(fixef.mlm2.sim[,2], main="Change in hits per month, 100k simulations", xlab="Coefficient")
~~~

![Distribution of slopes estimated from 100k simulation runs ] ( /doc/technology/google/alerts/gwern-mlm2-simulation.png )
-->

### 那次下跌呢？

做到这些后我本以为已经结束，直到想起最初那些博主提到的不是“长期缓慢恶化”，而是2012年开始的一次突然跌落。我试着做二分检验：对比 2010/2011 与 2012/2013。

~~~{.R}
alertsRecent <- alerts[year(alerts$Date)>=2010,]
alertsRecent$Recent <- year(alertsRecent$Date) >= 2012
wilcox.test(Links ~ Recent, conf.int=TRUE, data=alertsRecent)
#
#     Wilcoxon rank sum test with continuity correction
#
# data:  Links by Recent
# W = 71113, p-value = 6.999e-10
# alternative hypothesis: true location shift is not equal to 0
# 95% confidence interval:
#  34 75
# sample estimates:
# difference in location
#                     53
~~~

我刻意没有用依赖正态假设的 [`t.test`](!W "Student’s t-test")，而改用 [Wilcoxon](!W "Mann-Whitney U")，因为每月链接数没有理由服从正态分布。无论统计细节如何，两阶段差异都明显：219 对比 140 条链接，下降约 36%，这确实是明显下降，而且不能简单归因于我的 Alerts 设置（我一直用“全部结果”而非“只看最佳结果”），也不能由多层模型所关心的其他混杂项解释：

~~~{.R}
alerts$Recent <- year(alerts$Date) >= 2012
mlm3 <- lmer(Links ~ Date + Recent + (1+Date|Search), alerts); mlm3
#
# Random effects:
#  Groups   Name        Variance Std.Dev. Corr
#  Search   (Intercept) 9.22e+03 9.60e+01
#           Date        9.52e-05 9.75e-03 -0.164
#  Residual             1.18e+04 1.09e+02
# Number of obs: 1048, groups: Search, 68
#
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept) -440.1540   175.3630   -2.51
# Date           0.0413     0.0121    3.42
# RecentTRUE  -102.2273    13.3224   -7.67
#
# Correlation of Fixed Effects:
#            (Intr) Date
# Date       -0.993
# RecentTRUE  0.630 -0.647
anova(mlm1, mlm2, mlm3)
# Models:
# mlm1: Links ~ Date + (1 | Search)
# mlm2: Links ~ Date + (1 + Date | Search)
# mlm3: Links ~ Date + Recent + (1 + Date | Search)
#      Df   AIC   BIC logLik deviance Chisq Chi Df Pr(>Chisq)
# mlm1  4 13070 13089  -6531    13062
# mlm2  6 12771 12801  -6379    12759 302.7      2     <2e-16
# mlm3  7 13015 13050  -6500    13001  0.0      1          1
~~~

<a id="it-was-mid-2011"></a>
### 2011 年中发生了什么？

将“2012年前”与“2012年后”处理为不同状态并不比先前更好。可否更好？一个 [`changepoint`](https://cran.r-project.org/web/packages/changepoint/index.html) 模型指向 2011 年5/6月，并给出更明显的均值差异（254 vs 147）：

~~~{.R}
library(changepoint)
plot(cpt.meanvar(alertsRecent$Links), ylab="Links")
~~~

![链接数量（2010–2013），图示 2011 年5/6月制度变化](/doc/technology/google/alerts/gwern-changepoint.jpg){.width-full}

采用这一新分界点后，检验显著性更强：

~~~{.R}
alertsRecent <- alerts[year(alerts$Date)>=2010,]
alertsRecent$Recent <- alertsRecent$Date > "2011-05-01"
wilcox.test(Links ~ Recent, conf.int=TRUE, data=alertsRecent)
#
#     Wilcoxon rank sum test with continuity correction
#
# data:  Links by Recent
# W = 63480, p-value = 4.61e-12
# alternative hypothesis: true location shift is not equal to 0
# 95% confidence interval:
#   62 112
# sample estimates:
# difference in location
#                     87
~~~

拟合也明显改善：

~~~{.R}
alerts$Recent <- alerts$Date > "2011-05-01"
mlm4 <- lmer(Links ~ Date + Recent + (1+Date|Search), alerts); mlm4
#
# Random effects:
#  Groups   Name        Variance Std.Dev. Corr
#  Search   (Intercept) 8.64e+03 9.30e+01
#           Date        9.28e-05 9.63e-03 -0.172
#  Residual             1.11e+04 1.05e+02
# Number of obs: 1048, groups: Search, 68
#
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept) -1.11e+03   1.87e+02   -5.91
# Date         8.86e-02   1.30e-02    6.83
# RecentTRUE  -1.65e+02   1.44e+01  -11.43
#
# Correlation of Fixed Effects:
#            (Intr) Date
# Date       -0.994
# RecentTRUE  0.709 -0.725

anova(mlm1, mlm2, mlm3, mlm4)
#      Df   AIC   BIC logLik deviance Chisq Chi Df Pr(>Chisq)
# mlm1  4 13070 13089  -6531    13062
# mlm2  6 12771 12801  -6379    12759 302.7      2     <2e-16
# mlm3  7 13015 13050  -6500    13001   0.0      1          1
# mlm4  7 12948 12983  -6467    12934  66.8      0     <2e-16
~~~

#### 鲁棒性检验

<!--
Given the foregoing, it's not surprising that the posterior simulation never spits out an estimate for `Recent` anywhere close to zero:

~~~{.R}
mlm4.sim <- sim(mlm4,  n.sims = 100000)
fixef.mlm4.sim <- fixef(mlm4.sim)
quantile(fixef.mlm4.sim[,3], probs = c(0, 0.025, 0.975, 1))
#      0%    2.5%   97.5%    100%
# -186.74 -152.69 -101.37  -69.05
~~~

The posterior check is good, so I take a look at the other direction:
-->

不同样本检验是否依然显示下降？用[自助法](!W "Bootstrapping (statistics)")也支持这一点，而且 Wilcoxon 给出了一个相当好的置信区间：

~~~{.R}
library(boot)
recentEstimate <- function(dt, indices) {
  d <- dt[indices,] # allows boot to select subsample
  mlm4 <- lmer(Links ~ Date + Recent + (1+Date|Search), d)
  return(fixef(mlm4)[3])
}
bs <- boot(data=alerts, statistic=recentEstimate, R=10000, parallel="multicore", ncpus=4); bs
# ...
# Bootstrap Statistics :
#     original  bias    std. error
# t1*   -164.8   34.06       17.44

boot.ci(bs)
# ...
# Intervals :
# Level      Normal              Basic
# 95%   (-233.0, -164.7 )   (-228.2, -156.7 )
#
# Level     Percentile            BCa
# 95%   (-172.9, -101.4 )   (-211.8, -156.7 )
~~~

置信区间为 (-159,-95)，在这里既有统计显著性，也代表了一个不容忽略的效应量。2011 年中这次下跌很可能是真的。我原本预计会下降，但预期的是逐步、缓慢的，而不是 Google 搜索算法渐进剔除更多网站导致的缓慢过程。现在看到的是，在某个月里结果会“一下子掉三分之一以上”。

<a id="panda"></a>
### Panda？

我不知道 Google 在 2011 年5/6月是否发布了影响 Alerts 的改动，邮件本身也无法直接说明发生了什么，但可以猜测一个主因：那段时间或许是 Google 进行“Panda”排序更新（[Google Panda](!W)）的时段。该更新影响了大量网站和搜索，初期有不少问题，并且据称促进了社交网络站点（我在自己的 alerts 里也很少见到），且于2011年4月全球上线——这恰好足以触发 5/6 月的变化（随后 2011 年内还持续调整 [Google 算法变更](https://moz.com/google-algorithm-change#2011 "Google Algorithm Change History")）。

（真正原因恐怕我们永远不会知道：Google 对内部技术决策和更新向外说明得一向非常少。）

<a id="conclusion"></a>
# 结论

那么我们得到了什么？

整体线性回归并没直接回答问题，但它有一个好处：展示了提醒间巨大差异，也提醒我们要谨慎定义问题；对多样性和随机性保持警惕，先看“大效果”和“大局”。如果某人说 alerts 略有下降，可能只是记忆偏差；但若他说从每封 20 条掉到 3 条，就不应机械地怀疑，而应更细看。

当直接检验最初说法时，我们并没有*完全*支持那些早期博主的说法：下降并未在他们说的 2012 年发生，而是大约晚半年的时候（不同用户可能有偏差）。这说明什么？很难说。Google 有时会把更新在不同用户中分批慢慢推，可能我先于多数用户经历了大幅降链；或者别人一开始不确定是否真少了链接（那样的话我对他们评价过于严苛）；又或者 SEO 相关改动先影响了我的搜索词，别人的搜索还没受。

所以 Alerts“坏了”吗？至少它确实明显被打击：命中链路变少了，而且我观察到的返回内容也没那么“珍贵”，不足以抵消稀缺性。更糟糕的是，问题到现在都持续了两年，没有可见改善。

但进一步看，命中减少似乎是一次性事件；如果我的 Panda 猜想成立，这更像 Google 的优化优先级问题，而非刻意抛弃——搜索（Search）毕竟是“犬摇尾巴”的狗，优先级永远高于 Alerts。我的生存模型也许最后仍会笑到最后：Alerts 可能会比更出名的同类服务活得更久。

只是看法不同：如果你喜欢把杯子看半满，那么这意味着 Alerts 看起来没那么糟糕，短期内未必会像 Google Reader 一样进“天上的回收箱”；若你看半空，倒像是 Google 典型案例——不与用户沟通、单向且隐形改动、为了更赚钱服务削减另一服务、用户在其技术能力面前无力抗争（还有谁能像它这样持续抓取全网新内容匹配关键词？）。

# 相关内容

<div class="columns">
- [Fanfiction reviewer survival curves](/hpmor "A survival analysis finds no major anomalies in reviewer lifetimes, but an apparent increase in mortality for reviewers who started reviewing with later chapters"){.backlink-not}
- [Weather and mood](/weather "'Weather and My Productivity', Gwern 2013"){.backlink-not}
</div>

# 外部链接

- [Hacker News 讨论](https://news.ycombinator.com/item?id=6445270)

<!-- For the update:
#. fix the 0-link anomalous emails early in the sample
#. use a MLM, using a Poisson family - matches the underlying process more accurately
#. add additional level of nesting for unique subject lines but about the same subject (so it would go email-subject-lines nested under general-topics eg. all the Gene Wolfe searches should be clustered)
#. add Google Scholar & Pubmed alerts
#. add a nesting level for Google (Alerts & Scholar), and nesting for all alerts (Google & Pubmed) -->
