---
title: 间隔重复：高效学习与记忆
description: "利用间隔效应实现高效记忆：回顾其广泛适用性、使用技巧，以及它擅长解决什么问题。"
thumbnail: https://gwern.net/doc/psychology/spaced-repetition/2013-memotrainerrr.png
thumbnail-text: "概念图对比集中复习与间隔重复对记忆概率的影响：集中复习在短期内更强，但记忆会稳定衰减；而间隔重复会定期将其拉回并逐渐锁定。"
thumbnail-css: "outline"
created: 2009-03-11
modified: 2019-05-17
status: finished
confidence: highly likely
importance: 9
css-extension: dropcaps-kanzlei
...

<div class="abstract">
> 间隔重复（spaced repetition）是一种有数百年历史的心理学技巧，用于高效记忆与技能练习：它不依赖“临时抱佛脚/突击背诵”，而是把每次复习分散开，并随着掌握程度的提高逐步延长间隔，通常由软件来安排复习日程。
>
> 因为这种“慢但稳”的方法效率更高，间隔重复可以扩展到记忆几十万条信息（而突击记住的内容几乎会立刻遗忘），对外语学习与医学生尤其有用。（如果信息量仍然大到不可能全部记住，可参阅我提出的[“反间隔重复”](/anti-spaced-repetition "‘Anti-Spaced Repetition for Serendipity’, Gwern 2014")方案。）
>
> 本文回顾：这种技术适合解决什么问题；关于它与“测验效应”（testing effect）的研究文献（主要截至 ~2013）；现有软件与使用模式；以及一些杂想与观察。
</div>

