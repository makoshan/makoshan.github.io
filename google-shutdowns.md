---
title: 预测 Google 关闭
description: 分析 Google 放弃产品的预测因素并对未来关闭进行预测
created: 28 Mar 2013
tags: statistics, archiving, predictions
status: finished
belief: likely
...

Google 有时会关闭我在用的服务，而且不总是给出明确警告（许多科技公司也是如此——今天有，明天没，虽然 Google 相对温和）；这让人沮丧而乏味。很自然，常有人替 Google 说教：Google 不欠我们任何人情；如果是问题，那是我们自己的问题，我们应当更早预测未来（同时也同情因关闭而受影响的普通人，以及那段[链接逐渐失效]（Archiving URLs）历史）。我不知道 Reader RSS 归档到底会丢失多少。  
但如果连 Google 对某个产品能支持多久、为什么支持、以及它如何做决策都没有数据和线索，我们又怎么能做出理性的预期？于是本文我整理了 [350 个 Google 产品](#sources) 的数据，寻找可用于预测的变量（[predictive variables](#variables)）。我在[建模关闭模式](#modeling)中找到了部分模式，并据此对未来关闭给出一些[预测](#predictions)。希望结果有意思，也有用，或兼而有之。

# 先看一眼过去

> “这是文学一向敏感却又迟迟不肯承认的事：技术总是难以被正视。冷风在空旷的石室里呼啸。什么时候才坦白？Dell 的电脑呢？这是德克萨斯奥斯汀，Michael Dell 是中德州最大的科技巨头。为什么他不在现场？为什么至少不去卖货？你过去喜欢的那些专用游戏机呢？你还记得它们曾经有多重要吗？我可以整天在这儿列举你这个行业里被替代的名字。电子世界永远是在前沿。没人会回头看那些被电锯砍掉再被扔进河里的“电子森林”。而且还有一种空洞的说法：这些创新让世界变得更好……比如“如果我们不让世界更好，那我们为什么要做这些？”  
我不想说这种态度就是伪善。因为在 SXSW 你若说“我们来这里是想让世界更好”——那你甚至还没到“虚伪”这个层次，最多只是“童稚的天真”。’” -- [Bruce Sterling](!Wikipedia)， [SXSW2013 收官演讲文字版](http://www.wired.com/beyond_the_beyond/2013/04/text-of-sxsw2013-closing-remarks-by-bruce-sterling/)

2013 年 3 月 13 日 [宣布关闭的](http://googleblog.blogspot.com/2013/03/a-second-spring-of-cleaning.html)热门服务 [Google Reader](!Wikipedia) 让很多人意识到：自己依赖的一些产品只是 Google 的施舍而已——它们的存在原因对外人难以洞察，Google 可能对产品投入不深[^Reader-threats-1][^Reader-threats-2][^Reader-threats-3]，对用户利益未必友好，可能在任何时刻、任何原因下收回产品[^Reader-popularity]（尤其是其中很多是服务类[^cloud-suckers]，并非真正的 [FLOSS](!Wikipedia "Free and open-source software")，而且通常与 Google 的基础设施紧耦合[^unportable]，无法轻易分拆出售；当 CEO 不再站在它这边、且[没有 Googler](http://www.buzzfeed.com/mattlynley/google-reader-died-because-no-one-would-run-it)愿意拿职业生涯去支撑它时），用户便几乎没有发言权[^voice-utility]，只有 [离开](!Wikipedia "Exit, Voice, and Loyalty) 这条路。

[^unportable]: 来自 Gannes 的文章 ["Another Reason Google Reader Died: Increased Concern About Privacy and Compliance"](http://allthingsd.com/20130324/another-reason-google-reader-died-increased-concern-about-privacy-and-compliance/)

    > 但与此同时，Google Reader 与 Google Apps 的整合非常深入，Google 并不能像去年把 SketchUp 三维建模软件那样把它剥离并出售。

    [mattbarrie](https://news.ycombinator.com/item?id=5373584) 在 Hacker News 上写道：

    > 我和在澳大利亚负责工程的 Alan Noble 谈过。Reader 项目我见过他负责直到大约 18 个月前。团队曾考虑过开源，但因为与 Google 基础设施绑定太紧而不现实。事实上它主要是由于长期使用量下滑才被砍掉的。

[^cloud-suckers]: 这对 [Archive Team](!Wikipedia) 的 [Jason](http://ascii.textfiles.com/archives/1717 "FUCK THE CLOUD - January 16, 2009") 和 [Scott](http://ascii.textfiles.com/archives/2229 "Oh Boy, The Cloud - October 5, 2009") 来说也不是什么新奇话题；但 [James Fallows](http://www.theatlantic.com/technology/archive/2013/03/finale-for-now-on-googles-self-inflicted-trust-problem/274286/ "Finale for Now on Google's Self-Inflicted Trust Problem") 指出，当一个云端服务消失，它就是彻底消失，这个对比很有意思：

    > [Kevin Drum](!Wikipedia) 在 _Mother Jones_ 的文章《[Google 与云端的问题](http://www.motherjones.com/kevin-drum/2013/03/problem-google-and-cloud)》中写到，无法像以前那样依赖 Google 服务往往比传统的“本地程序被抛弃”更具破坏性。我的例子是 [Lotus Agenda](!Wikipedia)，它官方已经死掉近 20 年，但我现在还是能用（如果愿意，在 Mac 的 VMware Fusion Windows 虚拟机里开 DOS 会话——这就叫分层遗产）。当一个云服务像 Google Reader 那样消失时，它就是真的消失；你不能像处理本地“孤儿”软件那样保留一份旧版可用文件继续用。

[^voice-utility]: 一些 Google 服务的规模和主导地位引发了与[自然垄断]相关的比较，例如《经济学人》专栏 [“Google 的 Google 问题”](http://www.economist.com/blogs/freeexchange/2013/03/utilities)。我看到这类比较时常被嘲讽，但值得注意的是至少已有 Googler 早年提出同样观点。来自 [Levy](!Wikipedia "Steven Levy") 的 _[In the Plex](!Wikipedia)_ 2011 中第 7 章第 2 节写到：

    > 一些 Googler 觉得自己被过度关注，遭受不公；但更审慎的人理解，这是 Google 持续增长的自然后果，尤其是在分发和存储海量信息方面。“这就像 Google 掌控了美国整个供水系统，”Mike Jones 说过，他当时负责 Google 一些政策问题，“社会让我们受点压力是公平的，以确保我们做得对。”

[^Reader-threats-1]: Google Reader 在透明度上有很多问题，最明显是 Google 是否愿意持续支持 Reader（对用户很关键，也对依赖 Reader 的第三方服务和应用尤其重要）；摘自 BuzzFeed 的《[Google's Lost Social Network: How Google accidentally built a truly beloved social network, only to steamroll it with Google+. The sad, surprising story of Google Reader](http://www.buzzfeed.com/robf4/googles-lost-social-network)》：

    > 困难在于，Reader 的用户虽然与产品高度互动，但从未成长为数以千万计的规模。Brian Shih 在 2008 年秋季成了 Reader 的产品经理：“如果 Reader 是一款独立创业公司，按 Google 的逻辑它很值得收购。我们是 Google 员工时把它放进 Google 家庭，按规模看它小到不值得持续投资。” 他回忆道：有一段时间，工程师被抽离去做 OpenSocial，一个“半成品”开发平台，后来也没能成形。Shih 说，内部一直在争论是否要继续给这个小项目留人力。某时在 Reader 办公室挂过一块牌子：  
    > “自上次停摆警告以来的天数”。数字几乎总是 0。与此同时，虽然绝对用户规模相比 Gmail 的几亿仍然很小，但在 Shih 任内用户增长还翻倍了。然而，Bellotta 说“上级”看重的是绝对用户数而非饱和度，所以 Reader 一直在“切割线”上打转。
    >
    > 当消息传开，Shih 形容像海明威那句“先慢后快”：慢慢来，接着突然结束。到了春天他确认，Reader 的内部分享体系——非对称关注模型、内建评论与点赞机制、进阶隐私设置——都会被 Google+ 取代。而且他被明文禁止向用户解释这些变化。

    [Marco Arment](http://www.marco.org/2013/07/03/lockdown "Lockdown") 写道：“我从多个来源听到，它实际上长期运作时几乎是‘0 人状态’。”

[^Reader-threats-2]: Shih 在 Quora 里又写道：[Why is Google killing Google Reader?](https://www.quora.com/Google-Reader-Shut-Down-March-2013/Why-is-Google-killing-Google-Reader):

    > 要明确的是这跟收入和运营成本无关。Reader 并没直接变现（尽管 Feedburner 与 AdSense for Feeds 的使用可能算贡献），也不是“产品目标”的主要内容。Reader 在 Google 内部争取认可和生存很久了，比我做 PM 时早得多。我几乎可以确认，在它真正死亡前至少被威胁削减/撤资三次，而且每次都与“社交”有关：
    >
    > - 2008：把团队抽调去做 OpenSocial
    > - 2009：把团队抽调去做 Buzz
    > - 2010：把团队抽调去做 Google+
    >
    > 结果是它 2010 年仍被砍掉，尽管多数工程师并不想转去 G+。我想 Google 之所以总是挪走 Reader 团队，是因为这支团队真正理解“社交”——他们多年来做了许多实验，后来都反馈到公司更大的社交架构里（见 Reader 的好友实现 v1、v2、v3、评论、隐私控制与分享功能；现在这些都没了）。Reader 的社交功能大多是围绕用户自然需求演化，而非像公司内部其他项目那样自上而下拍板设计。[Rob Fishman 的 BuzzFeed 文章对这一点有较好梳理：Google's Lost Social Network](http://www.buzzfeed.com/robf4/googles-lost-social-network)。我猜它得以存活一段时间，是因为公司仍希望从中为 Google+ 提供内容。Reader 用户常年大量消费内容并过滤、分享。然而在把分享能力转给 G+、并重构 UI 后，使用率开始下降，尤其是分享环节。我在重构后基本停止分享（参见[这篇 Reader 重构评论](http://www.brianshih.com/post/30194495552/reader-redesign-terrible-decision-or-worst-decision)——那时我比现在更生气，现在只是遗憾）。虽然 Google 最后修复了大量 UI 问题，分享能力（因此到 G+ 的内容流）却再也没恢复。所以在持续投入变为维护状态、价值递减、再加上 Google 近几年“聚焦”战略的压力下，收掉它几乎是必然。

[^Reader-threats-3]: 另一个 Googler 的“关闭前兆”故事也得到印证： ["Google Reader lived on borrowed time: creator Chris Wetherell reflects"](http://gigaom.com/2013/03/13/chris-wetherll-google-reader/):

    > “当他们把 Reader 的分享功能替换成 +1 时，就已经明摆着这一天会到来，”他写道。Wetherell 43 岁，惊讶 Reader 能活这么久。项目刚成立不久就不确定是否上线时，Google 高层就已经犹豫；甚至在项目刚起步前，管理层就曾威胁如果持续延期就取消它。“我们在一开始就有一块牌子写着‘*到上次取消已有多久*’，一直贴着。”他接着补充，这说明 Google 从未真正相信这个项目。Reader 诞生于 2005 年，那个时期正是 RSS、博客系统和新内容生态的黄金时代；当时的“巨头”是 [Bloglines](!Wikipedia)（后来被 Ask.com 收购），而 Reader 只是后来居上者之一。

[^Reader-popularity]: 官方声明称关闭是因为使用量太少，但第三方质疑这个说法：Reader 看起来驱动了比 Google+ 更多流量；Google+ 上线初期已有 [200 万名同时拥有 Reader 账号的用户](http://allthingsd.com/20130324/another-reason-google-reader-died-increased-concern-about-privacy-and-compliance/)。仅替代方案 Feedly 在宣布关闭消息后新增了超过 [300 万账号](http://blog.feedly.com/2013/04/02/announcing-the-new-feedly-mobile-and-welcoming-3-million-reader-refugees/)（有时被说到 400 万），而且围绕该事件的最大公开请愿也收到了 [14.8 万签名](https://www.change.org/petitions/google-keep-google-reader-running)。比较 Android 客户端超 100 万次下载量，Reader 的流量至少更高。鉴于少数用户会专门去 Feedly、签请愿、访问 BuzzFeed 或相关应用，我倾向认为其关闭时活跃用户更接近 2000 万而非 200 万。有一位 Google 工程师在 2010 年被引用为说过 Reader 月活可达“数千万”。[前 Googler Jenna Bilotta](http://www.forbes.com/sites/alexkantrowitz/2013/07/01/google-reader-founder-i-never-would-have-founded-reader-inside-todays-google/)（2011 年 11 月离开 Google： [The Pinkest Black](http://www.thepinkestblack.com/2011/11/all-good-things.html)）回应道：

    > “我认为大家为 Reader 叫嚣是因为它真的‘粘住’了用户，”她说，“所以大家对 Google 关停这样受欢迎的产品很吃惊。至少在我离开前，数字还在持续增长。”

    到 2013 年 3 月 Reader 中最热门的 feed 有 [2430 万订阅者](http://googlesystem.blogspot.com/2013/03/google-reader-data-points.html)（基于[官方用户量曲线](http://googlereader.blogspot.com/2013/03/welcome-and-look-back.html)和一张[被泄露视频](http://blogoscoped.com/forum/108194.html)推算，Reader 全部用户在 2011 年 1 月或许已到 3600 万）。Jason Scott 在 2009 年也提醒了这一点：从历史上看，企业会雇人不断告诉你“公司很稳健”，直到这些人自己也被裁掉，因为公司倒闭了。

就 Reader 而言，它确实摧毁了最初 RSS 阅读器市场，但仍有可替代产品；主要代价是 RSS 的读者群萎缩——不少用户最终放弃学习新阅读器或转向停止；另一个是 Reader 独特、完整的 RSS 存档（可追溯到 2005 年）将不可逆丢失。为了公平起见，我也要说两点支持 Google 的地方：

1. 我仍在使用某些 Google 服务，因为除了少数事故（如 [Website Optimizer](AB testing#max-width)）外，它们几乎是少数能让用户备份数据的公司之一，尤其通过 [Google Data Liberation Front](!Wikipedia)；它也比许多公司更积极地鼓励用户为“停服”做备份，比如自动把 Buzz 数据同步到 Google Drive。
2. Google 通过低价甚至免费替代市场上大公司服务带来的好处同样巨大，因此不能只看到坏处。它们的模式也符合 [可见成本与隐性成本] 的讨论（见 Bastiat《[The Seen and The Unseen]》），所以我们不应只看表面。

但不管怎么说，每次关闭仍会以不同程度伤害用户，即使我们现在可基本排除像 Gmail 这样灾难性关闭的可能。更有意思的是看：关闭是否具有可预测性？是否有明显模式？常见说法是否能被验证？这些结果对未来有什么启发？

[^benefits]: 这可以看成降低[死重损失](!Wikipedia)的一种方式：在某些成功收购案例中，Google 的做法是把非常昂贵或溢价高昂的服务设为免费，并同时提高质量。Analytics、Maps、Earth、Feedburner 都是先前要收费的服务（Maps 和 Earth 尤其常见）——但它们后来改为免费。若价格弹性和试错成本高，人们会因为“免费 + 变好”而更多使用；否则会有大量潜在福利被抑制。Google 在其曾是付费服务中，常引用的用户规模常达数十亿，说明死重损失下降带来的收益很大。
[^survival]: 如果行业里有一条不变真理，那就是除了 IBM 之外，规模化公司并不长寿。所有公司与非营利机构的死亡率都很高，科技行业更甚。[有博主](http://shkspr.mobi/blog/2013/03/preparing-for-the-collapse-of-digital-civilization/ "Preparing for the Collapse of Digital Civilization")提了个问题：

    > 我们对互联网越来越依赖，意味着一旦把服务绑定到第三方，就会有真实风险。互联网天生抗核灾难导致的节点故障，但无法防范服务被撤掉或公司破产。有人会觉得苹果和 Google 这种几十亿美元巨头不会消失，但历史告诉我们 Nokia、Enron、Amstrad、Sega 等都曾高悬于空中却最终只剩空壳，不再提供大量用户依赖的服务……我常问拍照同行：“要是 Yahoo! 突然删除你 Flickr 的所有照片，你怎么办？” 有些人有备份，多数人听到便无言以对。

# 数据

## 来源

### 已停服产品

> 夏草——  
> 是许多勇士梦想  
> 最后的残痕。

我先整理了来自《卫报》文章 ["Google Keep? It'll probably be with us until March 2017 - on average: The closure of Google Reader has got early adopters and developers worried that Google services or APIs they adopt will just get shut off. An analysis of 39 shuttered offerings says how long they get"](http://www.guardian.co.uk/technology/2013/mar/22/google-keep-services-closed) 的服务/API/程序清单（作者 Charles Arthur）。Arthur 的清单已相当完整，但我在 Slate 墓地页、Weber 的《[Google Fails 36% Of The Time》](http://thenextweb.com/google/2013/10/17/google-fails/)（见 [Weber 总结](#weber)）、维基收录的 Google 收购分类和列表、Google 公司史等基础数据上补充了 300 余个缺失条目。加入的这批停服项包括许多早于 2010 的关闭，说明 Arthur 的样本偏向近年的停服。

[^Weber]: Weber 的结论：

    > 我们统计到从 1998 年以来（排除了附加功能与并入其他项目的实验性项目）Google 独立产品总数约 251 个，其中 90 个（约 36%）已终止。更有意思的是，我们还找到了 8 个重磅失败和 14 个重磅成功，意味着高可见度产品中 36% 都失败了。这个结果非常巧合。  
    > 备注：我并未为了这个结果而篡改数据，这只是一个偶然发现。

    同时，用我 350 项数据集做统计，也得到 123 个被取消/停服，约 35%。

部分项目的起始时间只能是最佳估计（如 [Google Translate](https://plus.google.com/u/0/103530621949492999968/posts/fqxuM2SBRQ5)），而停/弃用时间更难判断，因为多数项目本身不受关注。此时我主要从网页快照、新闻报道、博客（如 Google Operating System）、新闻稿、密切相关服务的停运（如 eReader Play）以及源码仓库（如 AngularJS）反推。部分条目会被标为 discontinued（如 Google Catalogs）但仍维护或已并入其他软件（如 Spreadsheets、Docs、Writely、News Archive），或被出售/移交（如 Flu Shot Finder、App Inventor、Body）或停止维护但保留内容，所以不列为 dead；对已收购且已关闭的软件/服务，我按收购时点记起始时间。

### 存活产品

> “…他常常清醒得可怕，在心智与力量与意志上依旧坚挺，  
> 夜深仍听得见时间流逝，  
> 夜色里万物朝着审判日爬行。”^[["The Mystic"](http://www.blackcatpoems.com/t/the_mystic.html), _Poems, Chiefly Lyrical_; [Lord Alfred Tennyson](!Wikipedia "Alfred, Lord Tennyson")]

Arthur 的主要批评之一是：如果数据里只包含已停服产品，你只能说“平均一个 dead 产品活了 1459 天”，却不能推断活着的产品未来寿命，因为你不知道它最终是否也会死。如果一个产品体系中只有 1% 会死，那么 1459 天这个条件均值会严重低估在“当前依然存活”的群体寿命。其数据只能回答条件问题：假设产品最终会死，它会死多久。真正感兴趣的问题恰恰是“我会不会死？”——这是每位 Google 用户想知道的问题。

因此我基于同样来源又整理了*存活*产品列表；存活与停服比例就给出了 1997–2013 区间随机选取产品会被下线的基准率，并基于各存活产品的上线时间可做右删失 [survival analysis](!Wikipedia)，给出更多可操作预测（比如平均关闭时间）。一些服务在功能意义上基本上已废止（如 Sync、FeedBurner、Meebo 已失去关键功能；Google Group 的 Usenet 归档长期被忽视）却还没“死”，我依然将其列为存活。

## 变量

> 致我那位挚友，  
> 我本想让你看看——  
> 那些  
> 如今已失去踪迹的  
> 梅花，  
> 已无处寻觅，  
> 在降雪中消散。^[ [Yamabe no Akahito](!Wikipedia), [_万叶集_](http://en.wikipedia.org/wiki/Man%27y%C5%8Dsh%C5%AB) [VIII: 1426](http://www.temcauley.staff.shef.ac.uk/waka0088.shtml)]

仅仅把数据列出来就有意义，因为我们可以据此估计总体死亡率或中位寿命。但我们也许能做得更好，而不是只做基准率。最终，我为所有产品收集了一些可能预示寿命的自变量：

- `Hits`: 每个服务的 Google 搜索命中次数

    Google hits 是非常粗糙的代理变量；它即便只能近似反映“受欢迎程度”“用户规模”“盈利能力”，也偏向最近上线的产品（例如搜索“Google Answers”在 2002 年时会命中更多，而今天大概率没那么多）。它仍可能提供一些信息。

    我没看到还有其他免费、可用的优质来源来衡量产品 URL/主页的历史或当前流量。像 Alexa、Google Ad Planner 要么是商业产品，只能用于域名，要么覆盖不足。等我完成数据后，才有人提醒：虽然 Ad Planner 用处不大，Google AdWords 本身每月可返回某查询的全球搜索量，这更有用，不过只能反映当下兴趣，不能反映历史走势。

- `Type`: 把产品分类为“服务/程序/硬件/其他”

    1. *服务*：主要通过浏览器、API 或网络访问的内容；例如 Gmail 或从 Google 服务器加载字体的浏览器扩展，不包括本地 Gmail 通知程序，也不包括可下载/分发的 FLOSS 字体。
    2. *程序*：应用、插件、类库、框架或它们组合，规模可大可小（如 Authenticator 到 Android）。包括依赖网络连接或 Google API 的程序，也包括未开源项目，因此“程序”类也不免受停服影响，且往往受 Google 自身支持周期约束。
    3. *硬件*：主要为物理实体。例如 Android 手机、Chromebook。

        回头看，我大概应该把这个分类移除；手机并不一定遵循服务或程序的生命周期，反而带来更复杂的分类问题（手机“死亡”指的是哪个节点？单台设备、单一型号，还是全线？），而且一个产品会有很多代，资料也难取。
    4. *其他*：兼容性最差的一类，用于难归类的条目。例如 Google 智库、慈善机构、会议、风险投资基金，它们并非软件，也不完全是服务。
- `Profit`: Google 是否*直接*盈利于该产品

    这是个棘手变量。Google 常说任何能带来更多网络使用的产品都在间接造就利润，因此按这个逻辑每个服务都可能带来收益；但这解释得过于牵强，外部观察者很难判断真实财务。一般来说我把“直接盈利”理解为直接涉及广告投放/订阅/手续费/销售的产品（AdWords、Gmail、Blogger、Search、购物引擎、问卷）；不少产品却没有与之直接挂钩（Alerts、Office、Drive、Gears、Reader[^Reader-monetization]）。像 Voice 这种按国际通话计费的服务也许有收入，但金额很小，是否应算盈利并不清楚。你也许会认为 Google Search 的每项增强（个性化搜索、搜索记录）都“为了盈利”，但我仍将这类二次功能归为非盈利。
- `FLOSS`: 源码是否开源，或 Google 是否让第三方持续接管服务/应用维护

    > 长期来看，所有非自由软件的效用会走向零，而所有非自由软件最终都会变成死胡同。^[[Mark Pilgrim](!Wikipedia), ["Freedom 0"](http://web.archive.org/web/20110726001925/http://diveintomark.org/archives/2004/05/14/freedom-0)]——讽刺的是，Pilgrim（2007 年入职 Google）似乎对其中一项被标记为死的条目负有责任：他的“Doctype 技术百科全书”在他“infosuicide”前后消失，之后并未被恢复，只“部分 FLOSS]。

    Android、AngularJS、Chrome 都是例子：就算 Google 失去兴趣，服务也不一定“死”，因为可由第三方接手。许多代码库依赖专有 Google API/服务（尤其移动应用），说明这个变量的实际含义并不那么大；因此在少数关键场景，我用 `Dead` 与 `Ended` 记录“Google 是否放弃、何时放弃”，而非是否被第三方接收。比如 App Inventor for Android 记录为 2011-12 死，但半年后转交给 MIT 并得到其支持。不要天真以为源码可得就等于 Google 支持不存在。
- `Acquisition`: 产品是并购获得、授权获得，还是内部开发

    这个变量用于检验所谓“[Google black hole](http://www.slate.com/articles/technology/technology/2008/08/the_google_black_hole.single.html "The Google Black Hole: Sergey and Larry just bought my company. Uh oh.")”现象：Google 收购了许多创业公司（DoubleClick、Dodgeball、Android、Picasa），或购买技术/数据授权（Translate 里的 SYSTRAN、实时搜索里的 Twitter 数据）。不少并购后产品逐渐停滞（Jaiku、JotSpot、Dodgeball、[Zagat](http://www.businessinsider.com/google-zagat-story-2013-6)），所以我会纳入该变量。若某产品与收购后新发布的项目紧密相关（例如移动 App），我不把它视为 acquisition；也不把 Google 一接手就砍掉的项目纳入（Apture、fflick、Sparrow、Reqwireless、PeakStream、Wavii）或尚未发布衍生产品的（BumpTop）排入。

[^Reader-monetization]: 有人辩解 Reader 关闭是理性的——Reader 没有直接盈利、Google 不是慈善机构。更可能的解释是 Google 对它始终兴趣不足；如果 Google 能盈利 Gmail，理论上也应能盈利 Reader，这在两位曾参与其中的 Googler 看法中更明确（见《Google Reader lived on borrowed time: creator Chris Wetherell reflects》）：

    > 我在想，Google 与更广泛生态是否错误解读了信号？更广泛的人群是否真看到的是 RSS/阅读器市场，而真实可盈利市场其实是“数据与情绪分析”？Wetherell 认可我的猜测。  
    > “阅读器市场并未走出试验阶段，也没人持续迭代商业模式”，他说。“变现能力从未真正被测试过。”  
    >
    > “我们积累了大量数据，也知道用户对内容的偏好程度，因此我们一直觉得它有变现潜力。” Dick Costolo（当时在 Google 工作，且售出了 Feedburner）当时想了很多变现思路，却都被忽视。Costolo 现在在 Twitter 上抓住“关系与上下文”信号，成效显著。Wetherell 在他的 2011 年博客《[Dreams, discernment, and Google Reader](http://massless.org/?p=174)》里写道：
    >
    >> ***Reader 为内容生产者与消费者关系提供了我见过最好的“无偿表达》模型***。你为 HBO 付费，就给出了非常明确的信号；在免费消费模式中 Reader 更像梦想：它让消费者免费获得“偏好信号”——也就是明确可计量的货币价值；并追踪用户跨源消费序列，同时把内容快速分发给目标受众，不会引入社交负罪感或博弈化机制；再加上通过常见 Web 技术搭建的可扩展平台，这对有视觉的产品负责人来说都很有吸引力。***Reader（曾经）属于“信息猎人”而非“技术极客”***。这种市场客观存在，但长期被供给不足，而且可能买单能力很强。

    就 PR 角度看，Google 也许更好的路线是将 Reader 转成订阅制，再逐步“以订阅不足为由”停掉。映入眼帘的三个费用上调案例是 Maps API、通话（最初免费）和 App Engine 费用；据我所知 Maps API 的调价后来被取消，后两者几乎无人记得（连 App Engine 开发者都不太记得）。

### 命中率

理想情况下我们应该拿到产品官方关闭前一天的命中数，但那种历史数据现在拿不到。我只能用 2013 年 1–5 月我搜索得出的命中数。Google hits 这个指标有三点问题：

1. 网络不断增长，因此 2000 年的 100 万次命中和 2013 年的 100 万次命中并不等价；
2. 没被关闭的服务会活得更久、命中会更高；
3. 产品越早，命中里可能更早被抹去的内容比例越高。

我们可以用寿命标准化进行补偿：比如 10 万次命中，对仅运行十年产品而言与对运行 6 个月产品的含义完全不同。至于成长偏见，可以按各时期 Google 索引规模估计并把当前命中数归一化为服务下线时相对 Google 索引的分数（例如假设 Answers 在 2006 年关停、并且那时索引有 10 亿 URL，那么 100 万命中可换算为 0.001）；这就是“实质化命中”（deflated hits）。先对 Google 索引规模做指数拟合（利用罕见公共报告和第三方估计值），拟合效果不错（sigmoid 可能更好，但末端分歧较大）。这样我们再按日均值标准化，总共得到四个命中相关指标，后文再细看。

![估计 Google WWW 索引规模随时间变化](/images/google/www-index-model.png)

拟合得相当合理。虽然 sigmoid 可能更好，但终点偏差较大。由此我再对天数做平均，得到了 4 个可用指标。后面会继续深入。

## 处理

如果产品未结束，终止日期定义为 2013 年 4 月 1 日（我停止汇编产品的时间）；于是总寿命=终止日期-起始日期。最终 CSV 在 [docs/2013-google.csv](https://gwern.net/docs/2013-google.csv)。欢迎 Googler 或 Xoogler 就发布/关闭时间、直接变现项目等变量纠错。

# 分析

> 我让马从废墟中驰过，  
> 废墟会让行者的心震颤，  
> 高矮不一的旧垛口，  
> 大小不一的古墓，  
> 风中草茎阴影轻颤，  
> 巨树给人恒定的声音。  
> 我悲叹的是普遍的骨骸，  
> 在“不朽者”名单里没有名字。^[ [Han-Shan](!Wikipedia "Hanshan (poet)"); #18 in [_The Collected Songs of Cold Mountain_](http://www.amazon.com/Collected-Mountain-Mandarin-Chinese-English/dp/1556591403/), Red Pine 2000, ISBN 1-55659-140-3]

## 描述性统计

先把辛苦整理的数据和 R 总结打印出来（完整源代码见[附录](#source-code)，若能附同样可复现的 R 代码就欢迎来做统计修正）：

~~~{.R}
    Dead            Started               Ended                 Hits               Type
 Mode :logical   Min.   :1997-09-15   Min.   :2005-03-16   Min.   :2.04e+03   other  : 14
 FALSE:227       1st Qu.:2006-06-09   1st Qu.:2012-04-27   1st Qu.:1.55e+05   program: 92
 TRUE :123       Median :2008-10-18   Median :2013-04-01   Median :6.50e+05   service:234
                 Mean   :2008-05-27   Mean   :2012-07-16   Mean   :5.23e+07   thing  : 10
                 3rd Qu.:2010-05-28   3rd Qu.:2013-04-01   3rd Qu.:4.16e+06
                 Max.   :2013-03-20   Max.   :2013-11-01   Max.   :3.86e+09
   Profit          FLOSS         Acquisition       Social             Days         AvgHits
 Mode :logical   Mode :logical   Mode :logical   Mode :logical   Min.   :   1   Min.   :      1
 FALSE:227       FALSE:300       FALSE:287       FALSE:305       1st Qu.: 746   1st Qu.:    104
 TRUE :123       TRUE :50        TRUE :63        TRUE :45        Median :1340   Median :    466
                                                                 Mean   :1511   Mean   :  29870
                                                                 3rd Qu.:2112   3rd Qu.:   2980
                                                                 Max.   :5677   Max.   :3611940
  DeflatedHits    AvgDeflatedHits  EarlyGoogle      RelativeRisk    LinearPredictor
  Min.   :0.0000   Min.   :-36.57   Mode :logical   Min.   : 0.021   Min.   :-3.848
 1st Qu.:0.0000   1st Qu.: -0.84   FALSE:317       1st Qu.: 0.597   1st Qu.:-0.517
 Median :0.0000   Median : -0.54   TRUE :33        Median : 1.262   Median : 0.233
 Mean   :0.0073   Mean   : -0.95                   Mean   : 1.578   Mean   : 0.000
 3rd Qu.:0.0001   3rd Qu.: -0.37                   3rd Qu.: 2.100   3rd Qu.: 0.742
 Max.   :0.7669   Max.   :  0.00                   Max.   :12.556   Max.   : 2.530
 ExpectedEvents   FiveYearSurvival
 Min.   :0.0008   Min.   :0.0002
 1st Qu.:0.1280   1st Qu.:0.1699
 Median :0.2408   Median :0.3417
 Mean   :0.3518   Mean   :0.3952
 3rd Qu.:0.4580   3rd Qu.:0.5839
 Max.   :2.0456   Max.   :1.3443
~~~

<!-- Better yet, a stacked line plot of start/end intervals? something like http://stackoverflow.com/questions/9871043/increasing-the-performance-of-visualising-overlapping-segments? -->

### 关闭时间分布

> `Google Reader`: “谁在 blog 里呼唤我？/ 我听见一声尖厉鸣唱，胜过一切 YouTubes / 呼唤‘Reader！’ 直面你的耳朵，Reader 便会回应。”
>
> `Dataset`: “Beware the ides of [March](http://googleblog.blogspot.com/2013/03/a-second-spring-of-cleaning.html "'A second spring of cleaning', 13 March 2013")。”^[[_Google Reader_](!Wikipedia "Julius Caesar (play)") Act 1, scene 2, 15-19; with apologies.]

一个明显特征是关闭时间并非均匀：卡方检验显著（_p_=0.014），图上也能看到 9 月和 3/4 月的峰值[^by-months-vacation]：

![按月份统计关闭数（9 月、3 月、4 月出现峰值）](/images/google/shutdownsbymonth.png)

[^by-months-vacation]: Xoogler [Rachel Kroll](http://rachelbythebay.com/) 在 [这一峰值上的看法](https://news.ycombinator.com/item?id=5653934)：

    > 我对死亡日期这件事有些想法。
    >
    > 九月：所有实习生都回学校了。这些位于系统边缘的人往往能做大量工作，可能因为他们没背负正式员工的各种行政负担。实习生离开后，轮到 FTE（全职员工）承担已建成项目的所有权，并不总是可行。能留住更多实习生是我的愿望吧。
    >
    > 三月/四月：季度奖金期？那以前也常是这样。我本人 5 月离职也并非偶然。关键在于：人走了，相关计划也随之夭折。

因为 Google 自 1997 年以来快速扩张，我们也看见其他不均衡：例如 1997–2004 年很少推出产品，2005 年以后则大量上线：

![按年份的产品上线数](/images/google/startsbyyear.png)

我们也可以将寿命与停服时间做散点图，得到更清楚的图像：

![上线日期 vs 寿命](/images/google/openedvslifespan.png)

2009 年周边的聚集尤其可疑。为突出 2011–2012 年末的关闭高峰，我画了停服频次直方图和核密度图：

![按年份的关闭分布](/images/google/shutdownsbyyear.png)

![核密度（默认带宽）](/images/google/shutdownsbyyear-kernel.png)

核密度图提示一个之前未明显看到的现象：近年几乎没有关闭事件。2013 年计划关闭了 4 个产品，但最后一个在 11 月，暗示 2013 年可能见底，之后的关闭更多会落在 2014。

这种时间曲线可解释为 2011 年 4 月 4 日 Larry Page 接任 CEO（接替 Ererick Schmidt）后的一次结构变化。Eric Schmidt 当年被招为“IPO 前 Google 的成人监护人”，Larry 很尊敬 Steve Jobs（他们俩见面前甚至建议 Jobs 担任 CEO）。Isaacon 的《Steve Jobs》记载，Jobs 去世前建议 Larry “聚焦”，并问“你们要专注哪五样产品？” 其答案是：“砍掉其余拖慢你进度的产品。”果然在 [2011 年 7 月 14 日](https://plus.google.com/+LarryPage/posts/dRtqKJCbpZ7) 的公开博文里他写道：

> ...本季度另一个重点就是“更聚焦”；这相当于用更少的箭射得更远。上个月我们宣布将关闭 Google Health 与 Google PowerMeter。我们也在内部做了大量简化与整合产品线的工作。很多工作外部还没看得出来，但我对进展很满意。面对诸多机遇，聚焦与优先排序至关重要。

虽然有人[不认同](http://thenextweb.com/google/2013/01/12/larry-page-did-well-to-ignore-steve-jobs/)这一思路，但很难否认 2011 年底到 2012 年，Google 关闭潮确实一浪接一浪。这看上去更像一次“清理”，如果真的在做“聚焦”，那两年内新增服务很可能比以前少。

## 建模

### 逻辑回归

要预测一个产品何时会关闭，第一步是先判断它是否会关闭。因变量是二分类（存活/死亡），因此可以用标准的[逻辑回归](!Wikipedia)。首次模型使用主要变量和总命中数：

~~~{.R}
Coefficients:
                Estimate Std. Error z value Pr(>|z|)
(Intercept)       2.3968     1.0680    2.24    0.025
Typeprogram       0.9248     0.8181    1.13    0.258
Typeservice       1.2261     0.7894    1.55    0.120
Typething         0.8805     1.1617    0.76    0.448
ProfitTRUE       -0.3857     0.2952   -1.31    0.191
FLOSSTRUE        -0.1777     0.3791   -0.47    0.639
AcquisitionTRUE   0.4955     0.3434    1.44    0.149
SocialTRUE        0.7866     0.3888    2.02    0.043
log(Hits)        -0.3089     0.0567   -5.45  5.1e-08
~~~

在[对数几率](!Wikipedia)意义上，系数 >0 增加关闭几率，<0 降低关闭几率。根据系数可做初步解释：

- Google 过去在社交产品上反复踩坑

    这支持“Google 历史上处理社交属性很差”的普遍观点；但能否用于预测未来仍有疑问。考虑到 Larry Page 2009 年后开始押注社交，`social` 相关产品未来要么直接并入 Google+，要么会被长期维持在生存边缘而非立刻关闭。
- Google 正在把软件产品替换为 Web 服务

    这从 Firefox、Chromium 经验已可见——更多资源用于提升 Web 浏览器这一应用平台。随着 HTML5 等成熟，Google 对独立软件投入和维护更少动力。
- 但似乎这不适用于其 FLOSS 软件

    因为不少软件后续交由第三方（Wave、Etherpad、Refine），融入既有社区（Summer of Code 项目），或承担“战略角色”（Android、Chromium、Dart、Go、Closure Tools、VP Codecs），整体上是为了构建“替代操作系统的浏览器栈”（为何如此可见《[Commoditize your complements](http://www.joelonsoftware.com/articles/StrategyLetterV.html)》）。
- 收费或广告展示的服务更可能存活

    这虽然看似显然，但还是有统计支持；起码它能部分验证本模型。
- “Google 命中”能反映受欢迎程度

    同样直观——也许不是这么简单？

#### 命中指标的使用方式

我们的命中指标（或 4 个命中特征）是否可信？这些数据多是事后补采，偶尔几年后才可得——数据会不会被“某产品关闭导致当下搜索热度上升”污染？比如文章刚讨论该产品关闭，搜索量突然暴涨，反过来影响命中。页面本身也可能增加某些死产品的命中。难道我们看到的是[信息泄漏（leakage）](http://www.cs.umb.edu/~ding/history/470_670_fall_2011/papers/cs670_Tran_PreferredPaper_LeakingInDataMining.pdf "'Leakage in Data Mining: Formulation, Detection, and Avoidance', Kaufman et al 2011)吗？我自己在 [漏斗分析](#leakage)里也体会过这一点。

继续研究，单独用命中数确实有信息：

~~~{.R}
            Estimate Std. Error z value Pr(>|z|)
(Intercept)   3.4052     0.7302    4.66  3.1e-06
log(Hits)    -0.3000     0.0549   -5.46  4.7e-08
~~~

平均每日日命中（产品寿命内平均）更重要：

~~~{.R}
             Estimate Std. Error z value Pr(>|z|)
(Intercept)    -2.297      1.586   -1.45    0.147
log(Hits)       0.511      0.209    2.44    0.015
log(AvgHits)   -0.852      0.217   -3.93  8.3e-05
~~~

这有些反直觉：平均命中高意味着风险越低是合理的，但总命中越高却按逻辑也该更安全。于是第三指标登场后，局面更清晰：

~~~{.R}
                  Estimate Std. Error z value Pr(>|z|)
(Intercept)        -21.589     11.955   -1.81   0.0709
log(Hits)            2.054      0.980    2.10   0.0362
log(AvgHits)        -1.921      0.708   -2.71   0.0067
log(DeflatedHits)   -0.456      0.277   -1.64   0.1001
~~~

把全部 4 个命中变量放进来后，3 个进入模型并显著：

~~~{.R}
                  Estimate Std. Error z value Pr(>|z|)
(Intercept)       -24.6898    12.4696   -1.98   0.0477
log(Hits)           2.2908     1.0203    2.25   0.0248
log(AvgHits)       -2.0943     0.7405   -2.83   0.0047
log(DeflatedHits)  -0.5383     0.2914   -1.85   0.0647
AvgDeflatedHits    -0.0651     0.0605   -1.08   0.2819
~~~

并不是命中指标只是互相替代。把所有非命中变量纳入并做复杂度惩罚后，仍只保留这 3 个命中变量：

~~~{.R}
                  Estimate Std. Error z value Pr(>|z|)
(Intercept)        -23.341     12.034   -1.94   0.0524
AcquisitionTRUE      0.631      0.350    1.80   0.0712
SocialTRUE           0.907      0.394    2.30   0.0213
log(Hits)            2.204      0.985    2.24   0.0252
log(AvgHits)        -2.068      0.713   -2.90   0.0037
log(DeflatedHits)   -0.492      0.280   -1.75   0.0793
~~~

AIC: 396.9
~~~

许多变量被剔除，仅 4 个命中中的 3 个留存；“平均命中”与“去通胀命中”都还在（后者符号正确，方向合理）。原始总命中出现异常符号，说明泄漏影响很大。平均命中和原始命中相关度过高、不合常识。  
因此我只用去通胀命中（`DeflatedHits`）——其符号正确且数量级更可接受（大约前者的五分之一）。当然，这并不代表我确信它完全没有泄漏。

### 生存曲线

逻辑回归能筛选变量，但只处理“是否关闭”的二元结果；却没有纳入“已经存活了多久”这一最关键变量——显然存活天数越长，死亡风险会变化（“长期来看我们都要死”）。  
如果想看随时间变化，应使用[生存分析](!Wikipedia)。我参考了 Wikipedia、[Fox 与 Weisberg 附录](http://socserv.mcmaster.ca/jfox/Books/Companion/appendix/Appendix-Cox-Regression.pdf)、[Bewick 等](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1065034/)、[Zhou 指南](https://web.archive.org/web/20130402204254/http://www.ms.uky.edu/~mai/Rsurv.pdf) 以及 Hosmer & Lemeshow 的《Applied Survival Analysis》，并用 `survival` 包给出了下面结果（见[CRAN 的 Survival 分析任务视图](http://cran.r-project.org/web/views/Survival.html)）。错误是我自己的。

初步估计给出中位寿命 2824 天（高于 Arthur 的 1459 天，因为条件已校正了那些最终会关闭的样本，且我专门补充了更多 2009 年前的产品）；下界不紧，而且死亡样本太少导致上界不好算：

~~~{.R}
records   n.max n.start  events  median 0.95LCL 0.95UCL
    350     350     350     123    2824    2095      NA
~~~

总体 Kaplan-Meier 生存曲线值得关注：

![按时间的累计关闭概率](/images/google/overall-survivorship-curve.png)

如果每个新增后死亡风险不变，曲线应近似“II 型”——一条直线；若像人类死亡率随年龄上升，则应是“I 型”（先缓后陡）。实际上看起来有“水平化”趋势，更像“III 型”：早期死亡高，随后趋稳。正如 Wikipedia 所述：

> ...死亡往往在生命周期早期最为集中，那些度过这一瓶颈的人群，其后续死亡率会明显下降。这种曲线常见于高繁殖物种（见 [r/K 选择理论](!Wikipedia)）。

这很符合科技行业/创业常见做法：一次做很多东西，快速迭代，反复“扔砖”测试。更重要的是，它也表明样本并未因偏差而严重漏掉短命产品；若漏掉大量短寿命，曲线将更像 I/II 型而非这种高早期死亡的 III 型——若确有漏失，真实曲线会更偏向 III 型。

但死亡率的下降从约 2000 天后才明显，因此那些产品可能在 2005 年及以前就已推出，也就是 Google 在那年起加速推出产品、且关闭行为可能制度化；这可能触及 Kaplan-Meier 的核心假设（基础生存函数随时间不变）。

下一步是对协变量拟合 Cox [比例风险模型](!Wikipedia)：

~~~{.R}
...
n= 350, number of events= 123

                    coef exp(coef) se(coef)     z Pr(>|z|)
AcquisitionTRUE    0.130     1.139    0.257  0.51    0.613
FLOSSTRUE          0.141     1.151    0.293  0.48    0.630
ProfitTRUE        -0.180     0.836    0.231 -0.78    0.438
SocialTRUE         0.664     1.943    0.262  2.53    0.011
Typeprogram        0.957     2.603    0.747  1.28    0.200
Typeservice        1.291     3.638    0.725  1.78    0.075
Typething          1.682     5.378    1.023  1.64    0.100
log(DeflatedHits) -0.288     0.749    0.036 -8.01  1.2e-15

                  exp(coef) exp(-coef) lower .95 upper .95
AcquisitionTRUE       1.139      0.878     0.688     1.884
FLOSSTRUE             1.151      0.868     0.648     2.045
ProfitTRUE            0.836      1.197     0.531     1.315
SocialTRUE            1.943      0.515     1.163     3.247
Typeprogram           2.603      0.384     0.602    11.247
Typeservice           3.637      0.275     0.878    15.064
Typething             5.377      0.186     0.724    39.955
log(DeflatedHits)     0.749      1.334     0.698     0.804

Concordance= 0.726  (se = 0.028 )
Rsquare= 0.227   (max possible= 0.974 )
Likelihood ratio test= 90.1  on 8 df,   p=4.44e-16
Wald test            = 79.5  on 8 df,   p=6.22e-14
Score (logrank) test = 83.5  on 8 df,   p=9.77e-15
~~~

再检验协变量是否异常，整体看没有明显问题：

~~~{.R}
                      rho  chisq     p
AcquisitionTRUE   -0.0252 0.0805 0.777
FLOSSTRUE          0.0168 0.0370 0.848
ProfitTRUE        -0.0694 0.6290 0.428
SocialTRUE         0.0279 0.0882 0.767
Typeprogram        0.0857 0.9429 0.332
Typeservice        0.0936 1.1433 0.285
Typething          0.0613 0.4697 0.493
log(DeflatedHits) -0.0450 0.2610 0.609
GLOBAL                 NA 2.5358 0.960
~~~

我仍心存疑虑，于是加入另一个协变量 `EarlyGoogle`（是否在 2005 年前发布）。它是否补充了“老产品”信息？比例风险假设是否仍成立？答案都是否定：

~~~{.R}
                     coef exp(coef) se(coef)     z Pr(>|z|)
AcquisitionTRUE    0.1674    1.1823   0.2553  0.66    0.512
FLOSSTRUE          0.1034    1.1090   0.2922  0.35    0.723
ProfitTRUE        -0.1949    0.8230   0.2318 -0.84    0.401
SocialTRUE         0.6541    1.9233   0.2601  2.51    0.012
Typeprogram        0.8195    2.2694   0.7472  1.10    0.273
Typeservice        1.1619    3.1960   0.7262  1.60    0.110
Typething          1.6200    5.0529   1.0234  1.58    0.113
log(DeflatedHits) -0.2645    0.7676   0.0375 -7.06  1.7e-12
EarlyGoogleTRUE   -1.0061    0.3656   0.5279 -1.91    0.057
...
Concordance= 0.728  (se = 0.028 )
Rsquare= 0.237   (max possible= 0.974 )
Likelihood ratio test= 94.7  on 9 df,   p=2.22e-16
Wald test            = 76.7  on 9 df,   p=7.2e-13
Score (logrank) test = 83.8  on 9 df,   p=2.85e-14
~~~

~~~{.R}
                       rho   chisq     p
EarlyGoogleTRUE   -0.05167 0.51424 0.473
GLOBAL                  NA 2.52587 0.980
~~~

按预期，2005 年前发布的产品确实更不容易被关闭，是仅次于“并购/非 FLOSS/是否社交”等因素的第三大影响；其显著性接近 0.057（按传统 [NHST] 批评观点，这与 0.050 并不离谱）并未触发假设违例，所以继续用 Cox。

模型解释起来很清楚：降低关闭风险的方法是

1. 不是并购产物
2. 不是 FLOSS
3. 有直接盈利
4. 不是社交属性
5. 相对寿命归一后命中越高越安全
6. 在 Google 早期时期推出

这都合理。利润和社交效应最有意思，但对应风险比值不太直观：若社交属性让关闭赔率×1.943，非直接盈利让赔率×1.215，这该如何理解？我把全体数据按 profit / social 分组画生存曲线，去掉置信区间以便比较（略重叠），大致把含义具象化。

![按 `Profit` 分组的全量生存曲线](/images/google/profit-survivorship-curve.png)
![按 `Social` 分组的全量生存曲线](/images/google/social-survivorship-curve.png)

### 随机森林

出于好奇，我还比较了[随机森林](!Wikipedia)（见 [Breiman 2001](https://web.archive.org/web/20140430075247/http://oz.berkeley.edu/~breiman/randomforest2001.pdf)）与逻辑回归、以及基线预测（“没有模型时按 ~65% 产品仍存活”）的表现。

我用 [`randomForest`](http://cran.r-project.org/web/packages/randomForest/index.html) 训练分类随机森林，得到：

~~~{.R}
               Type of random forest: classification
                     Number of trees: 500
No. of variables tried at each split: 2

        OOB estimate of  error rate: 31.71%
Confusion matrix:
      FALSE TRUE class.error
FALSE   216   11     0.04846
TRUE    100   23     0.81301
~~~

把它和逻辑回归相比，逻辑回归将 `shutdown-odds>1` 定义为关闭概率更高，再与真实标签比对（逻辑回归并不使用[严格评分规则](!Wikipedia)），得到 base-rate 为 65%，逻辑回归约 68%，随机森林也接近 68%。这两个结果不算差，因为我没有把寿命（`Days`）纳入分类器；一旦考虑寿命有更多信息。综合看并未比逻辑回归更复杂更好。

#### 随机生存森林

下一步自然是把寿命与生存曲线也纳入。`"Random survival forests"`（见 [Ishwaran et al 2008](http://arxiv.org/pdf/0811.1645)、[Mogensen et al 2012](http://www.jstatsoft.org/v50/i11/paper)）在 `randomForestSRC` 中实现（成功版）：

~~~{.R}
                         Sample size: 350
                    Number of deaths: 122
                     Number of trees: 1000
          Minimum terminal node size: 3
       Average no. of terminal nodes: 61.05
No. of variables tried at each split: 3
              Total no. of variables: 7
                            Analysis: Random Forests [S]RC
                              Family: surv
                      Splitting rule: logrank *random*
       Number of random split points: 1
              Estimate of error rate: 35.37%
~~~

还得到一张有趣的变量重要性图：

![随机树对变量重要性的平均贡献](/images/google/rsf-importance.png)

按同样方法，随机生存森林的错误率为 78%，基于 Cox 的也有 72%；但是 bootstrap 稳健性测试不佳：随机生存森林约 57%–64%（200 次 bootstrap，95%）；Cox 约 68%–73%。这说明随机生存森林或许过拟合/代码实现问题，所以继续采用普通 Cox。

## 预测

在给未来做明确预测前，先看那些尚未关闭产品的[相对风险](!Wikipedia)。Cox 模型中“最危险”的前 10 名是：

1. Schemer
2. Boutiques
3. Magnifier
4. Hotpot
5. Page Speed Online API
6. WhatsonWhen
7. Unofficial Guides
8. WDYL search engine
9. Cloud Messaging
10. Correlate

这些都算比较合理（尽管我很喜欢 Correlate，因为它让“相关≠因果”可视化得更容易，见 [slatestarcodex 文章](http://slatestarcodex.com/2013/02/16/google-correlate-does-not-imply-google-causation/)；我惊讶它或 Boutiques 还没死）。反向，风险最低的 10 个（风险按升序）是：

1. Search
2. Translate
3. AdWords
4. Picasa
5. Groups
6. Image Search
7. News
8. Books
9. Toolbar
10. AdSense

旗舰产品（Search、Books）几乎不可能关闭，这部分结果很合理；Picasa、Toolbar 因其老旧、被忽视、前 2005 产生且主要依赖广告，我对“它们不太会死”仍持保留态度，但模型给出这样结论可解释。继续看更多：对仍存活服务，我进一步算了若干样本在接下来 5 年存活的概率（将各自协变量代入，曲线明显不同）：

![15 个代表产品的预估生存曲线（AdSense、Scholar、Voice 等）](/images/google/15-predicted-survivorship-curves.png)

这些是以“从 0 日起、同质化人群”设定的曲线。若假设该产品已活到今天该如何估计？这需要把生存曲线“向当前条件反推”，过程较绕；我导出了 5 年存活预测值，并附上主观判断作对照（我在[预测市场](Prediction markets)里并不差）：

产品         5 年生存率           个人预测   相对风险（越低越好）
-----------    ----------------- -------------- ----------------------------------------------------
AdSense        100%              [99%][]        0.07
Alerts         89%               [70%][]        0.21
Analytics      76%               [97%][]        0.24
Blogger        100%              [80%][]        0.32
Calendar       66%               [95%][]        0.36
Docs           63%               [95%][DOCS]    0.39
FeedBurner     43%               [35%][]        0.66
Gmail          96%               [99%][GMAIL]   0.08
Google+        79%               [85%][]        0.36
Scholar        92%               [85%][S]       0.10
Voice[^v]      44%               [50%][]        0.78
Chrome         70%               [95%][C]       0.24
Project Glass  37%               [50%][Glass]   0.10
Search         96%               [100%][]       0.05
Translate      92%               [95%][T]       0.78

[99%]: http://predictionbook.com/predictions/17897
[70%]: http://predictionbook.com/predictions/17898
[97%]: http://predictionbook.com/predictions/17899
[80%]: http://predictionbook.com/predictions/17900
[95%]: http://predictionbook.com/predictions/17901
[DOCS]: http://predictionbook.com/predictions/17902
[35%]: http://predictionbook.com/predictions/17903
[GMAIL]: http://predictionbook.com/predictions/17904
[85%]: http://predictionbook.com/predictions/17905
[S]: http://predictionbook.com/predictions/17906
[50%]: http://predictionbook.com/predictions/17907
[Glass]: http://predictionbook.com/predictions/17911
[100%]: http://predictionbook.com/predictions/17912
[T]: http://predictionbook.com/predictions/17913

[^v]: 我保留 Voice 在列表中，即便我自己不使用，也未必不值得关注；因为关于 Voice 前景的[猜测](http://www.wired.com/gadgetlab/2013/04/google-voice-future-uncertain/)很多，而且我收到过人要求对其未来[给出预测](http://lesswrong.com/r/discussion/lw/h3w/open_thread_april_115_2013/8p2q)的请求。

一眼可见，一些模型估计与我们对 Google 的理解不符。

我对被忽略的 [Google Alerts] 更悲观；而对 Analytics、Calendar、Docs 被认为有风险，我认为这明显过度，毕竟 Analytics 是广告基础设施核心，Calendar 是企业套件中的基石。Project Glass 的预测也值得关注：Google 知名度和推力度都极高，是否真如此危险？我不能完全认同。历史上不少技术潮汐来去匆匆，硬件尤其脆弱、贴身产品更看重体验（Glass 可能是 Apple 的大卖款式，但 Google 能否做到？），而 Google Glass 已遭到不少公开批评，尤其是 [Steve Mann](!Wikipedia) 这位长期头戴显示器研究者在 [这篇文章](http://spectrum.ieee.org/geek-life/profiles/steve-mann-my-augmediated-life) 对其指出过“与业界领先方案不一致”“设计决策可能让用户难以使用”“糟糕版本会带来视疲劳，甚至损伤视力”等。

另一些估计更能接受——Google 在社交工具上的口碑确实差，所以对 Google+ 的风险偏悲观合理。FeedBurner 或 Voice 亦如此，我也同意前景偏暗。Blogger 在模型中的非常乐观结论反而有意思：我起初认为它会慢慢衰退，但研究发现它反而拿到了某些被关停服务的迁移入口（如 Scribe、Friend Connect），还是 Google+ 时代的 Dynamic Views 转型起点之一，并且官方公告仍大量使用 Blogger 平台，因此我对它保持更高信心。

整体看来，这些估计整体仍可接受。

# 后续

> 那些不死去的人是怎样的存在——\
> 死亡向所有人一视同仁。\
> 我想起一个高大的身影，\
> 他如今化作尘土。\
> 这幽暗世界里不见晨曦，\
> 即便尘外有新一季的繁茂；\
> 凡涉足这哀伤之地，\
> 松风便以悲痛将其终结。^[[韩山](!Wikipedia "Hanshan (poet)"), #50]

也许值得继续维护数据库并在五年后（2018）做一次复盘。到那时我们可检验预测准确性，也会因为 2011–2012 年 30+ 个样本被关闭，生存曲线和协变量估计将更清晰。为此我曾做过更新跟踪，建立了两类 Google Alerts 搜索：

- `google ("shut down" OR "shut down" "shutting" OR "closing" OR "killing" OR "abandoning" OR "leaving")`
- `google (launch OR release OR announce)`
- 并订阅了 Google Operating System 博客

这些源头在此后一年内给了我约 64 个候选项；2014 年 6 月 4 日后我停止继续添加。

# 参见

- [Archiving URLs](https://gwern.net/archiving)
- [survival analysis of _MoR_ readers](hpmor#survival-analysis)
- [Wikipedia and Knol](https://gwern.net/wikipedia-and-knol)


# 外部链接

- [Archive Team](!Wikipedia)（[ArchiveTeam Warrior](http://www.archiveteam.org/index.php?title=ArchiveTeam_Warrior): [Reader](http://www.archiveteam.org/index.php?title=Google_Reader))
- 讨论串：
  - [Hacker News](https://news.ycombinator.com/item?id=5653748)
  - [Metafilter](http://www.metafilter.com/127712/In-a-few-cases-the-start-dates-are-wellinformed-guesses)
- 媒体评论：
  - [_Ars Technica_](http://arstechnica.com/business/2013/05/google-services-survive-if-they-make-money-arent-social/)（含[评论](http://arstechnica.com/business/2013/05/google-services-survive-if-they-make-money-arent-social/?comments=1)）
  - [_The Atlantic_ 的《有趣的软件追更：Scrivener》](http://www.theatlantic.com/technology/archive/2013/05/interesting-software-follow-up-scrivener-googles-orphans/275563/)
  - _Forbes_：
    - [“Google 股价上涨背后在驱动什么？”](http://www.forbes.com/sites/haydnshaughnessy/2013/05/08/what-is-driving-the-google-stock-price-up/)
    - [“Google Glass—它能存活多久？”](http://www.forbes.com/sites/haydnshaughnessy/2013/05/09/google-glass-has-only-a-37-chance-of-going-five-years-lessons/)
  - [_Boy Genius Report_](http://bgr.com/2013/05/07/google-services-shut-down-study/)
- 并购背景：
  - [“What Happened to Yahoo”](http://paulgraham.com/yahoo.html)，Paul Graham
  - 37signals 的 ["Exit Interview" 系列](http://www.google.com/search?q=%22Exit+Interview%22&sitesearch=37signals.com/svn/posts/)
    1. [Jaiku 的退出访谈](http://37signals.com/svn/posts/2883-exit-interview-jaikus-jyri-engestrm)
    2. [AOL/JD: Founders look back at acquisitions by Google, AOL, Microsoft, and more](http://37signals.com/svn/posts/2942-exit-interview-founders-look-back-at-acquisitions-by-google-aol-microsoft-and-more)
    3. [Ask Jeeves 被 Google 收购后的退出访谈](http://37signals.com/svn/posts/2806-exit-interview-ask-jeeves-acquisition-of-bloglines)
    4. [被 Yahoo 收购后的去向](http://37signals.com/svn/posts/2777-what-happens-after-yahoo-acquires-you)

<!--
如何处理更新？我打算把它们都放在这里。思路是新增一个协变量，区分“企业向”“消费向”还是“两者兼有”。并补充新数据。

"Product","Dead","Started","Ended","Hits","Type","Profit","FLOSS","Acquisition","Social"
"Inactive Account Manager",FALSE,2013-04-11,NA,175000,service,FALSE,FALSE,FALSE,FALSE
"Affiliate Network",TRUE,2007-04-13,2013-04-16,3480000,service,TRUE,FALSE,TRUE,FALSE http://googleaffiliatenetwork-blog.blogspot.in/2013/04/an-update-on-google-affiliate-network.html
Behavio's FunF http://www.sfgate.com/technology/businessinsider/article/Google-Just-Bought-A-Cool-SXSW-Startup-Behavio-4430716.php supposedly Google will continue it but it may be killed too quickly to count for this list
"AdWords Pay Per Action",TRUE,2007-03-20,2008-08-31,144000,service,TRUE,FALSE,TRUE,FALSE
"AdSense Referrals",TRUE,2007-04-05,2008-08-31,25000,service,TRUE,FALSE,FALSE,FALSE
"Quick View in Search",TRUE,2009-10-07,2013-04-24,2460000,service,FALSE,FALSE,FALSE,FALSE http://googleblog.blogspot.com/2009/10/quickly-view-formatted-pdfs-in-your.html http://googlesystem.blogspot.com/2013/04/no-more-quick-view-in-google-search.html exact search query: "google search" "quick view"
WhatsonWhen: dead? site down after January 2013, but no apparent announcements. "google whatsonwhen " 48,400 results
Free Zone: http://www.nation.lk/edition/biz-news/item/17466-dialog-axiata-and-google-launch-free-zone.html 'google "free zone"' 3,030,000 results
Meebo Bar: http://www.pcmag.com/article2/0,2817,2418268,00.asp 'google "meebo bar"' 160,000 results killed 6 June 2013 http://gigaom.com/2013/06/06/a-year-after-google-acquistion-meebo-bar-will-discontinue-as-team-settles-in-with-google/ social acquisition ad-supported
'paid channels'? http://www.wired.com/gadgetlab/2013/05/youtube-adds-paid-channel-subscriptions/ http://youtube-global.blogspot.com/2013/05/yt-pc-2013.html
SMS down 9 May 2013:  http://productforums.google.com/forum/#!msg/websearch/yKG7BGro7QQ/ntAXQWWKj70J https://news.ycombinator.com/item?id=5695086 "google sms" 579,000 other results.
Scratchpad free program non-social non-acquisition non-floss  "google scratchpad" 965 results  dead 2 November 2012 http://www.omgchrome.com/google-stopping-development-of-scratchpad-web-app/ general description: https://support.google.com/chrome_webstore/answer/183097?hl=en merged into Keep? "* * Scratchpad is moving to Google Keep. * * If you have unsynced Scratchpad notes, please open the app and follow instructions to save your notes. You can add Google Keep here:  https://chrome.google.com/webstore/detail/google-keep/hmjkmjkepdijhoojdojkdfohbdgmmhki" when was it launched? best guess, January 2011 http://voices.yahoo.com/scratchpad-notepad-application-google-chrome-7581750.html?cat=15
Cloud Messaging for Chrome http://developer.chrome.com/apps/cloudMessaging.html "service",FALSE,FALSE,FALSE,FALSE launch: 10 May 2013 search 'Google "Cloud Messaging for Chrome"' 23,300 results
Google Play Music 15 05 2013 paid service non-acquisition non-FLOSS social? ("You can share songs on your google+") '"google play music"' About 37,300,000 results (0.46 seconds)
google Music: was actually dead 19 October 2012! http://www.reuters.com/article/2012/09/21/net-us-google-china-music-idUSBRE88K07120120921
Google+ Games, launched 11 08 2011 http://googleblog.blogspot.com/2011/08/games-in-google-fun-that-fits-your.html Dead, 30 June 2013 https://support.google.com/plus/answer/3123176?p=plus_games&rd=1 non-FLOSS, non-acquisition profit social, '"google+ games"' 142000 hits
Checkout Gadget: dead, see http://googlecommerce.blogspot.com/2013/05/an-update-to-google-checkout-for.html https://support.google.com/checkout/sell/answer/3080449
is checkout proper dead?
"On November 20th, 2013, Google will shut down its Checkout product. Here's how this may affect you:

    Merchants selling digital goods may transition to Google Wallet for digital goods
    Merchants selling through Google-hosted marketplaces (e.g. Google Play) will be unaffected
    Merchants selling physical goods will need to switch to third-party alternatives (see below)"
https://news.ycombinator.com/item?id=5740447 (also https://news.ycombinator.com/item?id=6579812 / https://news.ycombinator.com/item?id=6581906 )
"> 'Wait, so what's the difference between this and Google Wallet?' With Checkout, Google is a credit card processor. With Wallet, Google isn't a credit card processor, they are partnered with Bankcorp Bank who is issuing virtual cards which are funded either by transferring funds from the users bank account or by charging credit cards."

04:57:29 < quanticle> gwern: When you get this, would you mind giving me your opinion on the continued long-term viability of Google Tasks? My prediction is that it won't last much longer; it seems to be a massively underdeveloped part of GMail/Google Calendar, and the task-list/to-do-list market is fiercely competitive.
05:11:25 < harrow> old Closure Library codebase, guy who wrote it quit, no tie-in with G+
Tasks LIVE, service non-profit non-social non-acquisition '"Google Tasks"' 641000 hits launched: 8 December 2008 http://gmailblog.blogspot.com/2008/12/new-in-labs-tasks.html
http://googlesystem.blogspot.com/2013/06/googles-caldav-and-carddav-apis-for.html CalDav API given a reprieve?
what happened to Waze? http://www.globes.co.il/serveen/globes/docview.asp?did=1000850934&fid=1725 apparently decided to keep Waze app running, so it enters the listings: http://www.wired.com/gadgetlab/2013/06/google-waze-acquisition/ http://googleblog.blogspot.com/2013/06/google-maps-and-waze-outsmarting.html
also check these: "Google acquired personalized Website gadget developer Labpixies for $25 million and interactive video-clip developer Quiksee for $10 million. Both acquisitions were in 2010.
google Chrome Frame https://en.wikipedia.org/wiki/Google_Chrome_Frame "chrome frame" 2,830,000 "google chrome frame" 28,200,000 plugin "According to Alex Russell - who came to Google specifically to start the Chrome Frame project - the plug-in will officially be retired early in 2014, and the company is beginning to warn the consumers and businesses who use the tool. "We've gotten to the point now where the trend lines indicate the need for Chrome Frame is going to expire early next year, so we're giving consumers and enterprises a lot of heads up that Chrome Frame is going to be going away," he says." http://www.wired.com/wiredenterprise/2013/06/chrome-frame-ends/ http://www.techrepublic.com/blog/google-in-the-enterprise/google-chrome-frame-is-leaving-the-picture/ http://blog.chromium.org/2013/06/retiring-chrome-frame.html January 2014
AdWhirl bought with AdMob, died 30 September 2013 http://vator.tv/news/2013-06-14-google-shutting-down-adwhirl-at-the-end-of-september for profit open-source https://code.google.com/p/adwhirl/ "google adwhirl" 101,000 results
"Google Mine", Pinterest competitor http://googlesystem.blogspot.com/2013/06/google-mine.html unreleased as of June 21, 2013
"Google Latitude" dead 9 August 2013; search 'Google Latitude' pulls up 1,150,000 hits on 10 July ANN: https://support.google.com/gmm/answer/3001634 https://plus.google.com/+jlapenna/posts/deBP7kj7rMi
Google Shopping for Suppliers 'Google "Shopping for Suppliers"' 67,300  11 July 2013; profit www.google.com/shopping/suppliers/‎ started 28 Jan 2013
Alfred,  dead 19 July 2013, for-profit acquisition (14 December 2011) http://techcrunch.com/2013/07/11/google-will-shut-down-alfred-the-local-recommendations-app-july-19/ http://www.ubergizmo.com/2013/07/google-to-shut-down-alfred-on-july-19th/ http://www.engadget.com/2011/12/14/google-buys-alfred-maker-clever-sense-brings-us-closer-to-perso/ "google alfred"  46,100   17 July 2013
Chromecast product for-profit non-social? non-FLOSS  341,000,000 hits 'google chromecast' 29 July 2013  http://www.n3rdabl3.co.uk/2013/07/google-announce-chromecast-a-new-way-to-share-on-your-tv/
Google Shopper: dead. 30 August 2013 http://www.fiercemobilecontent.com/story/google-shopper-price-comparison-app-shutting-down-aug-30/2013-07-29 "google shopper", 297000 hits as of 2 August 2013
Google Earth Tour Builder  http://googlesystem.blogspot.com/2013/08/google-earth-tour-builder.html https://tourbuilder.withgoogle.com/about/faq About 28,500 results (0.33 seconds) as of 1 September 2013
`google "tour builder"` About 24,800 results (19 September 2013) non-profit software FLOSS https://code.google.com/p/tour-builder/
Google Lime Scholarship 'google lime scholarship' About 1,030,000 results (0.23 seconds) (19 September 2013) started 15 April 2009 http://googleforstudents.blogspot.com/2011/04/2011-google-lime-scholars-announced.html http://googleforstudents.blogspot.com/2012/03/announcing-2012-google-lime-scholars.html  http://google.about.com/b/2009/04/15/google-lime-scholarship.htm http://www.limeconnect.com/opportunities/page/google-lime-scholarship-program http://www.google.com/edu/students/scholarships.html
Course Builder non-profit FLOSS https://code.google.com/p/course-builder/ program 11 September 2012 '"google course builder"' About 264,000 results  (19 September 2013) (sunsetted by Open edX)
Open edX 10 September 2013;  '"Open edX"' About 18,900 results (19 September 2013) http://googleresearch.blogspot.com/2013/09/we-are-joining-open-edx-platform.html FLOSS? program? service?
Bump start: 17 September 2013; acquisition: http://www.iol.co.za/scitech/technology/business/google-buys-bump-app-1.1578671 http://techcrunch.com/2013/09/16/bump-mobile-contact-sharing-app-acquired-by-google-will-stay-alive-for-now/ application non-profit non-FLOSS '"google bump"' About 116,000 results Dead: 31 January 2014 http://blog.bu.mp/post/71781606704/all-good-things http://www.hngn.com/articles/20977/20140102/google-shutting-down-bump-flock-apps-end-january.htm
Flock start: 17 September 2013; acquisition: http://www.iol.co.za/scitech/technology/business/google-buys-bump-app-1.1578671 http://techcrunch.com/2013/09/16/bump-mobile-contact-sharing-app-acquired-by-google-will-stay-alive-for-now/ application non-profit non-FLOSS 'google flock' About 34,200,000 results Dead: 31 January 2014
Google Web Designer: 30 September 2013 ' 1,790,000 results ' "google web designer"' https://news.ycombinator.com/item?id=6470426 for-profit program non-FLOSS (see https://support.google.com/webdesigner/answer/3413931?hl=en ) non-acquisition
Google Shopping Express: 25 September 2013 service for-profit non-acquisition non-floss http://www.siliconbeat.com/2013/09/25/public-launch-of-google-shopping-express-a-challenge-to-amazon-ebay/  '"google shopping express"' 1,480,000 results  (1 October 2013)
Flutter https://flutterapp.com/home/ http://arstechnica.com/gadgets/2013/10/hands-on-with-googles-latest-acquisition-flutter-a-webcam-gesture-app/ 2 October 2013  "Flutter users will be able to continue to use the app, and stay tuned for future updates." https://flutterapp.com/ closed-source non-profit? flutter,  18,800,000;  '"google flutter"'  3,980
Google Tag Manager alive released Oct 1, 2012; http://www.google.com/tagmanager/ for-profit service non-acquisition  262,000 results  'google "tag manager"' 10 October 2013
Google TV killed? '"google tv"' 7,860,000 17 Oct 2013 http://www.hngn.com/articles/14778/20131013/google-tv-shuts-down-three-years-shifting-focus-android.htm http://gigaom.com/2013/10/10/google-tv-rebranded-android-tv/
Google WiFi Passport http://googlesystem.blogspot.com/2013/10/google-wifi-passport.html launched 16 October 2013 http://arstechnica.com/civis/viewtopic.php?f=9&t=1221867 for-profit service non-floss  'google "wifi passport"' 26 October 2013 1,090 results
'google helpouts' 4 November 2013 http://blogs.wsj.com/digits/2013/11/04/google-to-launch-helpouts-on-monday/ service, for-profit non-acquisition '"google helpouts"' 140,000 results
Ingress 14 December 2013 http://venturebeat.com/2013/11/04/googles-niantic-labs-to-formally-launch-massive-ingress-augmented-reality-game-on-dec-14/ application closed-source for-profit (sponsorship)
Google Trader: dead 10 December 2013, google.com.ng; '"Google Trader"' 14 Nov 2013: 101k results http://niyitabiti.net/2013/11/google-trader-nigeria-shut-down-website/
"Offer Extensions"  22 Feb 2013; 14 Nov 2013: 'google "Offer Extensions"' 35.6k hits dead 1 November 2013 http://searchengineland.com/adwords-offer-extensions-get-shut-down-in-favor-of-google-offers-176566
Google Newsstand http://www.pcmag.com/article2/0,2817,2427413,00.asp http://play.google.com/about/newsstand/ Android app 20 Nov 2013 '"Google Newsstand"' 71500 for-profit closed-source
Google Partners 28 November 2013 '"Google Partners"' 289k 3 December 2013;  http://articles.timesofindia.indiatimes.com/2013-11-28/services-apps/44545708_1_google-india-google-partners-agencies https://www.google.com/partners/ http://www.zdnet.com/in/launch-of-google-partners-to-help-smes-in-india-7000023740/ organization, for-profit
Android Gallery, dead Dec 2013? http://www.androidcentral.com/stock-android-gallery-app-no-more-new-google-play-edition-devices http://www.techhive.com/article/2079353/google-is-killing-the-android-gallery-app-so-that-google-plus-may-live.html 'google "android gallery"' 13 Dec 2013 516,000 results
Open Gallery, 10 December 2013 https://twitter.com/digitalfay/status/410361346522611712 http://www.google.com/opengallery https://support.google.com/opengallery/ closed-source service non-profit 'google "open gallery"' 1,110,000 17 Dec 2013
LiquidFun 11 December 2013 FLOSS software non-profit http://google-opensource.blogspot.ca/2013/12/liquidfun-rigid-body-physics-library.html http://www.i-programmer.info/news/144-graphics-and-games/6711-googles-liquidfun-for-fluid-simulation-.html http://google.github.io/liquidfun/ https://github.com/google/liquidfun  'google liquidfun' 14 Dec 2013 174000 results
Google+ Auto Backup ios/android application closed-source non-profit start: 24 June 2013? http://www.vlogg.com/10149/how-to-disable-auto-backup-of-photos-in-android/ https://support.google.com/plus/answer/1647509?hl=en http://www.techrepublic.com/blog/google-in-the-enterprise/quick-tip-back-up-your-photos-to-google-plus/ http://googlesystem.blogspot.com/2013/12/google-auto-backup-for-desktop.html http://www.gplusexpertise.com/2013/12/google-photos-auto-backup-now-in-picasa.html 'Google+ Auto Backup' 8,830,000 results  28 Dec 2013
7 February 2014 Schemer http://googlesystem.blogspot.com/2013/12/schemer-to-be-discontinued.html to be shut down in 2014? confirmed: "All your schemes are available for download until February 7, 2014, after which all data will be permanently deleted." https://plus.google.com/+Schemer/posts/AhXkhvzRtek
Google Talk Windows client? http://www.tbreak.ae/news/google-killing-google-talk-windows-client "Connections from the Google Talk client to Google Talk will continue to operate for the first two months of 2014. Users may continue to see the deprecation warning in the client during this time. After this period has elapsed the client will be unable to connect to the Google Talk service."
Timely 2014-01-04 closed-source application Bitspin acquisition non-profit (since Google made the paid Android Timely app free) http://www.bitspin.ch/google http://www.pcworld.com/article/2084140/google-makes-timely-buy-of-swiss-app-maker.html "For new and existing users, Timely will continue to work as it always has." '"google timely"' 2014-01-08: 25,400 results
Nest: "Nest Learning Thermostat", "Protect"  13 January 2013 https://investor.google.com/releases/2014/0113.html http://techcrunch.com/2014/01/13/google-just-bought-connected-device-company-nest-for-3-2b-in-cash/ https://nest.com/blog/2014/01/13/nest-google-and-you/ acquisition thing for-profit "google nest"  'About 87,300,000 results (0.42 seconds) '
Google Currents: dead 19 February 2014 http://www.androidpolice.com/2014/02/19/google-currents-is-officially-dead-with-latest-update-transitions-users-to-play-newsstand-and-disappears-for-good/
Wildfire 31 July 2012 http://wildfireapp.blogspot.com/2012/07/wildfire-is-joining-google.html acquisition social for-profit Maintenance stops 1 September 2014 "A source tells us that Wildfire has begun contacting its clients — which have included Cisco, Amazon, DQ, Gap, Jamba Juice, and McCann — to tell them that their business would no longer be serviced after the end of 2015."; shutdown: http://wildfireapp.blogspot.com/2014/03/accelerating-our-wildfire-integration.html
Know Your Candidate http://www.google.co.in/elections/ed/in/districts http://www.businessinsider.in/Indian-Election-Fever-Has-Hit-Google-As-They-Launch-KnowYour-Candidate-Tool/articleshow/33444019.cms 8 April 2014 website nonprofit non-FLOSS 'google "know your candidate"' 25 April 2014: 2,190,000 results
TODO: Hangout, Photo
6 May 2014 http://www.digitaljournal.com/pr/1903697 for-profit acquisition service https://www.google.com/search?num=100&q=google%20ezanga 14 May 2014 '34,400 results'
Google Zavers http://www.google.com/get/zavers/ coupon business for-profit acquisition service launched January 2013 death leaked 2 June 2014 http://recode.net/2014/06/02/google-will-kill-off-its-digital-coupon-business-zavers/ 'google zavers' 5 June 2014:  1,540 hits ('zavers': 51,500)
followup window closed 4 June 2014: no more new entries unless they came into existence before then! too much work
-->

# 附录
## 源代码

运行命令：`R --slave --file=google.r`:

~~~{.R}
set.seed(7777) # for reproducible numbers

library(survival)
library(randomForest)
library(boot)
library(randomForestSRC)
library(prodlim) # for 'sindex' call
library(rms)

# Generate Google corpus model for use in main analysis
# Load the data, fit, and plot:
index <- read.csv("http://www.gwern.net/docs/2013-google-index.csv",
                   colClasses=c("Date","double","character"))
# an exponential doesn't fit too badly:
model1 <- lm(log(Size) ~ Date, data=index); summary(model1)
# plot logged size data and the fit:
png(file="~/wiki/images/google/www-index-model.png", width = 3*480, height = 1*480)
plot(log(index$Size) ~ index$Date, ylab="WWW index size", xlab="Date")
abline(model1)
invisible(dev.off())

# Begin actual data analysis
google <- read.csv("http://www.gwern.net/docs/2013-google.csv",
                    colClasses=c("character","logical","Date","Date","double","factor",
                                 "logical","logical","logical","logical", "integer",
                                 "numeric", "numeric", "numeric", "logical", "numeric",
                                 "numeric", "numeric", "numeric"))
# google$Days <- as.integer(google$Ended - google$Started)
# derive all the Google index-variables
## hits per day to the present
# google$AvgHits <- google$Hits / as.integer(as.Date("2013-04-01") - google$Started)
## divide total hits for each product by total estimated size of Google index when that product started
# google$DeflatedHits <- log(google$Hits / exp(predict(model1, newdata=data.frame(Date = google$Started))))
## Finally, let's combine the two strategies: deflate and then average.
# google$AvgDeflatedHits <- log(google$AvgHits) / google$DeflatedHits
# google$DeflatedHits <- log(google$DeflatedHits)

cat("\nOverview of data:\n")
print(summary(google[-1]))

dead <- google[google$Dead,]

png(file="~/wiki/images/google/openedvslifespan.png", width = 1.5*480, height = 1*480)
plot(dead$Days ~ dead$Ended, xlab="Shutdown", ylab="Total lifespan")
invisible(dev.off())

png(file="~/wiki/images/google/shutdownsbyyear.png", width = 1.5*480, height = 1*480)
hist(dead$Ended, breaks=seq.Date(as.Date("2005-01-01"), as.Date("2014-01-01"), "years"),
                   main="shutdowns per year", xlab="Year")
invisible(dev.off())
png(file="~/wiki/images/google/shutdownsbyyear-kernel.png", width = 1*480, height = 1*480)
plot(density(as.numeric(dead$Ended)), main="Shutdown kernel density over time")
invisible(dev.off())
***
