---
title: "<em>Death Note</em>: L，匿名与逃避熵"
description: "应用计算机科学：关于将谋杀视为 STEM 领域——利用信息论量化夜神月在《死亡笔记》中的错误严重程度并考虑修正方案"
created: 2011-05-04
modified: 2017-12-15
status: finished
confidence: highly likely
importance: 7
css-extension: dropcaps-kanzlei
...

<div class="abstract">
> 在漫画《死亡笔记》中，主角夜神月获得了超自然的武器“死亡笔记”，可以按需杀死任何人，并开始用它重塑世界。天才侦探 L 试图通过分析和诡计追踪他，并最终获胜。《死亡笔记》几乎是一个思想实验——既然有了完美的谋杀武器，你怎么还会搞砸呢？我从计算机安全、密码学和信息论的角度考察了 L 过程的各个步骤，量化了月的初始匿名性以及 L 如何逐步去匿名化他，并按如下顺序考虑哪个错误最大：
>
> 1. 月的根本错误是以与其目标无关的方式杀人。
>
>    通过心脏麻痹杀人不仅让他很早就暴露了，而且死亡表明他的暗杀方法精确得不可能，正在发生某种极度反常的事情。L 已经被提示基拉的存在。无论虚假的理由是什么，这对他的对手来说都是一个重大胜利。（为了威慑罪犯和恶棍，没有必要存在一个全球知名的单一异常或超自然杀手，如果安排所有杀戮都通过第三方/警察/司法等普通机制自然发生，或被间接用作平行构建来破案，效果也是一样的。）
> 2. 更糟糕的是，死亡在其他方面也是非随机的——它们倾向于发生在特定时间！
>
>    仅仅是死亡的时间安排就让月损失了 6 比特的匿名性。
> 3. 月的第三个错误是对 Lind L. Tailor 的公然挑衅做出了反应。
>
>    咬住诱饵让 L 将目标缩小到原来的 1⁄3 日本人口，获得了约 1.6 比特的信息增益。
> 4. 月的第四个错误是利用他警察父亲的凭证窃取了机密警察信息。
>
>    这个错误的比特损失最大。这个错误让他损失了 11 比特的匿名性；换句话说，这个错误的代价是他时间安排错误代价的两倍，几乎是谋杀 Tailor 的 8 倍！
> 5. 杀死 Ray Penbar 和 FBI 小组。
>
>    如果我们假设 Penbar 被分配了 10,000 个线索中的 200 个，那么谋杀他和他的未婚妻只让月掉了 6 比特，或者说略多于第四个错误的一半，与最初的时间安排错误相当。
> 6. 终局：在剧情的这一点上，L 诉诸直接措施，直接进入月的生活，进入大学，月无法在密切的面对面监视下完美地扮演无辜者的角色。
>
>    从那时起，月就完了，因为他现在正在与 L 和调查组玩一场致命的“杀人游戏”。他浪费了超过 25 比特的匿名性，然后 L 直觉到了剩下的部分，并一直怀疑他。
>
> 最后，我建议月应该如何最有效地利用死亡笔记并限制他的匿名性损失。在附录中，我讨论了使用死亡笔记作为通信设备可能的最大信息泄漏量。
>
> **(注：本文假设读者熟悉《[死亡笔记](!W)》的早期情节和 [夜神月](!W)**。如果你不熟悉 DN，请参阅我的 [《死亡笔记》结局](/death-note-ending "‘Death Note’s Ending’, Branwen 2008") 论文或查阅 [维基百科](!W "Death Note#Plot") 或 [阅读 DN 规则](https://deathnote.fandom.com/wiki/Rules_of_the_Death_Note "Rules of the Death Note")。)
</div>

我曾称《死亡笔记》的主角夜神月“傲慢”，并说他犯了大错。所以我应该解释他哪里做错了以及他如何能做得更好。

虽然月早在 FBI 小组抵达日本时就开始策划并承担严重风险，但他从根本上已经搞砸了。L 本不该离月那么近。死亡笔记杀人于无形，不留法医痕迹，且距离任意；《死亡笔记》几乎是一个思想实验——既然有了*完美*的谋杀武器，你怎么*还会*搞砸呢？

其他一些死亡笔记用户凸显了这个问题。[四叶集团](!W "List of Death Note characters#Yotsuba Group") 的用户执行正常的处决，但*也*杀死了一些著名的竞争对手。这些杀戮直接指向四叶集团，并最终导致用户的死亡。这个故事的寓意是，间接关系在将可能性从“所有人”缩小到“这 8 个人”时可能是致命的。

# 侦探故事作为优化问题

在月的情况下，L 从全世界 70 亿人口开始，需要将其缩小到 1 个人。这是一个搜索问题。事实上，它相当直接地映射到基本的[信息论](!W)。（另见 [模拟推断](/simulation-inference)，[3 枚手榴弹](/3-grenades "‘The Three Grenades and the Four Noble Truths’, Branwen 2008")，以及应用去匿名化的案例研究，[Tor DNM 相关逮捕，2011--2015](/dnm-arrest "‘DNM-related arrests, 2011–2015’, Gwern 2012")。）要从 70 亿个项目中唯一指定一个项目，你需要 33 比特的信息，因为 log~2~(7000000000) ≈ 32.7；打个比方，你的 32 位计算机只能寻址 *4* 亿个内存位置中的一个唯一位置，增加一位则容量翻倍至 >80 亿。33 比特的信息很多吗？

并不多。L 仅通过查看历史或犯罪统计数据就能获得一个比特，并注意到大规模杀人犯在惊人的程度上是*男性*^[事实上，在我那篇 [恐怖主义无效](/terrorism-is-not-effective#competent-murders) 中提到的每一个人都是男性，这对于完整的 [维基百科大规模杀人犯名单](!W "List of rampage killers") 似乎也是如此。]，从而排除了世界人口的一半，实际上让 L 从一开始只需要获取 32 比特就能打破月的匿名性。[^Misa] 如果死亡笔记用户足够理性和知识渊博，他们可以利用 [超理性](!W) 等概念进行非因果合作^[非因果性是 [决策理论](!W) 中一个奇怪的新概念，主要在 [侯世达](!W "Douglas Hofstadter") 的 ["超理性"文章](/doc/existential-risk/1985-hofstadter "Metamagical Themas: Sanity and Survival")，[Gary Drescher](!W "Gary Drescher") 的 _[Good and Real](/doc/statistics/decision/2006-drescher-goodandreal.pdf "‘<em>Good and Real: Demystifying Paradoxes from Physics to Ethics</em>’, Drescher 2006")_ 第 5--7 章，以及 [LessWrong.com](https://www.lesswrong.com/) 上讨论。] 以避免这种信息泄漏……通过安排将死亡笔记传递给女性^[我的第一个解决方案涉及变性手术，但这会让情况变得更糟，因为变性人非常罕见，以至于一个足够聪明能预料到这些超理性死亡笔记用户的 L 会立即获得巨大的线索：只需检查手术名单上的每个人。无论如何，大多数死亡笔记用户可能会更喜欢传递它的解决方案。] 来恢复 50:50 的性别比例——例如，如果每有一个获得死亡笔记的女性，就有 3 个男性拥有死亡笔记，那么所有用户都可以掷一个 1d3 骰子，如果是 1 就保留，如果是 2 或 3 就传给异性。

[^Misa]: 这种推理在 [弥海砂](!W) 的情况下是错误的，但海砂是一个荒谬的角色——一个哥特萝莉流行歌星，通过非凡的巧合爱上了夜神月，对他言听计从，甚至不惜牺牲 75% 的寿命或记忆；因此从维基百科上得知作者塑造她角色的动机是为了避免“无聊”的全男性演员阵容并成为“一个可爱的女性”，这并不奇怪。（《死亡笔记》也不能免俗于 [酷规则](https://tvtropes.org/pmwiki/pmwiki.php/Main/RuleOfCool) 或 [性感规则](https://tvtropes.org/pmwiki/pmwiki.php/Main/RuleOfSexy)！）

我们要首先指出，月总是会泄漏*一些*比特。他能保持完全隐藏的唯一方法是根本不使用死亡笔记。如果你以哪怕最细微的方式改变世界，那么你原则上已经泄漏了关于你自己的信息。万物在某种意义上都是相互联系的；你不能神奇地挥去火的存在，而不引发一连串后果导致 [每一个生物死亡](https://www.lesswrong.com/posts/LaM5aTcXvXzwQSC2Q/universal-fire)。例如，月处决罪犯的根本目的是*缩短他们的寿命*——这无法通过某种方式隐藏。你不能既缩短他们的生命又*不*缩短他们的生命。他至少会以这种方式向精算师和统计学家暴露自己。

更具历史意义的是，这对密码学家来说一直是一个挑战，比如在二战中：他们如何利用 Enigma 和其他通信而不暴露他们已经破解了它？他们的解决方案是误导：[不断安排看似合理的替代方案](https://en.wikipedia.org/wiki/Ultra_(cryptography)#Safeguarding_of_sources)，比如“恰好”发现德国潜艇的搜索飞机，或者向 [受控的已知德国特工](!W "Double-Cross System") 泄漏有未被发现的间谍存在的消息。（然而，关于温斯顿·丘吉尔为了不冒 Ultra 秘密泄露的风险而允许考文垂镇被轰炸的著名故事 [后来受到了质疑](!W "Coventry Blitz#Coventry and Ultra")。）这在一定程度上是因为德国人的过度自信，因为战争没有持续太久，部分原因是因为每个掩盖故事本身都是合理的，在战争的混乱中，没有人能够看到全貌并意识到有*太*多幸运的搜索飞机和太多不可发现的鼹鼠；然而最终，总有人会意识到，显然有些德国人确实得出结论 Enigma 一定被破解了（但为时已晚）。
我不清楚什么是月掩盖其正常杀戮的最佳误导——利用死亡笔记的控制功能编造一个反犯罪恐怖组织？

所以这里存在一个真正的挑战：一方试图从观察到的效果中推断出尽可能多的信息，另一方试图尽量减少前者能观察到的信息但又不完全停止行动。月如何在相互竞争的需求之间取得平衡？

# 错误

## 错误 1

然而，他可以试图减少泄漏并使他的 [匿名集](!W "Degree of anonymity") 尽可能大。例如，用心力衰竭杀死每个罪犯是一个显而易见的破绽。罪犯不会那么频繁地死于心脏病发作。（如果你把“心脏病发作”换成“红斑狼疮”，这一点会更戏剧化；众所周知，在现实生活中从来不是红斑狼疮。）心脏病发作是所有死亡的一个子集，通过限制自己，月让他的活动更容易被发现。1,000 人死于红斑狼疮是刺耳的红色警报；1,000 人死于心脏病发作是一件怪事；而 1,000 人分布在统计上可能的癌症和心脏病等死因中几乎是不可见的（但原则上仍然可以察觉）。

所以，月的根本错误是以与其目标无关的方式杀人。
通过心脏麻痹杀人不仅让他很早就暴露了，而且死亡表明他的暗杀方法精确得超自然。L 已经被提示基拉的存在。
无论虚假的理由是什么，这对他的对手来说都是一个重大胜利。

第一个错误，也是连环杀手的典型错误（例如 [BTK 杀手](!W "Dennis Rader") 的自吹自擂并不像他以为的那样匿名）：妄自尊大，渴望嘲弄、玩弄和控制受害者，并展示他们对普通民众的权力。
从文学角度来看，这种相似性显然不是偶然的，因为我们注定要将月解读为 [反社会](https://tvtropes.org/pmwiki/pmwiki.php/Main/TheSociopath) [英雄](https://tvtropes.org/pmwiki/pmwiki.php/Main/SociopathicHero) 原型（类似于 [索龙元帅](/thrawn "‘The Tragedy of Grand Admiral Thrawn’, Gwern 2019")）：他最终的垮台是他 [致命性格缺陷](!W "Hamartia")，即 [傲慢](!W) 的后果，特别是原始的虐待狂意义上的。
月*无法*不这样自我破坏。

（从执行月的威慑理论的角度来看，这也是非常有问题的：为了威慑罪犯和恶棍，没有必要存在一个全球知名的单一超自然杀手，如果安排所有杀戮都通过第三方/警察/司法自然完成，或被间接用于破案，效果是一样的。
可以说，威慑越被认为是分散的就越有效——因为单一杀手的寿命有限、知识有限、容易犯错，并且有个人偏好，这会减少威胁和与犯罪的联系，而如果所有的死亡都归因于异常高效的警察或侦探，这会被推断为各类警察能力的普遍提高，这种能力不会因为一个人感到无聊或被公共汽车撞到而瞬间消失。）

## 错误 2

更糟糕的是，死亡在其他方面也是非随机的——它们倾向于发生在特定时间！画成图表，日常模式一目了然。

L 能够将推测的学生或工人的活跃时间缩小到特定的经度范围，比如 180° 中的 125--150°；在这个范围内哪个国家最突出？日本。所以这把 70 亿人削减到了大约 1.28 亿；1.28 亿需要 27 比特（log~2~ (128000000) ≈ 26.93），所以仅仅是死亡的时间安排就让月损失了 6 比特的匿名性！

### 去匿名化

顺便说一句，有些人可能会怀疑人们能否从图表中推断出什么，认为《死亡笔记》只是在这部分一带而过。“怎么可能仅凭日本早晚的两条聚集线就推断出是住在日本的人？”但实际上，这样的图表精确得惊人。我在看《死亡笔记》之前的几年就学到了这一点，当时我在维基百科上非常活跃；我经常想知道两个编辑是否是同一个人，或者一个编辑大概住在哪里。如果他们的编辑或用户页面没有透露任何有用的信息，我会去“Kate 的 [编辑计数器](!W "Wikipedia:WikiProject edit counters")”，检查他们数百或数千次编辑的时间。通常，人们会看到约 4 小时没有任何编辑，然后是约 4 小时的中等到高活跃度，一个低谷，然后又逐渐上升持续 8 小时，再下降到那 4 小时的无活动期。这些时期非常清楚地对应于睡眠（几乎每个人都在凌晨 4 点睡觉）、早晨、午餐和工作时间、晚上，然后是夜里人们偶尔熬夜编辑^[这适用于许多其他活动，如 [Twitter帖子](https://archive.nytimes.com/bits.blogs.nytimes.com/2012/06/07/good-night-moon-good-night-little-bird/ "Twitter Knows When You Sleep, and More") 或 Google 搜索；例如博主 [muflax](https://webcitation.org/6EDvDSVzN "Google Web History (original http://blog.muflax.com/personal/google-web-history/)") 在他的 Google 搜索中按小时观察到了同样的清晰昼夜节律。]。当然会有噪音，来自人们熬夜特别晚，或者在工作日进行大量编辑，或者是偶尔旅行，但总体模式是清晰的——我从未发现有人实际上是守夜人而我的猜测偏离了整个半球的情况。（基于用户编辑模式的学术估计与基于 IP 编辑地理位置的预测吻合良好。^[参见 2011 年的论文，["维基百科编辑活动的昼夜模式：人口统计分析"](https://arxiv.org/abs/1109.1746)。]）

<div id="results">计算机安全研究提供了更多可怕的结果。
也许因为 [“万物皆相关”](/everything)，有惊人数量的方法可以打破某人的隐私并去匿名化他们（[背景](https://web.archive.org/web/20130425111434/http://33bits.org/2013/04/16/privacy-technologies-an-annotated-syllabus/ "Privacy technologies: An annotated syllabus")；这样做还有 [经济动机](https://www-users.cse.umn.edu/~odlyzko/doc/privacy.economics.pdf "‘Privacy, Economics, and Price Discrimination on the Internet’, Odlyzko 2003") 以便做广告和 [价格歧视](!W)）：

#. 计算机 [时钟时间](https://catalog.caida.org/details/paper/2005_fingerprinting/ "‘Remote physical device fingerprinting’, Kohno et al 2005") 的微小误差（甚至 [通过 Tor](https://murdoch.is/papers/usenix08clockskew.pdf)）
#. [Web 浏览历史](https://pdfs.semanticscholar.org/ae93/529e8b9b1770593fae83f86803c6a7b529ea.pdf "‘Feasibility and Real-World Implications of Web Browser History Detection’, Janc & Olejnik 2010")^[你可以通过 [JS](https://blog.jeremiahgrossman.com/2006/08/i-know-where-youve-been.html) 或 [CSS](https://blog.mozilla.org/security/2010/03/31/plugging-the-css-history-leak/) 窃取信息，并且分析历史以 [推断人口统计数据](http://www.mikeonads.com/2008/07/13/using-your-browser-url-history-estimate-gender/) 已经 [被授予专利](https://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PG01&p=1&u=%2Fnetahtml%2FPTO%2Fsrchnum.html&r=1&f=G&l=50&s1=%2220070073681%22.PGNR.&OS=DN/20070073681&RS=DN/20070073681)。] 或仅仅是 [版本和插件](https://coveryourtracks.eff.org/static/browser-uniqueness.pdf "‘How Unique Is Your Web Browser?’, Eckersley 2010")^[你可以在 [EFF](!W "Electronic Frontier Foundation") 的 [Panopticlick](https://coveryourtracks.eff.org/) 上实时尝试你自己的浏览器。]；这还是在随机的 [Firefox](https://web.archive.org/web/20100810201303/http://33bits.org/2010/06/01/yet-another-identity-stealing-bug-will-creeping-normalcy-be-the-result/ "Yet Another Identity Stealing Bug. Will Creeping Normalcy be the Result?") 或 [Google Docs](https://web.archive.org/web/20100226190432/http://33bits.org/2010/02/22/google-docs-leaks-identity/ "How Google Docs Leaks Your Identity") 或 [Facebook](https://web.archive.org/web/20101003031057/http://33bits.org/2010/09/28/instant-personalization-privacy-flaws "Facebook’s Instant Personalization: An Analysis of Fundamental Privacy Flaws") 漏洞没有泄漏你身份的时候
#. 基于页面加载速度的 [时序攻击](!W)^[Felten & Schneider 2000, ["Timing Attacks on Web Privacy"](/doc/cs/security/2000-felten.pdf)]（有多少次 [缓存未命中](!W)；时序攻击也可用于 [获知网站用户名或私人照片数量](https://crypto.stanford.edu/~dabo/pubs/papers/webtiming.pdf "‘Exposing private information by timing web applications’, Bortz et al 2007")）
#. 知道一个人在什么“群组”中可以 [唯一识别 42%](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.155.820&rep=rep1&type=pdf)^[另见研究人员的 [博客](https://web.archive.org/web/20130926165125/http://honeyblog.org/archives/51-A-Practical-Attack-to-De-Anonymize-Social-Network-Users.html)。] 的社交网站 [XING](!W) 用户，可能还有 Facebook 和其他 6 个网站
#. 类似地，通过 [Netflix](!W) [知道某人看过的几部电影](https://arxiv.org/abs/cs/0610105 "‘How To Break Anonymity of the Netflix Prize Dataset’, Arvind Narayanan & Shmatikov 2007")^[对这种去匿名化算法的报道通常将其与 [IMDb](!W) 评级联系起来，但作者很清楚——你可以从任何来源获得这些评级，除了它是公开和在线的之外，IMDb 没有什么特别之处。]，无论是流行还是冷门，如果包含在 [Netflix 奖](!W) 中，通常可以访问其个人资料的其余部分。（这比 [AOL 搜索数据丑闻](!W) 更具戏剧性，因为 AOL 搜索在查询中嵌入了大量个人信息，相较之下，Netflix 数据似乎极其贫乏——除了一个人看了什么晦涩的动画之外，没有什么*明显*的标识。）
#. 研究人员 [推广了他们的 Netflix 工作](/doc/cs/algorithm/2009-narayanan.pdf "‘De-anonymizing Social Networks’, Narayanan & Shmatikov 2009") 以寻找任意图之间的同构性^[这听起来像是应该是 [NP 完全](!W) 的，虽然 [图同构问题](!W) 已知在 NP 中，但它几乎是独一无二的，就像 [整数分解](!W) 一样——它可能容易也可能难，没有任何证明。在实践中，大型现实世界图往往 [易于解决](https://web.archive.org/web/20090331052423/http://33bits.org/2008/11/20/graph-isomorphism-deceptively-hard "Graph isomorphism: deceptively hard")。]（例如去除了 *任何和所有* 数据 *除了* 图结构的社交网络），[例如](https://web.archive.org/web/20110313170927/http://33bits.org/2011/03/09/link-prediction-by-de-anonymization-how-we-won-the-kaggle-social-network-challenge/ "Link Prediction by De-anonymization: How We Won the Kaggle Social Network Challenge") [Flickr](!W) 和 [Twitter](!W)，并举出许多 [公共数据集](https://web.archive.org/web/20090306144914/http://33bits.org/2008/11/12/57 "Lendingclub.com: A de-anonymization walkthrough") 可以被去匿名化的例子[^abstract]——例如你的 [亚马逊购买记录](https://web.archive.org/web/20110528175925/http://33bits.org/2011/05/24/you-might-also-like-privacy-risks-of-collaborative-filtering "‘You Might Also Like’: Privacy Risks of Collaborative Filtering [blog]") ([Calandrino 等人 2011](https://www.cs.utexas.edu/~shmat/shmat_oak11ymal.pdf "‘You Might Also Like’: Privacy Risks of Collaborative Filtering"); [博客](https://freedom-to-tinker.com/2011/05/24/you-might-also-privacy-risks-collaborative-filtering/)). 这些攻击仅仅针对在尝试匿名化数据后留下的数据；它们并不利用这样的观察：选择删除什么数据与留下什么一样有趣，即 [Julian Sanchez](!W "Julian Sanchez (writer)") 所谓的 ["删减者的困境"](https://www.juliansanchez.com/2009/12/08/the-redactors-dilemma/)。
#. 用户名几乎 [不值一谈](https://web.archive.org/web/20110221224022/http://33bits.org/2011/02/16/usernames-linkability-uber-profiles/ "The Linkability of Usernames: a Step Towards 'Uber-Profiles'")
#. 你的医院记录可以仅仅通过查看公共选民名册就被 [去匿名化](https://dataprivacylab.org/dataprivacy/projects/law/law1.html) ^[例如，97% 的马萨诸塞州剑桥选民可以通过出生日期和邮政编码识别，29% 可以通过出生日期和性别识别。] 那位研究人员后来继续 [进行](https://latanyasweeney.org/work/identifiability.html) 关于去识别化调查数据可识别性的实验 [[引文](https://latanyasweeney.org/cv.html#survey)]，药房数据 [[引文](https://dataprivacylab.org/projects/identifiability/pharma1.html)]，临床试验数据 [[引文](https://latanyasweeney.org/cv.html#clinicaltrial)]，犯罪数据 [特拉华州诉甘尼特出版公司案]，DNA [[引文](https://dataprivacylab.org/dataprivacy/projects/genetic/dna3.html), [引文](https://dataprivacylab.org/dataprivacy/projects/genetic/dna2.html), [引文](https://dataprivacylab.org/dataprivacy/projects/genetic/dna1.html)]，税务数据，公共卫生登记处 [[引文](https://latanyasweeney.org/cv.html#iterativeprofiler) (被法院查封), 等等]，网络日志，和部分社会安全号码 [[引文](https://dataprivacylab.org/dataprivacy/projects/ssnwatch/index.html)]。（呼。）
#. 你的 [打字](!W "Keystroke dynamics#References") 惊人地独特，打字的声音和手臂运动可以识别你或用于窥探输入和 [窃取密码](https://arxiv.org/abs/1512.05616 "‘Deep-Spying: Spying using Smartwatch and Deep Learning’, Beltramelli & Risi 2015")
#. 知道你的早晨通勤路线即使粗略到街区（或更低粒度）也能 [唯一识别](https://web.archive.org/web/20090517214657/http://33bits.org/2009/05/13/your-morning-commute-is-unique-on-the-anonymity-of-homework-location-pairs/ "Your Morning Commute is Unique: On the Anonymity of Home/Work Location Pairs") ([Golle & Partridge 2009](https://crypto.stanford.edu/~pgolle/papers/commute.pdf "On the Anonymity of Home/Work Location Pairs")) 你；知道你通勤的邮政编码/人口普查区可以唯一识别 5% 的人
#. 你的笔迹相当独特，当然——但你在测试中填涂气泡的方式也是如此[^bubbles]
#. 说到笔迹，你的写作风格也 [可能](https://www.nytimes.com/2011/07/24/opinion/sunday/24gray.html) [相当独特](https://spectrum.library.concordia.ca/id/eprint/36253/1/2010_Mining_Writeprints_from_Anonymous_E-mails.pdf "‘Mining writeprints from anonymous e-mails for forensic investigation’, Iqbal et al 2010") [也是](https://www.cs.princeton.edu/~arvindn/publications/author-identification-draft.pdf)
#. 不明显的背景电流嗡嗡声可能 [唯一确定录音的日期](https://www.bbc.co.uk/news/science-environment-20629671 "The hum that helps to fight crime")。不明显的声音也可以用来持久跟踪设备/人员，跨气隙窃取信息，并可用于监控房间存在/活动，甚至 [监控手指运动](https://arxiv.org/abs/1808.10250 "‘SonarSnoop: Active Acoustic Side-Channel Attacks’, Cheng et al 2018") 或敲击声 [以帮助破解密码短语](https://arxiv.org/abs/1903.11137 "‘Hearing your touch: A new acoustic side channel on smartphones’, Shumailov et al 2019") 或 [复制物理钥匙](/doc/technology/2020-ramesh.pdf "‘Listen to Your Key: Towards Acoustics–based Physical Key Inference’, Ramesh et al 2020")
#. 你可能听说过用于窃听的 [激光麦克风](!W)... 但通过 [薯片袋的视频录制](https://people.csail.mit.edu/mrub/VisualMic/ "‘The Visual Microphone: Passive Recovery of Sound from Video’, Davis et al 2014")，[糖纸](https://spectrum.ieee.org/your-candy-wrappers-are-listening "Your Candy Wrappers are Listening")，[悬挂的灯泡](https://eprint.iacr.org/2020/708.pdf "‘Lamphone: Real-Time Passive Sound Recoveryfrom Light Bulb Vibrations’, Nassi et al 2020")，或 [电源 LED](https://www.nassiben.com/glowworm-attack "‘Glowworm Attack: Optical TEMPEST Sound Recovery via a Device’s Power Indicator LED’, Nassi et al 2021") 进行窃听呢？([新闻稿](https://news.mit.edu/2014/algorithm-recovers-speech-from-vibrations-0804))，或 [手机陀螺仪](https://crypto.stanford.edu/gyrophone/files/gyromic.pdf "‘Gyrophone: Recognizing Speech From Gyroscope Signals’, Michalevsky et al 2014")？激光也擅长检测你的心跳，这——当然——是 [唯一识别的](https://www.technologyreview.com/2019/06/27/238884/the-pentagon-has-a-laser-that-can-identify-people-from-a-distanceby-their-heartbeat/ "The Pentagon has a laser that can identify people from a distance—by their heartbeat: The Jetson prototype can pick up on a unique cardiac signature from 200 meters away, even through clothes.") 并且 [硬盘也可以变成麦克风。](/doc/technology/2019-kwong.pdf "‘Hard Drive of Hearing: Disks that Eavesdrop with a Synthesized Microphone’, Kwong et al 2019") 很快甚至 [月的薯片](https://arxiv.org/abs/2001.04642 "‘Seein the World in a Bag of Chips’, Park et al 2020") 也不再安全了...
#. 转向和驾驶模式足够独特，以至于在某些情况下仅通过 1 次转弯就可以识别驾驶员：[Hallac 等人 2017](https://arxiv.org/abs/1708.04636 "Driver Identification Using Automobile Sensor Data from a Single Turn")。这些攻击也适用于智能手机的时区、气压、公共交通时间、IP 地址以及连接 WiFi 或蜂窝网络的模式 ([Mosenia 等人 2017](/doc/statistics/2017-mosenia.pdf "PinMe: Tracking a Smartphone User Around the World"))，或 [加速度计](/doc/technology/2019-kroger.pdf "‘Privacy Implications of Accelerometer Data: A Review of Possible Inferences’, Kröger et al 2019")
#. 智能手机可以通过像素噪声模式被识别，这是由于 [传感器噪声](https://scholar.google.com/scholar?as_sdt=0%2C21&q=identification+sensor+noise+anonymity+OR+forensics&btnG=) 如 CCD 传感器和镜头中的小瑕疵（Facebook 甚至 [为此申请了专利](https://patents.google.com/patent/US20150124107 "US20150124107A1: Associating cameras with users and objects in a social networking system")）
#. 智能手机使用模式，如应用程序偏好、应用程序切换率、通勤模式的一致性、整体地理流动性、较慢或较少的驾驶已与阿尔茨海默病 ([Kourtis 等人 2019](https://www.nature.com/articles/s41746-019-0084-2 "Digital biomarkers for Alzheimer’s disease: the mobile/wearable devices opportunity")) 和个性 ([Stachl 等人 2019](https://osf.io/preprints/psyarxiv/ks4vd/ "Behavioral Patterns in Smartphone Usage Predict Big Five Personality Traits")) 相关联。^[另见 ["从 Facebook 状态推断人类特征"](https://arxiv.org/abs/1805.08718), Cutler & Kulis 2018/[Matz 等人 2019](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0214369 "Predicting individual-level income from Facebook profiles") 或 ["社交媒体预测的个性特征和价值观可以帮助人们匹配理想的工作", Kern 等人 2019](https://www.pnas.org/doi/10.1073/pnas.1917942116 "‘Social media-predicted personality traits and values can help match people to their ideal jobs’, Kern et al 2019"), 或 ["从 Twitter 上关注的账户预测心理健康", Costelli 等人 2021](https://online.ucpress.edu/collabra/article/7/1/18731/115925/Predicting-Mental-Health-From-Followed-Accounts-on "‘Predicting Mental Health From Followed Accounts on Twitter’, Costello et al 2021"), 关于社交媒体或媒体消费的普通使用可能泄漏什么的例子 ([综述](https://onlinelibrary.wiley.com/doi/10.1111/spc3.12624 "‘Personality computing: New frontiers in personality assessment’, Phan & Rauthmann 2021")).]

    眼动追踪 [也很有趣](https://rd.springer.com/chapter/10.1007/978-3-030-42504-3_15 "‘What Does Your Gaze Reveal About You? On the Privacy Implications of Eye Tracking’, Kröger et al 2020").
#. 声音不仅与年龄/性别/种族相关，而且与... [整体面部外观](https://arxiv.org/abs/1905.09773 "‘Speech2Face: Learning the Face Behind a Voice’, Oh et al 2019") 相关？

（关于 [DNA 相关隐私破坏](https://www.nytimes.com/2013/01/18/health/search-of-dna-sequences-reveals-full-identities.html) 的唯一令人惊讶的事情是它们花了这么长时间才出现。）

总结：[差分隐私](!W) [几乎](http://radar.oreilly.com/2011/05/anonymize-data-limits.html) 是不可能的[^FAQ] 并且隐私已死[^Brin]。（另见 ["隐私的破碎承诺：应对匿名化的惊人失败"](https://www.uclalawreview.org/pdf/57-6-3.pdf "Ohm 2010").）
</div>

[^abstract]: 来自 [论文](https://www.cs.utexas.edu/~shmat/shmat_oak09.pdf) 摘要：

    > [我们] 开发了一种针对匿名社交网络图的新重识别算法。为了证明其在现实世界网络上的有效性，我们展示了在 Twitter（一个流行的微博服务）和 Flickr（一个在线照片共享网站）上都可以验证拥有账户的用户中，有三分之一可以在匿名 Twitter 图中以仅 12% 的错误率被重识别。我们的去匿名化算法纯粹基于网络拓扑，不需要创建大量的虚拟“sybil”节点，对噪声和所有现有的防御都是鲁棒的，并且即使目标网络与对手的辅助信息之间的重叠很小也能工作。
[^FAQ]: Arvind Narayanan 和 Vitaly Shmatikov [粗略总结](https://web.archive.org/web/20090331074813/https://www.cs.utexas.edu/~shmat/socialnetworks-faq.html) 了他们去匿名化的含义：

    > **那么，解决方案是什么？**
    >
    > 我们不认为存在针对社交网络中匿名问题的技术解决方案。具体来说，我们不认为任何图变换可以 (a) 满足稳健的隐私定义，(b) 抵御我们论文中描述的去匿名化攻击，并且 (c) 保持图在常见数据挖掘和广告目的中的效用。因此，我们提倡非技术解决方案。

    所以，去匿名化只是发生在 [紧闭的门后](https://web.archive.org/web/20130114231753/http://33bits.org/2012/12/17/new-developments-in-deanonymization/ "New Developments in Deanonymization")：

    > ...研究人员不再有去匿名化的动力。另一方面，如果恶意实体这样做，他们自然不会公开谈论，所以不会有公关后果。在没有公众强烈抗议的情况下，监管机构在调查匿名数据发布方面并不是很积极，所以这可能是一个微不足道的风险。有些人质疑去匿名化在现实中是否真的在发生。鉴于经济激励，我认为假设它没有发生有点愚蠢。当然，我也无法证明这一点，可能永远也无法证明。没有一家这样做的公司会公开谈论它，而且隐私伤害是如此间接，以至于将其与特定的数据发布联系起来几乎是不可能的。我只能提供轶事来解释我的立场：在这个行业的朋友曾多次联系我，希望我去匿名化他们获得的数据库，我也听不同行业的朋友随便提到，他们日常工作中将不同数据库结合在一起实际上就是去匿名化。

    一般来说，从识别/破坏隐私/反向匿名化的角度来看，‘有用’和‘无用’信息之间没有明确的区别 ([强调添加](https://web.archive.org/web/20110314105222/http://33bits.org/2009/10/14/de-anonymization-is-not-x-the-need-for-re-identification-science/ "De-anonymization is not X: The Need for Re-identification Science"))：

    > ‘准标识符’是一个概念，源于试图将某些属性（如邮政编码）视为有助于重识别，而将其他属性（如品味和行为）视为不有助于重识别。然而，过去几年重识别论文的主要教训是 *关于一个人的任何信息* 都可能被用来辅助重识别。
[^bubbles]: 见 ["Bubble Trouble: Off-Line De-Anonymization of Bubble Forms"](https://static.usenix.org/event/sec11/tech/full_papers/Calandrino.pdf), USENIX 2011S Security Symposium; 来自 ["New Research Result: Bubble Forms Not So Anonymous"](https://web.archive.org/web/20170702141754/https://freedom-to-tinker.com/2011/06/07/new-research-result-bubble-forms-not-so-anonymous/):

    > 如果气泡标记模式是完全随机的，分类器的表现不会好于随机猜测测试集的创建者，预期准确率为 1⁄92 ~ 1\%。我们的分类器达到了超过 51% 的准确率。分类器很少偏离太远：正确答案落在分类器前三个猜测中的概率为 75%（随机猜测为 3%），前十个猜测中的概率超过 92%（随机猜测为 11%）。
[^Brin]: 但是嘿，至少隐私的缺乏是双向的，公众可以 [监视](!W "Transparency (social)") 像政府这样的作恶者，正如 [David Brin](!W "David Brin") 的 _[透明社会](!W)_ 所论证的那样是最好的结果。

    但是等等，维基解密揭露了由于反恐战争导致美国政府保密的大规模扩张，甚至透明度的 [所谓朋友](https://www.washingtonpost.com/wp-dyn/content/article/2008/12/10/AR2008121003364.html)，奥巴马总统，[已经](https://www.nytimes.com/2009/03/17/us/politics/17signing.html) [主持](https://www.nytimes.com/2010/06/12/us/politics/12leak.html) [了](https://web.archive.org/web/20120826184911/http://www.salon.com/2007/11/01/whistleblowers "War on whistle-blowers intensifies") [乔治·W·布什总统保密计划的](https://web.archive.org/web/20110624070259/https://harpers.org/archive/2010/08/hbc-90007562 "Obama's War on Whistleblowers") [扩张](https://www.dailykos.com/stories/2011/03/01/951432/-War-on-Whistleblowers-Escalating) 并镇压各类 [吹哨人](!W)？噢。我想那太糟糕了。

## 错误 3

月的第三个错误是对 Lind L. Tailor 广播的 [金丝雀陷阱](!W) 挑衅做出反应，批评基拉，而月猛烈抨击，利用清晰可见的名字和脸杀死了 Lind L. Tailor。
现场直播是一次公然的尝试，旨在激起惊讶且毫无准备的月的反应——任何反应——仅仅这一点就足以成为完全忽略它的理由（即使月不可能合理地知道它是*如何*成为陷阱的）：永远不要在敌人准备好的地盘、条款和时间点上做敌人希望你做的事。
（月可以在未来的任何时候使用死亡笔记，这将几乎与在直播中这样做一样能够展示他的力量。）

在 1 个地区进行广播也是 L 的一次赌博和潜在错误；他没有真正的理由认为月在 [关东](!W "Kanto region")（或者如果他确实已经有先验/信息表明这一点，他应该将关东一分为二），并且应该安排将其广播给正好一半的日本人口，获得预期的最大 1 比特。
但这得到了回报；他将目标缩小到原来的 1⁄3 日本人口，获得了约 1.6 比特的信息增益。
（你可以通过考虑如果月不在关东会怎样来看出这不仅是一场赌博；因为他不会看到直播，他也就不会做出反应，L 能了解到的只是他的嫌疑人在另外 2⁄3 的人口中，仅获得约 0.3 比特的增益。）

但即使这不是一个 *巨大* 的错误。他在杀人时间表上损失了 6 比特，又因性情急躁杀害 Lind L. Tailor 损失了 1.6 比特，但由于关东的男性人口为 2150 万（总数 4300 万），他仍剩下约 24 比特的匿名性（log~2~ (21500000) ≈ 24.36）。这还不算太糟糕，而且正如 [Zmflavius](https://www.alternatehistory.com/forum/threads/victoria.10/ "How might the real world react to a real Kira (Death Note)") 所指出的，这个错误的损失被其他细节进一步减轻；具体来说，不像“是男性”或“是日本人”，关于在关东的信息是会 *衰减* 的，因为人们总是因为各种原因搬来搬去：

> ...很可能月最大的错误是通过黑进他父亲的电脑无意中暴露了他与警察等级制度的联系。虽然 Lind L. Taylor 的惨败只暴露了他的杀人机制并将他缩小到“关东地区的某人”（这虽然基于他掌握的信息是一个令人印象深刻的成就，但对于实际找到嫌疑人来说毫无意义），但只有几百人能够访问月父亲所拥有的信息。还有一个事实是，L *知道* 月可能是一个十几岁的人，这意味着非常有这种可能：在学年结束时，即使是他的那一击也会过期，因为学生们会前往日本各地的大学（当然，月去了 [东大](!W "University of Tokyo")，像他这样水平的学生不上这样的大学会很可疑，但也 L 當時无法知道这一点）。我的意思是，也许 L 曾希望基拉通过突然搬离关东地区来暴露自己，但在接下来的五月，他将无法监控青少年的异常活动，因为很大一部分人会出于正当理由搬家。

（人们仍然可以对任何特定的人“向后”进行推断，以验证他们在正确的时间段内是否在关东，但随着时间的推移，越来越不可能“向前”进行推断并只检查关东的人。）

这个错误也向我们表明，信息论给我们带来的重要东西，实际上不是 *比特*（我们可以使用 log~10~ 而不是 log~2~，并比较 ["dits"](!W "Ban (information)") 而不是 "bits"），而是在 *对数* 尺度上比较情节中的事件。如果我们仅仅看每一步排除了多少绝对数量的人，我们会得出结论，月的第一个错误是无比巨大的灾难，因为它让 L 排除了超过 60 亿人，大约是所有其他错误加起来能让 L 排出人数的 60 倍。错误是相对于彼此的，而不是绝对的。
## 错误 4

月的第四个错误是利用他警察父亲的凭证窃取了机密警察信息。
这是不必要的，因为仍有无数罪犯是他可以利用公开信息（脸+名字通常不难获得）处决的，如果出于某种原因他需要特定的罪犯，他要么可以将机密信息的使用限制在少数高优先级受害者身上——哪怕只是为了避免被怀疑黑客攻击和随后的安全升级导致他失去访问权限！——或者利用死亡笔记的强制力或基拉的公众支持，制造一种发布信息的方式，如“泄漏”或通过公开透明法案。

这个错误的比特损失最大。
但有趣的是，许多甚至大多数《死亡笔记》粉丝似乎并不认为这是他最大的错误，反而指向他杀死 Lind L. Tailor 或者可能是过分依赖魅上照。信息论的观点强烈反对这一点，并让我们量化这个错误有多大。

当他根据秘密警察信息采取行动时，他立即将自己的可能身份缩小到与警方有联系的几千人之一。让我们大方一点，说是 10,000 人。从 10,000 人中指定 1 人需要 14 比特（log~2~ (1,0000) ≈ 13.29）——相比之下，指定一个关东居民需要 24--25 比特。

这个错误让他损失了 11 比特的匿名性；换句话说，这个错误的代价是他时间安排错误代价的*两倍*，几乎是谋杀 Tailor 的 *8* 倍！

## 错误 5

相比之下，第五个错误，谋杀 Ray Penbar 的未婚妻并将 L 的怀疑集中在 Penbar 的指定目标上，是非常廉价的。如果我们假设 Penbar 被分配了 10,000 个线索中的 200 个，那么谋杀他和他的未婚妻只让月从 14 比特降到了 8 比特（log~2~ (200) ≈ 7.64），只损失了 6 比特，或者说略多于第四个错误的一半，与最初的时间安排错误相当。

## 终局

在剧情的这一点上，L 诉诸直接措施，直接进入月的生活，进入大学。从那时起，月就完了，因为他现在正在与 L 和调查组玩一场致命的 [杀人游戏](!W "Mafia (party game)")。
他浪费了超过 25 比特的匿名性，然后 L 直觉到了剩下的部分，并一直怀疑他。
（我们可以通过指出 L 可以分析死亡事件并推断出傲慢、解谜和高智商等心理特征来证明 L 跳过剩余的 8 比特是合理的，这与启发式搜索剩余的候选人相结合，可能导致他锁定月。）

从理论角度来看，游戏在那时已经结束了。
L 随后的挑战变成了在他自我施加的道德约束下，向 L 自己证明这一点。^[考虑到极高的全球利害关系，以及如果是谋杀则表明 L 对正在发生的事情极其重要的信息一无所知，一个更务实的 L 会在开始认真怀疑月时就简单地绑架并折磨或暗杀月。]

# 安全很难（还是去购物吧）

月 *应该* 做什么？这很容易回答，但很难实施。

人们可以试图制造 *虚假* 信息。[陶哲轩](!W) 演练了许多关于信息论和匿名性的上述观点，并 [进而松散地讨论](/doc/cs/security/2012-terencetao-anonymity.html "Original: plus.google.com/114134834346472219368/posts/8vmpA9fgRMq") 了 [伪造信息](!W "Disinformation") 的可能好处：

> ...获得更多匿名性的一种额外方式是通过故意的 *虚假信息*。例如，假设一个人透露了关于自己的 100 个独立信息比特。通常，这将花费 100 比特的匿名性（假设每个比特 _先验_ 为真或假的概率相等），将可能性数量减少 2^100^ 倍；但如果这 100 个比特中有 5 个（随机选择且未提前透露）是故意伪造的，那么可能性数量又增加了 (100 `选` 5) ~ 2^26^ 倍，恢复了约 26 比特的匿名性。实际上，人们获得的匿名性比这更多，因为要消除虚假信息，需要解决一个 [可满足性](!W) 问题，这在计算上通常是难以处理的，尽管这种额外的保护可能会随着时间的推移随着算法的改进而消散（例如通过结合 [压缩感知](!W) 中的想法）。

## 随机化

建议月应该——或 *能够*——在死亡时间上使用虚假信息的困难在于，实际上，我们正在从事一种 [后见得明偏误](!W)。

月或任何人究竟如何知道 L 可以从他的杀戮中推断出他的时区？我提到了一个使用维基百科编辑来定位编辑者的例子，但那种技术在 WP 编辑者中是我独有的^[我后来看到过试图将活动时间与暗网市场和其他地方的位置关联起来的例子，例如试图推断恐怖海盗罗伯茨（美国）和中本聪（？）的时区。] 无疑还有许多我从未听说过的信息泄漏形式，尽管我编制了一份清单；即使我是月，即使我记得我的维基百科技术，我可能也不会费心在时钟上均匀分布我的杀戮或采用欺骗性模式（例如暗示我在欧洲而不是日本）。

如果月知道他在泄漏时间信息但不知道外面有人聪明到可以使用它（一种“已知的未知”），那么我们可能会责怪他；但月怎么应该知道这些“未知的未知”呢？

[随机化](!W) 是答案。随机化和加密打乱了输入和输出之间的相关性，它们在《死亡笔记》中会像在现实世界的密码学和统计学中一样有效，代价是一些效率。随机化的重点，无论是在密码学还是在统计实验中，不仅是为了防止你知道泄漏的信息或 [混淆因素](!W)（分别），而且也是为了防止你 *尚未* 知道的那些。

窃取并改写 [Jim Manzi](!W "Jim Manzi (software entrepreneur)") 的 [_Uncontrolled_](https://www.amazon.com/Uncontrolled-Surprising-Trial---Error-Business/dp/046502324X/) 中的一个例子：你正在进行一项减肥实验。你知道效果可能随每个受试者已有的体重而变化，但你不相信随机化（你是个务实的人！只有神经质的统计学家才担心随机化！）；所以你按体重划分受试者，为了方便，你按他们出现在你实验的时间分配他们——最后，正好有 10 个超过 150 磅的实验对象和 10 个超过 150 磅的对照组，依此类推。不幸的是，结果表明，在你不知情的情况下，一种遗传变异控制着体重增加，而且整个大家族很早就出现在你的实验中，他们都被分配到了“实验组”，没有一个分配到“对照组”（因为你不需要随机化，对吧？你正在确保各组在体重上匹配！）。你的实验现在是虚假和误导性的。当然，你可以进行第二个实验，确保实验组和对照组在体重上匹配，现在也在那个遗传变异上匹配……但现在有可能某种 *第三* 混淆因素打击你。如果你使用了随机化——那么你可能也会将一些变异放入另一组，你的结果就不会是虚假的！

所以要处理月的第一个错误，仅仅在每个整点安排死亡是行不通的，因为睡眠-觉醒周期仍然存在。如果他建立一个列表并为每个小时写下 _n_ 个罪犯以消除高峰-低谷而不是随机化，那还会出错吗？也许：我们不知道数据中可能留下什么信息，L 或图灵可能会破译这些信息。我可以推测一种可能性——将每种类型的罪犯分配到每个小时。如果一个人起草名单并按顺序进行（嘿，不需要随机化，对吧？），那么顺序可能是“晨报上的罪犯，电视上的罪犯，细节未立即给出但可在网上查到的罪犯，几年前的罪犯，历史罪犯等”；如果晨报罪犯从日本时间早上 6 点开始……而且均匀分配可能很难，因为当那一天没有很多罪犯或者报纸不出版（假期？）等情况时，自然会出现短缺，所以短缺期将查明基拉认为的“一天的结束”是什么。

一个更安全的程序是对时间、对象和死亡方式进行彻底的随机化。即使我们假设月下定决心要揭示基拉的存在并获得宣传和国际恶名（这本身就是一个主要性格缺陷；做事，邀功——二选一），他仍然不必将他的匿名性降低到 32 比特以下。

#. 每次处决的时间可以由随机掷骰子决定（例如，小时用 24 面骰子，分钟用 60 面骰子）。
#. 选择死亡方式可以类似地基于容易研究的人口统计数据来完成，尽管这可能无关紧要（主要用于掩盖杀戮已经发生的事实）。
#. 选择罪犯可以基于通过国际可访问的期刊，这些期刊似乎每个人都可以访问，例如《纽约时报》，死亡可以延迟数月或数年，以扩大基拉从哪里得知受害者的可能性（电视？书？互联网？），并避免诸如杀死仅在一个晦涩的日本公共电视频道上宣传的罪犯这类问题。等等。

让我们记住，所有这些都基于匿名性，以及月使用低技术策略；正如一个人问我的那样，“为什么月不建立一个加密的 [暗杀市场](!W) 或直接接管世界？没有这些小聪明他也能赢。”好吧，那这就不是《死亡笔记》了。

# 另请参阅

- ["谁写了《死亡笔记》剧本？"](/death-note-script){.backlink-not} (作者身份的统计分析)

# 外部链接

- **讨论**:

    - [LessWrong](https://www.lesswrong.com/posts/zumnfc7jctgocfoe9/death-note-anonymity-and-information-theory)
    - *Hacker News*: [1](https://news.ycombinator.com/item?id=3634320), [2](https://news.ycombinator.com/item?id=9553494), [3](https://news.ycombinator.com/item?id=20617325), [4](https://news.ycombinator.com/item?id=26826585), [5](https://news.ycombinator.com/item?id=46839743)
    - *Reddit*: [1](https://www.reddit.com/r/rational/comments/6vnj2g/is_death_note_a_rationalist_fic/), [2](https://www.reddit.com/r/anime/comments/cmiijr/using_computer_security_cryptography_and/)
    - [Gigazine](https://gigazine.net/news/20190812-death-note-anonymity-entropy/) (日文)
- 翻译: [俄语](https://habr.com/ru/articles/516190/) (RU)
- ["论谋杀被视为一种美术"](!W "On Murder Considered as one of the Fine Arts"), [托马斯·德·昆西](!W)
- ["监视：FBI 如何追踪并抓获一名芝加哥匿名者；持续监视，线人，诱捕和追踪设备——FBI 不遗余力..."](https://arstechnica.com/tech-policy/2012/03/stakeout-how-the-fbi-tracked-and-busted-a-chicago-anon/) (去匿名化 [Jeremy Hammond](!W))
- ["当匿名并非真正匿名时"](https://brooksreview.net/2014/01/i-see-you/)
- ["为什么我不是一个熵主义者"](/doc/cs/security/2009-syverson.pdf), Syverson 2013
- ["有毒配对，重识别和信息论：国籍与宗教"](https://www.johndcook.com/blog/2017/09/30/toxic-pairs/)
- ["我如何使用 Facebook 广告针对 Reddit CEO 以获得 Reddit 的面试机会"](https://web.archive.org/web/20200215144602/https://twicsy-blog.tumblr.com/post/174063770074/how-i-targeted-the-reddit-ceo-with-facebook-ads-to) ([HN](https://news.ycombinator.com/item?id=17110385))
- ["‘破碎’：拯救数字时代美国卧底间谍的秘密战斗内幕"](https://www.yahoo.com/news/shattered-inside-the-secret-battle-to-save-americas-undercover-spies-in-the-digital-age-100029026.html)
- ["收益公告的信号质量：来自知情交易卡泰尔的证据"](/doc/economics/2020-xie.pdf), Xie 2020

# 附录

## 用死亡笔记交流

有人可能会想，一个人可以用死亡笔记 *有意* 发送多少信息，而不是无意中泄漏关于自己身份的比特。由于死亡大体上是公众已知的信息，我们将假设发送者和接收者有某种预先安排的密钥或一次性密码本（尽管人们会想知道为什么他们会使用这种不道德和笨拙的系统而不是隐写术或在线消息）。

死亡笔记造成的死亡有 3 个主要特征，人们可以控制——谁，何时，以及如何：

#. **人**

    ‘谁？’已经为我们计算过了：如果指定一个唯一个人需要 33 比特，那么一个特定的人可以传达 33 比特。关于可学习性的担忧（你怎么知道一个亚马逊部落成员的死亡？）意味着它实际上 <33 比特。

    如果你尝试某种方案将更多比特编码到暗杀选择中，你要么最终得到 33 比特，要么最终无法传达某些比特组合，实际上还是 33 比特——你的方案会告诉你，为了传达你那绝望重要的关于 L 真实身份以及你如何发现它的 50 比特信息 _X_，你需要杀死一个体重超过 200 磅且来自台湾的坦桑尼亚的 Olafur Jacobs，但唉！Jacobs 不存在供你杀死。
#. **时间**

    ‘何时’通过类似的推理处理。死亡笔记杀人有一定的粒度：即使 *它* 能够将死亡时间精确到纳秒，人们也无法实际目睹这一点或收到这方面的记录。医生可能会记录死亡时间精确到分钟，但不会更精细（而且你反正怎么获得如此精确的医疗记录？）。新闻报道可能更不准确，仅仅指出它发生在早上或深夜。在像现场直播这样的极少数情况下，人们可能能够做得稍微好一点，但即使它们也倾向于延迟几秒或几分钟，以便缓冲，修复技术故障，速记员制作隐藏字幕，或者只是为了防止尴尬事件（如珍妮·杰克逊的露乳事件）。所以我们假设时间不能比分钟更准确。但是死亡笔记用户有什么分钟可供选择呢？鉴于死亡笔记显然无法影响过去或导致普拉切特式[^Mort]的超光速效应，过去是禁区；但消息也必须在它们应该影响的事情发生之前发送，所以人们不能有一个世纪的时间窗口。如果消息需要在一天内产生影响，那么用户只有 60 · 24 = 1,440 分钟的时间窗口，即 log~2~(1,440) = 10.49 比特；如果用户有一年的窗口，那稍微好一点，因为精确到分钟的死亡时间可能包含多达 log~2~(60 · 24 · 365) = 19 比特。（十年则是 22.3 比特，等等。）如果我们允许时间精确到秒，那么一年将是 24.9 比特。无论如何，很明显我们不会从日期中获得超过 33 比特。从好的方面来说，‘死网协议’（IP over Death）将优于 [某些其他协议](!W "IP over Avian Carriers")——在这里，你的延迟越差，你可以从数据包的时间戳中提取的比特就越多！_[恐龙漫画](!W)_ 关于 [压缩方案](https://qwantz.com/index.php?comic=354 "T-Rex As: 'The Computer Scientist'"):

    !["是的，但聪明不仅仅是知道压缩方案！" "不，就是！" "该死——他知道秘密！！" --Ryan North](/doc/cs/algorithm/information/compression/2004-ryannorth-dinosaurcomics-391.png "https://qwantz.com/index.php?comic=354"){.invert}
#. **环境**（如地点）

    ‘如何’... 有更多的自由度。环境要难计算得多。我们可以用很多方式细分它；这是一个：

    #. [地点]{.smallcaps}（例如纬度/经度）

        地球有 ~510,072,000,000 平方米的表面积；从我们的角度来看，其中大部分是完全无用的——如果有人在飞机上死亡，人们究竟如何弄清楚他在哪一平方米之上？或者在海洋上？地球有 ~148,940,000,000 平方米的 *陆地*，这更有用：通常的计算给我们 log~2~(148940000000) = 37.12 比特。（惊讶于这与‘谁？’比特计算如此相似？但 37.12 - 33 = 4.12 且 2^4.12^ = 17.4。科幻经典 _[桑给巴尔](!W)_ 的名字来源于这样一个观察：2010 年活着的 70 亿人只有肩并肩站着才能塞进桑给巴尔——把他们散开，并将该面积乘以 ~18...）这提出了一个影响所有 3 个特征的问题：死亡笔记能控制多少？它能把受害者移到任意点吗，比如说，西伯利亚？或者它仅限于驾驶距离内？等等。这些问题中的任何一个都可能使 37 比特缩水很多。
    #. [死因]{.smallcaps}

        [国际疾病分类](https://www.who.int/classifications/classification-of-diseases) 列出了超过 20,000 种疾病，我们可以想象数千种可能的意外或故意死亡。但重要的是传达了什么：如果有 500 种不同的脑癌，但死亡仅被报告为‘脑癌’，那么这 500 种对我们的目的来说只算作 1 种。但我们会大方一点，按 20,000 种报告的疾病加事故计算，即 log~2~(20000) = 14.3 比特。
    #. [死前行为]{.smallcaps}

        死前行为与意外原因重叠；该系列在这里没有帮助我们。月早期的实验最终导致了“L，你知道死神爱吃苹果吗？”，似乎暗示行为受熵限制，因为每个词花费一次死亡（假设普通英语词汇量为 50,000 个词，16 比特），但其他情节事件暗示人类可以在死亡笔记的命令下进行漫长的复杂计划（如魅上照将假死亡笔记带到与尼亚的最后对抗中）。死前行为可以被非常详细地报告，或者它们可能被隐藏在官方保密之下，就像前面提到的死神一样（月独特地有幸知道它成功了，作为 L 测试他的一部分）。我无法开始猜测有多少独特的叙述会在传输中幸存下来，或者笔记会设定什么限制。我们必须让这一个未定义：它几乎肯定超过 10 比特，但具体是多少？

[^Mort]: [特里·普拉切特](!W), _[Mort](!W)_:

    > 根据哲学家 Ly Tin Weedle 的说法，唯一已知比普通光更快的东西是君主制。他的推理是这样的：你不能有一个以上的国王，传统要求国王之间没有空隙，所以通过这种方式当国王死时，继承权必须因此 *瞬间* 传递给继承人。他说，据推测，必定有一些基本粒子——kingons，或者可能是 queons——做这项工作，但当然继承有时会失败，如果在飞行途中，它们撞上了反粒子，或 republicon。他雄心勃勃的计划是利用他的发现发送信息，包括仔细折磨一个小国王以调制信号，但从未完全展开，因为在那一点上，酒吧关门了。

总计，我们得到 \<33 + \<19 + 17 + \<37 + 14 + ? = 120\? 比特每次死亡。

## "贝叶斯法理学"

[E.T. Jaynes](!W) 在他死后出版的 [_概率论：科学的逻辑_](https://omega0.xyz/omega8008/JaynesBookPdf.html)（关于 [贝叶斯统计](!W)）包括第 5 章 ["概率论的奇怪用途"](https://omega0.xyz/omega8008/ETJ-PS/cc5d.ps)，讨论了诸如 ESP；奇迹；启发式和 [偏误](!W "Cognitive bias")；视觉感知如何充满理论；关于牛顿力学和著名的 [海王星发现](!W) 的科学哲学；赛马和天气预报；也就是——第 5.8 节，"贝叶斯法理学"。Jaynes 的分析在精神上与我上面的分析有些相似，尽管我的分析不是明确的贝叶斯式的，除了可能在关于性别消除一个必要比特的讨论中。

以下是摘录；另见 ["贝叶斯正义"](https://www.lesswrong.com/posts/xx7TeDmBQDFnx8GY7/bayesian-justice).

> 将概率论应用于我们不能总是很好地将其简化为数字的各种情况是有趣的，但它仍然自动显示什么样的信息将有助于我们进行合理的推理。假设有人在纽约市犯了谋杀罪，起初你不知道是谁，但你知道纽约市有 1000 万人。在没有其他知识的基础上，_e_(有罪|X) = −70 _db_ 是任何特定人有罪的可信度。
>
> 在我们决定应该关押某人之前，需要多少有罪的正面证据？也许 +40 _db_，尽管你的反应可能是这还不够安全，数字应该更高。如果我们提高这个数字，我们给予无辜者更多的保护，但代价是使定罪变得更加困难；在某一点上，整个社会的利益不容忽视。
>
> 例如，如果释放了 1,000 名有罪的人，我们从太多的经验中知道，他们中的 200 或 300 人将立即着手对社会造成更多的犯罪，并且他们逃脱正义将鼓励另外 100 人犯罪。因此很明显，允许 1,000 名有罪的人逍遥法外对整个社会造成的损害，远远大于错误地定罪一名无辜者所造成的损害。
>
> 如果你对这个陈述有情绪反应，我请你思考：如果你是一名法官，你宁愿面对一个你错误定罪的人；还是 100 名你本可以预防的犯罪的受害者？将阈值设定在 +40 _db_ 意味着，粗略地说，平均每 10,000 次定罪中只有不超过一次是错误的；一个要求陪审团遵守这一规则的法官在其职业生涯中可能不会做出一次错误定罪。
>
> 无论如何，如果我们从 −70 db 开始取 +40 db，这意味着为了确保持有罪判决，你必须提供大约 110 db 的证据证明这个特定人的罪行。假设现在我们得知这个人有动机。这对他有罪的可信度有什么影响？概率论说
>
> $$e(\text{有罪}|\text{动机}) = e(\text{有罪}|X) + 10 log_{10} \frac{P(\text{动机}|\text{有罪})}{P(\text{动机}|\text{无罪})}$$ (5-38)
>
> $$\simeq -70 - 10log_{10} P(\text{动机}|\text{无罪})$$
>
> 因为 $P(\text{动机}|\text{有罪}) \simeq 1$，即我们要认为犯罪完全没有动机是不太可能的。因此，得知此人有动机的 [重要性] 几乎完全取决于一个无辜者也会有动机的概率 $P(\text{动机}|\text{无罪})$。
>
> 如果我们思考片刻，这显然符合我们的常识。如果死者善良且受所有人爱戴，几乎没有人有动机杀他。得知尽管如此，我们的嫌疑人*确实*有动机，那么这将是非常 [重要] 的信息。如果受害者是一个令人讨厌的角色，以各种恶行取乐，那么很多人都会有动机，得知我们的嫌疑人是其中之一并不那么 [重要]。这一点的意义在于，除非我们也知道关于死者性格的一些事情，否则我们不知道该如何看待我们的嫌疑人有动机这一信息。但是，如果不向他们指出，有多少陪审团成员会意识到这一点呢？
>
> 假设一位非常开明的法官，拥有现行法律未赋予法官的权力，察觉到了这一事实，并且当关于动机的证词被引入时，他指示他的助手为陪审团确定纽约市有动机的人的 *数量*。如果这个数字是 $N_m$，那么
>
> $$P(\text{动机}|\text{无罪}) = \frac{N_m - 1}{(\text{纽约人数}) - 1} \simeq 10^{-7} (N_m - 1)$$
>
> 并且方程 (5-38) 减少为，出于所有实际目的，
>
> $$e(\text{有罪}|\text{动机}) \simeq −10 \log(N_m - 1)$$ (5-39)
>
> 你看，纽约的人口已经从方程中抵消了；一旦我们知道有动机的人的数量，那么城市有多大就不再重要了。注意 (5-39) 即使当 $N_m$ 只有 1 或 2 时也继续说着正确的事情。
>
> 你可以这样继续很长时间，我们认为你会发现这样做既有启发性又有趣。例如，我们现在得知嫌疑人不久前在犯罪现场附近被看到。根据贝叶斯定理，这一点的 [重要性] 几乎完全取决于附近还有多少无辜的人。如果你曾被告知不要相信贝叶斯定理，你应该再多关注几个这样的例子，看看它是如何准确地告诉你什么信息是相关的，什么是不相关的，在合理的推理中。^["注意，在这些情况下，我们试图从不完整的信息片段中决定一个亚里士多德命题的真实性；即被告是否实施了某个定义明确的行为。这就是概率论作为逻辑所设计的情况——事实问题。但还有其他法律情况截然不同；例如，在医疗事故诉讼中，可能各方都同意被告实际做了什么的事实；问题在于他是否行使了合理的判断。由于没有官方的、精确的‘合理判断’定义，这就不是一个亚里士多德命题的真实性问题（然而，如果已确定他故意违反了我们要理性章节 1 中的某个愿望，我们认为大多数陪审团会定他的罪）。有人声称概率论基本上不适用于这种情况，我们关心的是一个非亚里士多德命题的部分真实性。然而，我们建议，在这些情况下，我们要关心的根本不是真理问题；相反，需要的是价值判断。我们将稍后回到这个主题（第 13、18 章）。"]
>
> 近年来，关于贝叶斯法理学的文献大量增加；有关包含许多参考文献的评论，请参见 Vignaux & Robertson 1996 [这显然是 [_解释证据：评估法庭上的法医科学_](https://www.amazon.com/Interpreting-Evidence-Evaluating-Forensic-Courtroom/dp/0471960268/) --编者注]。
>
> 即使在我们将完全无法说应该使用数值的情况下，贝叶斯定理仍然定性地再现了你的常识（也许经过一些深思熟虑后）告诉你的东西。这就是 [George Pólya](!W) 详尽地展示的事实，以至于现在的作者确信这种联系不仅仅是定性的。