计算领域最富成果的方向之一，是弥补人类的脆弱。它们能把算术做得完美，因为我们做不到^[<span id="foref1">“人们并不是靠手摇计算器来学习计算机，但人们会忘掉算术。”</span>——[Perlis 1982](#perlis-1982)]。它们能记住 TB 级数据，因为我们会忘。它们是最好的日历，因为它们永远会去检查“今天有什么事要做”。
即便我们不记得细节，只要记得一个“出处/参考”也几乎同样有用——这就像把一本手册或教材从头读到尾的意义：并不是为了将来能背出书里的一切，而是为了将来记得 *有这么个东西*（而在浏览时，你还会学到合适的关键词，等真的需要深入某个主题时就知道该搜什么）。

我们已经在使用许多这样的[神经假肢](!W)[^my-neuroprosthetics]，但总还有更多可以被发现。它们值得投入，因为价值极高：铲子当然比徒手高效得多，但[电铲](!W)又比两者高出好几个数量级——即使它需要训练与技巧才能驾驭。

[^my-neuroprosthetics]: 要把其他神经假肢都列出来并不容易。这个想法很有趣，但正如[外在论](!W)的支持者（如 [Andy Clark](!W)）所发现的：你很容易“感觉外在论很有意义”，但要给出一个清晰定义，把“神经假肢/心智的一部分”和“你恰好喜欢或觉得有用的随机工具”区分开来就很难。比如，纸笔算不算神经假肢？对于一个刚学写字的孩子来说显然不是——他必须在脑中谨慎组织词句，再一笔一画写下来；但对一个写了一辈子字的成年人来说就不那么清楚了：他可以不经思考地涂鸦或记下念头，甚至会惊讶于自己“居然写出了那样的话”。

    我喜欢这样一个定义：“神经假肢是任何一种工具——它的结果会被你在无需进一步思考的情况下直接使用”。因此在经典例子里，当 Otto 要去某个地方时，他不会想“我是个把地点记在笔记本里的失忆者，我现在必须去查地点”——他只会直接查。一个不错的经验法则是：凡是被摧毁后会让人感到迷失、迟钝、愚笨或无知的东西，大概都算。

    按这个标准，我能想到的、真正会在不加思索的情况下使用其结果的工具其实并不多：

    - 各种快捷键，比如窗口管理器的快捷键，尤其是 Google 搜索快捷键；有时 [XMonad](!W "XMonad") 的 Prompt 会莫名其妙地卡死并锁住输入。遇到这种情况我 *必须* 重启 X，因为我几乎什么都要 Google，而这个快捷键已经 *深到骨子里*，不用它会让我难以忍受——就像试图用非惯用手写字一样。
    - [Google Calendar](!W) 与 [PredictionBook](/prediction-market#predictionbook-nights "‘Prediction Markets § 1001 PredictionBook Nights’, Gwern 2009")：我能把多少跟进事项、提醒、周期性任务扔进 GC 或 PB 里，这简直不可思议。我把许多习惯与念头外包给它们，久而久之甚至不觉得这有什么特别；但只要其中一个消失，我就会感到恐惧——有哪些事件正在发生、哪些信念已被证伪、哪些机会正在打开（或关闭！）而我突然一无所知？
    - [Evernote](!W) 也是类似原因：我的许多“记忆”不再是“章鱼看得太快所以只有 HDTV 或 [UHDTV](!W) 适合它们；我在 _Orion Magazine_ 里读到的”这样的完整句子，而变成了“章鱼 电视 Evernote”这种索引；如果我想知道章鱼与电视到底有什么关系，那么我就得去 Evernote 里查。Mnemosyne 对我也起着类似作用，但在那里面，很多记忆因为间隔重复而更“自带清晰度”。
    - 我的网站 Gwern.net；我经常不得不说“我不知道我对某件事到底怎么想”，但无论我怎么想，它都在我网站上。（这是 Evernote/Mnemosyne 神经假肢更极端的形态。）有位评论者曾写道，读 Gwern.net 像是在我脑子里爬来爬去；他比自己意识到的更接近事实。

# 间隔效应 {#spacing-effect}

<div class="epigraph poem">
> 排练能带来很多收获， \
> 只要它分散得恰到好处。 \
> 若要一口气全做完， \
> 你可真是个傻瓜， \
> 记忆只会更糟糕。
>
> Ulrich Neisser^[引自 ["Retrieval practice and the maintenance of knowledge"](https://gwern.net/doc/psychology/spaced-repetition/1988-bjork.pdf)，Bjork 1988]
</div>

我目前最喜欢的假肢，是一类利用[间隔效应](!W)的软件。间隔效应是认知心理学里一个古老的观察：它能让学习与记忆取得远胜传统学生技巧的效果；遗憾的是，它仍然相当冷门[^efficiency]。

[^efficiency]: 引自 ["Close the Book. Recall. Write It Down: That old study method still works, researchers say. So why don't professors preach it?"](https://web.archive.org/web/20090430093950/http://chronicle.com/free/v55/i34/34a00101.htm)；_[The Chronicle of Higher Education](!W)_

    > 两本心理学期刊最近发表的论文表明，这种策略确实有效——这是一个持续数十年的研究传统中的最新发现。当学生自学时，“主动回忆”（比如复述、抽认卡，以及各种自测）是把知识刻进长期记忆里最有效的方法。然而，许多大学教师对这些研究也只是略知一二……

    引自 ["The Spacing Effect: A Case Study in the Failure to Apply the Results of Psychological Research"](https://andrewvs.blogs.com/usu/files/the_spacing_effect.pdf)（Dempster 1988），光看标题就足以概括现状（另见 Kelley 2007，[_Making Minds: What's Wrong with Education - and What Should We Do About It?_](https://www.amazon.com/Making-Minds-Whats-Education-Should/dp/0415414113/)）：

     > 第二，间隔效应异常稳健。在许多情形中，两次“有间隔”的呈现，大约相当于两次“集中”的呈现效果的两倍（如 Hintzman 1974；[Melton 1970](https://gwern.net/doc/psychology/spaced-repetition/1970-melton.pdf "The Situation with Respect to the Spacing of Repetitions and Memory")），并且两者差距会随着重复次数的增加而进一步拉大（Underwood 1970）……
     >
     > 间隔效应早在 1885 年就已为人所知，当时 Ebbinghaus 发表了他关于记忆的奠基性研究结果。以自己为被试，Ebbinghaus 发现：对于一个 12 音节的序列，如果立刻连续重复 68 次，可以在第二天再追加 7 次后做到无误背诵；但同样的效果，只需要把 38 次重复分散到 3 天里就能达到。基于这一点和其他相关发现，Ebbinghaus 总结道：“当重复次数达到一定规模时，把重复合理地分布在一段时间里，显然比把重复堆在同一时刻更有优势”（Ebbinghaus 1885/1913，p. 89）。

     Son & Simon 2012：

    > 更进一步：即便已经承认了间隔的好处，改变教学实践仍然极其困难。Delaney 等人 2010 写道：“据轶事所见，高中教师与大学教授似乎常以线性方式教学，缺乏重复，并给出三四次互不累积的考试。”（p. 130）聚焦数学领域——按理说数学应当很容易实施“可复习、可间隔”的策略——Rohrer（2009）指出数学教材通常以不间隔、也不混合的方式呈现主题。甚至更早，Vash（1989）就写道：“教育政策制定者非常清楚，[间隔练习] 比 [集中练习] 更有效。他们不在乎。它不整齐。它不能让教师教完一个单元就拍拍手，舒舒服服地说‘好了，这就结束了。’”（p. 1547）
    >
     > - Rohrer, D. (2009). "The effects of spacing and mixing practice problems". Journal for Research in Mathematics Education, 40, 4-17
     > - Vash, C. L. (1989). "The spacing effect: A case study in the failure to apply the results of psychological research". American Psychologist, 44, 1547（对 Dempster 文章的评论？）

     引自 [_Psychology: An Introduction_](https://www.psywww.com/intropsych/ch06-memory/what-should-a-student-do.html#spacingeffect)：

     > 在一个关于间隔效应的实用演示中，[Bahrick, Bahrick, Bahrick, & Bahrick（1993）](https://gwern.net/doc/psychology/spaced-repetition/1993-bahrick.pdf "Maintenance of foreign language vocabulary and the spacing effect")显示：如果练习间隔拉得很开，外语词汇的保持率会显著提升。比如，“把 13 次再训练间隔设置为 56 天，其保持效果可与把 26 次训练间隔设置为 14 天相当。”换言之，如果把训练分布在 *四倍长* 的时间跨度里，被试可以用 *一半* 的学习次数达到类似效果。

间隔效应本质上是在说：如果你有一个问题（比如“我学过的这段随机序列里，第五个字母是什么？”），你最多只能学习它 5 次，那么把这 5 次尝试分散到更长的时间跨度——几天、几周、甚至几个月——会让你对答案（比如 ‘e’）的记忆最牢。你能做的最糟糕的事之一，就是把这 5 次机会全砸在一两天里。
你可以把[遗忘曲线](!W)想象成放射性[半衰期](!W)的曲线图：每次复习都把记忆强度“抬回去”（比如抬回到曲线高度的 50%），但在最初几天里，复习看起来并不怎么“赚”，因为记忆还没怎么衰减！
（从生物学层面看，间隔效应 *为什么* 会起作用？在[动物模型](https://onlinelibrary.wiley.com/doi/epdf/10.1155/2012/581291 "'Molecular Determinants of the Spacing Effect', Naqib et al 2012")中，集中与间隔确实存在明确的神经化学差异：间隔（>1 小时）能增强[长时程增强](!W)，而集中则不会[^Kramar-2012]；但其更深层的因果机制仍是开放问题，可参阅[记忆痕迹](!W "Engram (neuropsychology)")概念或与[睡眠](#when-to-review)相关的研究。）下面是遗忘曲线的一个图示：

![Stahl et al 2010; _CNS Spectrums_](https://gwern.net/doc/psychology/spaced-repetition/forgetting-curve-stahl.jpg "http://www.cnsspectrums.com/userdocs/ArticleImages/Stahl_figure1.jpg")

[^Kramar-2012]: ["Synaptic evidence for the efficacy of spaced learning"](https://www.pnas.org/doi/10.1073/pnas.1120700109), Kramar et al 2012 (["Take your time: Neurobiology sheds light on the superiority of spaced versus massed learning"](https://medicalxpress.com/news/2012-03-neurobiology-superiority-spaced-massed.html)):

    > The superiority of spaced versus massed training is a fundamental feature of learning. Here, we describe unanticipated timing rules for the production of long-term potentiation (LTP) in adult rat hippocampal slices that can account for one temporal segment of the spaced trials phenomenon. Successive bouts of naturalistic theta burst stimulation of field CA1 afferents markedly enhanced previously saturated LTP if spaced apart by 1 h or longer, but were without effect when shorter intervals were used. Analyses of F-actin-enriched spines to identify potentiated synapses indicated that the added LTP obtained with delayed theta trains involved recruitment of synapses that were "missed" by the first stimulation bout. Single spine glutamate-uncaging experiments confirmed that less than half of the spines in adult hippocampus are primed to undergo plasticity under baseline conditions, suggesting that intrinsic variability among individual synapses imposes a repetitive presentation requirement for maximizing the percentage of potentiated connections. We propose that a combination of local diffusion from initially modified spines coupled with much later membrane insertion events dictate that the repetitions be widely spaced. Thus, the synaptic mechanisms described here provide a neurobiological explanation for one component of a poorly understood, ubiquitous aspect of learning.

更妙的是，研究早已表明，[主动回忆](!W)比单纯被动接触信息要强得多。[^mapping]
而且，间隔重复还能扩展到极其庞大的信息量：赌徒/金融家 [Edward O. Thorp](!W) 在读物理研究生时就用“间隔学习”来“让自己能更久、更努力地学习”[^Thorp]；而 [Roger Craig](!W "Roger Craig (Jeopardy! contestant)") 在 2010--2011 年参加问答节目 _[Jeopardy!](!W)_ 时，部分依靠[使用 Anki](https://gwern.net/doc/psychology/spaced-repetition/2011-qs-rogercraigwinsjeopardy.html#comment-3004)记住了一个包含[>200,000](https://www.j-archive.com/)道往期题目的题库里的许多片段，从而创下多项纪录[^Craig]；后来的 _Jeopardy!_ 赢家 Arthur Chu 也使用了间隔重复[^Chu]。
医学生（由于医学院需要记忆的事实材料极其庞大，他们已成为 SRS 的主要人群之一）通常会有数千张卡片，尤其是使用预制牌组时（在医学领域更可行，因为课程相对标准化，而且自制卡片时间往往不够）。
外语学习者很容易达到 10--30,000 张卡片；[一位 Anki 用户](https://www.reddit.com/r/Anki/comments/a9s456/what_is_the_largest_anki_deck_you_have_read_about/)甚至报告过一个 >765k 的[自动生成](https://subs2srs.sourceforge.net/ "subs2srs allows you to create import files for Anki or other Spaced Repetition Systems (SRS) based on your favorite foreign language movies and TV shows to aid in the language learning process: this utility will parse through subtitle files, extract the dialog and timing information and then use that information to generate audio clips, snapshots and video clips for each line of dialog.")牌组，其中塞满了来自许多来源的日语音频样本（“Youtube 视频、电子游戏、电视节目等”）。

[^mapping]: There are many studies to the effect that active recall is best. Here's one recent study, ["Retrieval Practice Produces More Learning than Elaborative Studying with Concept Mapping"](https://ses.enseigne.ac-lyon.fr/spip/IMG/pdf/2011_karpicke_blunt_science.pdf), Karpicke 2011 (covered in [_Science Daily_](https://www.sciencedaily.com/releases/2011/01/110121111216.htm "Learning science: Actively recalling information from memory beats elaborate study methods; Put down those science text books and work at recalling information from memory. That's the shorthand take away message of new research that says practicing memory retrieval boosts science learning far better than elaborate study methods.") and the [_NYT_](https://www.nytimes.com/2011/01/21/science/21memory.html "To Really Learn, Quit Studying and Take a Test")):

    > Educators rely heavily on learning activities that encourage elaborative studying, while activities that require students to practice retrieving and reconstructing knowledge are used less frequently. Here, we show that practicing retrieval produces greater gains in meaningful learning than elaborative studying with concept mapping. The advantage of retrieval practice generalized across texts identical to those commonly found in science education. The advantage of retrieval practice was observed with test questions that assessed comprehension and required students to make inferences. The advantage of retrieval practice occurred even when the criterial test involved creating concept maps. Our findings support the theory that retrieval practice enhances learning by retrieval-specific mechanisms rather than by elaborative study processes. Retrieval practice is an effective tool to promote conceptual learning about science.

    From ["Forget What You Know About Good Study Habits"](https://www.nytimes.com/2010/09/07/health/views/07mind.html). _New York Times_;

    > Cognitive scientists do not deny that honest-to-goodness cramming can lead to a better grade on a given exam. But hurriedly jam-packing a brain is akin to speed-packing a cheap suitcase, as most students quickly learn - it holds its new load for a while, then most everything falls out....When the neural suitcase is packed carefully and gradually, it holds its contents for far, far longer. An hour of study tonight, an hour on the weekend, another session a week from now: such so-called spacing improves later recall, without requiring students to put in more overall study effort or pay more attention, dozens of studies have found.
    >
    > "The idea is that forgetting is the friend of learning", said Dr. Kornell. "When you forget something, it allows you to relearn, and do so effectively, the next time you see it."
    >
    > That's one reason cognitive scientists see testing itself - or practice tests and quizzes - as a powerful tool of learning, rather than merely assessment. The process of retrieving an idea is not like pulling a book from a shelf; it seems to fundamentally alter the way the information is subsequently stored, making it far more accessible in the future.
    >
    > [In one of his own experiments](https://gwern.net/doc/psychology/spaced-repetition/2006-roediger.pdf "‘Test-Enhanced Learning: Taking Memory Tests Improves Long-Term Retention’, Roediger & Karpicke 2006"), Dr. Roediger and Jeffrey Karpicke, who is now at Purdue University, had college students study science passages from a reading comprehension test, in short study periods. When students studied the same material twice, in back-to-back sessions, they did very well on a test given immediately afterward, then began to forget the material. But if they studied the passage just once and did a practice test in the second session, they did very well on one test two days later, and another given a week later.
[^Thorp]: _The Mathematics of Gambling_, Thorp 1984, [§2 "The Wheels", Chapter 4](https://gwern.net/doc/statistics/decision/1984-thorp-themathematicsofgambling-ch4.pdf), pg43–44:

    > It was the spring of 1955. I was finishing my second year of graduate physics at U.C.L.A...I changed my field of study from physics to mathematics...I attended classes and studied 50–60 hours a week, generally including Saturdays and Sundays. I had read about the psychology of learning in order to be able to work longer and harder. I found that "spaced learning" worked well: study for an hour, then take a break of at least ten minutes (shower, meal, tea, errands, etc.). One Sunday afternoon about 3 p.m., I came to the co-op dining room for a tea break...My head was bubbling with physics equations, and several of my good friends were sitting around chatting.
[^Craig]: From [_Final Jeopardy: Man Versus Machine and the Quest to Know Everything_](https://www.amazon.com/Final-Jeopardy-Machine-Quest-Everything/dp/0547483163/), by Stephen Baker, pg214:

    > The program he put together tested him on categories, gauged his strengths (sciences, NFL football) and weaknesses (fashion, Broadway shows), and then directed him toward the preparation most likely to pay off in his own match. To patch these holes in his knowledge, Craig used a free online tool called Anki, which provides electronic flash cards for hundreds of fields of study, from Japanese vocabulary to European monarchs. The program, in Craig's words, is based on psychological research on 'the forgetting curve'. It helps people find holes in their knowledge and determines how often they need those areas to be reviewed to keep them in mind. In going over world capitals, for example, the system learns quickly that a user like Craig knows London, Paris, and Rome, so it might spend more time reinforcing the capital of, say, Kazakhstan. (And what would be the Kazakh capital? 'Astana', Craig said in a flash. 'It used to be Almaty, but they moved it.')
[^Chu]: ["Our Interview With _Jeopardy!_ Champion Arthur Chu"](https://www.mentalfloss.com/article/54853/our-interview-jeopardy-champion-arthur-chu):

    > [Chu:] ..._Jeopardy!_ is aimed at the sort of average TV viewer, so they're not going to ask things that are pointlessly obscure...So I used a program called Anki which uses a method called "spaced repetition." It keeps track of where you're doing well or poorly, and pushes you to study the flashcards you don't know as well, until you develop an even knowledge base about a particular subject, and I just made flashcards for those specific things. I memorized all the world capitals, it wasn't that hard once I had the flashcards and was using them every day. I memorized the US State Nicknames (they're on Wikipedia), memorized the basic important facts about the 44 US Presidents. I really focused on those. But there's a lot more stuff to know. I went on _Jeopardy!_ knowing that there was stuff I didn't know. For instance, everyone laughs about sports - but I also knew that [sports clues] were the least likely to come up in Double Jeopardy and Final Jeopardy and be very important. So I decided I shouldn't sweat it too much, I should just recognize that I didn't know them and let that go, as long as I can get the high value clues. So that was how I prepared.

一张图或许更直观：设想你只能为某条信息复习几次（毕竟人很忙）。观察“我们还能记住它”的概率，就会发现突击在短期内获胜，但未经巩固的记忆衰减得太快，所以用不了多久，间隔复习就会显著占优：

![_Wired_ (original, Wozniak?); massed vs spaced ([alternative](https://gwern.net/doc/psychology/spaced-repetition/2013-memotrainerrr.png))](https://gwern.net/doc/psychology/spaced-repetition/forgetting-curve-wired-wozniak.jpg "https://www.wired.com/images/article/magazine/1605/ff_wozniak_graph_f.jpg"){.invert}

如果看一段可视化“记忆语料库衰减”的视频，会更有冲击力：对比[随机复习 vs 最近优先复习 vs 间隔复习](https://www.youtube.com/watch?v=ai2K3qHpC7c#t=2m40s)。

## 既然这么好，为何没人靠它发财 {#if-youre-so-good-why-arent-you-rich}

> Most people find the concept of programming obvious, but the doing impossible.^[Alan J. Perlis, ["Epigrams in Programming"](https://gwern.net/doc/cs/algorithm/1982-perlis.pdf "'Epigrams on Programming', Perlis 1982") (1982)]

当然，后一种策略（突击）正是学生最常做的事：考试前一晚狂背，一个月后几乎什么都不记得了。那么，为什么大家仍然会这么做？（我自己也并不无辜。）为什么间隔重复如此令人沮丧地不受欢迎，哪怕是在那些尝试过一次的人之中？[^sites]

[^sites]: 网页开发者 Persol 在 2012 年 8 月[写道](https://www.lesswrong.com/posts/YbCc3NRrr5avvWSHT/who-wants-to-start-an-important-startup?commentId=cmjjdPpksrjgynF8z)：

    > I actually wrote a site that did this [spaced repetition] a few months ago. I had about 4000 users who had actually gone through a complete session...As guessed, the problem is that I couldn't get people to start forming it as a habit. There is no immediate payback. Less than 20 people out of 4000 did more than one session...Additionally, there are at least 18 competitors. Here's the list I [made at the time](https://gwern.net/doc/psychology/spaced-repetition/2012-persol-srssitecomparison.pdf). Very few seem to be successful. I shut the site down about a month ago. There are numerous free competitors which don't have any great annoyances. I wouldn't suggest starting another of these sites unless you figured out an effective way to "gamify" it.
    >
    > ...~4000 people finished a session. Many more 'tried' than 4000...I just couldn't determine which users were bots that registered randomly vs users that didn't finish the first session.
    >
    > - Tried: lots (but unknown)
    > - Finished 1 session: ~4000
    > - Finished >1 session: ~20 [0.5%]

![Scumbag Brain meme: knows everything when cramming the night before the test / and forgets everything a month later](https://gwern.net/doc/psychology/spaced-repetition/2013-gwern-meme-scumbagbrain.png "Humorous description of the downside to cramming as a study method; original: http://www.ml.sun.ac.za/wordpress/wp-content/uploads/2012/01/Screen-Shot-2012-01-30-at-4.24.53-PM.png"){.invert .float-right}

Because it does work. Sort of. Cramming is a trade-off: you trade a strong memory now for weak memory later. (Very weak[^Stahl1].) And tests are usually of all the new material, with occasional old questions, so this strategy pays off! That's the damnable thing about it - its memory longevity & quality are, in sum, less than that of spaced repetition, but cramming delivers its goods *now*[^vacha]. So cramming is a rational, if short-sighted, response, and even SRS software recognize its utility & support it to some degree[^cramming]. (But as one might expect, if the testing is continuous and incremental, then the learning tends to also be long-lived[^conway]; I do not know if this is because that kind of testing is a disguised accidental spaced repetition system, or the students/subjects simply studying/acting differently in response to small-stakes exams.) In addition to this short-term advantage, there's [an ignorance](https://gwern.net/doc/psychology/spaced-repetition/2011-mccabe.pdf "'Metacognitive awareness of learning strategies in undergraduates', McCabe 2011") of the advantages of spacing and a subjective *illusion* that the gains persist[^Stahl2][^Kornell2010] (cf. [Son & Simon 2012](https://gwern.net/doc/psychology/spaced-repetition/2012-son.pdf "Distributed Learning: Data, Metacognition, and Educational Implications")[^Son-Simon-meta], [Mulligan & Peterson 2014](https://gwern.net/doc/psychology/spaced-repetition/2014-mulligan.pdf "The Spacing Effect and Metacognitive Control"), [Bjork et al 2013](https://gwern.net/doc/psychology/spaced-repetition/2013-bjork.pdf "Self-Regulated Learning: Beliefs, Techniques, and Illusions"), [Deslauriers et al 2019](https://www.pnas.org/doi/10.1073/pnas.1821936116 "Measuring actual learning versus feeling of learning in response to being actively engaged in the classroom")); from [Kornell 2009's](https://sites.williams.edu/nk2/files/2011/08/Kornell.2009b.pdf "Optimising Learning Using Flashcards: Spacing Is More Effective Than Cramming") study of GRE vocab (emphasis added):

> Across experiments, *spacing* was more effective than massing for 90% of the participants, yet after the first study session, 72% of the participants believed that *massing* had been more effective than spacing....When they do consider spacing, they often exhibit the illusion that massed study is more effective than spaced study, even when the reverse is true ([Dunlosky & Nelson, 1994](https://gwern.net/doc/psychology/spaced-repetition/1994-dunlosky.pdf "Does the Sensitivity of Judgments of Learning (JOLs) to the Effects of Various Study Activities Depend on When the JOLs Occur?"); Kornell & Bjork, 2008a; [Simon & Bjork 2001](https://gwern.net/doc/psychology/spaced-repetition/2001-simon.pdf "Metacognition in Motor Learning"); [Zechmeister & Shaughnessy, 1980](https://www.willatworklearning.com/2005/11/research_review.html)).

[^Son-Simon-meta]: From Son & Simon 2012:

    > Thus, while spacing may boost learning, it may be thought to be relatively inefficient in terms of study time. As we discuss later, this feeling of inefficiency may be one of the reasons that spacing is not the more popular strategy. Interestingly, in that same study (Baddeley & Longman 1978; and see also Pirolli & Anderson 1985 and Woodworth & Schlosberg 1954 [_Experimental Psychology_]), there was evidence of such a thing as *laboring in vain*. That is, exceeding a certain number of hours of practice a day (more than approximately 2h) led to no increases in learning, as might be expected. Related to the deficient-processing theory mentioned above, these results are crucial in understanding intuitively how the spacing effect works: We simply get burnt out. These data are also analogous to the cognitive literature on *overlearning*, which shows that while continuous study over long periods of time might seem beneficial (and even feel good) in the short-term, the benefits disappear soon afterwards (Rohrer et al 2005; Rohrer & Taylor 2006)...In the above-described Baddeley & Longman 1978's study, for example, after postal workers practiced typing in either massed or spaced study sessions, they had to indicate how satisfied they were with the training. Results showed that while spacing led to the best learning, it was the *least* liked. Similarly, Simon & Bjork 2001 found that people preferred the massing strategy on a motor learning task.
    >
    > - Baddeley, A. D., & Longman, D. J. A. (1978). ["The influence of length and frequency of training session on the rate of learning to type"](https://gwern.net/doc/psychology/spaced-repetition/1978-baddeley.pdf). Ergonomics, 21, 627-635
    > - Pirolli, P., & Anderson, J. R. (1985). ["The role of practice in fact retrieval"](https://gwern.net/doc/psychology/spaced-repetition/1985-pirolli.pdf)
[^Stahl1]: ["Play it Again: The Master Psychopharmacology Program as an Example of Interval Learning in Bite-Sized Portions"](http://www.cnsspectrums.com/aspx/articledetail.aspx?articleid=2783), Stahl et al 2010:

    > Since Ebbinghaus' time, a voluminous amount of research has confirmed this simple but important fact: the retention of new information degrades rapidly unless it is reviewed in some manner. A modern example of this loss of knowledge without repetition is a study of cardiopulmonary resuscitation (CPR) skills that demonstrated rapid decay in the year following training. By 3 years post-training only 2.4% were able to perform CPR successfully.^[6](https://gwern.net/doc/psychology/spaced-repetition/1985-mckenna.pdf "'Occupational first aid training: Decay in cardiopulmonary resuscitation (CPR) skills', McKenna & Glendon 1985")^ Another recent study of physicians taking a tutorial they rated as very good or excellent showed mean knowledge scores increasing from 50% before the tutorial to 76% immediately afterward.^[7](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2517967/ "'Knowledge retention after an online tutorial: a randomized educational experiment among resident physicians', Bell et al 2008")^ However, score gains were only half as great 3-8 days later and incredibly, there was no [statistically-]significant knowledge retention measurable at all at 55 days.^7^ Similar results have been reported by us in follow-up studies of knowledge retention from continuing medical education programs.^1^ [Stahl SM, Davis RL. [_Best Practices for Medical Educators_](https://www.amazon.com/Practices-Medical-Educators-Stephen-Stahl/dp/1422500497/). Carlsbad, CA: NEI Press; 2009]
    >
    > ...This may be due to the fact that lectures with assigned reading are the easiest for teachers. Also, medical learning is rarely measured immediately after a lecture or after reading new material for the first time and then measured again a few days or weeks later, so that the low retention rates of this approach may not be widely appreciated.^1,[4](https://pdfs.semanticscholar.org/9731/c11be2ef8183dd974d79ef3ad1236f33e342.pdf "'Applying the Principles of Adult Learning to the Teaching of Psychopharmacology: Overview and Finding the Focus', Stahl & Davis 2009")^ No wonder formal medical education conferences without enabling or practice-reinforcing strategies appear to have relatively little impact on practice and healthcare outcomes.^[8](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.556.6124&rep=rep1&type=pdf "'Impact of formal continuing medical education: do conferences, workshops, rounds, and other traditional continuing education activities change physician behavior or health care outcomes?', Davis et al 1999"),[9](https://gwern.net/doc/psychology/spaced-repetition/1998-davis.pdf "'Does CME work? An analysis of the effect of educational activities on physician performance or health care outcomes', Davis 1998"),[10](https://gwern.net/doc/psychology/spaced-repetition/1995-davis.pdf "'Changing Physician Performance: A Systematic Review of the Effect of Continuing Medical Education Strategies', Davis et al 1995")^
[^Stahl2]: Stahl 2010:

    > For example, simple restudying allows the learner to reexperience all of the material but actually produces poor long-term retention.^[25](https://pdfs.semanticscholar.org/6698/bf91c9333faa0d333a800254b8063230d4f4.pdf "Optimizing retrieval as a learning event: When and why expanding retrieval practice enhances long-term retention, Storm et al 2010"),[26](https://gwern.net/doc/psychology/spaced-repetition/2007-pashler.pdf "'Enhancing learning and retarding forgetting: Choices and consequences', Pashler et al 2007"),[35](https://gwern.net/doc/psychology/spaced-repetition/2006-roediger.pdf "'Test-Enhanced Learning: Taking Memory Tests Improves Long-Term Retention', Roediger & Karpicke 2006")^ Why do students keep studying the original materials? Certainly if this is their only choice, then restudying is a necessary tactic. Another answer may be that repeated studying falsely inflates students' confidence in their ability to remember in the future because they sense that they understand it now, and they and their instructors may be unaware of the many studies that show poor retention on delayed testing after this form of repetition.^25,26,35^
[^Kornell2010]: From Kornell et al 2010:

    > Contrary to the massing-aids-induction hypothesis, final test performance was consistently and considerably superior in the spaced condition. A large majority of participants, however, judged massing to be more effective than spacing, despite making the judgment *after* taking the test.
    >
    > ...Metacognitive judgments-that is, judgments about one's own memory and cognition-are often based on feelings of fluency(eg. see [Benjamin, Bjork, & Schwartz, 1998](https://gwern.net/doc/psychology/cognitive-bias/illusion-of-depth/1998-benjamin.pdf "‘The mismeasure of memory: When retrieval fluency is misleading as a meta-mnemonic index’, Benjamin et al 1998"); [Rhodes & Castel, 2008](http://castel.bol.ucla.edu/publications/RhodesCastelJOLFontSize.pdf "Memory predictions are influenced by perceptual information: evidence for metacognitive illusions")). Because massing naturally leads to feelings of fluency and increases short-term task performance during learning, learners frequently rate spacing as less effective than massing, even when their performance shows the opposite pattern (Baddeley & Longman 1978; Kornell & Bjork, 2008; Simon & Bjork, 2001; Zechmeister & Shaughnessy, 1980). Averaged across Kornell and Bjork's (2008) experiments, for example, more than 80% of participants rated massing as equally or more effective than spacing, whereas only 15% of participants actually performed better in the massed condition than in the spaced condition.
    >
    > ...Such an illusion was apparent in the induction condition. Contrary to previous research, however, participants gave higher ratings for spacing than massing during repetition learning (see, eg. Simon & Bjork, 2001; Zechmeister & Shaughnessy, 1980). This outcome may have occurred because of a process of a habituation: Six presentations and a total of 30 s spent studying a single painting may have come to seem inefficient and pointless. Thus, there appears to be a turning point in metacognitive ratings based on fluency: As fluency increases, metacognitive ratings increase up to a point, but as fluency continues to increase and encoding or retrieval becomes too easy, metacognitive ratings may begin to decrease.
    >
    > ...In advance of their research, Kornell & Bjork 2008 were convinced that such inductive learning would benefit from massing, yet their results showed the opposite. Undaunted, we remained convinced that spacing would be more beneficial for repetition learning than for inductive learning- especially for older adults, given their overall declines in episodic memory. The current results disconfirmed our expectations once again. If our intuitions are erroneous, despite our years spent proving and praising the spacing effect-including roughly 40 years' worth contributed by Robert A. Bjork-those of the average student are surely mistaken as well (as the inaccuracy of the participants' metacognitive ratings suggests). We have, perhaps, fallen victim to the illusion that making learning easy makes learning effective, rather than recognizing that spacing is a desirable difficulty ([Bjork 1994](https://gwern.net/doc/psychology/spaced-repetition/1994-bjork.pdf "Memory and Metamemory Considerations in the Training of Human Beings")) that enhances inductive learning as well as repetition learning well into old age.
[^cramming]: Anki has its [Cram Mode](https://docs.ankiweb.net/filtered-decks.html#filtered-decks--cramming) and Mnemosyne 2.0 has a cramming plugin. When a SRS doesn't have explicit support, it's always possible to 'game' the algorithm by setting one's scores artificially low, so the SR algorithm thinks you are stupid and need to do a lot of repetitions.
[^vacha]: One study looking at cramming is the 1993 "Cramming: A barrier to student success, a way to beat the system or an effective learning strategy?", Vacha et al 1993, abstract:

    > Tested the hypothesis that cramming is an ineffective study strategy by examining the weekly study diaries of 166 undergraduates. All subjects also completed an end-of-semester questionnaire measuring study habits. subjects were classified in the following study patterns: ideal, confident, zealous, or crammer. Contrary to the hypothesis, results suggest that cramming is an effective approach, most widespread in courses using take-home essay examinations and major research papers. Crammers' grades were as good as or better than those of subjects using other strategies; the longer subjects were in college, the more likely it was that they crammed. Crammers studied more hours than most students and were as interested in their courses as other students.

    Note that there is no measure of long-term retention, suggesting that people who only care about grades are rationally choosing to cram.
[^conway]: ["Examining the examiners: Why are we so bad at assessing students?"](https://journals.sagepub.com/doi/pdf/10.2304/plat.2002.2.2.70), Newstead 2002:

    > [Conway, Cohen & Stanhope 1992](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.56.6901&rep=rep1&type=pdf "Very Long Term Retention of Knowledge") looked at long term memory for the information presented on a psychology course. They found that some types of information, especially that relating to research methods, were remembered better than others. But in a follow up analysis, they found that the type of assessment used had an effect on memory. In essence, material assessed by continuous assessment was more likely to be remembered than information assessed by exams.

如果测验效应与间隔效应确实存在，那么我们会期待：那些会自发自测、并且提前很久开始复习的学生，往往有更高的 GPA。[^Hartwig] 如果把“提问”也视作一种测试，那么我们也就不意外：1 对 1 家教比普通教学[显著更有效](!W "Bloom’s 2 Sigma Problem")，并且在辅导中学生需要回答的问题数量会高出几个数量级[^intelligence-ethnography]。

[^Hartwig]: ["Study strategies of college students: Are self-testing and scheduling related to achievement?"](https://gwern.net/doc/psychology/spaced-repetition/2012-hartwig.pdf), Hartwig & Dunlosky 2012:

    > Previous studies, such as those by Kornell and Bjork (_Psychonomic Bulletin & Review_, 14:219-224, 2007) and Karpicke, Butler, and Roediger (_Memory_, 17:471-479, 2009), have surveyed college students' use of various study strategies, including self-testing and rereading. These studies have documented that some students do use self-testing (but largely for monitoring memory) and rereading, but the researchers did not assess whether individual differences in strategy use were related to student achievement. Thus, we surveyed 324 undergraduates about their study habits as well as their college grade point average (GPA). Importantly, the survey included questions about self-testing, scheduling one's study, and a checklist of strategies commonly used by students or recommended by cognitive research. Use of self-testing and rereading were both positively associated with GPA. Scheduling of study time was also an important factor: Low performers were more likely to engage in late-night studying than were high performers; massing (versus spacing) of study was associated with the use of fewer study strategies overall; and all students-but especially low performers-were driven by impending deadlines. Thus, self-testing, rereading, and scheduling of study play important roles in real-world student achievement.

    (See also [Dunlosky et al 2013](https://gwern.net/doc/psychology/spaced-repetition/2013-dunlosky.pdf "Improving Students' Learning With Effective Learning Techniques: Promising Directions From Cognitive and Educational Psychology").) Note the self-testing correlation excludes flashcards, a result that both the authors and me found surprising. The sleep connection is interesting, given the [hypothesized link](#when-to-review) between stronger memory formation & studying before a good night's sleep - you can hardly get a good night's sleep if you are cramming late into the night (correlated with lower grades) but you can if you do so at a reasonable time in the evening (in time to get a solid night).

    See also [Susser & McCabe 2012](https://gwern.net/doc/psychology/spaced-repetition/2012-susser.pdf "From the lab to the dorm room: metacognitive awareness and use of spaced study"):

    > Laboratory studies have demonstrated the long-term memory benefits of studying material in multiple distributed sessions as opposed to one massed session, given an identical amount of overall study time (ie. the *spacing effect*). The current study goes beyond the laboratory to investigate whether undergraduates know about the advantage of spaced study, to what extent they use it in their own studying, and what factors might influence its utilization. Results from a web-based survey indicated that participants (_n_ = 285) were aware of the benefits of spaced study and would use a higher level of spacing under ideal compared to realistic circumstances. However, self-reported use of spacing was intermediate, similar to massing and several other study strategies, and ranked well below commonly used strategies such as rereading notes. Several factors were endorsed as important in the decision to distribute study time, including the perceived difficulty of an upcoming exam, the amount of material to learn, how heavily an exam is weighed in the course grade, and the value of the material. Further, level of metacognitive self-regulation and use of elaboration strategies were associated with higher rates of spaced study.
[^intelligence-ethnography]: [_Analytic Culture in the US Intelligence Community: An Ethnographic Study_](https://apps.dtic.mil/dtic/tr/fulltext/u2/a507369.pdf), Johnston 2005, pg89:

    > To investigate the intensity of instructional interactions, [Art Graesser and Natalie Person 1994](https://gwern.net/doc/psychology/spaced-repetition/1994-graesser.pdf "Question Asking during Tutoring") compared questioning and answering in classrooms with those in tutorial settings.^5^ They found that classroom groups of students ask about three questions an hour and that any single student in a classroom asks about 0.11 questions per hour. In contrast, they found that students in individual tutorial sessions asked 20-30 questions an hour and were required to answer 117-146 questions per hour. Reviews of the intensity of interaction that occurs in technology-based instruction have found even more active student response levels. [J. D. Fletcher, _Technology, the Columbus Effect, and the Third Revolution in Learning_.]

    Although Graesser & Person 1994 also found that sheer number of questions was not necessarily important, suggesting [diminishing marginal returns](!W) or perhaps bad question asking.

当然，这种短期视角从长远看并不是好事。知识是在知识之上累积的；我们学习的并不是彼此独立的零散冷知识。[Richard Hamming](!W) 在[“You and Your Research”](https://gwern.net/doc/science/1986-hamming#conscientiousness)里回忆说：“你会发现大多数伟大的科学家都有惊人的驱动力……知识与生产力就像[复利](!W)。”

知识需要持续累积；而带间隔重复的抽认卡正可以帮助这种累积：即使卡片数量和先修知识堆到[成千上万](#the-workload)，它也能维持稳定的复习节奏。

这种长期导向或许解释了为什么“显式的间隔重复”并不是一种常见的学习技巧：收益遥远且反直觉，而自控的成本近在眼前且极其鲜明（参见[双曲贴现](!W)）。更糟的是，你很难判断自己到底应该 *何时* 复习：最佳时点恰恰是“你正要忘记它的时候”，但问题就在这里——如果你正要忘记它，你又怎么会想起来去复习？你只会记得去复习你还记得的东西；而你还记得的东西，往往并不是你最需要复习的！[^wired1]

[^wired1]:  "SuperMemo is based on the insight that there is an ideal moment to practice what you've learned. Practice too soon and you waste your time. Practice too late and you've forgotten the material and have to relearn it. The right time to practice is just at the moment you're about to forget. Unfortunately, this moment is different for every person and each bit of information. Imagine a pile of thousands of flash cards. Somewhere in this pile are the ones you should be practicing right now. Which are they?" Gary Wolf, ["Want to Remember Everything You'll Ever Learn? Surrender to This Algorithm"](https://www.wired.com/2008/04/ff-wozniak/ "‘Want to Remember Everything You’ll Ever Learn? Surrender to This Algorithm’, Wolf 2008"), _[Wired Magazine](!W)_

这个悖论可以通过让计算机来做全部计算而解决。我们要感谢 [Hermann Ebbinghaus](https://en.wikisource.org/wiki/Memory:_A_Contribution_to_Experimental_Psychology "'Memory: A Contribution to Experimental Psychology', Ebbinghaus 1885")：他以极其繁琐的细致程度验证了这样一件事——我们确实可以编程让计算机计算遗忘曲线与一组近似最优的复习时点^[“别搞错了：计算机处理的是数字——不是符号。我们对某个活动的理解（与控制）程度，取决于我们能在多大程度上把它算术化。”Perlis，同上。]。这正是[间隔重复](!W)软件背后的洞见：反复提问同一个问题，但时间间隔逐步拉长。起初每隔几天问一次，很快人就能记得相当牢；随后把间隔扩展到几周、几个月、再到几年。一旦记忆形成并转入长期记忆，它只需要偶尔“锻炼”就能保持健康^[这种指数式扩展也解释了 SR 程序为何能持续输入新卡：如果卡片固定每隔两天复习一次，那么复习很快就会变得不可能——我在 Mnemosyne 里有 >18000 条目，但我不可能每天复习 9000 道题！]——我至今仍清楚记得四五岁生日时那些纸板做的大恐龙，或箱子搭成的隧道，尽管我一年顶多想起它们一两次。

## 文献综述 {#literature-review}

但别只听我一面之词——_Nullius in verba_！我们可以直接看科学证据。当然，如果你愿意相信我的结论，你多半只是想知道如何使用它，以及它能玩出哪些花样；那我建议你直接[跳到后面](#using-it)的“使用方法”一节。否则，我们就从头开始：

### 背景：测验确实有效！

> "If you read a piece of text through twenty times, you will not learn it by heart so easily as if you read it ten times while attempting to recite from time to time and consulting the text when your memory fails." --_[The New Organon](!W)_, [Francis Bacon](!W)

[测验效应](!W)是心理学中一个相当稳固的观察：仅仅通过“测试某人的记忆”这一行为，就能强化记忆（不论是否提供反馈）。由于[间隔重复](!W)本质上就是在特定日期进行测试，我们应当先确认：测试确实比普通复习/学习更有效，而且它并不只适用于背诵历史年代这类随机事实。下面简单列几篇论文：

#. Allen, G.A., Mahler, W.A., & Estes, W.K. (1969). ["Effects of recall tests on long-term retention of paired associates"](https://gwern.net/doc/psychology/spaced-repetition/1969-allen.pdf). _Journal of Verbal Learning and Verbal Behavior_, 8, 463-470

    一次测试，在一天后的记忆强度上就能达到“学习 5 次”的效果；相比集中呈现，加入间隔能提升保持。

#. Karpicke & Roediger (2003). ["The Critical Importance of Retrieval for Learning"](http://www.wsu.edu/~fournier/Teaching/psych592/Readings/Karpicke_et_al_2008.pdf "‘The Critical Importance of Retrieval for Learning’, Karpicke & Roediger 2008")

    在学习斯瓦希里语词汇时，学生被分配到不同流程：只测试、只学习、或测试+学习。在学习阶段，各组表现相近。学生被要求预测自己能记住多少（各组平均：50%）。一周后，做过测试的学生还能记住约 80% 的词汇，而未测试组约为 35%。一些学生被测试/学习的次数更多；但一旦第一天形成记忆，边际收益很快开始递减。学生自述很少自测，也很少测试“已经学会的内容”。

    结论：再次验证，测试相比单纯学习能更好地增强记忆；而且学生普遍并不知道这一点。

#. Roediger & Karpicke (2006a). ["Test-Enhanced Learning: Taking Memory Tests Improves Long-Term Retention"](https://gwern.net/doc/psychology/spaced-repetition/2006-roediger.pdf "‘Test-Enhanced Learning: Taking Memory Tests Improves Long-Term Retention’, Roediger & Karpicke 2006")

    学生在阅读一段文章后接受阅读理解测试（无反馈），测试发生在 5 分钟后、2 天后、以及 1 周后。5 分钟后“学习”优于“测试”，但在更长间隔上并非如此；学生主观上却认为各个间隔中学习都优于测试。到 1 周时，测试组约 60%，学习组约 40%。

    结论：测试相比学习能更好地增强记忆；而每个人（教师与学生）都“知道”相反的事。
#. Karpicke & Roediger (2006a). ["Expanding retrieval promotes short-term retention, but equal interval retrieval enhances long-term retention"](https://gwern.net/doc/psychology/spaced-repetition/2007-karpicke.pdf "‘Expanding retrieval practice promotes short-term retention, but equally spaced retrieval enhances long-term retention’, Karpicke & Roediger 2007")

    针对一般科学类散文的理解；引自 Roediger & Karpicke 2006b：“2 天后，初次测试的保持优于重复学习（68% vs 54%）；1 周后测试相对重复学习的优势仍然存在（56% vs 42%）。”
#. Roediger & Karpicke (2006b). ["The Power of Testing Memory: Basic Research and Implications for Educational Practice"](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.858.5753&rep=rep1&type=pdf)

    文献综述；列举了 1941 年前的 7 项研究与之后的 6 项研究，均显示测试能提升保持。另见综述[“Spacing Learning Events Over Time: What the Research Says”](https://gwern.net/doc/psychology/spaced-repetition/2006-thalheimer.pdf "Thalheimer 2006")与[“Using spacing to enhance diverse forms of learning: Review of recent research and implications for instruction”](https://laplab.ucsd.edu/articles/Carpenter_etal_EPR2012.pdf)（Carpenter et al 2012）。
#. Agarwal et al 2008, ["Examining the Testing Effect with Open- and Closed-Book Tests"](https://pdfs.semanticscholar.org/7521/c9adbe66cb2e777f37b6b00e97f5f95633c2.pdf)

    类似 #2，越“纯粹”的测试形式（这里是开卷 vs 闭卷测试）在长期上表现越好；而学生对“什么更有效”仍然存在错觉。
#. Bangert-Drowns et al 1991. ["Effects of frequent classroom testing"](https://gwern.net/doc/psychology/spaced-repetition/1991-bangertdrowns.pdf)

    对 35 项研究（1929--1989）进行元分析，这些研究操纵了学期内的测试安排：29 项发现收益，5 项发现负面影响，1 项无显著结果。元分析认为，即便只测试一次也有明显收益，随后则出现边际递减。
#. Cook 2006, ["Impact of self-assessment questions and learning styles in Web-based learning: a randomized, controlled, crossover trial"](https://gwern.net/doc/psychology/spaced-repetition/2006-cook.pdf); final scores were higher when the doctors (residents) learned with questions.
#. Johnson & Kiviniemi 2009, ["The Effect of Online Chapter Quizzes on Exam Performance in an Undergraduate Social Psychology Course"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2747780/) ("This study examined the effectiveness of compulsory, mastery-based, weekly reading quizzes as a means of improving exam and course performance. Completion of reading quizzes was related to both better exam and course performance."); see also [McDaniel et al 2012](https://gwern.net/doc/psychology/spaced-repetition/2012-mcdaniel.pdf "Using quizzes to enhance summative-assessment performance in a web-based class: An experimental study").
#. Metsämuuronen 2013, ["Effect of Repeated Testing on the Development of Secondary Language Proficiency"](https://www.ccsenet.org/journal/index.php/jedp/article/download/19582/15080)
#. Meyer & Logan 2013, ["Taking the Testing Effect Beyond the College Freshman: Benefits for Lifelong Learning"](https://gwern.net/doc/psychology/spaced-repetition/2013-meyer.pdf); verifies testing effect in older adults has similar effect size as younger
#. Larsen & Butler 2013, ["Test-enhanced learning"](https://gwern.net/doc/psychology/spaced-repetition/2013-larsen.pdf "'Chapter 38: Test-Enhanced Learning', Larsen & Butler 2013")
#. Yang et al 2021, ["Testing (Quizzing) Boosts Classroom Learning: A Systematic And Meta–Analytic Review"](https://gwern.net/doc/psychology/spaced-repetition/2021-yang.pdf)

（你可能会忍不住反驳：测试只对 *某些*[学习风格](!W)有效，比如偏语言型的人。但这缺乏支持：关于学习风格的实验文献质量不高，而且现有证据也相当混杂，甚至难以确认“学习风格”是否真以这种方式存在。[^style]）

[^style]: See the 2008 meta-analysis, ["Learning Styles: Concepts and Evidence"](https://www.psychologicalscience.org/journals/pspi/PSPI_9_3.pdf) ([APS press release](https://www.psychologicalscience.org/news/releases/learning-styles-debunked-there-is-no-evidence-supporting-auditory-and-visual-learning-psychologists-say.html)); from the abstract:

    > ...in order to demonstrate that optimal learning requires that students receive instruction tailored to their putative learning style, the experiment must reveal a specific type of interaction between learning style and instructional method: Students with one learning style achieve the best educational outcome when given an instructional method that differs from the instructional method producing the best outcome for students with a different learning style. In other words, the instructional method that proves most effective for students with one learning style is not the most effective method for students with a different learning style.
    >
    > Our review of the literature disclosed ample evidence that children and adults will, if asked, express preferences about how they prefer information to be presented to them. There is also plentiful evidence arguing that people differ in the degree to which they have some fairly specific aptitudes for different kinds of thinking and for processing different types of information. However, we found virtually no evidence for the interaction pattern mentioned above, which was judged to be a precondition for validating the educational applications of learning styles. Although the literature on learning styles is enormous, very few studies have even used an experimental methodology capable of testing the validity of learning styles applied to education. Moreover, of those that did use an appropriate method, several found results that flatly contradict the popular meshing hypothesis.
    >
    > We conclude therefore, that at present, there is no adequate evidence base to justify incorporating learning-styles assessments into general educational practice. Thus, limited education resources would better be devoted to adopting other educational practices that have a strong evidence base, of which there are an increasing number. However, given the lack of methodologically sound studies of learning styles, it would be an error to conclude that all possible versions of learning styles have been tested and found wanting; many have simply not been tested at all.

#### 材料类型 {#subjects}

上述研究经常使用词对、或单个词作为材料。测验效应的适用范围到底有多广？

已知能从测试中获益的材料包括：

- 外语词汇（如 Karpicke & Roediger 2003、[Cepeda et al 2009](https://home.cs.colorado.edu/~mozer/Research/Selected%20Publications/reprints/Cepedaetal2009.pdf)、Fritz et al 2007^[Fritz, C. O., Morris, P. E., Acton, M., Etkind, R., & Voelkel, A. R (2007). "Comparing and combining expanding retrieval practice and the keyword mnemonic for foreign vocabulary learning". _Applied Cognitive Psychology_, 21, 499-526.]、[de la Rouviere 2012](https://scholar.sun.ac.za/server/api/core/bitstreams/6dfdb0ca-e7e5-403e-9a2b-4161e3d93385/content#pdf "Chinese Radicals in Spaced Repetition Systems: a pilot study on the acquisition of Chinese characters by students learning Chinese as a foreign language")）
- [GRE](!W) 材料（如词汇；[Kornell 2009](#kornell-2009 "'Optimising Learning Using Flashcards: Spacing Is More Effective Than Cramming', Kornell 2009")）；以及一般科学主题的散文段落（Karpicke & Roediger, 2006a；Pashler et al, 2003）
- 知识问答/冷知识（trivia；[McDaniel & Fisher 1991](https://gwern.net/doc/psychology/spaced-repetition/1991-mcdaniel.pdf "Tests and Test Feedback as Learning Sources")）
- 小学/初中课程内容，例如传记材料与科学知识（分别参见 [Gates 1917](https://archive.org/details/recitationasafa00gategoog)、[Spitzer 1939](https://gwern.net/doc/psychology/spaced-repetition/1939-spitzer.pdf)[^Spitzer]、Vlach & Sandhofer 2012[^Vlach]）
- Agarwal et al 2008：在教科书段落上，简答题测试优于其他形式
- 历史教科书：先做一次简答题测试相比选择题能获得更好的保持（[Nungester & Duchastel 1982](https://gwern.net/doc/psychology/spaced-repetition/1982-nungester.pdf)）
- [LaPorte & Voss 1975](https://gwern.net/doc/psychology/spaced-repetition/1975-laporte.pdf) 也发现：相比选择题或再认题，保持更好
- [Duchastel & Nungester, 1981](https://gwern.net/doc/psychology/spaced-repetition/1981-duchastel "'Long-term Retention of Prose Following Testing', Duchastel & Nungester 2012")：测试后 6 个月，在一段历史文章的保持上，测试优于学习
- [Duchastel 1981](https://gwern.net/doc/psychology/spaced-repetition/1981-duchastel.pdf)：自由回忆在历史文章阅读理解上显著优于简答题与选择题
- [Glover 1989](https://gwern.net/doc/psychology/spaced-repetition/1989-glover.pdf)：自由回忆式自测优于再认或 [Cloze deletions](!W)；材料是花朵部位的名称标签
- [Kang et al 2007](https://gwern.net/doc/psychology/spaced-repetition/2007-kang.pdf "Test format and corrective feedback modify the effect of testing on long-term retention")：散文段落；初次简答题测试在 3 天后对选择题与简答题两类测验都更优
- [Leeming 2002](https://gwern.net/doc/psychology/spaced-repetition/2002-leeming.pdf "The Exam-A-Day Procedure Improves Performance in Psychology Classes")：在两门心理学课程（导论与记忆/学习）中进行测试；“导论课 80% vs 74%，记忆/学习课 89% vs 80%”^[另见 Balch 2006，对心理学导论课中的间隔 vs 集中进行了比较。]

[^Spitzer]: From Balota et al 2007, describing [Spitzer 1939, "Studies in retention"](https://gwern.net/doc/psychology/spaced-repetition/1939-spitzer.pdf):

    > Spitzer (1939) incorporated a form of expanded retrieval in a study designed to assess the ability of sixth graders to learn science facts. Impressively, Spitzer tested over 3600 students in Iowa-the entire sixth-grade population of 91 elementary schools at the time. The students read two articles, one on peanuts and the other on bamboo, and were given a 25-item multiple choice test to assess their knowledge (such as 'To which family of plants does bamboo belong?'). Spitzer tested a total of nine groups, manipulating both the timing of the test (administered immediately or after various delays) and the number of identical tests students received (one to three). Spitzer did not incorporate massed or equal interval retrieval conditions, but he had at least two groups that were tested on an expanding schedule of retrieval, in which the intervals between tests were separated by the passage of time (in days) rather than by intervening to-be-learned information. For example, in one of the groups, the first test was given immediately, the second test was given seven days after the first test, and the third test was given 63 days after the second test. Thus, in essence, this group was tested on a 0-7-63 day expanding retrieval schedule. Spitzer compared performance of the expanded retrieval group to a group given a single test 63 days after reading the original article. On the first (immediate) test, the expanded retrieval group correctly answered 53% of the questions. After 63 days and two previous tests, their score was still an impressive 43%. The single test group correctly answered only 25% of the original items after 63 days, giving the expanded retrieval group an 18% retention advantage. This is quite impressive, given that this large benefit remained after a 63-day retention interval. Similar beneficial effects were found in a group tested on a 0-1-21 day expanded retrieval schedule compared to a group given a single test after 21 days. Of course, this study does not decouple the effects of testing from spacing or expansion, but the results do clearly indicate considerable learning and retention using the expanded repeated testing procedure. Spitzer concluded that '...examinations are learning devices and should not be considered only as tools for measuring achievement of pupils' (p. 656, italics added)
[^Vlach]: ["Distributing Learning Over Time: The Spacing Effect in Children's Acquisition and Generalization of Science Concepts"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3399982/), Vlach & Sandhofer 2012:

    > The spacing effect describes the robust finding that long-term learning is promoted when learning events are spaced out in time, rather than presented in immediate succession. Studies of the spacing effect have focused on memory processes rather than for other types of learning, such as the acquisition and generalization of new concepts. In this study, early elementary school children (5-7 year-olds; _N_ = 36) were presented with science lessons on one of three schedules: massed, clumped, and spaced. The results revealed that spacing lessons out in time resulted in higher generalization performance for both simple and complex concepts. Spaced learning schedules promote several types of learning, strengthening the implications of the spacing effect for educational practices and curriculum.

这涵盖了相当广泛的、可称为“陈述性知识”的范围。把“测试”扩展到其他领域会更困难，可能就会退化成“经常写很多小分析，而不是偶尔写一篇大分析”，或者“做大量小练习”之类——在不同领域里这可能意味着不同的事：

> A third issue, which relates to the second, is whether our proposal of testing is really appropriate for courses with complex subject matters, such as the philosophy of Spinoza, Shakespeare's comedies, or creative writing. Certainly, we agree that most forms of objective testing would be difficult in these sorts of courses, but we do believe the general philosophy of testing (broadly speaking) would hold-students should be continually engaged and challenged by the subject matter, and there should not be merely a midterm and final exam (even if they are essay exams). Students in a course on Spinoza might be assigned specific readings and thought-provoking essay questions to complete every week. This would be a transfer-appropriate form of weekly 'testing' (albeit with take-home exams). Continuous testing requires students to continuously engage themselves in a course; they cannot coast until near a midterm exam and a final exam and begin studying only then.^[Roediger & Karpicke 2006b again.]

#### 缺点 {#downsides}

测试确实有一些已知缺点：

#. 回忆干扰：记住被测试条目的能力，会挤出对相似但未被测试条目的记忆能力

    大多数/几乎所有研究都在实验室环境进行，并发现效应相对较小：

    > In sum, although various types of recall interference are quite real (and quite interesting) phenomena, we do not believe that they compromise the notion of test-enhanced learning. At worst, interference of this sort might dampen positive testing effects somewhat. However, the positive effects of testing are often so large that in most circumstances they will overwhelm the relatively modest interference effects.
#. 选择题可能会意外引发“负性暗示效应”：如果测试题目里出现过某个错误陈述，你之后更可能相信它。

    若能快速反馈正确答案，此问题可被缓解或消除（见 Butler & Roediger 2008 ["Feedback enhances the positive effects and reduces the negative effects of multiple-choice testing"](https://gwern.net/doc/psychology/spaced-repetition/2008-butler.pdf)）。解决方案：尽量别用选择题；无论如何，在测试能力上它本来也不如自由回忆或简答。

这两个问题看起来都不算严重。

### 分布式练习（间隔） {#distributed}

关键在于你把这些测试放在 *什么时候* 做。上面我们看到：在刚学会某个东西的当下多测试几次会有好处；但同样数量的测试也可以分散到更长时间里，从而形成所谓的*间隔效应*或*间隔重复*。关于间隔效应的研究有数百篇：

- [Cepeda et al 2006](http://uweb.cas.usf.edu/~drohrer/pdfs/Cepeda_et_al_2006PsychBull.pdf "Distributed Practice in Verbal Recall Tasks: A Review and Quantitative Synthesis") 综述了 184 篇论文、317 个实验；其他综述包括：
- Ruch 1928, ["Factors influencing the relative economy of massed and distributed practice in learning"](https://gwern.net/doc/psychology/spaced-repetition/1928-ruch.pdf)
- Crowder 1976, [_Principles of learning and memory_](https://www.amazon.com/Principles-Learning-Memory-Experimental-Psychology/dp/0898591155/)
- Dempster 1989, ["Spacing effects and their implications for theory and practice"](https://gwern.net/doc/psychology/spaced-repetition/1989-dempster.pdf)
- Delaney et al 2010, ["Spacing and testing effects: A deeply critical, lengthy, and at times discursive review of the literature"](https://gwern.net/doc/psychology/spaced-repetition/2010-delaney.pdf)
- Donovan & Radosevich 1999, ["A meta-analytic review of the distribution of practice effect: Now you see it, now you don't"](https://gwern.net/doc/psychology/spaced-repetition/1999-donovan.pdf)
- Greene 1992, [_Human memory: Paradigms and paradoxes_](https://www.amazon.com/Human-Memory-Paradigms-Robert-Greene/dp/080580997X/)
- Janiszewski et al 2003, ["A meta-analysis of the spacing effect in verbal learning: Implications for research on advertising repetition and consumer memory"](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.200.8846&rep=rep1&type=pdf)
- Pavlik & Anderson 2003, ["An ACT-R model of the spacing effect"](http://act-r.psy.cmu.edu/wordpress/wp-content/themes/ACT-R/workshops/2003/proceedings/46.pdf)
- Balota et al 2007, ["Is Expanded Retrieval Practice a Superior Form of Spaced Retrieval? A Critical Review of the Extant Literature"](http://psychnet.wustl.edu/coglab/wp-content/uploads/2015/01/2007-Is-expanded.pdf "'Is Expanded Retrieval Practice a Superior Form of Spaced Retrieval? A Critical Review of the Extant Literature', Balota et al 2015")
- Carpenter et al 2012, ["Using Spacing to Enhance Diverse Forms of Learning: Review of Recent Research and Implications for Instruction"](https://files.eric.ed.gov/fulltext/ED536925.pdf)

几乎一致的结论是：当最终测验/评估发生在几天甚至几年之后时，把测试分散开来要优于集中测试[^superiority]，尽管其机制仍不清晰[^mechanism]。除了前述研究外，还可以补充：

- Peterson, L. R., Wampler, R., Kirkpatrick, M., & Saltzman, D. (1963). ["Effect of spacing presentations on retention of a paired associate over short intervals"](https://gwern.net/doc/psychology/spaced-repetition/1963-peterson.pdf). _Journal of Experimental Psychology_, 66(2), 206-209
- Glenberg, A. M. (1977). ["Influences of retrieval processes on the spacing effect in free recall"](https://gwern.net/doc/psychology/spaced-repetition/1977-glenberg.pdf). _Journal of Experimental Psychology: Human Learning and Memory_, 3(3), 282-294
- Balota et al 1989, ["Age-related differences in the impact of spacing, lag and retention interval"](http://psychnet.wustl.edu/coglab/wp-content/uploads/2015/01/1989-Balota.pdf). _Psychology and Aging_, 4, 3-9

[^mechanism]: Balota et al 2007 的综述基于[记忆编码](!W "Encoding (memory)")，综合了关于“集中 vs 间隔”为何不同的主流理论：

    > According to encoding variability theory, performance on a memory test is dependent upon the overlap between the contextual information available at the time of test and the contextual information available during encoding. During massed study, there is relatively little time for contextual elements to fluctuate between presentations and so this condition produces the highest performance in an immediate memory test, when the test context strongly overlaps with the same contextual information encoded during both of the massed presentations. In contrast, when there is spacing between the items, there is time for fluctuation to take place between the presentations during study, and hence there is an increased likelihood of having multiple unique contexts encoded. Because a delayed test will also allow fluctuation of context, it is better to have multiple unique contexts encoded, as in the spaced presentation format, as opposed to a single encoded context, as in the massed presentation format.

    Storm et al 2010 针对阅读理解做了 3 个实验：

    > On a test 1 week later, recall was enhanced by the expanding schedule, but only when the task between successive retrievals was highly interfering with memory for the passage. These results suggest that the extent to which learners benefit from expanding retrieval practice depends on the degree to which the to-be-learned information is vulnerable to forgetting.

研究文献会*大量*讨论这样一个问题：哪一种“间隔形式”最好、以及这对记忆意味着什么——间隔应该是固定不变的，还是逐渐扩展的？这对于理解记忆与建立模型很重要，也有助于把间隔重复整合进课堂（例如 [Kelley & Whatson 2013](https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2013.00589/full "Making long-term memories in minutes: a spaced learning pattern from memory research in education") 的“学习 10 分钟/休息 10 分钟”模式，重复相同材料 3 次，试图触发该材料块的 LTM 形成）。但从实用角度看，这个问题并不太有意思：概括来说，支持两边的研究都有，而效率差异（如果存在）也很小。大多数软件遵循 SuperMemo 使用“扩展间隔”算法，因此不必为此操心；正如 Mnemosyne 开发者 Peter Bienstman 所说，更复杂的算法是否真的更好并不明确[^Bienstman]；而 Anki 开发者也担心算法复杂度、难以复现 SM 的专有算法、收益不大，以及 SM3+ 为求最优而带来的更大误差风险（见其[说明](https://faqs.ankiweb.net/what-spaced-repetition-algorithm.html)）。这里同理。

[^superiority]: Balota et al 2007 review:

    > No feedback or correction was given to subjects if they made errors or omitted answers. [Landauer & Bjork 1978](https://gwern.net/doc/psychology/spaced-repetition/1978-landauer.pdf "Optimum Rehearsal Patterns and Name Learning") found that the expanding-interval schedule produced better recall than equal-interval testing on a final test at the end of the session, and equal-interval testing, in turn, produced better recall than did initial massed testing. Thus, despite the fact that massed testing produced nearly errorless performance during the acquisition phase, the other two schedules produced better retention on the final test given at the end of the session. However, the difference favoring the expanding retrieval schedule over the equal-interval schedule was fairly small at around 10%. In research following up Landauer and Bjork's (1978) original experiments, practically all studies have found that spaced schedules of retrieval (whether equal-interval or expanding schedules) produce better retention on a final test given later than do massed retrieval tests given immediately after presentation (eg. Cull, 2000; Cull, Shaughnessy, & Zechmeister, 1996), although exceptions do exist. For example, in Experiments 3 and 4 of Cull et al 1996, massed testing produced performance as good as equal-interval testing on a 5-5-5 schedule, but most other experiments have found that any spaced schedule of testing (either equal-interval or expanding) is better than a massed schedule for performance on a delayed test. However, whether expanding schedules are better than equal-interval schedules for long-term retention-the other part of Landauer and Bjork's interesting findings-remains an open question. Balota, Duchek, and Logan (in press) have provided a thorough consideration of the relevant evidence and have shown that it is mixed at best, and that most researchers have found no difference between the two schedules of testing. That is, performance on a final test at the end of a session often shows no difference in performance between equal-interval and expanding retrieval schedules.

    如果你感兴趣，这里还有 Cull（Cull, W. L. (2000). ["Untangling the benefits of multiple study opportunities and repeated testing for cued recall"](https://gwern.net/doc/psychology/spaced-repetition/2000-cull.pdf). _Applied Cognitive Psychology_, 14, 215-235)：

    > Cull (2000) compared expanded retrieval to equal interval spaced retrieval in a series of four experiments designed to mimic typical teaching or study strategies encountered by students. He examined the role of testing versus simply restudying the material, feedback, and various retention intervals on final test performance. Paired associates (an uncommon word paired with a common word, such as bairn-print) were presented in a manner similar to the flashcard techniques students often use to learn vocabulary words. The intervals between retrieval attempts of to-be-learned information ranged from minutes in some experiments to days in others. Interestingly, across four experiments, Cull did not find any evidence of an advantage of an expanded condition over a uniform spaced condition (ie. no [substantial] expanded retrieval effect), although both conditions consistently produced large advantages over massed presentations. He concluded that distributed testing of any kind, expanded or equal interval, can be an effective learning aid for teachers to provide for their students.
[^Bienstman]: 引自 Mnemosyne 的[Principles](https://mnemosyne-proj.org/principles.php) 页面：

    > The Mnemosyne algorithm is very similar to [SM2](https://www.supermemo.com/en/blog/application-of-a-computer-to-improve-the-results-obtained-in-working-with-the-supermemo-method) used in one of the early versions of SuperMemo. There are some modifications that deal with early and late repetitions, and also to add a small, healthy dose of randomness to the intervals. Supermemo now uses SM11. However, we are a bit skeptical that the huge complexity of the newer SM algorithms provides for a statistically relevant benefit. But, that is one of the facts we hope to find out with our data collection. We will only make modifications to our algorithms based on common sense or if the data tells us that there is a statistically relevant reason to do so.

如果你想看“固定间隔优于扩展间隔”的研究，这里列 3 项：

#. Carpenter, S. K., & DeLosh, E. L. (2005). ["Application of the testing and spacing effects to name learning"](https://gwern.net/doc/psychology/spaced-repetition/2005-carpenter.pdf). _Applied Cognitive Psychology_, 19, 619-636[^carpenter]
#. Logan, J. M. (2004). _Spaced and expanded retrieval effects in younger and older adults_. Unpublished doctoral dissertation, Washington University, St. Louis, MO

    这篇论文有趣之处在于：Logan 发现年轻人在一天之后用“扩展间隔”反而明显更差。
#. Karpicke & Roediger, 2006a

先不纠结“固定 vs 扩展”，这里再列一些一般性研究：它们都发现间隔优于集中。

- Cepeda et al 2006 (large review used elsewhere in this page)
- Karpicke & Roediger 2006a
- Rohrer & Taylor 2006. ["The effects of over-learning and distributed practice on the retention of mathematics knowledge"](http://uweb.cas.usf.edu/~drohrer/pdfs/Rohrer&Taylor2006ACP.pdf). _Applied Cognitive Psychology_, 20: 1209–1224 (see also [Rohrer & Taylor 2007](https://gwern.net/doc/psychology/spaced-repetition/2007-rohrer.pdf "The shuffling of mathematics problems improves learning"), [Rohrer et al 2005](https://escholarship.org/content/qt0279q9m1/qt0279q9m1.pdf "The Effect of Overlearning on Long-Term Retention"))
- Seabrook et al 2005. ["Distributed and Massed Practice: From Laboratory to Classroom"](https://gwern.net/doc/psychology/spaced-repetition/2005-seabrook.pdf)
- Keppel, Geoffrey. ["A Reconsideration of the Extinction-Recovery Theory"](https://gwern.net/doc/psychology/spaced-repetition/1967-keppel.pdf). _Journal of Verbal Learning & Verbal Behavior_. 6(4) 1967, 476-486

    一周后，集中复习组从 5.9 个正确降到 2.1；间隔复习组从 5.5 降到 5.0。（这符合常见观察：集中一开始更好，但之后会更糟，甚至不到一半。）
- Bloom & Schuell 1981, ["Effects of massed and distributed practice on the learning and retention of second-language vocabulary"](https://gwern.net/doc/psychology/spaced-repetition/1981-bloom.pdf)

    两个高中生小组记住 16 个法语单词后 4 天，间隔组还能记住 15 个，而集中组为 11 个。
- Rea & Modigliani 1985, ["The effect of expanded versus massed practice on the retention of multiplication facts and spelling lists"](https://gwern.net/doc/psychology/spaced-repetition/1985-rea.pdf)[^multiplication]

    > A test immediately following the training showed superior performance for the distributed group (70% correct) compared to the massed group (53% correct). These results seem to show that the spacing effect applies to school-age children and to at least some types of materials that are typically taught in school.^[[Balota et al 2007](http://psychnet.wustl.edu/coglab/wp-content/uploads/2015/01/2007-Is-expanded.pdf "Is Expanded Retrieval Practice a Superior Form of Spaced Retrieval? A Critical Review of the Extant Literature").]
- Donovan & Radosevich 1999, ["A meta-analytic review of the distribution of practice effect: Now you see it, now you don't"](#donovan-radosevich-1999):

    > According to Donovan & Radosevich's meta-analysis of spacing studies, the [effect size](!W) for the spacing effect is [_d_](https://en.wikipedia.org/wiki/Effect_size#Cohen%27s_d) = 0.42. This means that the average person getting distributed training remembers better than about 67% of the people getting massed training. This effect size is nothing to sneeze at-in education research, effect sizes as low as _d_ = 0.25 are considered "practically significant", while effect sizes above _d_ = 1 are rare.^[Balota et al 2007; >1 is rare in psychology, see ["One Hundred Years of Social Psychology Quantitatively Described"](https://jenni.uchicago.edu/Spencer_Conference/Representative%20Papers/Richard%20et%20al,%202003.pdf), Bond et al 2003]

    > In one meta-analysis by Donovan & Radosevich 1999, for instance, the size of the spacing effect declined sharply as conceptual difficulty of the task increased from low (eg. rotary pursuit) to average (eg. word list recall) to high (eg. puzzle). By this finding, the benefits of spaced practise may be muted for many mathematics tasks.^[Rohrer & Taylor 2006]

    The Donovan meta-analysis notes that the effect size is smaller in studies with better methodology, but still important.
- Bahrick, Harry P; Phelphs, Elizabeth. ["Retention of Spanish vocabulary over 8 years"](https://gwern.net/doc/psychology/spaced-repetition/1987-bahrick.pdf). _Journal of Experimental Psychology: Learning, Memory, & Cognition_. Vol 13(2) April 1987, 344-349; the extremely long delay after the initial training period makes this particularly interesting:

    > Harry Bahrick and Elizabeth Phelps (1987) examined the retention of 50 Spanish vocabulary words after an eight-year delay. Subjects were divided into three groups. Each practiced for seven or eight sessions, separated by a few minutes, a day, or 30 days. In each session, subjects practiced until they could produce the list perfectly one time....Eight years later, people in the no-delay group could recall 6% of the words, people in the one-day delay group could remember 8%, and those in the 30-day group averaged 15%. Everyone also took a multiple choice test, and again, the spacing effect was observed. The no-delay group scored 71%, the one-day group scored 80%, and the 30-day group scored 83%.
    >
    > ...Bahrick and his colleagues varied both the spacing of practice and the amount of practice. Practice sessions were spaced 14, 28, or 56 days apart, and totaled 13 or 26 sessions. They tested subjects' memory one, two, three, and five years after training. Once again, it took a bit longer to reach the criterion within each session when practice sessions were spaced farther apart, but again, this small investment paid dividends years later. It didn't matter whether testing occurred at one, two, three, or five years after practice-the 56-day group always remembered the most, the 28-day group was next, and the 14-day group remembered the least. Further, the effect was quite large. If words were practiced every 14 days, you needed twice as much practice to reach the same level of performance as when words were practiced every 56 days!
- Pashler et al 2003; ["Is Temporal Spacing of Tests Helpful Even When It Inflates Error Rates?"](https://gwern.net/doc/psychology/spaced-repetition/2003-pashler.pdf)

    Long intervals between tests necessarily means you will often err; errors were thought to intrinsically reduce learning. While the extra errors do damage accuracy in the short-run, the long intervals are powerful enough that they still win.
- works in ill subpopulations:
    - works on short-term review conducted with Alzheimer's patients; spacing used on the scale of seconds and minutes, with modest success in teaching object locations or daily tasks to do[^calendar]:

        - Camp, C. J. (1989). "Facilitation of new learning in Alzheimer’s disease". In G. C. Gilmore, P. J. Whitehouse, & M. L. Wykle (Eds.), [_Memory, aging, and dementia_](https://gwern.net/doc/psychology/spaced-repetition/1989-gilmore-memoryaginganddementia.pdf) (pp. 212-225)
        - Camp, C. J., & McKitrick, L. A. (1992). "Memory interventions in Alzheimer's-type dementia populations: Methodological and theoretical issues". In R. L. West & J. D. Sinnott (Eds.), _Everyday memory and aging: Current research and methodology_ (pp. 152-172)        -
    - works with traumatic brain injury; Goverover et al 2009, ["Application of the spacing effect to improve learning and memory for functional tasks in traumatic brain injury: a pilot study"](https://pdfs.semanticscholar.org/0eb4/8078fdc906f368d22f324e0520e4ee4f9c08.pdf)
    - and multiple sclerosis; Goverover et al 2009, ["A functional application of the spacing effect to improve learning and memory in persons with multiple sclerosis"](https://gwern.net/doc/psychology/spaced-repetition/2009-goverover.pdf)
- math[^Rohrer-warning]:

    - multiplication (Ria & Modigliani 1985)
    - [permuting](!W) a sequence (Rohrer & Taylor 2006)on
    - calculating the volume of [polyhedrons](!W) (Rohrer & Taylor 2007)
    - statistics ([Smith & Rothkopf 1984](https://people.tamu.edu/~stevesmith/SmithMemory/SmithRothkopf1984.pdf "Contextual Enrichment and Distribution of Practice in the Classroom"))
    - pre-calculus ([Revak 1997](https://gwern.net/doc/psychology/spaced-repetition/1997-revak.pdf "Distributed practice: More bang for your homework buck")[^pre-calculus] but there's a related [null 'calculus I' result](https://digitalcommons.lib.uconn.edu/dissertations/AAI3464319/) as well) and algebra ([Mayfield & Chase 2002](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1284369/pdf/12102132.pdf "The effects of cumulative practice on mathematics problem solving"), [Patac & Patac 2013](https://gwern.net/doc/psychology/spaced-repetition/2013-patac.pdf "The Analysis of Two Teaching Programs: Massed and Distributed"); possible null, [Sutherland 2013](https://getd.libs.uga.edu/pdfs/sutherland_pierre_201212_ma.pdf "The effects of distributed practice on two grade 10 mathematics classes"))
- medicine ([Kerfoot & Brotschi 2009](https://gwern.net/doc/psychology/spaced-repetition/2009-kerfoot-2.pdf "Online spaced education to teach urology to medical students: a multi-institutional randomized trial"), [Shaw et al 2012](https://qualitysafety.bmj.com/content/21/10/819.abstract "Impact of online education on intern behavior around joint commission national patient safety goals: a randomized trial"); [Kerfoot 2009](https://gwern.net/doc/psychology/spaced-repetition/2009-kerfoot.pdf "Learning Benefits of On-Line Spaced Education Persist for 2 Years"), a 2 year followup to [Kerfoot et al 2007](https://pdfs.semanticscholar.org/f2b5/aed794e5d164065a184207f2663620b96ba3.pdf "Spaced education improves the retention of clinical knowledge by medical students: a randomized controlled trial") and Kerfoot has a number of [other relevant studies](http://app.qstream.com/pricekerfoot); [Gyorki et al 2013](https://gwern.net/doc/psychology/spaced-repetition/2013-gyorki.pdf "Improving the impact of didactic resident training with online spaced education")) and surgery (Moulton et al 2006, ["Teaching Surgical Skills: What Kind of Practice Makes Perfect? A Randomized, Controlled Trial"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1856544/ "'Teaching surgical skills: what kind of practice makes perfect?: a randomized, controlled trial', Moulton et al 2006"), distributed practice of microvascular suturing; [Spruit et al 2014](https://gwern.net/doc/psychology/spaced-repetition/2014-spruit.pdf "Increasing efficiency of surgical training: effects of spacing practice on skill acquisition and retention in laparoscopy training"))
- introductory psychology (Balch 2006, ["Encouraging Distributed Study: A Classroom Experiment on the Spacing Effect"](https://gwern.net/doc/psychology/spaced-repetition/2006-balch.pdf)[^balch]. _Teaching of Psychology_, 33, 249-252)
- 8th-grade American history ([Carpenter, Pashler, and Cepeda 2009](https://laplab.ucsd.edu/articles/CarpenterPashlerCepeda2009.pdf))
- learning to read with phonics (Seabrook et al 2005)
- music ([Stambaugh 2009](https://works.bepress.com/laura_stambaugh/6/download/ "When repetition isn't the best practice strategy: Examining differing levels of contextual interference during practice"))
- biology (middle school; [Kelly & Whatson 2013](https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2013.00589/full "Making long-term memories in minutes: a spaced learning pattern from memory research in education"))
- statistics (introductory; [Maas et al 2015](https://gwern.net/doc/psychology/spaced-repetition/2015-maas.pdf "How Spacing and Variable Retrieval Practice Affect the Learning of Statistics Concepts"))
- memorizing website passwords ([Bonneau & Schechter 2014](https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-bonneau.pdf "Towards Reliable Storage of 56-bit Secrets in Human Memory"), [Blocki et al 2014](https://arxiv.org/abs/1410.1490 "Spaced Repetition and Mnemonics Enable Recall of Multiple Strong Passwords"), [Blum & Vempala 2017](https://arxiv.org/abs/1707.01204 "The Complexity of Human Computation: A Concrete Model with an Application to Passwords"))
- possibly not Australian constitutional law ([Colbran et al 2015](https://gwern.net/doc/psychology/spaced-repetition/2015-colbran.pdf "The impact of student-generated digital flashcards on student learning of constitutional law"))

[^Rohrer-warning]: Rohrer & Taylor 2006 warns us, though, about many of the other math studies:

    > In one meta-analysis by Donovan & Radosevich 1999, for instance, the size of the spacing effect declined sharply as conceptual difficulty of the task increased from low (eg. rotary pursuit) to average (eg. word list recall) to high (eg. puzzle). By this finding, the benefits of spaced practise may be muted for many mathematics tasks.
[^pre-calculus]: What is especially nice about this study was that not only did it use high-quality (intelligent & motivated) college students ([United States Air Force Academy](!W)), the conditions were relatively controlled - both groups had the *same* homework (so equal testing effect), but like Rohrer & Taylor 2006/2007, the *distribution* was what varied:

    > The course topics, textbook, handouts, reading assignments, and graded assignments (with the exception of quiz, homework, and participation points) were identical for the treatment and control groups. The listing of homework assignments in the syllabus differed between groups. The control group was assigned daily homework related to the topic(s) presented that day in class. Peterson (1971) calls this the vertical model for assigning mathematics homework. The treatment group was assigned homework in accordance with a distributed organizational pattern that combines practice on current topics and reinforcement of previously covered topics. Under the distributed model, approximately 40% of the problems on a given topic were assigned the day the topic was first introduced, with an additional 20% assigned on the next lesson and the remaining 40% of problems on the topic assigned on subsequent lessons (Hirsch et al, 1983). In Hirsch's research and in this study, after the initial homework assignment, problem(s) representing a given topic resurfaced on the 2<sup>nd</sup>, 4<sup>th</sup>, 7th, 12th, and 21<sup>st</sup> lesson. Consequently, treatment group homework for lesson one consisted of only one topic; homework for lessons two and three consisted of two topics; and homework for lesson four through six consisted of three topics. This pattern continued as new topics were added and was applied to all non-exam, non-laboratory lessons. As shown by Tables 1 and 2, the same homework problems were assigned to both groups with only the pattern of assignment differing. Because of the nature of the distributed practice model, homework for the treatment group contained fewer problems (relative to the control group) early in the semester with the number of problems increasing as the semester progressed. Later in the semester, homework for the treatment group contained more problems (relative to the control group)....The USAFA routinely collects study time data. After each exam, a large sample of cadets (at least 60% of the course population) anonymously reported the amount of time (in minutes) spent studying for the exam. Time spent studying was approximately equal for both groups (see Table 5). Descriptive data revels that, for both the treatment and control group, study time for the third exam was at least 16% greater than study time for any other exam. Study time for the final exam was at least 68% greater than study time for any of the hourly exams (see Table 5)
    >
    > ...The treatment produced an effect size (f 2) of 0.013 on the first exam, 0.029 on the second exam, 0.035 on the fourth exam, and 0.040 on the final course percentage grade. Although the effect sizes appear to be small, the treatment group outscored the control group in every case. A mean difference of 5.13 percentage points on the first, second, and fourth exam translates to an advantage of about a third of a letter grade for students in the treatment group. In addition, higher minimum scores earned by the treatment group may indicate that the distributed practice treatment served to eliminate the extremely low scores (refer to Table 3)....Oddly, the distributed practice treatment did not produce a [statistically-]significant effect on final exam scores. One possible cause for the disparity was the USAFA policy exempting the top performers from the final exam. Of the 16 exempted students, 11 were from the treatment group with only 5 from the control group.
[^balch]: Balch 2006 abstract:

    > Two introductory psychology classes (_N_ = 145) participated in a counterbalanced classroom experiment that demonstrated the spacing effect and, by analogy, the benefits of distributed study. After hearing words presented twice in either a massed or distributed manner, participants recalled the words and scored their recall protocols, reliably remembering more distributed than massed words. Posttest scores on a multiple-choice quiz covering points illustrated by the experiment averaged about twice the comparable pretest scores, indicating the effectiveness of the exercise in conveying content. Students' subjective ratings suggested that the experiment helped convince them of the benefits of distributed study.
[^carpenter]: Balota et al 2007:

    > Carpenter and DeLosh (2005, Exp. 2) have recently investigated face-name learning under massed, expanded (1-3-5), and equal interval (3-3-3) conditions. This study also involved study and study and test procedures during the acquisition phase. Carpenter and DeLosh found a large effect of spacing, but no evidence of a benefit of expanded over equal interval practice. In fact, Carpenter and DeLosh reported a reliable benefit of the equal interval condition over the expanded retrieval condition.
[^multiplication]: Balota et al 2007 again:

    > Rea & Modigliani 1985 tested the effectiveness of expanded retrieval in a third-grade classroom setting. In separate conditions, students were given new multiplication problems or spelling words to learn. The problem or word was presented audiovisually once and then tested on either a massed retrieval schedule of 0-0-0-0 or an expanding schedule of 0-1-2-4, in which the intervals involved being tested on old items or learning new items. After each test trial for a given item, the item was re-presented in its entirety so students received feedback on what they were learning. Performance during the learning phase was at 100% for both spelling words and multiplication facts. On an immediate final retention test, Rea and Modigliani found a performance advantage for all items-math and spelling- practiced on an expanding schedule compared to the massed retrieval schedule. They suggested, as have others, that spacing combined with the high success rate inherent in the expanded retrieval schedule produced better retention than massed retrieval practice. However, as in Spitzer's study, Rea and Modigliani did not test an appropriate equal interval spacing condition. Hence, their finding that expanded retrieval is superior to massed retrieval in third graders could simply reflect the superiority of spaced versus massed rehearsal-in other words, the spacing effect.
[^calendar]: Balota et al 2007:

    > ...long-term retention of information has been demonstrated over several days in some cases (eg. Camp et al, 1996). For example, in the latter study, Camp et al employed an expanding retrieval strategy to train 23 individuals with mild to moderate AD to refer to a daily calendar as a cue to remember to perform various personal activities (eg. take medication). Following a baseline phase to determine whether subjects would spontaneously use the calendar, spaced retrieval training was implemented by repeatedly asking the subject the question, 'How are you going to remember what to do each day?' at expanding time intervals. The results indicated that 20/23 subjects did learn the strategy (ie. to look at the calendar) and retained it over a 1-week period.

#### Generality of spacing effect

We have already seen that spaced repetition is effective on a variety of academic fields and mediums. Beyond that, spacing effects can be found in:

- various "domains (eg. learning perceptual motor tasks or learning lists of words)"^[See [Cepeda et al 2006](http://uweb.cas.usf.edu/~drohrer/pdfs/Cepeda_et_al_2006PsychBull.pdf "Distributed Practice in Verbal Recall Tasks: A Review and Quantitative Synthesis")] such as spatial^[Commins, S., Cunningham, L., Harvey, D., and Walsh, D. (2003). ["Massed but not spaced training impairs spatial memory"](https://gwern.net/doc/psychology/spaced-repetition/2003-commins.pdf). _Behavioural Brain Research_ 139, 215-223]
- "across species (eg. [rats](https://www.jneurosci.org/content/21/7/2404.long "'Long-term memory is facilitated by cAMP response element-binding protein overexpression in the amygdala', Josselyn et al 2001"), pigeons, and humans \[or [flies](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3044934/ "'Deconstructing Memory in Drosophila', Margulies et al 2005") or [bumblebees](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC311375/ "'Massed and Spaced Learning in Honeybees: The Role of CS, US, the Intertrial Interval, and the Test Interval', Menzel et al 2001"), and sea slugs, [Carew et al 1972](https://gwern.net/doc/psychology/spaced-repetition/1972-carew.pdf "'Long-Term Habituation of a Defensive Withdrawal Reflex in Aplysia', Carew et al 1972") & [Sutton et al 2002](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC155928/ "'Interaction between Amount and Pattern of Training in the Induction of Intermediate-Term and Long-Term Memory for Sensitization in <em>Aplysia</em>', Sutton et al 2002")\])"
- "across age groups [infancy[^Gallucio], childhood[^Toppino], adulthood[^Glenberg], the elderly^[See Kornell et al 2010; [Simone et al 2012](https://gwern.net/doc/psychology/spaced-repetition/2012-simone.pdf "Diminished But Not Forgotten: Effects of Aging on Magnitude of Spacing Effect Benefits") shows the spacing benefits but reduced in magnitude in its 56-74 year old subjects, similar to [Jackson et al 2012](https://www.sciencedirect.com/science/article/abs/pii/S1552526012001318 "Massed versus spaced visuospatial memory in cognitively healthy young and older adults") and [Maddox 2013](http://openscholarship.wustl.edu/cgi/viewcontent.cgi?article=2147&context=etd "The Efficiency of Retrieval Practice as a Function of Spacing and Intrinsic Value in Young and Older Adults")]] and individuals with different memory impairments"
- "and across retention intervals of seconds^[Mammarella, N., Russo, R., & Avons, S. E. (2002). ["Spacing effects in cued-memory tasks for unfamiliar faces and nonwords"](https://gwern.net/doc/psychology/spaced-repetition/2002-mammarella.pdf). _Memory & Cognition_, 30, 1238–1251] [to days^[Childers, J. B., & Tomasello, M. (2002). ["Two-year-olds learn novel nouns, verbs, and conventional actions from massed or distributed exposures"](https://gwern.net/doc/psychology/spaced-repetition/2002-childers.pdf). _Developmental Psychology_, 38, 967-978]] to months" (we have already seen studies using years)

[^Gallucio]: Galluccio & Rovee-Collier 2006, ["Nonuniform effects of reinstatement within the time window"](https://gwern.net/doc/psychology/spaced-repetition/2006-galluccio.pdf). _Learning and Motivation_, 37, 1-17.
[^Toppino]: See the previous sections for many using children; one previously uncited is Toppino 1993, ["The spacing effect in preschool children's free recall of pictures and words"](https://gwern.net/doc/psychology/spaced-repetition/1993-toppino.pdf); but [Toppino et al 2009](https://gwern.net/doc/psychology/spaced-repetition/2009-toppino.pdf "The spacing effect in intentional and incidental free recall by children and adults: Limits on the automaticity hypothesis") adds some interesting qualifiers to spaced repetition in the young:

    > Preschoolers, elementary school children, and college students exhibited a spacing effect in the free recall of pictures when learning was intentional. When learning was incidental and a shallow processing task requiring little semantic processing was used during list presentation, young adults still exhibited a spacing effect, but children consistently failed to do so. Children, however, did manifest a spacing effect in incidental learning when an elaborate semantic processing task was used.
[^Glenberg]: Another previously uncited study: Glenberg, A. M. (1979), ["Component-levels theory of the effects of spacing of repetitions on recall and recognition"](https://link.springer.com/content/pdf/10.3758%2FBF03197590.pdf). _Memory & Cognition_, 7, 95-112.

The domains are limited, however. Cepeda et al 2006:

> [[Moss 1995](http://digitalcommons.usu.edu/cgi/viewcontent.cgi?article=4569&context=etd "The efficacy of masses versus distributed practice as a function of desired learning outcomes and grade level of the student"), reviewing 120 articles] concluded that longer ISIs facilitate learning of verbal information (eg. spelling^[eg. [Fishman et al 1968](https://files.eric.ed.gov/fulltext/ED039222.pdf "Massed versus distributed practice in computerized spelling drills")]) and motor skills (eg. mirror tracing); in each case, over 80% of studies showed a distributed practice benefit. In contrast, only one third of intellectual skill (eg. math computation) studies showed a benefit from distributed practice, and half showed no effect from distributed practice.
>
> ...[Donovan & Radosevich 1999] The largest effect sizes were seen in low rigor studies with low complexity tasks (eg. rotary pursuit, typing, and peg reversal), and retention interval failed to influence effect size. The only interaction Donovan and Radosevich examined was the interaction of ISI and task domain. It is important to note that task domain moderated the distributed practice effect; depending on task domain and lag, an increase in ISI either increased or decreased effect size. Overall, Donovan and Radosevich found that increasingly distributed practice resulted in larger effect sizes for verbal tasks like free recall, foreign language, and verbal discrimination, but these tasks also showed an inverse-U function, such that very long lags produced smaller effect sizes. In contrast, increased lags produced smaller effect sizes for skill tasks like typing, gymnastics, and music performance.

Skills like gymnastics and music performance raise an important point about the testing effect and spaced repetition: they are for the maintenance of memories or skills, they do not increase it beyond what was already learned. If one is a gifted amateur when one starts reviewing, one remains a gifted amateur. Ericsson covers what is necessary to *improve* and attain new expertise: [deliberate practice](!W)^[The famous '10,000 hours of practice' figure may not be as true or important as Ericsson and publicizers like Malcolm Gladwell imply, given the high [variance](!W) of expertise against time, and results from sports showing [smaller](https://web.archive.org/web/20110809203726/http://www.sportsscientists.com/2011/08/talent-training-and-performance-secrets.html "Talent, training and performance: The secrets of success") time investments (see also [Hambrick's corpus](https://scholar.google.com/scholar?q=author%3AHambrick%20%22deliberate%20practice%22) cutting 'deliberate practice' down to size), and Ericsson absurdly deny the powerful role of genetics and the necessary condition of having talent but the insight of 'deliberate practice' helping talented people probably is real.
也许有人能用 3,000 小时而不是 10,000 小时达到目标，但无论如何，这都不可能靠无脑重复（或干脆不重复）做到。]. 引自 [“The Role of Deliberate Practice”](https://gwern.net/doc/psychology/writing/1993-ericsson.pdf "'The role of deliberate practice in the acquisition of expert performance', Ericsson et al 1993")：

> The view that merely engaging in a sufficient amount of practice---regardless of the structure of that practice---leads to maximal performance, has a long and contested history. In their classic studies of Morse Code operators, Bryan and Harter ([1897](https://gwern.net/doc/psychology/spaced-repetition/1897-bryan.pdf "Studies In The Physiology And Psychology Of The Telegraphic Language"), [1899](https://gwern.net/doc/psychology/spaced-repetition/1899-william.pdf "Studies on the telegraphic language: The acquisition of a hierarchy of habits")) identified plateaus in skill acquisition, when for long periods subjects seemed unable to attain further improvements. However, with extended efforts, subjects could restructure their skill to overcome plateaus...Even very experienced Morse Code operators could be encouraged to dramatically increase their performance through deliberate efforts when further improvements were required...More generally, [Thorndike (1921)](https://gwern.net/doc/psychology/spaced-repetition/1921-thorndike-educationalpsychology-v2-thepsychologyoflearning.pdf#page=188 "_Educational Psychology volume 2: The Psychology of Learning_: pg178") observed that adults perform at a level far from their maximal level even for tasks they frequently carry out. For instance, adults tend to write more slowly and illegibly than they are capable of doing...The most cited condition [for optimal learning and improvement of performance] concerns the subjects' motivation to attend to the task and exert effort to improve their performance...The subjects should receive immediate informative feedback and knowledge of results of their performance...In the absence of adequate feedback, efficient learning is impossible and improvement only minimal even for highly motivated subjects. Hence mere repetition of an activity will not automatically lead to improvement in, especially, accuracy of performance...In contrast to play, deliberate practice is a highly structured activity, the explicit goal of which is to improve performance. Specific tasks are invented to overcome weaknesses, and performance is carefully monitored to provide cues for ways to improve it further. We claim that deliberate practice requires effort and is not inherently enjoyable.

##### Motor skills

It should be noted that reviews conflict on how much spaced repetition applies to motor skills; Lee & Genovese 1988 find benefits, while Adams 1987 and earlier do not.
差异可能在于：简单的运动任务会从间隔中获益（如 [Shea & Morgan 1979](https://gwern.net/doc/psychology/spaced-repetition/1979-shea.pdf "Contextual interference effects on the acquisition, retention, and transfer of a motor skill") 所示：随机/间隔的练习安排更有利），而当任务*复杂*到被试已经在能力极限附近运作时，间隔可能就不再带来收益（如 [Wulf & Shea 2002](https://pdfs.semanticscholar.org/c747/336e77ce39f7f5cdbd937684a7f564e9e194.pdf "Principles derived from the study of simple skills do not generalize to complex skill learning") 所暗示）。
Stambaugh 2009 mentions some divergent studies:

> The contextual interference hypothesis (Shea and Morgan 1979, Battig 1966 ["Facilitation and interference" in [_Acquisition of skill_](https://archive.org/details/acquisitionofski00conf)]) predicted the blocked condition would exhibit superior performance immediately following practice (acquisition) but the random condition would perform better at delayed retention testing. This hypothesis is generally consistent in laboratory motor learning studies (eg. [Lee & Magill 1983](https://gwern.net/doc/psychology/spaced-repetition/1983-lee.pdf "The Locus of Contextual Interference in Motor-Skill Acquisition"), [Brady 2004](https://gwern.net/doc/psychology/spaced-repetition/2004-brady.pdf "Contextual interference: a meta-analytic study")), but less consistent in applied studies of sports skills (with a mix of positive & negative eg. [Landin & Hebert 1997](https://gwern.net/doc/psychology/spaced-repetition/1997-landin.pdf "A comparison of three practice schedules along the contextual interference continuum"), Hall et al 1994, [Regal 2013](http://digitalcommons.mtu.edu/cgi/viewcontent.cgi?article=1486&context=etds "Skill Acquisition and the Influence of Attentional Focus and Practice")) and fine-motor skills ([Ollis et al 2005](https://gwern.net/doc/psychology/spaced-repetition/2005-ollis.pdf "The influence of professional expertise and task complexity upon the potency of the contextual interference effect"), [Ste-Marie et al 2004](https://gwern.net/doc/psychology/spaced-repetition/2004-stemarie.pdf "High levels of contextual interference enhance handwriting skill acquisition")).

一些支持“运动技能也受益于间隔”的研究（引自 Son & Simon 2012）：

> Perhaps even prior to the empirical work on cognitive learning and the spacing effect, the benefits of spaced study had been apparent in an array of motor learning tasks, including maze learning (Culler 1912), typewriting (Pyle 1915), archery (Lashley 1915), and javelin throwing (Murphy 1916; see Ruch 1928, for a larger review of the motor learning tasks which reap benefits from spacing; see also Moss 1996, for a more recent review of motor learning tasks). Thus, as in the cognitive literature, the study of practice distribution in the motor domain is long established (see reviews by Adams 1987; Schmidt & Lee 2005), and most interest has centered around the impact of varying the separation of learning trials of motor skills in learning and retention of practiced skills. Lee & Genovese 1988 conducted a review and meta-analysis of studies on distribution of practice, and they concluded that massing of practice tends to depress both immediate performance and learning, where learning is evaluated at some removed time from the practice period. Their main finding was, as in the cognitive literature, that learning was relatively stronger after spaced than after massed practice (although see Ammons 1988; Christina & Shea 1988; Newell et al 1988 for criticisms of the review)...Probably the most widely cited example is Baddeley & Longman 1978's study concerning how optimally to teach postal workers to type. They had learners practice once a day or twice a day, and for session lengths of either 1 or 2 h at a time. The main findings were that learners took the fewest cumulative hours of practice to achieve a performance criterion in their typing when they were in the most distributed practice condition. This finding provides clear evidence for the benefits of spacing practice for enhancing learning. However, as has been pointed out (Newell et al 1988; Lee & Wishart 2005), there is also trade-off to be considered in that the total elapsed time (number of days) between the beginning of practice and reaching criterion was substantially longer for the most spaced condition....The same basic results have been repeatedly demonstrated in the decades since (see reviews by Magill & Hall 1990; Lee & Simon 2004), and with a wide variety of motor tasks including different badminton serves (Goode & Magill 1986), rifle shooting (Boyce & Del Rey 1990), a pre-established skill, baseball batting (Hall et al 1994), learning different logic gate configurations (Carlson et al 1989; Carlson & Yaure 1990), for new users of automated teller machines (Jamieson & Rogers 2000), and for solving mathematical problems as might appear in a class homework (Rohrer & Taylor 2007; Le Blanc & Simon 2008; Taylor & Rohrer 2010).
>
> - Culler, E. A. (1912). ["The effect of distribution of practice upon learning"](https://gwern.net/doc/psychology/spaced-repetition/1912-culler.pdf). _Journal of Philosophical Psychology_, 9, 580-583
> - Pyle, W. H. (1915). ["Concentrated versus distributed practice"](https://books.google.com/books?lr=&id=P8RMAAAAYAAJ&oi=fnd&pg=PA247&ots=ngbgLvHiqb&sig=Dyur1KbbI6Egs4z1lFqm6rYUIqw#v=onepage&q&f=false)
> - Lashley 1915, ["The acquisition of skill in archery"](https://gwern.net/doc/psychology/spaced-repetition/1915-lashley.pdf)
> - Murphy, H. H. (1916). ["Distributions of practice periods in learning"](https://gwern.net/doc/psychology/spaced-repetition/1916-murphy.pdf). Journal of Educational Psychology, 7, 150-162
> - Adams, J. A. (1987). ["Historical review and appraisal of research on the learning, retention, and transfer of human motor skills"](https://gwern.net/doc/psychology/spaced-repetition/1987-adams.pdf)
> - Schmidt, R. A., & Lee, T. D. (2005). [_Motor control and learning: A behavioral emphasis_](https://www.amazon.com/Motor-Control-Learning-Behavioral-Emphasis/dp/0880114843/) (4th ed.). Urbana-Champaign: Human Kinetics
> - Lee, T. D., & Genovese, E. D. (1988). ["Distribution of practice in motor skill acquisition: Learning and performance effects reconsidered"](https://gwern.net/doc/psychology/spaced-repetition/1988-lee.pdf). Research Quarterly for Exercise and Sport, 59, 277-287
> - Ammons, R. B. (1988). ["Distribution of practice in motor skill acquisition: A few questions and comments"](https://gwern.net/doc/psychology/spaced-repetition/1988-ammons.pdf). Research Quarterly for Exercise and Sport, 59, 288-290
> - Christina, R. W., & Shea, J. B. (1988). ["The limitations of generalization based on restricted information"](https://gwern.net/doc/psychology/spaced-repetition/1988-christina.pdf). Research Quarterly for Exercise and Sport, 59, 291-297
> - Newell, K. M., Antoniou, A., & Carlton, L. G. (1988). ["Massed and distributed practice effects: Phenomena in search of a theory?"](https://gwern.net/doc/psychology/spaced-repetition/1988-newell.pdf) Research Quarterly for Exercise and Sport, 59, 308-313
> - Lee, T. D., & Wishart, L. R. (2005). ["Motor learning conundrums (and possible solutions)"](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.574.5400&rep=rep1&type=pdf)
> - Lee, T. D., & Simon, D. A. (2004). ["Contextual interference"](https://gwern.net/doc/psychology/spaced-repetition/2004-lee.pdf "'Chapter 2: Contextual interference', Lee & Simon 2004")
> - Goode, S., & Magill, R. A. (1986). ["Contextual interference effects in learning three badminton serves"](https://gwern.net/doc/psychology/spaced-repetition/1986-goode.pdf). Research Quarterly for Exercise and Sport, 57, 308-314
> - Boyce,, & Del Rey, P. (1990). "Designing applied research in a naturalistic setting using a contextual interference paradigm". Journal of Human Movement Studies, 18, 189-200
> - Hall et al 1994, ["Contextual interference effects with skilled baseball players"](https://gwern.net/doc/psychology/spaced-repetition/1994-hall.pdf)
> - Carlson, R. A., & Yaure, R. G. (1990). ["Practice schedules and the use of component skills in problem solving"](https://gwern.net/doc/psychology/spaced-repetition/1990-carlson.pdf)
> - Carlson, R. A., Sullivan, M. A., & Schneider, W. (1989). ["Practice and working memory effects in building procedural skill"](https://gwern.net/doc/psychology/spaced-repetition/1989-carlson.pdf)
> - Jamieson,, & Rogers, W. A. (2000). ["Age-related effects of blocked and random practice schedules on learning a new technology"](https://gwern.net/doc/psychology/spaced-repetition/2000-jamieson.pdf)
> - Le Blanc, K. & Simon, D. A. (2008). "Mixed practice enhances retention and JOL accuracy for mathematical skills". Poster presented at the 2008 annual meeting of the Psychonomic Society, Chicago, IL
> - Wymbs et al 2016, ["Motor Skills Are Strengthened through Reconsolidation"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4747782/)
> - Dayan & Cohen 2011, ["Neuroplasticity subserving motor skill learning"](https://www.sciencedirect.com/science/article/pii/S0896627311009184)
> - Landin et al 1993, ["The Effects of Variable Practice on the Performance of a Basketball Skill"](https://gwern.net/doc/psychology/spaced-repetition/1993-landin.pdf)

顺着这个思路，还有一个有趣的点：交错练习（interleaving）对带有认知成分的技能任务也可能有帮助：[Hatala et al 2003](https://gwern.net/doc/psychology/spaced-repetition/2003-hatala.pdf "Practice Makes Perfect: The Critical Role of Mixed Practice in the Acquisition of ECG Interpretation Skills")、[Helsdingen et al 2011](https://pdfs.semanticscholar.org/7e0c/1bb80cbc332f07bda26a75a163a9cf76d591.pdf "The effects of practice schedule and critical thinking prompts on learning and transfer of a complex judgment task")；并且根据 [Huang et al 2013](https://jeffhuang.com/papers/HaloLearning_CHI13.pdf "Mastering the Art of War: How Patterns of Gameplay Influence Skill in Halo")，Xbox 游戏 _[Halo: Reach](!W)_ 玩家技能提升的速率与“练习分布”的预测相当吻合：每周玩 4--8 局的人，每局的技能增量更大（更分布）；但每周的总提升又慢于每周玩更多局（更集中）的人。
(See also [Stafford & Haasnoot 2016](https://eprints.whiterose.ac.uk/97780/ "Testing sleep consolidation in skill learning: a field study using an online game").)

##### Abstraction

另一种可能的反对意见是：有人会主张^[Gentner, D., Loewenstein, J., & Thompson, L. (2003). ["Learning and transfer: A general role for analogical encoding"](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.58.2647&rep=rep1&type=pdf). _Journal of Educational Psychology_, 95, 393-40]，间隔重复在本质上会妨碍抽象学习与思考，因为相关材料不会同时呈现（无法便于比较与推断），而是相隔数天甚至数月。Ernst A. Rothkopf 说：“间隔是回忆的朋友，却是归纳的敌人”（Kornell & Bjork 2008, p. 585）。基于一些早期研究，这种说法似乎有道理[^abstraction]；但我所知直接检验该问题的 4 项较新研究都发现：间隔重复不仅有助于一般回忆，也有助于抽象能力：

[^abstraction]: From Kornell et al 2010:

    > The benefits of spacing seem to diminish or disappear when to-be-learned items are not repeated exactly ([Appleton-Knapp, Bjork, & Wickens, 2005](https://gwern.net/doc/psychology/spaced-repetition/2005-appletonknapp.pdf "Examining the Spacing Effect in Advertising: Encoding Variability, Retrieval Processes, and Their Interaction"))...a number of studies have shown that massing, rather than spacing, promotes inductive learning. These studies have generally employed relatively simple perceptual stimuli that facilitate experimental control ([Gagné, 1950](https://gwern.net/doc/psychology/spaced-repetition/1950-gagne.pdf "The effect of sequence of presentation of similar items on the learning of paired associates"); [Goldstone, 1996](https://pcl.sitehost.iu.edu/rgoldsto/interrelated/interrelated.html); [Kurtz & Hovland, 1956](https://gwern.net/doc/psychology/spaced-repetition/1956-kurtz.pdf); [Whitman J. R., & Garner, W. R. (1963). "Concept learning as a function of the form of internal structure". _Journal of Verbal Learning & Verbal Behavior_, 2, 195-202]).

#. Kornell & Bjork 2008a, ["Learning concepts and categories: Is spacing the 'enemy of induction'?"](https://gwern.net/doc/psychology/spaced-repetition/2008-kornell.pdf) _Psychological Science_, 19, 585-592
#. Vlach, H. A., Sandhofer, C. M., & Kornell, N. (2008). ["The spacing effect in children's memory and category induction"](https://gwern.net/doc/psychology/spaced-repetition/2008-vlach.pdf). _Cognition_, 109, 163-167
#. Kenney 2009. ["The Spacing Effect in Inductive Learning"](http://akenney.fastmail.fm.user.fm/works/9.61Paper.pdf)
#. Kornell, N., Castel, A. D., Eich, T. S., & Bjork, R. A. (2010). ["Spacing as the friend of both memory and induction in younger and older adults"](https://pdfs.semanticscholar.org/be1a/70be5a6f990cd86804ccc1be29331556ddfc.pdf). _Psychology and Aging_, 25, 498-503
#. [Zulkiply et al 2011](https://gwern.net/doc/psychology/spaced-repetition/2011-zulkiply.pdf "Spacing and induction: Application to exemplars presented as auditory and visual text")
#. Vlach & Sandhofer 2012, ["Distributing Learning Over Time: The Spacing Effect in Children's Acquisition and Generalization of Science Concepts"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3399982/), _Child Development_
#. Zulkiply 2012, ["The spacing effect in inductive learning"](https://espace.library.uq.edu.au/view/UQ:281052); includes:

    - replication of Kornell & Bjork 2008
    - Zulkiply et al 2011
    - Zulkiply & Burt 2012, ["The exemplar interleaving effect in inductive learning: Moderation by the difficulty of category discriminations"](https://gwern.net/doc/psychology/spaced-repetition/2012-zulkiply.pdf)
    - unknown paper currently in peer review
#. McDanie et al 2013, ["Effects of Spaced versus Massed Training in Function Learning"](https://laplab.ucsd.edu/articles/McDaniel.Fadler.Pashler2013.pdf)
#. Verkoeijen & Bouwmeester 2014, ["Is spacing really the 'friend of induction'?"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3978334/)
#. Rohrer et al 2014: [1](https://gwern.net/doc/psychology/spaced-repetition/2014-rohrer.pdf "The benefit of interleaved mathematics practice is not limited to superficially similar kinds of problems"), [2](https://gwern.net/doc/psychology/spaced-repetition/2014-rohrer-2.pdf "Interleaved Practice Improves Mathematics Learning"); Rorher et al 2019: ["A randomized controlled trial of interleaved mathematics practice"](https://gwern.net/doc/psychology/spaced-repetition/2019-rohrer.pdf)
#. Vlach et al 2014, ["Equal spacing and expanding schedules in children's categorization and generalization"](https://gwern.net/doc/psychology/spaced-repetition/2014-vlach.pdf "'Equal spacing and expanding schedules in childrenâ€™s categorization and generalization', Vlach et al 2014")
#. Gluckman et al, ["Spacing Simultaneously Promotes Multiple Forms of Learning in Children's Science Curriculum"](https://gwern.net/doc/psychology/spaced-repetition/2014-gluckman.pdf)

### 综述要点 {#review-summary}

把前面内容汇总成几条要点：

- 测试确实有效，并且[负面因素](#downsides)很少
- 扩展间隔大致不逊于（较大跨度的）固定间隔，甚至可能更好；而扩展更方便，也是默认选择
- 测试（因此也包括间隔）在“智力性、事实性强、偏语言”的领域效果最好，但在许多更低层级的领域也可能奏效
- 研究更偏好那些尽可能迫使用户动用记忆的问题；按偏好从高到低依次为：

    #. free recall
    #. short answers
    #. multiple-choice
    #. Cloze deletion
    #. recognition
- 研究文献相当全面，多数问题在某处都已经有过回答。
- 间隔重复最常见的错误包括：

    #. 题目与答案写得很差
    #. 以为它能“替你学习”，而不是“维护与保存你已经学过的东西”^[High error rates - indicating one didn't actually learn the card contents in the first place - seem to be connected to failures of the spacing effect; there's [some evidence](https://www.columbia.edu/cu/psychology/metcalfe/PDFs/Son2010.pdf) that people naturally choose to mass study when they don't yet know the material.].（从卡片 *直接学新东西* 很难；但如果你已经学过某个主题，再围绕自己的薄弱点设计一组抽认卡就容易得多。）

## 使用方法 {#using-it}

当然，你不一定非要用 SuperMemo；免费的替代品很多。
我个人更喜欢 [Mnemosyne](!W "Mnemosyne (software)")（[主页](https://mnemosyne-proj.org/)）：它是[自由软件](!W "Free software")，在 [Ubuntu Linux](!W) 上有现成包，易用，有免费的移动端客户端，并且开发历史很长、可靠性不错（我从 ~2008 年开始用）。
不过，SRS 软件 [Anki](!W "Anki (software)") 也很流行；它的优势在于功能更丰富、社区更大且更活跃（并且可能对东亚语言材料支持更好，同时移动端客户端更好但为专有软件）。

好，但关键问题来了：到底该怎么用？这其实出乎意料地难。它有点像“空白页的暴政”（或空白 wiki）：当你突然拥有了这么强的力量——一个机械魔像，既不会忘记，也绝不会让你忘掉你选择记住的东西——那你到底该选择记住什么？

### 该加多少内容 {#how-much-to-add}

最困难的事情之一（除了坚持到收益变得明显）是：决定什么东西值得被加入。
在 3 年跨度里，平均而言，每一条目大约会消耗你[“30--40 秒”](https://super-memory.com/articles/programming.htm "SuperMemo as a new tool increasing the productivity of a programmer. A case study: programming in Object Windows")。
更长期的[理论预测](https://super-memory.com/articles/theory.htm)则会复杂一些。
对于单个条目，其每日耗时的公式为：Time = 1⁄500 × <em>n</em>thYear<sup>−1.5</sup> + 1⧸30,000。在第 20<sup>th</sup> 年，我们每天花费 _t_ = 1⁄500 × 20<sup>−1.5</sup> + 1⧸3,000，约为 `3.557e-4` 分钟。这是平均每日时间；要得到年度耗时，只需乘以 365。
假设我们关心一张抽认卡在 20 年里总共会花掉我们多少时间。平均每日时间每年都在变化（记得那张图看起来像指数衰减），因此需要对每一年计算一次并累加；用 Haskell 表示：

~~~{.Haskell}
sum $ map (\year -> ((1/500 * year ** (-(1.5))) + 1/30000) * 365.25) [1..20]
# 1.8291
~~~

计算结果为 1.8 分钟。（这看起来也许太小了，但第一年本来就花不了多少时间，而且耗时会迅速下降^[20 年的序列大致如下（注意[科学记数法](!W)）：`[0.742675, 0.27044575182838654, 0.15275979054767388, 0.10348750000000001, 7.751290630254386e-2, 6.187922936397532e-2, 5.161829250474865e-2, 4.445884397854832e-2, 3.923055555555555e-2, 3.5275438307530015e-2, 3.219809429218694e-2, 2.9748098818459235e-2, 2.7759942051635768e-2, 2.6120309801216147e-2, 2.474928593068675e-2, 2.35890625e-2, 2.2596898475825956e-2, 2.1740583401051353e-2, 2.0995431241707652e-2, 2.0342238287817983e-2]`].）例如，[Anki 用户 muflax](https://gwern.net/doc/psychology/spaced-repetition/2012-muflax-dreamingofaworldundone.html.maff "Dreaming of a World Undone")的统计给出每张卡 71 秒。但也许 [Piotr Woźniak](!W "Piotr Wozniak (researcher)") 过于乐观，或者我们不擅长[编写抽认卡](https://www.supermemo.com/en/blog/twenty-rules-of-formulating-knowledge)，所以我们把它翻倍，按 5 分钟估算。于是得到一个关键的经验法则，用来决定“记什么/忘什么”：如果在你一生中，你会花超过 5 分钟去查某个东西，或因为不知道它而损失超过 5 分钟，那么就值得用间隔重复把它记住。5 分钟是区分无用冷知识与有用数据的界线。[^memorizing]（符合“5 分钟规则”的卡片可能会有成千上万张，这没关系。间隔重复可以容纳数万张卡。见[下一节](#the-workload)。）

[^memorizing]: modulo things where knowing it is useful even if you don't need it often - it can be a brick in a pyramid of knowledge; cf. [page 3](https://www.wired.com/2008/04/ff-wozniak/ "‘Want to Remember Everything You’ll Ever Learn? Surrender to This Algorithm’, Wolf 2008") of Wolf:

     > The problem of forgetting might not torment us so much if we could only convince ourselves that remembering isn't important. Perhaps the things we learn - words, dates, formulas, historical and biographical details - don't really matter. Facts can be looked up. That's what the Internet is for. When it comes to learning, what really matters is how things fit together. We master the stories, the schemas, the frameworks, the paradigms; we rehearse the lingo; we swim in the episteme.
     >
     > The disadvantage of this comforting notion is that it's false. "The people who criticize memorization - how happy would they be to spell out every letter of every word they read?" asks Robert Bjork, chair of UCLA's psychology department and one of the most eminent memory researchers. After all, Bjork notes, children learn to read whole words through intense practice, and every time we enter a new field we become children again. "You can't escape memorization," he says. "There is an initial process of learning the names of things. That's a stage we all go through. It's all the more important to go through it rapidly." The human brain is a marvel of associative processing, but in order to make associations, data must be loaded into memory.

另外一个常见问题是：当你很赶时间时，应该用间隔重复还是集中重复？在什么样的考试/截止日期距离下，你应该放弃间隔重复？这很难精确比较，因为你需要一套明确的训练方案来找“交叉点”。但对于集中重复而言，平均来看，“记住之后还能以 50% 概率回忆出来”的时间大约是 3--5 天。^[见 Stephen R. Schmidt 的网页[“Theories of Forgetting”](https://frank.itlab.us/forgetting/mtsu_forgetting/#II.%20Decay%20Theory)，其中引用了 ‘Woodworth & Schlosbeg (1961)’，并给出多项研究遗忘曲线的[对数图](https://gwern.net/doc/psychology/spaced-repetition/1961-woodworth-forgettingcurveovertimein5studies.jpg)。] 在那段时间里你大概能做 2--3 次重复，因此实际回忆率很可能高于 50%。于是可以给出一个好记的经验法则：“5 分钟/5 天规则”：如果你需要它早于 5 天，或者它价值低于 5 分钟，就别用间隔重复。

#### 过载 {#overload}

间隔重复并不是无限可扩展的。
Wozniak 估计，人最多能学到大约[~300,000 个条目](https://supermemo.guru/wiki/How_much_knowledge_can_human_brain_hold)。

间隔重复新用户的常见经历是：一开始加得太多——尽是琐碎小事或自己并不真正在乎的东西。但他们很快就会体会到 [Borges](!W "Jorge Luis Borges") 的 [Funes the Memorious](!W) 式诅咒：如果你并不想真正学会你塞进来的材料，你很快就会停止每日复习；一旦停止，复习会迅速堆积；堆积又更让人泄气，于是更不想做，最终彻底放弃。至少在健身这件事上，没有一个精确到令人绝望的数字告诉你“你落后了多少”！不过，如果一开始加得太少，你每天的重复也会很少，难以从技术本身感受到明显收益——看起来就只是无聊的抽认卡复习。

### 添加什么 {#what-to-add}

我发现 Mnemosyne 的最佳用途之一，除了经典的学术材料记忆（如地理、元素周期表、外语词汇、《圣经》/《古兰经》经文、以及医学院海量事实）之外，是加入一些来自 [A Word A Day](!W)^[这也顺便解决了这类邮件列表“无用”的问题（‘谁会只看一眼就学会一个新词？’）。]与 [Wiktionary](!W) 的单词、我看到的令人印象深刻的引文^[此时 Mnemosyne 既是一种让我学会并能使用这些引文的方式，也是一种[摘录本/随手本](!W "Notebook (style)")；就在前几天我写一篇文章时能随手用上 3--4 条恰当引文，就是因为我在几个月或几年前把它们录进了 Mnemosyne。]、个人信息（如生日；或者车牌号——这曾是我的一个问题），等等。
这些都是日常用途，但对我而言都很有价值。
当抽认卡足够多样化时，我会觉得每日复习很有趣：一会儿我在判断一段 Haskell 代码是否语法正确；一会儿我在读韩文 [hangul](!W) 并听答案的发音；一会儿我在地图上找乌克兰；一会儿我在欣赏 [A.E. Housman](!W) 的诗；随后又冒出来几条来自 [LessWrong](https://www.lesswrong.com/) 引用帖的句子……诸如此类。
其他人还会用它做很多别的事情；一个让我觉得“简单但很有用”的应用是[记住学生的姓名与面孔](https://www.lesswrong.com/posts/YbCc3NRrr5avvWSHT/who-wants-to-start-an-important-startup?commentId=CyxaAxbokswt6ZyPh)（见[这里](https://www.lesswrong.com/posts/YbCc3NRrr5avvWSHT/who-wants-to-start-an-important-startup?commentId=RC2TbuNbD9sXTiH9e)与[这里](https://www.lesswrong.com/posts/YbCc3NRrr5avvWSHT/who-wants-to-start-an-important-startup?commentId=qPQGQd6E3hZ5DsLz4)）；另外，用它来[学习音高/音名](https://gwern.net/doc/psychology/spaced-repetition/2012-chessdata-perfectpitchspacedrepetition.webm "Perfect Pitch (Absolute Pitch) training with Mnemosyne (spaced repetition software) [original: https://www.youtube.com/watch?v=y3F7cTEL4b8]")也不坏。

### 工作量 {#the-workload}

平均而言，当我在学习一个新主题时，我每天会新增 3--20 个问题。结合我自身的记忆情况，我通常每天复习大约 90 或 100 个条目（总量 >18,300）。这通常花费不到 20 分钟，并不算糟糕。（我猜我的耗时被略微拉长了：早期我的排版规范还在逐步成形，分类体系也不如现在完整，所以我时不时需要停下来修改分类。）

如果我最近没有学新东西，复习数量会因为指数式衰减而缓慢下降。
例如在 2011 年 3 月，我没怎么学新内容，于是 2011-03-24--2011-03-26 这三天的计划复习量分别是 73、83、74；之后它可能会降到六十多，再过一两周降到五十多……直到触及一个最低平台，而这个平台会在多年尺度上继续缓慢缩小。
（我还没有长时间停止新增卡片到足以知道最低平台会是多少。）
到 2012 年 2 月，由于类似原因，每日复习量降到四十多、偶尔五十多；但这种缓慢下降仍会继续。

如果让 Mnemosyne 2.0 画出未来一年（直到 2013 年 2 月）每天需要复习的卡片数量（假设不再新增、也不漏复习等），我们就能非常直观地看到这一点；甚至还能看到一种“遗忘曲线”的类比形态：

![预测的每日卡片数量：波动很大但总体明显下降](https://gwern.net/doc/psychology/spaced-repetition/gwern-scheduled-cards.png){.invert}

如果 Mnemosyne 不使用间隔重复，要跟上 18,300+ 张抽认卡会非常困难。
但正因为它使用了间隔重复，跟上进度反而很轻松。

而且，18.3k 也并不算夸张。
许多用户的牌组在 6--7k 之间；Mnemosyne 开发者 [Peter Bienstman](https://groups.google.com/g/mnemosyne-proj-users/c/QzhysVWtdFE) 有 >8.5k，Patrick Kenny 有 >27k，[Hugh Chen](https://groups.google.com/g/mnemosyne-proj-users/c/7_RPX9sdc4s) 有 73k+；在 `irc://irc.libera.chat#anki` 里，他们甚至告诉我有人用 >200k 的牌组触发过 bug。
200,000 也许有点过头，但对普通人而言，“更小一些的规模”似乎是可能的——把 SRS 牌组与[背诵《失乐园》](https://gwern.net/doc/psychology/spaced-repetition/2010-seamon.pdf "'Memorising Milton's Paradise Lost: A study of a septuagenarian exceptional memoriser', Seamon et al 2010")这类壮举相比很有意思；或者对比穆斯林的称号 ['hafiz'](!W "Hafiz (Qur’an)")：背下约 80,000 词的《古兰经》；更严格的 'hafid' 则不仅背下《古兰经》，还背下 100,000 条 [hadiths](!W)。
还有一些记忆形式更为强大。[^visualization]
（我怀疑间隔重复也参与了少数有充分记录的“[超忆症](!W)”案例之一：[Jill Price](!W)。读一读 _Wired_ 的文章[_“Total Recall: The Woman Who Can't Forget”_](https://web.archive.org/web/20131208072327/https://www.wired.com/medtech/health/magazine/17-04/ff_perfectmemory?currentPage=all)：在没有观察到解剖学差异的情况下，她在突发要求下的记忆能力仍然是普通且会出错的，并且能力范围局限在“个人生活史与某些类别（如电视和空难）”；此外，她具有强迫特质的囤积倾向，保留了 >50,000 页的详细日记——也许源于童年创伤——几乎会不由自主地把日常事件与过去事件联想起来。
Marcus 说，其他超忆症案例也与 Price 类似。）

[^visualization]: It's well known that any speaker of a language understands many more words than they will ever use or be able to explicitly generate, that their "reading vocabulary" exceeds their "writing vocabulary"; less well-known is that on many problems, one can guess at well above random rates even while feeling unsure & ignorant, necessitating psychologists to employ forced-choice paradigms to reveal such ["dark knowledge"](https://gwern.net/doc/psychology/dark-knowledge/index). Even less known is the capacity of [recognition memory](!W) or "implicit memory" (cf. [McCollough effect](!W)); this memory can apply to things like recognizing images or text or music, typing, puzzle solving, etc. Andrew Drucker, in ["Multiplying 10-digit numbers using Flickr: The power of recognition memory"](https://people.csail.mit.edu/andyd/rec_method.pdf), employs visual memory to calculate 9,883,603,368 × 4,288,997,768 = 42,390,752,785,149,282,624; he cites as precedent [Standing 1973](https://gwern.net/doc/psychology/spaced-repetition/1973-standing.pdf "Learning 10,000 pictures"):

    > In one of the most widely-cited studies on recognition memory, Standing showed participants an epic 10,000 photographs over the course of 5 days, with 5 seconds' exposure per image. He then tested their familiarity, essentially as described above. The participants showed an 83% success rate, suggesting that they had become familiar with about 6,600 images during their ordeal. Other volunteers, trained on a smaller collection of 1,000 images selected for vividness, had a 94% success rate.

    One sometimes sees people argue that something is insecure or unguessable or free from possible placebo effect because it involves too many objects to explicitly memorize, but as these examples make clear, recognition memory can happen quickly and store surprisingly large amounts of information. This could be used for authentication (see for example [Bojinov et al 2012](https://www.usenix.org/conference/usenixsecurity12/technical-sessions/presentation/bojinov "Neuroscience Meets Cryptography: Designing Crypto Primitives Secure Against Rubber Hose Attacks"); [HN](https://news.ycombinator.com/item?id=4266115) [discussion](https://news.ycombinator.com/item?id=8952341)) or message since recognition memory could be exploited as a sort of secure communication system. Two parties can share a set of 20,000 photographs (10,000 pairs); to send a message, have a messenger spend 5 days on 10,000 picked ones; and then to receive it, ask him to recognize which photograph he saw in each of the 10,000 pairs. The subject not only does not know what the binary message is or what means, he can't even produce it since he cannot remember the photographs!

    At an 80% accuracy rate, we can even calculate how many bits of information can be entrusted to the messenger using [Shannon's theorem](!W); a calculation gives 5.8 kilobits as the upper limit: if _p_ = 0.2 (based on the 80% success rate), then 10000 / (1 − (_p_ × log~2~ _p_ + (1 − _p_) × (log~2~ (1 − _p_)))) = 5,807.44. (This message can, of course, be encrypted.)

    So we see that [Frank Herbert](!W) was right after all: the securest way to send a message is through a ["distrans" messenger](https://dune.fandom.com/wiki/Distrans)! (The downside is that the implicit recognition memory decays; see [Landauer 1986](https://gwern.net/doc/cs/algorithm/information/1986-landauer.pdf "How Much Do People Remember? Some Estimates of the Quantity of Learned Information in Long-term Memory") for adjusted estimates.)

    This system is even more interesting because the learning happens unconsciously, without volition, so the subject does not need to cooperate nor even know about it (they could be exposed to key images without realizing it, such as through 'advertising'). Further, recognition of an image also happens unconsciously, and can be observed by [EEG](https://gwern.net/doc/psychology/neuroscience/2007-rugg.pdf "‘Event-related potentials and recognition memory’, Rugg & Curran 2007") [ERPs](!W "Event-related potential") & fMRI (and probably other [neural correlates](https://scholar.google.com/scholar?as_sdt=0%2C21&q=%22recognition+memory%22+neurological+correlate) or modalities like [eyetracking](!W) or [skin galvanic response](!W)). Thus, messages can be stored & retrieved both *unconsciously & involuntarily* in brains!

### 何时复习 {#when-to-review}

应该什么时候复习？早上？晚上？随便什么时候？展示间隔效应的研究通常并不会控制或操纵一天中的具体时间，因此从某种意义上说答案是：无所谓——如果时间真的很关键，那么不同研究安排被试复习的时间不同，间隔效应的强弱就会出现很大的差异。

所以，就在最方便的时间复习即可。方便意味着你更可能坚持；而“能坚持”会压过任何短暂的微小改进。

如果你对“随便什么时候都行”这个答案不满意，那么从一般性的考虑出发，你更应该在睡前复习然后入睡。[记忆巩固](!W "Memory consolidation#Spacing effect")似乎与之相关，而[睡眠](!W "Sleep and memory")被认为会强烈影响哪些记忆进入长期记忆：它会[强化](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033079 "Memory for Semantically Related and Unrelated Declarative Information: The Benefit of Sleep, the Cost of Wake")那些靠近睡前学习的材料，并且还能[提升创造力](https://www.pnas.org/doi/full/10.1073/pnas.0900271106 "'REM, not incubation, improves creativity by priming associative networks', Cai et al 2009")；即使不影响总睡眠时长或质量，只要打断睡眠也会[损害小鼠的记忆形成](https://www.pnas.org/doi/10.1073/pnas.1015633108)[^polyphasic]。因此，睡前复习可能是最佳选择。（其他脑力训练也常见“睡前训练更好”的现象，例如 [[dual _n_-back](/dnb-faq#sleep)]{#gwern-dnb-faq}。）一种可能机制是：只要对未来复习/测验产生[*期待*](https://www.jneurosci.org/content/31/5/1563.full "Sleep Selectively Enhances Memory Expected to Be of Future Relevance")，就足以在睡眠中促进记忆巩固；所以如果你复习完就去睡，期待强度可能高于“早餐时复习、经历一天的活动、最后完全忘掉自己复习过什么抽认卡”的情况。（另见 Hartwig & Dunlosky 2012 中“学习时间与 GPA”的相关性。）神经生长也可能有关；引自 Stahl 2010：

> Recent advances in our understanding of the neurobiology underlying normal human memory formation have revealed that learning is not an event, but rather a process that unfolds over time.^[16](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1876761/ "'Neurogenesis and the spacing effect: Learning over time enhances memory and the survival of new neurons', Sisti et al 2007"),[17](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3650827/ "'Reconsolidation: maintaining memory relevance', Lee 2009"),[18](https://gwern.net/doc/psychology/spaced-repetition/2010-oneill.pdf "'Play it again: reactivation of waking experience and memory', O'Neill et al 2010"),[Squire\ 2003\ _[Fundamental\ Neuroscience](https://www.amazon.com/Fundamental-Neuroscience-Second-Larry-Squire/dp/0126603030/)_],[20](http://davidjf.free.fr/new/Xtech_scientific%20american_%20making%20memories%20stick.pdf "'Making Memories Stick', Fields 2005")^ Thus, it is not surprising that learning strategies that repeat materials over time enhance their retention.^20,[21](https://gwern.net/doc/psychology/spaced-repetition/1980-glenberg.pdf "'Spacing repetitions over 1 week', Glenberg & Lehmann 1980"),[22](https://gwern.net/doc/psychology/spaced-repetition/1991-toppino.pdf "'The effect of spacing repetitions on the recognition memory of young children and adults', Toppino et al 1991"),[23](https://gwern.net/doc/psychology/spaced-repetition/1978-landauer.pdf "'Optimum rehearsal patterns and name learning', Landauer & Bjork 1978"),[24](http://www.wsu.edu/~fournier/Teaching/psych592/Readings/Karpicke_et_al_2008.pdf "'The Critical Importance of Retrieval for Learning', Karpicke & Roediger 2008"),[25](https://pdfs.semanticscholar.org/6698/bf91c9333faa0d333a800254b8063230d4f4.pdf "'Optimizing retrieval as a learning event: When and why expanding retrieval practice enhances long-term retention', Storm et al 2010"),[26](https://gwern.net/doc/psychology/spaced-repetition/2007-pashler.pdf "'Enhancing learning and retarding forgetting: Choices and consequences', Pashler et al 2007")^
>
> ...Thousands of new cells are generated in this region every day, although many of these cells die within weeks of their creation.^[31](https://pdfs.semanticscholar.org/45c2/7c08fbb43f8728e69a7447366d4a4f74e088.pdf "'Adult neurogenesis produces a large pool of new granule cells in the dentate gyrus', Cameron & McKay 2001")^ The survival of dentate gyrus neurons has been shown to be enhanced in animals when they are placed into learning situations.^16-20^ Animals that learn well retain more dentate gyrus neurons than do animals that do not learn well. Furthermore, 2 weeks after testing, animals trained in discrete spaced intervals over a period of time, rather than in a single presentation or a 'massed trial' of the same information, remember better.^16-20^ The precise mechanism that links neuronal survival with learning has not yet been identified. One theory is that the hippocampal neurons that preferentially survive are the ones that are somehow activated during the learning process.^16-20^^[For a more recent review, see [Philips et al 2013](https://gwern.net/doc/psychology/spaced-repetition/2013-philips.pdf "Pattern and predictability in memory formation: From molecular mechanisms to clinical relevance").] The distribution of learning over a period of time may be more effective in encouraging neuronal survival by allowing more time for changes in gene expression and protein synthesis that extend the life of neurons that are engaged in the learning process.
>
> ...Transferring memory from the encoding stage, which occurs during alert wakefulness, into consolidation must thus occur at a time when interference from ongoing new memory formation is reduced.^17,18^ One such time for this transfer is during sleep, especially during non-rapid eye movement sleep, when the hippocampus can communicate with other brain areas without interference from new experiences.^[32](https://pdfs.semanticscholar.org/d0a7/f06ed267f3193daab1175a65abb7a067bef4.pdf "'Sleep, Learning, and Dreams: Off-line Memory Reprocessing', Stickgold et al 2001"),[33](https://pdfs.semanticscholar.org/77fd/0cf03de8a6c4f56c5decc7c47ebe69cf98c1.pdf "'The contribution of sleep to hippocampus-dependent memory consolidation', Marshall & Born 2007"),[34](https://gwern.net/doc/psychology/spaced-repetition/2001-maquet.pdf "'The Role of Sleep in Learning and Memory', Maquet et al 2001")^ Maybe that is why some decisions are better made after a good night's rest and also why pulling an all-nighter, studying with sleep deprivation, may allow you to pass an exam an hour later but not remember the material a day later.

[^polyphasic]: 说到这里，我想起一位前[多相睡眠者](!W "Polyphasic sleep")在 LessWrong 上[对我说](https://www.lesswrong.com/posts/p7CrByygeAqomsJqy/optimizing-sleep?commentId=LsuDzoEcksvGMp9Tt)的[一段话](https://www.lesswrong.com/posts/p7CrByygeAqomsJqy/optimizing-sleep?commentId=6nmQ5W7XucdXTqwJL)：

    > I've been polyphasic for about a year. (Not anymore; kills my memory.)...Anki reps, mostly. I found that I could do proper review sessions for about 2--3 days and would hit an impenetrable wall. I couldn't learn a single new card and had total brain fog until I got 3 hours more sleep. That, however, would reset my adaptation. The whole effect is a bit less pronounced on Everyman, but not much. It is however easier to add sleep when you already have a core. I didn't notice any other major mental impairment after the initial sleep deprivation.

#### 展望：扩展型抽认卡 {#prospects-extended-flashcards}

让我们先退后一步想想：我们那些大大小小的抽认卡到底在为我们做什么？例如，我为什么要在众多卡片里为单词 'anent' 做一对卡片？我明明可以直接查词典。

但相较于“已经知道”，查找是需要时间的。（先忽略前面讨论过的 5 分钟规则。）如果用计算机科学的抽象视角来看，这对应的是算法与优化里一个老概念——[空间-时间权衡](!W)。我们用有限的大脑存储空间，换取更少的查找时间。

以我们前面举过的事实数据为例：也许有一天我们需要知道檀香山或奥斯汀的年平均降雨量，但把所有城市的这类数据都背下来会占用太多空间。英语单词有数百万个，但在实践中，记住超过 100,000 个往往就已经过量。
更令人惊讶的是一种“程序性知识”。在计算机里，空间-时间权衡的一个极端形式是：把计算替换为预先计算好的常量。我们可以拿一个数学[函数](!W "Function (mathematics)")，为每一个可能的输入都计算出输出；于是就得到一个从输入到输出的[查找表](!W)。这种表通常非常大：想想看，如果要覆盖 1 到 10 亿之间所有整数乘法组合，这张表得有多少条目？但有时这张表又很小（如二元布尔函数），或不算大（如三角函数表），或虽然很大但依然有用（[彩虹表](!W)通常从 GB 起步，很容易涨到 TB）。

如果我们拥有一张无限大的查找表，那么我们就可以用它来*完全*替代加法或乘法这种技能：不需要计算，只要查表即可。这就是把空间-时间权衡推到“空间端”极致。（当然也可以反过来：把乘法/加法定义成一种完全不知道任何特定事实（如[乘法表](!W)）的缓慢计算过程——仿佛每次算 2+2 都要掰四根手指去数。）

那么，假设我们是想学乘法的孩子。乘法不是某个具体事实点，所以 SRS/Mnemosyne 就帮不上忙吗？空间-时间权衡告诉我们：我们可以把“乘法”去程序化（de-proceduralize），把它部分转化为事实点。我们完全可以写个小脚本或宏，例如生成 500 张随机卡片，让我们计算 AB×XY，然后导入 Mnemosyne。^[大概会立刻把它们都打一个很高的分数（比如 5），避免突然一段时间内每天要复习 500 张卡。]

毕竟，你的大脑会选择哪条路——擅长“当场算两个数相乘”（按需生成），还是记住 500 道不同的乘法题（[记忆化](!W)）？根据我在“同一张卡的多个细微变体”上的经验，大脑在试了几次后就会放弃死记硬背，转而回到“解题策略”——而在这个场景下，这恰恰就是你想训练的东西。恭喜，你做到了看似不可能的事。

从软件工程角度看，我们可能想修改/改进卡片；而 500 段文本更新起来会有点麻烦。最酷的做法是“动态卡片”（dynamic card）：增加一种标记，比如 `<eval src="​">`，然后 Mnemosyne 把 `src` 参数直接喂给 Python 解释器；解释器返回一个包含“问题文本”和“答案文本”的[元组](!W)。问题照常展示给用户，用户思考、请求答案、给自己打分。
在 Anki 中，应用本身就支持在 HTML `<script>` 标签里直接写 JavaScript（目前[仅支持内联](https://docs.ankiweb.net/templates/styling.html#javascript)，但理论上 Anki 也可以默认导入库），例如用来做各种[语法高亮](https://www.ojisanseiuchi.com/2016/03/12/JavaScript-in-Anki-cards/ "JavaScript in Anki cards")；因此你可以写出各种你想要的动态卡片。

以乘法为例，动态卡片可以随机取两个整数，打印出问题 `x * y = ?`，再把结果作为答案输出。你会不断遇到新的乘法题；随着你对乘法越来越熟练，你就会更少看到它——这正是你应该看到的行为。再举一个偏[数学](https://www.reddit.com/r/math/comments/hvqzd/printable_math_flashcards_in_pdf_and_latex_source/c1yror5/)的例子：你可以生成公式或程序的多个变体，其中一个正确、其他几个“微妙地错误”；我在编程抽认卡里会手工这么做（尤其当我做练习时犯错，通常意味着有个细节值得拆成多张卡），但这也可以自动化。[kpreid](https://www.lesswrong.com/posts/3r4GETDPMf335HfpA/memory-spaced-repetition-and-life?commentId=Mpc8rgQC4THkh38SF) [描述](https://www.lesswrong.com/posts/3r4GETDPMf335HfpA/memory-spaced-repetition-and-life?commentId=Mpc8rgQC4THkh38SF)了他的一个工具：

> I have written [a program](https://github.com/kpreid/mathquiz/) (in the form of [a web page](https://kpreid.github.io/mathquiz/mathquiz.html)) which does a specialized form of this [generating 'damaged formulas']. It has a set of generators of formulas and damaged formulas, and presents you with a list containing several formulas of the same type (eg. ∫ 2x dx = x^2 + C) but with one damaged (eg. ∫ 2x dx = 2x^2 + C).

这种思路可以推广到任何“你能生成随机题目”或“你拥有大量题库”的领域。
Khan Academy 似乎就做了类似的事：把大量（可能是算法生成的？）题目关联到每个小模块，并追踪该技能的保持情况，以决定何时需要再次复习该模块。
例如，你也许在学围棋并想掌握[死活题](!W "Life and death")：这些可以由围棋程序生成，或从 [GoProblems.com](https://www.goproblems.com/) 等网站获取。还可以做更多变体：围棋具有旋转对称性——棋盘怎么转，最佳着法通常不变；而且不像国际象棋那样有一个“棋盘的标准朝向”，所以一个好棋手应该能在任意朝向下都读出同样的棋。因此每个具体例题都可以再镜像出 3 个等价变体。你还可以写一个动态卡片，用它来测试自己“读棋”的能力：对每个例题棋局随机加一些棋子，只要像 [GNU Go](!W) 这样的围棋程序判断“加入噪声后最佳着法不变”，就保留该变体。

用这种方式可以学习非常多的东西。编程语言也可以这样学：学习 [Haskell](!W "Haskell (programming language)") 的人可以把 Prelude 或教材里列出的所有函数拿出来，让 [QuickCheck](!W) 为函数生成随机参数，再让 [GHC](!W "Glasgow Haskell Compiler") 的解释器 `ghci` 计算出“函数+参数”的结果。围棋之外的游戏也可能适用，例如国际象棋（在线例子包括 [Chess Tempo](http://chesstempo.com/user-guide/en/probSearchSpacedRepetition.html) 与 [Listudy](https://listudy.org/en "With Listudy you can improve your chess skills with the help of spaced repetition. Better train openings, endgames and tactics with the help of systematic repetition.")；另见 [Dan Schmidt](https://dfan.org/blog/2013/07/07/mnemosyne-part-3/ "I'll mostly discuss my experience using it for chess, since that's what the majority of my 8000 cards are...") 的经验；或者 [_Super Smash Brothers_](https://blog.waleedkhan.name/smash-training-retrospective/ "Smash Training retrospective")）。相当多的数学也可以。如果动态卡片能访问互联网，它就能从 [RSS feed](!W) 或网站拉取新题；在外语学习里，这可能很有用：每天都带来一句新的句子供你翻译，或一项新的练习。

配合一些 NLP 软件，还可以写出测试各种能力的动态抽认卡：例如如果你常把动词变位搞混，程序可以使用类似 "\$PRONOUN \$VERB \$PARTICLE \$OBJECT % {right: caresse, wrong: caresses}" 的模板，生成诸如 "Je caresses le chat" 或 "Tu caresse le chat" 的卡片，然后你需要判断变位是否正确。（这种动态性有助于避免你记住具体句子，而不是掌握底层变位规则。）从完全一般性角度看，这可能很难，但像模板这种简化方案也许已经足够好。Jack Kinsella：

> I wish there were dynamic SRS decks for language learning (or other disciplines). Such decks would count the number of times you have reviewed an instance of an underlying grammatical rule or an instance of a particular piece of vocabulary, for example its singular/plural/third person conjugation/dative form. These sophisticated decks would present users with fresh example sentences on every review, thereby preventing users from remembering specific answers and compelling them to learn the process of applying the grammatical rule afresh. Moreover, these decks would keep users entertained through novelty and would present users with tacit learning opportunities through rotating vocabulary used in non-essential parts of the example sentence. Such a system, with multiple-level review rotation, would not only prevent against overfit learning, but also increase the total amount of knowledge learned per minute, an efficiency I'd gladly invest in.

尽管这些看起来更像“技能”而不是“数据”！

# 普及度 {#popularity}

截至 2011-05-02：

<div class="table-small">
 Metric            Mnemosyne            [Mnemododo][] [Anki][]                iSRS        [AnyMemo][]
---------------    -------------------- ---------     ----------       --------------    ------------------
 Homepage Alexa    [383k][]             [27.5m][]     [112k][]                           [1,766k][][^alexa]
 ML/forum members  [461][]                            [4129][]/[215][] [129][]
 Ubuntu installs   [7k][]                             [9k][]
 Debian installs   [164][]                            [364][]
 Arch votes        [85][]                             [96][]
 iPhone ratings    Unreleased[^imnemo]                [193][]          [69][]
 Android ratings                        [20][]        [703][]                            [836][]
 Android installs                       [100-500][]   [10-50k][]                         [50-100k][FANTASTIC]

[Mnemododo]: https://www.tbrk.org/software/mnemododo.html
[Anki]: !W "Anki (software)"
[AnyMemo]: https://anymemo.org/
[383k]: https://web.archive.org/web/20140723063333/https://www.alexa.com/siteinfo/mnemosyne-proj.org
[112k]: https://web.archive.org/web/20140723063317/https://www.alexa.com/siteinfo/ankisrs.net
[27.5m]: https://web.archive.org/web/20140723063456/https://www.alexa.com/siteinfo/tbrk.org
[1,766k]: https://web.archive.org/web/20140723063242/https://www.alexa.com/siteinfo/anymemo.org
[461]: https://groups.google.com/g/mnemosyne-proj-users
[4129]: https://groups.google.com/group/ankisrs/
[215]: https://groups.google.com/group/ankisrs-users/about
[129]: https://groups.google.com/g/isrs-support
[7k]: https://popcon.ubuntu.com/universe/by_inst
[9k]: https://popcon.ubuntu.com/unknown/by_inst
[164]: https://qa.debian.org/popcon.php?package=mnemosyne
[364]: https://qa.debian.org/popcon.php?package=anki
[85]: https://aur.archlinux.org/packages/mnemosyne
[96]: https://aur.archlinux.org/packages/anki20-bin
[193]: https://apps.apple.com/us/app/ankimobile-flashcards/id373493387
[69]: https://web.archive.org/web/20191122005113/https://apps.apple.com/app/isrs-free/id332350042
[20]: https://www.tbrk.org/software/mnemododo.html
[703]: https://play.google.com/store/apps/details?id=com.ichi2.anki
[836]: https://play.google.com/store/apps/details?id=org.liberty.android.fantastischmemo
[100-500]: https://www.tbrk.org/software/mnemododo.html
[10-50k]: https://play.google.com/store/apps/details?id=com.ichi2.anki
[FANTASTIC]: https://play.google.com/store/apps/details?id=org.liberty.android.fantastischmemo
</div>

SuperMemo 不在同一套评价体系下，但在过去 20 年里，它的销量达到数十万份：

> Biedalak is CEO of SuperMemo World, which sells and licenses Wozniak's invention. Today, SuperMemo World employs just 25 people. The venture capital never came through, and the company never moved to California. About 50,000 copies of SuperMemo were sold in 2006, most for less than [$30]($2006). Many more are thought to have been pirated.^[[_Wired_](https://www.wired.com/2008/04/ff-wozniak/ "‘Want to Remember Everything You’ll Ever Learn? Surrender to This Algorithm’, Wolf 2008")]

一个相对稳妥的估计是：Anki、Mnemosyne、iSRS 等 SRS 应用合计的用户量可能低于 50,000（考虑到重复安装、安装后弃用等因素）。从 SuperMemo 迁移到这些新程序的用户似乎相对不多，因此把“SuperMemo 的 50k”与“其他程序的 50k”简单相加、得出全球用户量约为（但大概率低于）100,000，似乎也算合理。

[^alexa]: 数字越小越好。
[^imnemo]: ["For Mnemosyne 2.x, Ullrich is working on an official Mnemosyne iPhone client which will have very easy syncing."](https://groups.google.com/g/mnemosyne-proj-users/c/W74Pzq712rU)

# 我想说什么来着？ {#where-was-i-going-with-this}

其实也没想说什么。Mnemosyne/间隔重复软件只是我最喜欢的工具之一：它基于科学发现的著名效应[^proudest]，并以优雅[^me]且实用的方式加以利用。它体现了启蒙时代那种“以理性改善人类、克服自身缺陷”的理想；间隔重复在数学严谨性上也颇具诱惑力[^splendor]。在这个“自我提升”和进步常被嘲讽、连普通人都倾向于悲观的时代，日常生活里能有这样一个小例子，确实让人欣慰——它还没有像电灯泡那样变得过分日常与乏味。

[^proudest]: See [Page 4](https://www.wired.com/2008/04/ff-wozniak/ "‘Want to Remember Everything You’ll Ever Learn? Surrender to This Algorithm’, Wolf 2008"), Wolf 2008:

     > The spacing effect was one of the proudest lab-derived discoveries, and it was interesting precisely because it was not obvious, even to professional teachers. The same year that Neisser revolted, Robert Bjork, working with Thomas Landauer of Bell Labs, published the results of two experiments involving nearly 700 undergraduate students. Landauer and Bjork were looking for the optimal moment to rehearse something so that it would later be remembered. Their results were impressive: The best time to study something is at the moment you are about to forget it. And yet - as Neisser might have predicted - that insight was useless in the real world.
[^me]: When I first read of SuperMemo, I had already taken a class in [cognitive psychology](!W) and was reasonably familiar with Ebbinghaus's forgetting curve - so my reaction to its methodology was Huxley's: "How extremely stupid not to have thought of that!"
[^splendor]: See [page 7](https://www.wired.com/2008/04/ff-wozniak/ "‘Want to Remember Everything You’ll Ever Learn? Surrender to This Algorithm’, Wolf 2008"), Wolf 2008

     > And yet now, as I grin broadly and wave to the gawkers, it occurs to me that the cold rationality of his approach may be only a surface feature and that, when linked to genuine rewards, even the chilliest of systems can have a certain visceral appeal. By projecting the achievement of extreme memory back along the forgetting curve, by provably linking the distant future - when we will know so much - to the few minutes we devote to studying today, Wozniak has found a way to condition his temperament along with his memory. He is making the future noticeable. He is trying not just to learn many things but to warm the process of learning itself with a draft of utopian ecstasy.

# 参见 {#see-also}

在使用 Mnemosyne 的过程中，我写过一些脚本来生成“带重复变化”的卡片。

- [`mnemo.hs`](/haskell/mnemo.hs)：输入任意按行分隔的文本块（如一首诗），生成所有可能的 [Cloze deletion](!W)。比如一首 ABC 诗会变成 3 个问题：\_BC/ABC、A\_C/ABC、AB\_/ABC。
- [`mnemo2.hs`](/haskell/mnemo2.hs)：类似上面，但更受限，适用于较长文本（否则 `mnemo.hs` 会导致组合爆炸）。它生成一个子集：对于 ABCD，会得到 \_\_CD/ABCD、A\_\_D/ABCD、AB\_\_/ABCD（它删除两行，并在列表中迭代）。
- [`mnemo3.hs`](/haskell/mnemo3.hs)：用于日期或姓名类问题。输入形如 "Barack Obama is %47%."，会生成类似问题："Barack Obama is \_7./47"、"Barack Obama is 4\_./47" 等。
- [`mnemo4.hs`](/haskell/mnemo4.hs)：用于很长的条目列表。比如要背美国总统列表，自然会出现类似问题：“第 3<sup>rd</sup> 任总统是谁？/Thomas Jefferson”、“Thomas Jefferson 是第 \_ 任总统。/3”、“John Adams 之后的总统是谁？/Thomas Jefferson”、“James Madison 之前的总统是谁？/Thomas Jefferson”。

    你会注意到：如果对每一位总统都这样出题，会有大量重复——需要双向询问序号（条目→序号、序号→条目），还要问它的前驱与后继。`mnemo4.hs` 给定一个列表即可自动化这些问题。为了通用性，它的措辞略显别扭，但总比手写省事得多！（示例输出在源码的[注释](!W "Comment (computer programming)")里。）

读到这里，读者很可能会好奇：*我的* Mnemosyne 数据库是什么样的。
我使用 Mnemosyne 很多；截至 2020-02-02，我的牌组里有 16,149 张（活跃）卡片。
如果你感兴趣，可以在 [`gwern.cards`](https://gwern.net/doc/psychology/spaced-repetition/2019-02-03-gwern-mnemosyne-export.cards.xz) 找到我的卡片与媒体（52M；Mnemosyne 2.x 格式）。

<!-- the metadata:
Gwern’s flashcards (~2008–2019)
gwern
gwern@gwern.net
English, Japanese, Korean, Haskell, R, Python, statistics, China, quotes, philosophy (ancient & modern), etc.
revision: 6 (increment each time)
-->

Mnemosyne 项目多年来一直在收集用户提交的间隔重复统计数据。截至 2014-01-27 的完整数据集，任何想要分析的人都可以[下载](https://groups.google.com/g/mnemosyne-proj-users/c/tPHlkTFVX_4/m/oF61BF44iQkJ "Mnemosyne data set available")。

# 外部链接 {#external-links}

<span id="further-reading"></span>

- Michael Nielsen: ["Augmenting Long-term Memory"](https://augmentingcognition.com/ltm.html); ["Quantum computing for the very curious"](https://quantum.country/qcvc); ["How can we develop transformative tools for thought?"](https://numinous.productions/ttft/ "'How Can We Develop Transformative Tools For Thought?', Matuschak & Nielsen 2019")
- ["A Year of Spaced Repetition Software in the Classroom"](https://www.lesswrong.com/posts/Ww2dxwWpSfkQB4NZb/a-year-of-spaced-repetition-software-in-the-classroom); [two years](https://www.lesswrong.com/posts/dtCfxYubZgRnEkGpQ/a-second-year-of-spaced-repetition-software-in-the-classroom); [seven year followup](https://www.lesswrong.com/posts/F6ZTtBXn2cFLmWPdM/seven-years-of-spaced-repetition-software-in-the-classroom-1); cf. ["Easy Application of Spaced Practice in the Classroom"](https://theeffortfuleducator.com/2017/10/22/easy-application-of-spaced-practice-in-the-classroom/)
- [AJATT table of contents](https://www.alljapaneseallthetime.com/blog/all-japanese-all-the-time-ajatt-how-to-learn-japanese-on-your-own-having-fun-and-to-fluency/) -(applying SRS to learning Japanese)
- **Math**:

    - ["Using spaced repetition systems to see through a piece of mathematics"](https://cognitivemedium.com/srs-mathematics), Michael Nielsen
    - ["Teaching linear algebra"](https://bentilly.blogspot.com/2009/09/teaching-linear-algebra.html) (with spaced repetition), by Ben Tilly; [Manual flashcards for his 2^nd^ grader](https://bentilly.blogspot.com/2012/10/my-sons-flashcard-routine.html)
    - ["How I Rewired My Brain to Become Fluent in Math"](https://nautil.us/how-i-rewired-my-brain-to-become-fluent-in-math-rd-235086/) ([HN](https://news.ycombinator.com/item?id=8402859))
    - ["How I use Anki to learn mathematics"](https://www.lesswrong.com/posts/8ZugMc4E5959Xh86i/how-i-use-anki-to-learn-mathematics)
    - ["Spaced Repetition for Mathematics"](https://cronokirby.com/posts/2021/02/spaced-repetition-for-mathematics/)
- **Programming**:

    - ["SuperMemo as a new tool increasing the productivity of a programmer. A case study: programming in Object Windows"](https://super-memory.com/articles/programming.htm)
    - ["Janki Method: Using spaced repetition systems to learn and retain technical knowledge"](https://www.jackkinsella.ie/articles/janki-method) ([Reddit discussion](https://www.reddit.com/r/programming/comments/n30hl/janki_method_learning_programming_with_6000/)); [SRS problems & solutions](https://www.jackkinsella.ie/articles/autodidactism)
    - ["Memorizing a programming language using spaced repetition software"](https://sive.rs/srs) (Derek Sivers; [HN](https://news.ycombinator.com/item?id=5015183))
    - [learning text editor shortcuts](https://www.shortcutfoo.com/blog/introducing-interval-training-for-shortcuts)
    - ["Learning Go with flashcards and spaced repetition"](https://blog.developer.atlassian.com/golang-flashcards-and-spaced-repetition/)
    - ["Chasing 10X: Leveraging A Poor Memory In Engineering"](https://web.archive.org/web/20200209152222/https://senrigan.io/blog/chasing-10x-leveraging-a-poor-memory-in-software-engineering/); ["Everything I Know: Strategies, Tips, and Tricks for Anki"](https://web.archive.org/web/20200209014707/https://senrigan.io/blog/everything-i-know-strategies-tips-and-tricks-for-spaced-repetition-anki/)
    - ["Remembering R---Using Spaced Repetition to finally write code fluently"](https://empiria.io/blog/remembering-r-with-spaced-repetition/)
    - ["Anki as Learning Superpower: Computer Science Edition"](https://www.gresearch.com/news/anki-as-learning-superpower-computer-science-edition/)
- ["QS Primer: Spaced Repetition and Learning"](https://quantifiedself.com/blog/spaced-repetition-and-learning/) -(talks on applications of spaced repetition)
- Value compared to curriculums:

    #. Point: ["Why Forgetting Can Be Good"](https://www.scotthyoung.com/blog/2012/08/05/forgetting-is-good/), by Scott H. Young
    #. Counterpoint: ["Spaced repetition in natural and artificial learning"](https://web.archive.org/web/20130920193543/http://blog.learnstream.org/2012/08/spaced-repetition-in-natural-and-artificial-learning/), by Ryan Muller

    My own observation is that an optimally constructed curriculum *could* effectively implement spaced repetition, but even if it did (most don't), unless it is computerized it will not adapt to the user.
- ["Ditch the 10,000 hour rule! Why Malcolm Gladwell's famous advice falls short; Contrary to what the bestselling author would tell you, obsessive practice isn't the key to success. Here's why"](https://www.salon.com/2014/04/20/ditch_the_10000_hour_rule_why_malcolm_gladwells_famous_advice_falls_short/)
- ["How to Memorize the Quran and Never Forget it"](https://web.archive.org/web/20220510221945/https://www.ummah.com/forum/forum/library/learn-arabic-and-other-languages/qur-an-and-islamic/390413-how-to-memorize-the-quran-and-never-forget-it?381181-How-to-Memorize-the-Quran-and-Never-Forget-it=)
- [Bash scripts](https://groups.google.com/g/mnemosyne-proj-users/c/_RC55gH7DrY) for generating vocabulary flashcards (processing multiple online dictionaries, good for having multiple examples; images; and audio)
- vocabulary selection:

    #. ["Programmed Vocabulary Learning as a Traveling Salesman Problem"](https://jtauber.com/blog/2004/11/26/programmed_vocabulary_learning_as_a_travelling_salesman_problem/)
    #. ["Teaching New Testament Greek"](https://jtauber.com/blog/2006/05/05/teaching_new_testament_greek/)
    #. [graded-reader](http://graded-reader.org/): ["A New Kind of Graded Reader"](https://jtauber.com/blog/2008/02/10/a_new_kind_of_graded_reader/) (video talk)
    #. [Mailing list](https://groups.google.com/g/graded-reader)
    #. [Programs](https://code.google.com/archive/p/graded-reader)
- ["Diff revision: diff-based revision of text notes, using spaced repetition"](https://web.archive.org/web/20220119182149/https://www.fsavard.com/flow/2012/12/diff-revision/)
- Hacker News discussion: [1](https://news.ycombinator.com/item?id=6461936), [2](https://news.ycombinator.com/item?id=7539390), [3](https://news.ycombinator.com/item?id=8183220)
- ["A vote against spaced repetition"](https://www.lesswrong.com/posts/As9E3HfgED2zkTAfB/a-vote-against-spaced-repetition); ["How Flashcards Fail: Confessions of a Tired Memory Guy"](https://yourawesomememory.com/how-flashcards-fail-confessions-of-a-tired-memory-guy/)
- ["Learning Ancient Egyptian in an Hour Per Week with Beeminder"](https://blog.beeminder.com/hieroglyphs/)
- ["Anki, 10000 Cards Later: How my Anki usage has evolved"](https://rs.io/anki-tips/ "Anki Tips: What I Learned Making 10,000 Flashcards")
- "Using Anki with Babies / Toddlers": [1](https://www.reddit.com/r/Anki/comments/5ixzzx/anki_for_babies/ "'Anki for Babies', caffeine214 2016-12-18"), [2](https://www.reddit.com/r/Anki/comments/8iydl7/using_anki_with_babies_toddlers/ "'Using Anki with Babies / Toddlers', caffeine314 2018-05-12"), [2](https://www.reddit.com/r/Anki/comments/a9wqau/using_anki_with_babies_toddlers_update/ "'Using Anki with Babies / Toddlers [Update]', caffeine314 2018-12-27"), [4](https://www.reddit.com/r/Anki/comments/eit54e/starting_my_175_year_old_on_anki/ "'Starting my 1.75 year old on Anki', caffeine314 2020-01-02")

    - [followup at age 5](https://chrislakin.blog/p/spaced-repetition-for-teaching-two "Spaced repetition for teaching two-year olds how to read (Interview)") (cf. [mutualism](https://gwern.net/doc/iq/2006-vandermaas.pdf "‘A dynamical model of general intelligence: The positive manifold of intelligence by mutualism’, Maas et al 2006"))
    - ["SuperMemo does not work for kids"](https://supermemo.guru/wiki/SuperMemo_does_not_work_for_kids), Piotr Wozniak
- [Duolingo](https://www.duolingo.com/) [uses spaced repetition](https://www.quora.com/Do-you-have-any-plans-for-optimizing-Duolingos-vocabulary-learning-using-spaced-repetition)
- ["Everything You Thought You Knew About Learning Is Wrong"](https://www.wired.com/2012/01/everything-about-learning/)
- [SeRiouS](https://www.spacedrepetition.com/): ["Spaced Repetition Technology for Legal Education"](http://conference.cali.org/2014/sessions/spaced-repetition-technology-legal-education), ["SeRiouS: an LPTI-supported Project to Improve Students' Learning and Bar Performance"](https://sites.suffolk.edu/legaltech/2014/03/11/serious-an-lpti-supported-project-to-improve-students-learning-and-bar-performance/), Gabe Teninbaum ([video presentation](https://www.youtube.com/watch?v=dtClgl07lg8))
- ["The role of digital flashcards in legal education: theory and potential"](https://www.ejlt.org/index.php/ejlt/article/view/320/424), Colbran et al 2014
- ["Why We Should Memorize [Poetry]"](https://www.newyorker.com/books/page-turner/why-we-should-memorize)
- ["Studying for the Test by Taking It"](https://www.nytimes.com/2014/11/23/sunday-review/studying-for-the-test-by-taking-it.html)
- ["Making Summer Count: How Summer Programs Can Boost Children's Learning"](https://www.rand.org/content/dam/rand/pubs/monographs/2011/RAND_MG1120.pdf), McCombs et al 2011 (RAND MG1120)
- [_Learning Medicine: An Evidence-Based Guide_](https://www.learningmedicinebook.com/)
- ["Factors that Influence Skill Decay And Retention: a Quantitative Review and Analysis"](https://gwern.net/doc/psychology/spaced-repetition/1998-arthur.pdf), Arthur et al 1998
- ["On The Forgetting Of College Academics: At 'Ebbinghaus speed'?"](https://cbmm.mit.edu/sites/default/files/publications/CBMM%20Memo%20068-On%20Forgetting%20-%20June%2018th%202017%20v2.pdf), Subirana et al 2017
- ["Total recall: the people who never forget; An extremely rare condition may transform our understanding of memory"](https://www.theguardian.com/science/2017/feb/08/total-recall-the-people-who-never-forget) (obsessive recording & reviewing demonstrates you can recall much of your life if you live nothing worth recalling); ["The Mystery of S., the Man with an Impossible Memory: The neuropsychologist Alexander Luria's case study of Solomon Shereshevsky helped spark a myth about a man who could not forget. But the truth is more complicated"](https://www.newyorker.com/books/page-turner/the-mystery-of-s-the-man-with-an-impossible-memory)
- [_Anki Essentials_](https://alexvermeer.com/anki-essentials/), Vermeer
- ["No. 126: Four Years of Spaced Repetition"](https://genedan.com/no-126-four-years-of-spaced-repetition/) (Gene Dan, actuarial studies)
- ["One Year Anki Update"](https://deusexvita.medium.com/one-year-anki-update-2615b113f7c2) (biology grad school)
- ["How To Remember Anything Forever-ish": an interactive comic](https://ncase.me/remember/) (Nicky Case)
- ["The Overfitted Brain: Dreams evolved to assist generalization"](https://arxiv.org/abs/2007.09560), Hoel 2020
- ["Relearn Faster and Retain Longer: Along With Practice, Sleep Makes Perfect"](https://gwern.net/doc/psychology/spaced-repetition/2016-mazza.pdf), Mazza et al 2016
- ["Replication and Analysis of Ebbinghaus’ Forgetting Curve"](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0120644), Murre & Dros 2015
- ["Learning from Errors"](https://www.annualreviews.org/doi/10.1146/annurev-psych-010416-044022 "'Learning From Errors', Metcalfe 2017"), Metcalfe 2017
- [Glossika](https://ai.glossika.com/)
- **Discussion**: [HN](https://news.ycombinator.com/item?id=13151790)/[2](https://news.ycombinator.com/item?id=24857437)

## 抽认卡资源 {#flashcard-sources}

- [Mnemosyne 牌组集合](https://mnemosyne-proj.org/card-sets)
- [Anki 牌组集合](https://ankiweb.net/shared/decks)
- [FlashCardExchange.com](https://www.cram.com/)
- [StudyStack.com](https://www.studystack.com/)
- [Flashcarddb](https://www.cram.com/topics/popular)
