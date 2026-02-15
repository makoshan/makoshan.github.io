---
title: 本网站的设计
description: "描述 Gwern.net 的元页面，这个自我文档化的网站不仅实现了超文本‘语义缩放’的实验，还采用了 Markdown 和静态托管的技术决策。"
thumbnail: /doc/design/2020-12-25-gwern-gwernnet-recursivepopups.png
thumbnail-text: Gwern.net 的截图，展示了递归弹窗功能，允许对参考资料和链接进行任意深度的超文本探索。
thumbnail-css: "outline invert-not"
created: 2010-10-01
modified: 2023-04-20
status: finished
confidence: highly likely
importance: 3
css-extension: dropcaps-kanzlei
...

<div class="abstract">
> **Gwern.net** 是一个静态网站，通过 Hakyll 从 Pandoc Markdown 编译而来，并托管在专用服务器上（由于云带宽昂贵）。
>
> 它与标准的 Markdown 静态网站不同，致力于良好的排版、快速的性能以及先进的（即 1980 年代风格的）超文本浏览功能（代价是极大的实现复杂性）；[4 个设计原则](#principles)是：美观的极简主义、无障碍/渐进增强、速度以及超文本使用的‘语义缩放’方法。
>
> 不寻常的功能包括单色美学、在宽窗口上使用[侧边注](/sidenote "'Web 设计中的侧边注', Gwern 2020")代替脚注、高效的首字下沉、小型大写字母、可折叠部分、自动通胀调整货币、维基百科风格的链接图标和信息框、自定义[Syntax highlighting (语法高亮)](https://en.wikipedia.org/wiki/Syntax%20highlighting)、广泛的本地存档以对抗链接腐烂，以及一个由“弹窗”/“弹出层”注释和链接预览组成的生态系统，以实现无摩擦浏览——分层结构加上折叠和即时弹窗访问摘要的净效果是实现了类似冰山页面，大部分信息被隐藏，但读者可以随心所欲地深入挖掘。（有关所有功能的演示和压力测试页面，请参阅 [Lorem Ipsum](/lorem)；有关详细指南，请参阅[样式手册](/style-guide "‘样式手册’, Gwern 2025")。）
>
> 此外还讨论了沿途进行的[许多失败的实验/更改](/design-graveyard "'设计墓地', Gwern 2010")。
</div>

如何才能尽可能有效地在线长期展示复杂的、引用密集的、链接密集的长篇文本，同时节省读者的时间和注意力？

<!--
# 读者指南
## 快速入门

#. 悬停在一切内容上
#. 在右上角/右下角的主题切换中启用深色模式
#. 也在那里禁用弹窗

### 慢速入门

#. 一般来说，Gwern.net 上任何可以交互的内容都有工具提示或弹窗；如果有疑问，请悬停以了解更多信息。
#. 启用深色模式：要启用深色模式，请悬停（在桌面上）或点击（在移动设备上）右上角（桌面）或右下角（移动设备）的‘齿轮’图标以打开‘主题切换’，然后再次点击中间的‘月亮’图标。

    这将把深色模式设为默认。同样，点击‘太阳’图标可以将浅色模式设为默认。如果你更喜欢自动模式（根据浏览器/操作系统设置设置深色或浅色），请点击半填充的日食太阳/月亮图标。
#. 禁用弹窗/弹出层：

    - <span id="disabling-popups">弹窗（桌面）：要避免任何弹窗（除了工具提示），请点击右上角的齿轮图标打开主题切换，然后点击底部图标，即划掉的气泡图标。要重新启用，请转到同一位置，然后点击另一个气泡图标。</span>
    - 弹出层（移动设备）：点击任何‘弹出’的链接；在左上角的标题栏中，有一个气泡图标；点击它以禁用弹出层。要重新启用，请点击右下角的主题切换（划掉的气泡图标将突出显示），然后点击另一个气泡图标。
    - <span id="enabling-reader-mode">阅读模式：如果视觉设计‘太过分’，阅读模式可以移除许多功能，如链接图标或链接下划线，以获得‘纯粹’的阅读体验。转到主题切换，在中间的一组‘书本’图标中，选择‘实心书本’图标以启用阅读模式；要恢复常规外观，请选择‘空心书本’图标。</span>

## 功能概述

Gwern.net 专为具有深度引用的长篇内容而设计。
一些不寻常的功能包括：

- 页面元数据块：当前页面顶部是关于该页面的元数据。元数据可分为 3 组：

    - 标准元数据：标题、1-3 句简短描述、作者（如果不是 Gwern）、内容‘标签’、页面开始日期和最后一次‘主要’编辑日期，
    - 不寻常的元数据：其当前状态（如‘笔记’、‘进行中’或‘已完成’）、表明作者对内容大致信心的认知状态、重要性评级 0-10
    - 2 个书目工具：链接到当前页面的其他页面列表（反向引用或‘反向链接’）；以及当前页面内的链接列表（‘带注释的书目’，如果可用，包括每个链接的摘要）。
- 页面摘要：大多数页面都会有长篇摘要或概要，不仅限于标题+描述。
- 链接图标：许多链接后缀有一个小图标；类似于维基百科，这些‘链接图标’为读者提供了关于链接内容的即时提示。

    不足为奇，小的 Adobe PDF 图标意味着链接是 PDF，小的图像链接图标意味着链接可能是 JPG 或 PNG 文件——但 Gwern.net 的链接图标系统远不止于此，并提供了数百个链接图标，涵盖了 Gwern.net 上的大多数链接。链接图标不仅可以编码文件类型，还可以揭示作者、域名或主题，并且可以是徽标、首字母缩略词、首字母或缩写——任何能帮助读者在不访问链接的情况下理解链接内容的东西。

    大多数链接图标应该是不言自明的，但有几个值得一提：Fraktur 'G' 图标 (𝔊) 表示链接到另一篇 Gwern.net 文章（但不是链接到 Gwern.net 托管的文件或标签或索引页面）。
    向上箭头 (↑) 和向下箭头 (↓) 表示页面内的交叉引用，指向之前或之后的部分；这对于了解链接是指向已经阅读的内容（可以安全忽略），还是即将到来的内容（可能值得预览或跳过）非常有用；在分层标签之一上，箭头指示标签是嵌套在当前标签‘上方’还是‘下方’，类似于文件系统中的文件夹或目录（而‘ → ’仅作为另一个标签的‘另见’，既不在上方也不在下方）。
- 链接弹窗/弹出层：除了链接图标外，读者还会注意到有 3 种带下划线的链接，而不仅仅是通常的 1 种：

    #. 实线下划线：普通链接。当用鼠标悬停在上面时，该链接可能会显示工具提示标题，并且 URL 应该显示在浏览器的状态栏中，除此之外，它是一个普通的 HTML 链接。
    #. 带垂直‘左钩’（'|_'）的实线下划线：活动链接。当悬停（或轻按）时，活动链接会弹出一个框架，其中包含链接的预览。

    此预览可能是 PDF 的第一页，或网页的第一个屏幕，或源代码文件（为方便起见语法高亮）。读者可以在正常打开链接之前对其进行检查。
        活动链接不必是 PDF 或其他网站：它可以是链接到当前页面的另一部分，如某个章节或特定段落（参见上/下箭头），也可以是链接到另一个页面上的任何这些内容。
    #. 虚线下划线：‘带注释’的链接。带注释的链接就像维基百科文章上的小弹窗，但功能更多。

        带注释的链接会弹出一个小的‘迷你页面’：像普通页面一样，它在顶部有一个页面元数据块，包含标题/作者/日期/标签/反向链接等，然后是页面摘要——摘要可能是例如维基百科文章的介绍或 Gwern.net 文章或研究论文的摘要或整条 Twitter 推文。然而，注释可能包含更多内容——它们可能包含长段摘录、评论和相关链接（也带注释）。

        弹窗是一个功能齐全的页面，可以做普通页面能做的任何事情，因此可以从弹窗中弹出链接。因为可以深入挖掘弹窗，所以它们具有用于弹窗管理的 GUI 功能。可以点击标题栏拖动弹窗；可以通过点击边缘并拖动来调整弹窗大小；当鼠标离开时弹窗会淡出，但可以通过点击‘图钉’图标使其‘粘性’或‘固定’来使其永久存在；可以通过点击‘X’图标关闭固定的弹窗；四向箭头图标 (✥) 可以将弹窗放大到全屏（便于深度阅读），但会向角落或侧面弹出一个包含其他放大选项的菜单。

        如上所述，弹窗可以[永久禁用](#disabling-popups)，但可以通过[使用阅读模式](#enabling-reader-mode)暂时准禁用。

        - 备用 `[ARCHIVE]` 版本：许多可能会链接腐烂的 URL 都有可用的本地镜像；它们在弹窗中作为标题旁边的备用链接提供，并且是活动链接。
        - 备用 `[HTML]` 版本：有时链接可能有一个更可取的 HTML 版本，特别是对于移动读者；例如，Arxiv 链接对移动读者没有用，因为它要么是链接到 PDF 的着陆页，要么是 PDF 本身——然而，有特别适合移动读者的 HTML Arxiv 版本。（或者原始链接，像 Twitter 或 Medium 链接，由于对读者非常不友好，有特殊的镜像来修复它们。）
- 折叠区域：有时右侧有一个带有 '<' 图标的大灰色方块（例如在每个页面的底部），或者一些被大灰色括号包围的文本。

    这些是‘折叠’：页面的一部分默认被隐藏。可以通过点击或悬停在它们上面来取消隐藏。可以通过点击剩余的灰色轮廓/边缘来重新隐藏它们。
- 边注：除了脚注/侧边注，Gwern.net 还使用‘边注’。边注是设置在左侧（空间允许时）或行内斜体（在移动设备上）的简短短语。

    它们作为总结段落的小‘标题’，在浏览页面时有所帮助。如果有多个边注，它们会成组显示在章节标题下方，以帮助总结该部分。
- 反向链接：在页面和注释的底部，通常有一个反向链接部分，列出了链接到此页面的页面。

    此列表还显示了讨论当前页面的链接页面的片段。这让读者可以看到所有对页面的引用和讨论，并显示足够的上下文，以便读者可以弹出或访问这些页面。
- 链接参考书目：同样在页面、标签和注释的底部，通常有与反向链接相反的‘链接参考书目’（在弹窗中缩写为‘来源’）。链接参考书目是页面中除自身链接外的所有链接，按顺序列出（维基百科链接在最后）。

    如果它们有弹窗注释，则注释将显示在列表中。这比逐个弹出链接阅读或浏览要方便得多。
- 相似链接：相似链接是十几个在主题上与当前页面/注释‘相似’的注释列表，按相似度大致排序，由神经网络嵌入定义。

    相似链接不保证相关性，但经常会出现有趣的额外链接以供查看。为了搜索更多相似的论文，附上了链接到 Google 和 Google Scholar 搜索注释标题/[DOI](https://en.wikipedia.org/wiki/Digital_object_identifier) 的链接。
-->

# 益处

<div class="epigraph">
> 真正认真对待软件的人应该自己制造硬件。
>
> [Alan Kay](https://en.wikipedia.org/wiki/Alan%20Kay), ["Creative Think"](https://www.folklore.org/StoryView.py?project=Macintosh&story=Creative_Think.txt) 1982
</div>

![时间花得值。](/doc/design/2001-10-19-spongebob-s2e37-procrastination-thecalligraphy.jpg "《海绵宝宝》‘拖延症’一集（第 2 季第 37 集）的截图：海绵宝宝花了几个小时写了一个花哨的书法首字‘the’，却没能写完他关于‘在红灯前不该做什么’的 800 字家庭作业论文，说明了作家在琐事和排版设计上的危险。"){.float-right}

网页设计和排版的[悲哀](http://thecodelesscode.com/case/96 "无代码代码：案例 96：‘无状态’")在于，你如何展示你的页面可能只起一点点作用。
一个页面可能设计得很糟糕，呈现为 80 列 ASCII 等宽字体的打字机文本，读者仍然会阅读它，即使他们会抱怨。
而设计最有品味的页面，拥有真正的小型大写字母，正确使用长破折号与短破折号与连字符与减号等等，加载时间不到一秒，并且经过 SEO 优化，如果页面没有值得阅读的内容，也是徒劳的；再多的排版也无法拯救一页垃圾。
也许只有 1% 的读者能叫出这些细节的名字，更不用说识别它们了。
如果我们把所有的细微之处加起来，它们肯定会对读者的幸福感产生影响，但这一定是一个很小的影响——比如说，5%。^[Rutter 在 [_Web Typography_](https://book.webtypography.net/) 中主张这一点，这与我自己的 [A/B 测试](/ab-test "'Gwern.net 上长篇可读性的 A/B 测试', Gwern 2012")一致，即使在 _n_ 很大的情况下，糟糕的更改也很难与零效果区分开来，这与互联网的普遍混乱状态一致（例如在 [2019 Web Almanac](https://almanac.httparchive.org/en/2019/ "Web Almanac - HTTP Archive 的年度网络状态报告：我们的使命是将 HTTP Archive 的原始统计数据和趋势与网络社区的专业知识相结合。Web Almanac 是一份关于网络状态的综合报告，由真实数据和受信任的网络专家支持。它由 20 章组成，涵盖页面内容、读者体验、发布和分发等方面")中的评论）。如果读者[不安装广告拦截](/banner#they-just-dont-know){#ads-2}，并且多秒的加载时间只有适度的流量减少，那么像正确对齐列或使用章节符号或侧边注这样的事情对行为的影响必须接近于零，以至于无法观察到。]
仅仅为了写几样东西是不值得的。

但网页设计和排版的乐趣在于，仅仅是它的展示就可以对你所有的页面产生一点影响。
写作是一项艰苦的工作，任何新的作品通常只会增加现有作品的堆积，而不是倍增它；遍历所有现有的作品并以某种方式改进它们是一项巨大的工作，所以通常不会发生。
另一方面，设计改进有利于整个网站和所有未来的读者，因此在一定规模上，可能非常有用。
我觉得我已经到了值得在排版细节上花心思的地步。

# 设计原则 {#principles}

有 4 个设计原则：

#. 美观的 **极简主义**

    设计美学是极简主义，带有一丝 [Art Nouveau (新艺术运动)](https://en.wikipedia.org/wiki/Art%20Nouveau) 风格。我相信 [Minimalism (极简主义)](https://en.wikipedia.org/wiki/Minimalism) 有助于人们专注于内容。除了内容之外的任何东西都是 [干扰而不是设计](https://www.jwz.org/gruntle/design.html)。正如 [Ikkyū (一休)](https://en.wikipedia.org/wiki/Ikky%C5%AB) 会说的，‘注意！’[^attention]

    色调故意保持灰度，作为一致性的实验，以及这种约束是否允许一个可读的美观网站。经典的排版工具，如 [Initial (首字下沉)](https://en.wikipedia.org/wiki/Initial) 和 [Small caps (小型大写字母)](https://en.wikipedia.org/wiki/Small%20caps) 用于主题化或强调。^[这也无可否认是为了审美价值。通过首先进行移除实际多余细节的艰苦工作，人们赢得了添加‘多余’细节的权利；只有在清理了地面——最大化了‘数据墨水比’，移除了‘图表垃圾’——之后，人们才能看到真正美观的添加是什么。]

    这 *不* 意味着缺乏功能；许多以简单为傲的‘极简主义’设计只是头脑简单。^[好的设计可能是“尽可能少的设计”来完成工作，套用 [Dieter Rams](https://en.wikipedia.org/wiki/Dieter_Rams#Ten_Principles_of_Good_design) 的话；问题出现在设计师关注第一部分而忘记第二部分时。如果一个极简主义设计不能处理超过几段文本和一个通用的‘英雄图像’的内容，那么它就没有解决设计问题，只是插图的一个子流派。（就像优雅的极简主义斯堪的纳维亚或日本建筑的照片，让人怀疑是否有人能在里面 *生活*，以及 [How Buildings Learn (那些建筑如何学习)](https://en.wikipedia.org/wiki/How%20Buildings%20Learn)。）如果一个极简主义网站甚至不能很好地展示一些文本，你可以肯定他们没有解决任何网页设计的难题，如链接腐烂或交叉引用！]
#. 无障碍 & **[Progressive enhancement (渐进增强)](https://en.wikipedia.org/wiki/Progressive%20enhancement)**

    在 Markdown 允许的地方使用语义标记。核心阅读体验 *不* 需要 JavaScript，仅用于（大部分）可选功能：弹窗和包含、表格排序、[侧边注](/sidenote "'Web 设计中的侧边注', Gwern 2020"){#sidenotes-2} 等等。页面甚至可以在智能手机或像 `elinks` 这样的文本浏览器中毫无问题地阅读。
#. **速度 & 效率**

    在日益臃肿的互联网上，一个尽可能快的网站是一股清流。读者理应得到更好的体验。Gwern.net 使用许多技巧以最小的成本提供漂亮的功能，如侧边注或 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 数学公式。
#. <span id="structural-reading"><span id="semantic-zoom">[**语义缩放**](https://infovis-wiki.net/wiki/Semantic_Zoom)</span></span>

    我们应该如何在线展示文本？网页不同于许多媒介（如印刷杂志），允许我们提供无限量的文本。我们不必局限于过于简洁的结构，这种结构支持沉思但不支持确信。

    问题随后变成了驯服复杂性和长度，以免我们作茧自缚。有些读者想阅读关于特定主题的字字句句，而大多数读者只想要摘要或在去别处的途中浏览一下。树状结构有助于组织概念，但不能解决展示问题：一本书或一篇文章可能是分层组织的，但它仍然必须以 100% 的大小展示每一个叶节点。像脚注或附录这样的技巧只能到此为止——拥有数千个尾注或 20 个附录来驯服‘正文’的大小是不令人满意的，因为虽然任何特定的读者不太可能想阅读任何特定的附录，但他们肯定想阅读 *某个* 附录，甚至可能很多。简单地拥有一堆链接到数百个小页面的链接以避免任何页面太大的经典超文本范式也会崩溃，因为人们想细粒度到什么程度？每一节都应该是一个单独的页面吗？每一段？（任何试图阅读 [Info (GNU Info)](https://en.wikipedia.org/wiki/Info%20%28Unix%29) 手册的人都知道这有多乏味。^[单独页面的默认展示意味着一整页可能只包含 *一个* 段落或句子。许多技术手册的 HTML 版本（通常从 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">X</span>、DocBook 或 GNU Info 编译）*更糟糕*，因为它们未能 [利用预取](/idea#prefetch) & 比本地文档慢，并且剥夺了所有使浏览 info 手册快速方便的有用键绑定。在网络浏览器中阅读此类文档就像中国水刑。（几十年后，GNU 项目继续以这种格式生成文档，而不是至少生成带有超链接目录的大型单页手册，这是他们在 UI/UX 设计方面有多糟糕的一个很好的例子。）而且不清楚它是否比另一个极端更糟糕，即包含阳光下每一个细节的单体 [man page (man 页面)](https://en.wikipedia.org/wiki/man%20page)，如果不使用 [Incremental search (增量搜索)](https://en.wikipedia.org/wiki/Incremental%20search) 浏览通过几十个不相关的点击——每一次！——就不可能导航到不让眼睛呆滞。]）参考书目中的每一个引用呢，是否应该有 100 个不同的页面对应 100 个不同的引用？

    然而，网页可以是动态的。长度问题的解决方案是随着读者的请求逐渐展示默认之外的更多内容，并使请求尽可能容易。由于缺乏一个众所周知的术语（Nelson 的 ["StretchText"](https://en.wikipedia.org/wiki/StretchText) 从未流行起来），并类比 [Structure editor (结构编辑器)](https://en.wikipedia.org/wiki/Structure%20editor)/[Outliner (大纲)](https://en.wikipedia.org/wiki/Outliner) 中的 [Code folding (代码折叠)](https://en.wikipedia.org/wiki/Code%20folding)，我称之为 **语义缩放**：使层次结构可见且可塑，以允许在结构的多个级别上阅读。

    Gwern.net 页面可以在多个结构级别上阅读，从高到低：标题、元数据块、摘要、章节标题、边注、列表项中强调的关键词、脚注/侧边注、折叠的部分或段落、指向其他部分（如附录）的内部交叉引用链接（可弹出以立即阅读），以及全文链接或指向其他页面的内部链接（也可弹出）。

    因此，读者可以（以增加的深度）阅读标题/元数据，或页面摘要，或浏览标题/目录，然后浏览边注+项目摘要，然后阅读正文，然后点击取消折叠区域以阅读深入的部分，然后如果他们还想要更多，他们可以将鼠标悬停在参考文献上以提取摘要或摘录，然后他们可以通过点击全文链接阅读原文来进一步深入。因此，一个页面可能看起来很短，读者可以轻松理解和导航，但像冰山一样，那些想了解任何特定点的更多信息的读者会在表面之下发现更多内容。

[^attention]: 改写自《禅师语录》，引用于 [_Three Pillars of Zen_](https://www.amazon.com/Three-Pillars-Zen-Teaching-Enlightenment/dp/0385260938/ "‘<em>The Three Pillars of Zen: Teaching, Practice, and Enlightenment</em>’, Kapleau 1969") 编者导言第 11 页：

     > 一天，一个平民对一休大师说：“大师，请您为我写下最高智慧的格言好吗？”一休立即挥毫写下了‘注意’这个词。“这就是全部吗？您不写更多吗？”一休接着挥毫写了两次：‘注意。注意。’那人恼火地说这并没有什么深度或微妙之处。然后一休连续写了 3 次同样的词：‘注意。注意。注意。’那人半怒地问：“‘注意’到底是什么意思？”一休温和地回答：“注意就是注意。”

杂项原则：

<div class="columns" id="design-slogans">
- 视觉差异应为语义差异
- 可以反应的 UI 元素应在悬停时改变
- 所有 UI 元素都应有工具提示/摘要；交互式链接应为下划线或小型大写字母
- 层次结构和进程应以 3 个为周期（例如 粗体 > 小型大写字母 > 斜体）
- 所有数字应为 [0, 1, or ∞ (0, 1, 或 ∞)](https://en.wikipedia.org/wiki/Zero%20one%20infinity%20rule)
- 功能 > 形式
- 多 > 少
- 独立 > 碎片化
- 惯例（linter/检查器）> 约束
- 超文本是个好主意，我们应该尝试一下！
- 本地 > 远程——每个链接总有一天会失效

    - 存档短期内昂贵，但长期来看便宜
- 读者 > 作者
- 给予读者代理权
- 速度是继正确性之后第 2^nd^ 重要的功能
- [永远押注于文本](https://graydon2.dreamwidth.org/193447.html)
- 你必须 *赢得* 你的装饰

    - 如果你在极简主义上做得过火，你可能仅仅是平庸
- ["用户不会告诉你它坏了"](https://pointersgonewild.com/2019/11/02/they-might-never-tell-you-its-broken/ "‘They Might Never Tell You It’s Broken’, Chevalier-Boisvert 2019")
- UI 一致性被低估了
- 有疑问时，复制维基百科
- 像维基百科一样神奇
- 如果你发现自己 [某事做了 3 次](/epigram#rule-of-three)，修复它。
- 网站内容：好、FLOSS、无限制主题——选两个
- 标题即品牌
</div>

# 功能

<div class="epigraph">
> 56\. 软件处于持续的张力之下。作为符号，它是任意可完善的；但也它是任意可变的。
>
> [Alan Perlis](/doc/cs/algorithm/1982-perlis.pdf "‘Epigrams on Programming’, Perlis 1982")
</div>

显著功能（与标准 Markdown 静态网站相比）：

<noscript><div class="admonition error"><div class="admonition-title">需要启用 JavaScript</div></div></noscript>

- 链接弹窗注释（[所有类型演示](/doc/cs/js/2023-09-14-gwern-gwernnet-popups-allpopuptypes.png)；在小屏幕或移动设备上为 ['弹出层'](/doc/design/2021-03-30-gwern-sidenotes-gwernnet-popins.png)）：

    注释可以从来源自动提取（例如 Arxiv/BioRxiv/MedRxiv/Crossref），或手工编写（通过一系列广泛的重写规则和检查保持格式一致，包括 [使用机器学习分解](/static/build/paragraphizer.py "‘<code>paragraphizer.py</code>’, Gwern 2022") 单体摘要以提高可读性）；弹窗可以是递归的，并可以以多种方式操作——移动、全屏、'固定'（锚定在原地）等。
    [维基百科页面](/doc/design/2021-04-01-gwern-gwernnet-annotations-popups-recursivewikipediapopups.png) 受到特别支持，使它们也可以递归导航。
    本地 Gwern.net 页面和白名单域名可以弹出并完整查看；PDF 可以在 PDF 查看器中阅读；支持的源代码格式可以弹出语法高亮版本（[例如 `LinkMetadata.hs`](/static/build/LinkMetadata.hs)）。
- 客户端包含

    包含支持页面内或跨页面、任意 ID 或页面范围、链接、注释等。
    包含默认为懒加载，但可以设为严格；这使得极大的索引页面成为可能，如标签。
- 代码折叠式折叠/披露支持（行内和块级）

    这些与懒加载包含大量配合使用，因为它们允许人们仅通过编写普通的超链接文本来创建按需显示的任意大的‘虚拟’页面。
- [自动本地存档/镜像](/archiving#preemptive-local-archiving "‘Archiving URLs § Preemptive Local Archiving’, Gwern 2011") 大多数链接，从一开始就消除链接腐烂，同时提供更好的阅读体验
- [侧边注](/sidenote "'Web 设计中的侧边注', Gwern 2020"){#sidenotes-3} 使用两侧边距，回退到浮动脚注

    - [边注](https://edwardtufte.github.io/tufte-css/#sidenotes)（作为行内或侧边注）
- 真正的双向 [反向链接](#backlink)，可以弹出上下文

    - 也在章节级别支持，因此人们可以轻松看到别处对页面特定部分的讨论，而不仅仅是整个页面
- **阅读模式**（移除大多数 UX 如超链接的替代视图，[例如](/doc/design/2023-03-19-gwern-gwernnet-desktop-designpagescreenshot-readermode.png)；切换：[<!-- non-empty span placeholder -->]{.reader-mode-selector-inline}）
- 源代码语法高亮

    - 使用自定义的 [灵感来自 ALGOL 的单色主题](#syntax-highlighting-algol)
- 无 JavaScript 的 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 数学渲染（[示例](/lorem-block#math-block)；但在可能的情况下，它被 [编译为](/static/build/latex2unicode.py "‘<code>latex2unicode.py</code>’, Gwern 2023") 原生 HTML+CSS+Unicode，如 "√4" 或 "1⁄2"，因为那更高效且看起来更自然）
- [深色模式](#dark-mode)（带有 [主题切换器](/static/js/dark-mode.js "'<code>darkmode.js</code>', Achmiz 2020") 和使用 [InvertOrNot.com](https://invertornot.com/) 对是否反转图像的 AI 分类）
- 点击缩放图像和幻灯片；全宽表格/图像
- 可排序表格；各种大小的表格
- 自动 [通胀调整](#inflation) 美元金额，汇率比特币金额（例如 ‘1950 年的 \$1 是今天的 [$1]($1950)。’）
- <span id="link-icons"></span> 链接图标，用于按文件类型/域名/主题/作者分类链接（[示例](/lorem-link#link-icons)；[实现背景](/design-graveyard#link-icon-css-regexps "‘Design Graveyard § Link-Icon CSS Regexps’, Gwern 2010"))
- ["警告"](https://casual-effects.com/markdeep/features.md.html#basicformatting/admonitions) 信息框（通过 [Markdeep](https://casual-effects.com/markdeep/) 实现类似维基百科的风格）
- 轻量级 [首字下沉](/dropcap "‘Dropcap Generation With AI’, Gwern 2023")

    支持 AI 生成的集合，如猫主题页面上使用的 ["dropcats"](/dropcap#dropcat "‘Dropcap Generation With AI § Dropcat’, Gwern 2023")
- [高级诗歌支持](/style-guide#poetry)（[Concrete poetry (具体诗歌)](https://en.wikipedia.org/wiki/Concrete%20poetry)、[Alliteration (头韵诗)](https://en.wikipedia.org/wiki/Alliteration) 等）
- 多栏列表
- 跨维基链接语法
- 关键词自动链接化（[LinkAuto.hs](/static/build/LinkAuto.hs){#linkauto-hs}）
- 紧凑的引用排版（使用 [下标](/subscript "‘Subscripts For Citations’, Gwern 2020")）
- 打印支持
- 题词
- [采访格式](/design-graveyard#interviews "‘Design Graveyard § Interviews’, gwern 2010")
- 博客链接实现为页面页脚中的“今日网站/名言/链接”
- <span id="demo-mode"></span> **演示模式**：跟踪网站功能的使用计数，以便在 _n_ 次使用后禁用或更改它们。

    这允许显眼的新手友好功能或外观，对老读者自动简化。它松散地受到经典电子产品 [Demo mode ("演示模式")](https://en.wikipedia.org/wiki/Demo%20mode) 设置的启发，该设置循环显示设备的所有功能。它使用 [Web storage (LocalStorage)](https://en.wikipedia.org/wiki/Web%20storage) 以避免任何服务器集成。

    我们主要用它来突出主题切换工具栏（<span class="toolbar-mode-selector-inline"></span>）的存在，以便读者知道如何启用其他功能，如深色模式或阅读模式：如果我们在每次页面加载时都运行它，动画会非常令人分心，但如果我们不这样做，读者如何发现它？（我们发现很多读者 *没有* 自己注意到它，可能是由于普遍的网络杂乱盲视。）我们的解决方案：我们只是使用演示模式在几次后禁用它。

    我们还用它来精简 UI。例如，披露/折叠区域是不寻常的，所以我们明确为新读者写出描述；但它们使用得如此广泛，以至于将描述留在原处对于已经学会它们的读者来说是一大堆杂乱。
- **404 页面**：404 错误页面使用错误和站点地图 + [Levenshtein distance (Levenshtein 距离)](https://en.wikipedia.org/wiki/Levenshtein%20distance)，来 [尝试猜测预期的 URL](/static/js/404-guesser.js)，以及指向主索引并提供站点搜索快捷方式。

    （它还包括精选的题词和插图，供因链接腐烂而沮丧的读者阅读。）

Gwern.net 的大部分设计和 JavaScript/CSS 是由 [Said Achmiz](https://wiki.obormot.net/) 开发的，2017--202?。
一些灵感来自 [Tufte CSS](https://edwardtufte.github.io/tufte-css/) & Matthew Butterick 的 [_Practical Typography_](https://practicaltypography.com/)。

## 反向链接 {.collapse}

<div class="abstract-collapse">
Gwern.net 实现了 ["双向"](https://maggieappleton.com/bidirectionals) [Hyperlink (超链接)](https://en.wikipedia.org/wiki/Hyperlink)^[也称为“后向或反向 [Citation (引用)](https://en.wikipedia.org/wiki/Citation)”、“[链接至此](https://en.wikipedia.org/wiki/Help:What_links_here)” & “反向链接”。] 或 [**Backlink (反向链接)**](https://en.wikipedia.org/wiki/Backlink)（[例如此页面](#backlinks){.aux-links}）：链接既是向前（普通类型）从当前页面向外指向另一个页面；也是 *向后*，显示当前页面在其他页面的哪个位置被链接。

它的反向链接特别好，因为弹窗提供了无摩擦导航；我们要仔细的实现意味着它们可以在引用的内容附近提供上下文，甚至可以在任意 URL 之间提供（通过注释）。
</div>

示例可以在 [维基百科](https://en.wikipedia.org/wiki/Special:WhatLinksHere/Michael_Mitchell_(Australian_rules_footballer)) 或 [Andy Matuschak 的笔记](https://notes.andymatuschak.org/zXDPrYcxUSZbF5M8vM5Y1U9) 上看到，或者越来越多地被像 [Roam](https://roamresearch.com/) 或 [Notion](https://en.wikipedia.org/wiki/Notion%20%28productivity%20software%29) 这样的 [Zettelkasten (卡片盒笔记法式)](https://en.wikipedia.org/wiki/Zettelkasten) 服务普及，并且在超媒体系统中有很长的历史，至少可以追溯到 ~1965 年 [Project Xanadu (Xanadu 项目)](https://en.wikipedia.org/wiki/Project%20Xanadu) 的初始方案（该项目还引入了 [Transclusion (包含)](https://en.wikipedia.org/wiki/Transclusion)，我们广泛将其用于 UI 并显示所述反向链接）。

<noscript><div class="admonition error"><div class="admonition-title">需要启用 JavaScript</div></div></noscript>

在 Gwern.net 上，页面/注释（及其上的所有 [锚点](https://en.wikipedia.org/wiki/HTML%20element%23Anchor)/[ID](https://en.wikipedia.org/wiki/URI%20fragment)）的反向链接在每一项的底部作为包含的折叠附录提供。
这些部分列出了每个反向链接，此外，还包含了该反向链接的来源：

![例如 [此页面](#backlinks)，可以看到对 ["语义缩放"](/design#semantic-zoom){.backlink-not} 新词作为更有用的设计概念的暗示，或对涉足排版新颖性如 [下标符号](#gwern-subscript){.backlink-not} 的理由（[另一个例子](/doc/design/2023-04-02-gwern-gwernnet-backlinks-backlinksinsection-ideatimeghostsectionexample.png)）。](/doc/design/2023-04-14-gwern-gwernnet-backlinks-designexample.png)

反向链接也被重载以提供作者作品的书目：注释的作者链接（如他们的主页或传记或 WP 文章）本身就是一个带注释的链接，因此，它的反向链接将包括所有已知的作者链接。
为方便起见，当反向链接是作者链接时，它通过排序到反向链接列表的前面来优先显示，因此滚动作者的反向链接将首先显示他们的出版物，然后才是对他们的提及。

### 反向链接功能
#### 上下文内

这是可能的，因为链接通过 HTML 中的唯一 ID 进行跟踪，所以可以轻松确切地识别在另一个页面的 *哪里* 被链接。[^Wikipedia-bad-backlinks]

[^Wikipedia-bad-backlinks]: 这修复了 [MediaWiki](https://en.wikipedia.org/wiki/MediaWiki) wiki 系统的‘链接至此’反向链接实现的最大问题——这是实现它的简单方法，因此已成为显示反向链接的标准 wiki 软件方法。

    WhatLinksHere 页面（[例如 En WP](/doc/wikipedia/2023-04-18-mediawiki-englishwikipedia-georgewashington-whatlinkshere.png "https://en.wikipedia.org/wiki/Special:WhatLinksHere/George_Washington 的截图，显示了按字母顺序排序（！）的反向链接列表，没有上下文或查看上下文的方式，使其大部分无用。")）会告诉你几百个其他维基百科文章链接到你当前的维基百科文章，是的，但你不知道 *上下文* 是什么（在任何一个页面上！），以及它是一个重要链接还是次要链接，甚至它可能在文章的哪里——它可能隐藏在一些不可预测的显示文本下，你必须搜索 MediaWiki 标记本身才能找到它！

    这只能通过像 [Lupin's Tool](https://en.wikipedia.org/wiki/Wikipedia:Tools/Navigation_popups) 这样的工具部分修复，这些工具试图通过加载另一个页面来定位链接，因为只有少数编辑使用这些工具，而且仍然需要努力。因为 MediaWiki 在服务器端渲染所有内容，没有理由它不能做类似的事情并在每个链接旁边显示上下文摘录。它只是没有这样做。（它不需要真正的双向链接——即使是假设每篇文章中的第一个链接是‘真实’链接并忽略重复项的启发式黑客行为，也将是一个重大改进。）

这也意味着我们可以在任何相关的地方显示这些相同的反向链接条目。
例如，如果反向链接是指向一个部分，我们不必满足于仅仅是一个大的全页反向链接列表，我们可以将该部分的反向链接放在该部分 *内部* 以方便读者：你读完一个部分，然后通过弹窗看到其他地方已链接到它：

![包含语义缩放 ID 的部分还包括“语义缩放”链接的反向链接，读者可以取消折叠阅读。](/doc/design/2023-04-14-gwern-gwernnet-backlinks-designexample-insectionbacklinkexample.png)

这对于其他反向链接系统应该是可能的，但 Gwern.net 在像这样‘内联’反向链接方面几乎是独一无二的。[^alternative-inlined-backlinks]

[^alternative-inlined-backlinks]: Roam 显然可能会做类似我们‘内联’的事情，但我对它了解太少，无法确定。Maggie Appleton 模拟了这样的 [“推测性界面”](https://maggieappleton.com/transcopyright-dreams#designing-speculative-interfaces)，但似乎不知道有任何实现。

    一个有限的例子是 [GreaterWrong](https://www.greaterwrong.com/)，它在 [帖子](/doc/design/2023-04-14-gwern-greaterwrong-backlinks-postexample.png) 和 [个人评论](/doc/design/2023-04-14-gwern-greaterwrong-backlinks-commentexample.png) 上做反向链接。然而，虽然个人评论上的反向链接相当原子化，但它们不显示调用上下文，并且链接上的弹窗仅显示标准的整体项目视图。（GW 的反向链接是应 Wei Dai 的要求于 2019 年引入的，远早于 Gwern.net 的反向链接于 2021 年引入以利用新的包含功能，并且它们在设计上大部分是独立的。）

（类似的前向链接功能是链接书目，它按顺序聚合所有前向链接。
然而，几乎不需要‘上下文内’的前向链接，因为文章或注释已经提供了该上下文。）

#### 弹窗

Gwern.net 反向链接的另一个独特功能是它们与注释弹窗集成。
大多数 wiki 只能为相互链接的 wiki 页面提供反向链接；它们不能在任意 URL 和 wiki 页面之间提供反向链接或前向链接。
然而，Gwern.net 的反向链接可以从任何 URL 到任何 URL：页面 ↔ 页面，页面 ↔ URL，以及 URL ↔ URL（尽管如果没有注释来显示该元数据，读者无法 *看到* 这一点）。
这通过简单地将注释包含在解析链接的文件中，并将注释中的链接归因于其各自的 URL，然后照常进行来完成。
例如，我在许多关于深度学习的注释中链接了我的 GPT-3 页面，因为它描述了我认为解释深度学习结果的关键概念，如 ["提示工程"](/gpt-3#prompts-as-programming "‘GPT-3 Creative Fiction § Prompts As Programming’, Gwern 2020"){.backlink-not}，即使它们不是‘Gwern.net 页面’或‘wiki 文章’，它们也会出现在其反向链接中：

![GPT-3 页面的反向链接，显示了来自链接到它的研究文章的反向链接，而不仅仅是顶层页面（[另一个例子](/doc/design/2023-04-02-gwern-gwernnet-backlinks-backlinksinsection-gpt3roleplayingfootnoteexample.png)）。](/doc/design/2023-04-14-gwern-gwernnet-backlinks-gpt3example-backlinksfromannotations.png)

但是，注释也可以相互链接，创建一个隐式的 [Citation graph (引用图)](https://en.wikipedia.org/wiki/Citation%20graph)（比像 [Google Scholar](https://en.wikipedia.org/wiki/Google%20Scholar) 这样的论文分析和书目创建的要小，但因此更针对我的用途）：

    - **由外向内**: 如果页面 *A* 链接到 *B*，*B* 链接到 *C*，并且我在注释 *A*，那么我不一定知道 *B* 链接到 *C*。但如果我嵌入 *B* 的注释，*B* 的注释将包含 *C* 的链接。
    - **由内向外**: 反向链接包含在注释中。如果我在读 *C*，我可以看到 *B* 链接到它。这解决了垃圾反向链接的问题，这个问题扼杀了旧博客圈对 [Linkback (引用通知)](https://en.wikipedia.org/wiki/Linkback) 的使用。如果有人在外部 URL 链接到 Gwern.net URL（或任何 URL），我想将其包含在引用图中，我可以简单地为他们的外部 URL 创建一个注释并包含他们的目标链接。
现在这将自动出现在反向链接中。

### 实现

在 `<a>` 超链接元素上存在标识 ID 对于使双向链接工作至关重要：人们无法链接他们无法命名的东西。[^ID-origins]
因为 URL 可以在页面中为不同的用途被多次链接[^multiple-links]，所以 URL 是不够的；知道 URL 被链接在页面内是模棱两可的，人们需要 URL *加上* ID——只有这一对是唯一的。
这就是大多数反向链接方法不足的地方，不得不满足于 MediaWiki 风格的反向链接转储，没有任何可能的上下文。

[^ID-origins]: 我开始在所有 Gwern.net 超链接上自动生成 ID 的最初原因很小：我想使用页面内弹窗（像小的上/下箭头）来移除多余的链接并显示更多上下文。

    一篇研究论文可能会在一个部分详细讨论，但在其他地方被引用；不给它加超链接是不好的，所以通常，我会做一个多余的超链接。然而，如果第一次讨论有一个唯一的 ID，那么我可以简单地将后面的引用链接到该 ID，读者可以悬停在上面弹出该讨论，阅读它，然后点击通过。（所以在 Markdown 中看起来像这样：`[Foo 2020](URL){​#foo-2020} proved ABC, which is interesting because of DEF … [thousands of words & many sections later] … see also [Foo 2020](​#foo-2020).`）

    可以根据具体情况手动执行此操作，但链接太多，并且 ID 可以从元数据中推断出来，所以为什么不自动生成它们，这样就可以始终确信 `#foo-2020` 是有效的？

    一旦大多数链接在页面 *内* 有唯一的 ID，这就意味着它们在页面 *之间* 也可以是唯一的……所以弹窗导致了双向反向链接。
[^multiple-links]: <span id="multiple-links"></span> 到另一个 URL 的多个链接在 Gwern.net 上并不罕见，尤其是在使用 ID 进行精确链接时，这样人们可以容易地链接 `/foo` 还有 `/foo#bar`、`/foo#quux`，甚至 `/foo#baz`，为什么不呢？

    事实上，这是处理复杂注释的好方法：你可以将它们分解为多个注释并链接每个版本。例如，一篇复杂、深入的机器学习论文，如 [BigGAN 论文](https://arxiv.org/abs/1809.11096#deepmind "‘Large Scale GAN Training for High Fidelity Natural Image Synthesis’, Brock et al 2018"){.backlink-not}，其中摘要很重要，但省略了 [第 6 页](https://arxiv.org/pdf/1809.11096#page=6&org=deepmind "‘BigGAN: Large Scale GAN Training for High Fidelity Natural Image Synthesis § 4.2 Characterizing Instability: The Discriminator’, Brock et al 2019 (page 6)"){.backlink-not} 上的关键部分，以及我想为其他目的强调的 [第 8 页](https://arxiv.org/pdf/1809.11096#page=8&org=deepmind "‘BigGAN: Large Scale GAN Training For High Fidelity Natural Image Synthesis § 5.2 Additional Evaluation On JFT-300M’, Brock et al 2018 (page 8)"){.backlink-not}。

    我可以满足于根本不注释它们；或者我可以试着把它们全部塞进一个注释里；或者由于缺乏任何注释可能，我可以利用 [`#page=n`](/doc/cs/css/2007-adobe-parametersforopeningpdffiles.pdf#page=5) 技巧链接到论文 PDF 中的确切页面 & 满足于 PDF 弹出（如果你仅为了编写多个不同的注释而创建任意 ID，这也有效）；*或者* 我可以为确切的页面链接创建注释并简单地交叉引用它们！反向链接使交叉引用一目了然，并在悬停时导航。由于这都是完全递归的，注释是一等公民，目标可以是任意 URL 或 `<div>`/`<span>` 的任意 ID，反向链接和链接互操作等，对于作者和读者来说，这一切都无缝地 Just Works™。

    但是，丢弃锚点和 ID 元数据的系统很难做到这一点：1:1 链接或不同的 URL-锚点将崩溃为无可救药的模棱两可的多对多映射。

超链接（或像 [`<span>`](https://en.wikipedia.org/wiki/Div%20and%20span) 元素这样的目标）由 Pandoc 自动手动分配唯一的 ID，或使用注释元数据生成可预测的 ID。^[我为我的 ID 使用作者姓名，因为该元数据通常由于注释而可用，并且容易猜测和编写。但其他实现可能更喜欢通过简单地剥离或转义有问题的 URL（例如转为 [Base64](https://en.wikipedia.org/wiki/Base64) 或 URL 编码），或通过将其输入像 SHA-256 这样的网络浏览器支持的哈希函数（截断为 8 个字符——任何页面上都没有足够的 URL 来担心碰撞）来生成一致但唯一的 ID。]
（HTML ID 不能以数字开头或包含句点，还有其他限制，因此生成的 ID 通常采用 `#surname-year` 的形式；因此，链接到 GPT-3 论文 [Brown et al 2020](https://arxiv.org/abs/1809.11096#deepmind "‘Large Scale GAN Training for High Fidelity Natural Image Synthesis’, Brock et al 2018"){.backlink-not} 在此页面中的 ID 将是 `#brown-et-al-2020`，本段中的链接可以被寻址为 `/design#brown-et-al-2020`。
重复的 ID 可以通过全局覆盖来消除两个链接的歧义，或通过每页手动分配的 ID 来修复。）

反向链接作为离线过程实现，解析页面 Markdown 源代码和注释 HTML，并提取 URL+ID。
它们 *可以* 在编译时实现，但这不适合像 Hakyll 这样的静态网站生成器，所以我只是在晚上作为 cron 作业运行反向链接。
反向链接并不总是令人感兴趣（例如，新闻通讯中的链接通常没有任何有趣的评论或上下文），并且可以通过 `.backlink-not` 属性逐个链接地禁用。

然后，它们被转换为适当格式的 HTML 包含列表，每个 URL 一个片段。
然后将这些片段 *再次* 包含在该 URL 的折叠部分中，无论它如何显示。[^lazy-collapse]

[^lazy-collapse]: 显示反向链接的上下文需要下载注释或页面，以缩小到 ID 的上下文。显示反向链接上下文可能会占用大量空间，并且渲染所有 HTML 是昂贵的，特别是对于有大量反向链接的反向链接部分。

    所以折叠作为 [Lazy evaluation (惰性求值)](https://en.wikipedia.org/wiki/Lazy%20evaluation)，并避免这样做，除非读者请求它。（由于反向链接在编译时都是已知的，预先计算上下文是可能的，但不那么容易。）

因为反向链接利用了通用的包含和折叠功能，它们的前端集成主要是更新生成的 HTML 片段和偶尔的模板。
有人可能会问，当 URL 不是 Gwern.net 上的简单 HTML 页面，而可能是 PDF 或其他网站上的 URL（并且由于链接腐烂，URL 甚至可能不存在）时，如何处理 URL+ID？
答案很简单：只需将其重写为 *注释* HTML 片段 + ID 的 URL，并进行包含。
（一路都是包含！）

主要的挑战来自一些边缘情况，即反向链接弹窗无法无缝工作。
对于来自外部 URL 注释的反向链接，弹出 JavaScript 必须猜测注释内的 URL 以提供上下文。
此外，`data-target-id` 属性必须存储在反向链接内，以区分 ID 和实际锚点。
（我们考虑过简单地像 `#target​#id` 那样连接它们，但这种带内编码只会导致不同的歧义。）

#### 其他用途

反向链接数据库还有其他一些用途：

- 如果反转查询或模式，反向链接数据库就是前向链接数据库。因此，如果想要页面中的链接列表（即其前向链接），可以跳过解析文件，只需查询反向链接数据库。

    这使得全站链接分析成为可能；一种用途是将其与 [链接图标](#link-icons) 和每日网站功能结合起来，列出使用频率足以证明链接图标或包含在每日网站中的域名，并寻找经常链接但未注释的链接。
- 反向链接还用于为注释生成神经网络 [Embeddings (嵌入)](https://en.wikipedia.org/wiki/Word%20embedding)（目前仅用于‘相似链接’推荐——这是 [Semantic Web (语义网)](https://en.wikipedia.org/wiki/Semantic%20Web) 吗？——但我打算用于其他目的，如标签重构），用它们的全站上下文丰富其元数据。

## 相似链接 {.collapse}

<span class="abstract-collapse">Gwern.net 在可能的情况下提供 **相似链接**（[例如此页面](#similars-section){.aux-links}），这是与当前注释在语义上‘相似’的注释列表。</span>
‘相似’目前定义为对注释文本的神经网络嵌入进行的普通 [_k_ 近邻查找](https://en.wikipedia.org/wiki/Nearest_neighbor_search)。

独特的是，相似链接也按 [嵌入距离“排序”](#sort-by-magic)，这以逻辑方式组织相似链接列表并使其更具可读性。

## 链接参考书目 {.collapse}

<span class="abstract-collapse">Gwern.net 页面和注释提供 **链接参考书目**（[例如此页面](#link-bibliography){.aux-links}）：按顺序排列的超链接列表，注释会自动展开。</span>

由于注释，我们不提供通常的‘参考’或‘参考书目’部分，而是更接近‘带注释的书目’的东西。
这让人可以浏览页面的‘带注释的书目’，而不必逐个弹出链接。

## 标签 {.collapse}

<div class="abstract-collapse">
Gwern.net 为所有链接实现了一个简单的分层/DAG [标签](https://en.wikipedia.org/wiki/Tag%20%28metadata%29) 系统，模仿 [维基百科的分类](https://en.wikipedia.org/wiki/Help:Category)（参见 [`Tags.hs`](/static/build/Tags.hs)）。

它旨在通过弹窗浏览，并与文件系统自然集成。
</div>

<noscript><div class="admonition error"><div class="admonition-title">需要启用 JavaScript</div></div></noscript>

这些分层标签对应于文件系统层次结构：URL 可以被‘标记’为字符串 `foo`，在这种情况下，它被分配到 `/doc/foo/` 目录。^[这取代了早期的 [基于 Hakyll 的标签系统](https://jaspervdj.be/hakyll/reference/Hakyll-Web-Tags.html)。Hakyll 方法非常简单，仅适用于小型博客，无法处理本地文件标记，更不用说任意 URL。（标签代码也是我无法修改的黑魔法。）与此同时，我本地文件的不断演变的文件系统层次结构已经 *看起来* 像一个标签系统，演变很容易。]
如果标签字符串中有斜杠，则它指的是嵌套标签，如 `foo/bar` → `/doc/foo/bar/`。
因此，添加到 Gwern.net 目录如 `/doc/foo/bar/2023-smith.pdf` 的文件被推断为自动标记为 `foo/bar`。
（因为它是分层的，它不能同时标记为 `foo` 和 `foo/bar`；这被解释为仅仅是 `foo/bar`。）
将文件复制/符号链接到各处是个坏主意，因此给定的 URL（如文件）可以被任意多次标记。
这在与注释相同的元数据数据库中跟踪，并且可以像注释的任何其他部分一样进行编辑。

它实现为一个 [独立的批处理过程](/static/build/generateDirectory.hs)，读取目录列表，查询注释数据库以查找与每个目录隐含标签匹配的注释，并写出一个包含包含列表的 Markdown `index.md` 文件，然后正常编译。

### 属性

标签是一等公民，因为它们本身就是页面/文章，并且可以像任何其他 URL 一样被标记：

#. 标签作为 **页面**：

    标签可以有关于主题的介绍/讨论，用于标签含义可能不明显的情况（例如 ["内心独白"](/doc/psychology/inner-voice/index) 或 ["暗知识"](/doc/psychology/dark-knowledge/index)）。

    这些介绍像文章一样处理，实际上，可能只是从常规页面 *包含*（例如 [鼻屎标签](/doc/biology/booger/index "‘Booger Picking’, Gwern 2021") 或 [高效 Transformer 注意力](/doc/ai/nn/transformer/attention/index "‘Efficient Attention: Breaking The Quadratic Transformer Bottleneck’, Gwern 2020")）。
#. **被标记** 的标签：

    标签本身可以被“标记”，并出现在该标签下（反之亦然）；然而，这些标签不是递归的，也不试图避免循环。它们更多地是出于‘另见’交叉引用的精神。
#. 标记 **任何 URL**：由于标签在 URL/注释上，它们将不同的 URL+[锚点](https://en.wikipedia.org/wiki/HTML_element#Anchor)-片段视为不同的。

    因此，您可以为页面上的多个锚点或 PDF 内的多个页面创建注释，并分别对它们进行注释和标记。请参阅 [反向链接讨论](#multiple-links) 了解此黑客行为有多有用。（因为锚点不需要存在于 URL 内部——如果找不到锚点，浏览器将简单地正常加载 URL——您甚至可以将锚点视为一种用任意元数据‘标记’URL 的方式，而无需数据库或其他软件支持[^affiliation-anchors]。）

[^affiliation-anchors]: 我以这种方式滥用锚点来跟踪 URL 的‘隶属关系’，既为了更容易引用/搜索，也为了设置链接图标。例如，我认为 DeepMind 的论文作者身份是一件有用的事情，所以我将 `#deepmind` 附加到任何与 DeepMind 相关的 URL（例如 `https://arxiv.org/abs/1704.03073#deepmind`）。我觉得特别有助于跟踪中国 AI 研究，他们习惯在 Arxiv 上悄悄发布具有启发性的论文，而没有公关或西方的关注。

    当我链接该 URL 时，该链接将获得 DeepMind 徽标作为其链接图标，如果我能记住它与 DM 相关，我更容易搜索。这不会破坏链接，因为锚点仅在客户端（不像如果你想以这种方式滥用查询参数——许多服务器会忽略像 `foo?deepmind` 这样格式错误的 url，但许多其他服务器会抛出错误）；因此，我可以在 Gwern.net 和 Reddit 或 Twitter 之间来回复制粘贴，后者将继续正常工作（它们跟踪完整的 URL，但通常为了搜索等目的而删除锚点）。因为它重载了锚点，我可以随时定义新的隶属关系，截至 2023-04-19 已达 51 个隶属关系；我可以通过使用新约定来编码我可能想要编码的任何其他内容。我可以通过写 `#2023-04-19` 来编码日期，或作者 `#john-smith`，或像 `#todo` 这样的小笔记。只要它们不碰巧是 *真正* 的锚点，它们就会工作。（这就是为什么许多过去的网页设计黑客行为，如 [`#!'](https://en.wikipedia.org/wiki/URI_fragment#Proposals) [URL](https://en.wikipedia.org/wiki/Single-page_application) 或 ["文本片段"](https://developer.mozilla.org/en-US/docs/Web/URI/Fragment/Text_fragments)（粗糙的 [内容寻址 URL](https://en.wikipedia.org/wiki/Content%20centric%20networking)）也利用了锚点，为了它们的后向兼容性。）

    这种黑客行为确实有代价。首先，它会产生虚假的锚点，我的链接检查器会警告这些锚点，但必须作为故意错误忽略。其次，更严重的是，虽然它在外部 URL 上工作正常，但在本地 URL 上开始引起问题：考虑像 `/doc/reinforcement-learning/model-free/2016-graves.pdf#deepmind` 这样的情况——这个 URL 对于注释本身不是问题，注释通过 URL 做所有事情，但对于文件级别的任何东西都是问题，它只看到 `.../2016-graves.pdf`。文件级别没有 `#deepmind`！这需要不稳定的黑客行为，如查找以文件为前缀的每个注释，看看是否有带有某种锚点的注释。我打算移除这个黑客行为，转而在注释元数据中存储隶属关系；然而，我可能会保留它作为输入隶属关系的便捷方式。

### 使用 & 外观

浏览标签的主要方式是通过带注释的 URL 上的弹窗：

![一张有 3 个标签打开的研究论文的示例，这些标签本身也被标记，带有用于快速弹出特定标签条目的目录。](/doc/design/2023-04-18-gwern-gwernnet-popups-examplesofmultipletagpopups.png)

标签弹窗提供了整个标签的概览：有多少带标记的项目是什么类型的，它是如何被标记的 & 访问其更广泛的父标签，原始标签名称，图像缩略图（从最近的带图像的注释中提取），以及紧凑的目录，将弹出这些注释。
支持链接书目等标准功能，并且全部通过弹出和/或包含实现。^[标签弹窗过去只是简单地包含/加载标签页面到弹窗中。结果证明这对于像 [`psychology`](/doc/psychology/index) 这样有数百到数千个条目（并且迫切需要重构）的大型标签来说是不可预测且缓慢的，这些标签当时也不是包含，因此可能需要 >10s 才能加载。]
像反向链接一样，标签和其他一切之间几乎没有区别——从读者的角度来看，这一切都 Just Works™。

如果想进行更深入的阅读，标签作为独立的 HTML 页面提供。
这些页面的想法是，人们可能正在搜索关键参考文献，或试图了解最新的研究。

因此，这些被组织为前言/介绍（如果有），然后是父级 & 子级 & 交叉引用的标签（带有箭头指示哪个），然后是按时间倒序排列的注释（需要日期 & 标题），然后是维基百科链接（最后，因为它们没有明确定义的‘日期’）；然后，‘杂项’部分列出了至少有 1 个标签但缺乏关键元数据如标题、作者或日期的 URL；最后是链接书目，这是所有带注释条目的单独链接书目的串联。
这些项目都大量使用了包含和折叠的惰性来呈现可接受的效果——它们充满了超链接，以至于完全包含的页面会让网络浏览器崩溃（这可能就是为什么像维基百科这样的网站甚至不尝试提供类似界面的原因之一）。

标签是组织大量注释的关键方式。
在某些情况下，它们取代了页面部分或整个页面，否则那里将有手动维护的参考书目。
例如，我试图跟踪 [DNM Archive](/dnm-archive#works-using-this-dataset) & [Danbooru20xx](/danbooru2021#publications) 数据集的使用，以帮助确定它们的价值并存档它们的使用；我过去常常手动链接每个反向引用，同时也不得不手动标记/注释它们。
但是有了标签+包含，我可以简单地为涉及数据集使用的 URL 设置一个标签（`darknet-market/dnm-archive` & `ai/anime/danbooru`），并将该标签包含到一个部分中。
现在，当我标记它时，每个 URL 都会自动出现，无需进一步努力。

### 功能

便利功能：

#. **生成的** 标签：有两个特殊的标签是‘生成的’（更多是）：

    - [`newest`](/doc/newest/index)，列出了最近添加的注释（作为 [每月通讯](https://gwern.substack.com/ "‘Gwern.net newsletter (Substack letter)’, Gwern 2013") 的一种实时等价物 & 让我轻松校对最近写的注释）
    - 以及根标签目录本身，[`doc`](/doc/index)，按路径 & 人类可读的短名称列出 *所有* 标签（向读者展示可用标签的全部广度）。
#. **短 ↔ 长** 标签名：

    为了简洁起见，Gwern.net 标签分类法并不试图成为完美的分类金字塔。
    它支持‘短’或‘昵称’，这是不透明的长标签名的人类可读短版本。
    （例如，`genetics/heritable/correlation/mendelian-randomization` → "[Mendelian randomization (孟德尔随机化)](https://en.wikipedia.org/wiki/Mendelian%20randomization)"。）

    在另一个方向上，它试图智能地猜测任何短标签可能指的是什么：如果我试图在 CLI 上运行命令上传新文档，如 <code>[upload](/static/build/upload.sh) 1981-knuth.pdf latex</code>，标签代码将猜测是指 `design/typography/tex`，并上传到该标签目录。
#. 推断或 **自动标签**：

    - 为了引导标签分类法，我定义了规则，即页面链接的任何 URL 都会获得特定标签；例如，[DNB FAQ](/dnb-faq "‘Dual n-Back FAQ’, Gwern 2009"){.backlink-not} 将强加 `dual-n-back` 标签。事实证明这对标签太随意了，已被移除。
    - 本地托管的文件通常在路径中编码了一个标签，如前所述。（这排除了 `/doc/www/` 中的本地镜像的特殊情况，以及一些镜像或项目。）
    - 域名匹配可以触发标签，在域名本身就是一个标签的情况下（例如，[_The Public Domain Review_](https://publicdomainreview.org/) 在 [`history/public-domain-review`](/doc/history/public-domain-review/index) 有自己的标签，因此方便自动标记任何匹配 `publicdomainreview.org` 的 URL），或者网站是单一主题的（任何指向 [EvaMonkey.com](https://www.evamonkey.com/) 的链接都将是 [`anime/eva`](/doc/anime/eva/index) 标签）。
#. CLI 工具：[`changeTag.hs`](/static/build/changeTag.hs) 和 `upload` 允许批量编辑 & 创建注释，[`annotation-dump.hs`](/static/build/annotation-dump.hs) 启用搜索/浏览：

    我使用 `changeTag.hs`（快捷键：`gwt`）作为一种 [Bookmark (书签)](https://en.wikipedia.org/wiki/Bookmark%20%28digital%29) [tool (工具)](https://en.wikipedia.org/wiki/Social%20bookmarking) 来‘标记’我遇到的任何 URL。（通过列出所有目录名并将其转换为标签，很容易提供 [Tab completion (Tab 补全)](https://en.wikipedia.org/wiki/Command-line%20completion)。）例如，一个有趣的 [Arxiv](https://en.wikipedia.org/wiki/ArXiv) 链接将获得快速的 `gwt https://arxiv.org/abs/2106.11297 attention/compression t5`；这将创建 [它的注释](https://arxiv.org/abs/2106.11297 "‘TokenLearner: What Can 8 Learned Tokens Do for Images and Videos?’, Ryoo et al 2021"){.backlink-not}，从 Arxiv 拉取所有元数据，运行所有格式化通道如分段，为其生成嵌入，该嵌入将包含在所有未来的相似链接推荐中，将其添加到本地存档队列，并在 [`ai/nn/transformer/attention/compression`](/doc/ai/nn/transformer/attention/compression/index) & [`ai/nn/transformer/t5`](/doc/ai/nn/transformer/t5/index) 下标记它。比手动做要好！

    与此同时，`annotation-dump.hs`（快捷键：`gwa`）帮助我实际利用标记来重新查找东西，例如 `gwa https://arxiv.org/abs/2106.11297 | fold --spaces --width=100`：

    ![在 [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) 中查询注释的示例，显示了 [语法高亮](https://en.wikipedia.org/wiki/Syntax_highlighting)，如查看注释的完整 Gwern.net URL 的快捷方式、标签、所在的 YAML 文件数据库等。](/doc/cs/shell/2023-04-18-gwern-gwernnet-commandline-annotationdump-queryexample.png)

    这些可以被 grep、管道传输、在文本编辑器中编辑等。这可以与 `gwt` 结合用于批量编辑：grep 特定关键词，过滤掉已标记的注释，管道传输到 `less`，手工审查，并复制要标记/取消标记的 URL。这可以进一步与 `link-extractor.hs` 结合，从给定的 Markdown 页面提取链接，查看它们是否已经被标记了某个标签，并仅呈现未标记的以供审查。

    例如，当我想要填充我的 [Frank Herbert](/doc/fiction/science-fiction/frank-herbert/index) 标签时，我从我的两个 _Dune_ 相关页面提取了链接，grep 了任何 *提到* 任何这些链接的注释，过滤掉任何已标记为 'Frank Herbert' 的注释，并打印出剩余的 URL 以供审查，并标记了其中许多：

    ~~~{.Bash .collapse}
    TMP=$(mktemp /tmp/urls.txt.XXXX)

    cat ./dune-genetics.md ./dune.md | pandoc -f markdown -w markdown | \
        runghc -i/home/gwern/wiki/static/build/ ~/static/build/link-extractor.hs | \
        sort --unique | grep -E -v -e '^#' >> "$TMP"
    cat "$TMP"

    gwa | grep -F --color=always --file="$TMP" | \
        grep -F -v -e '"fiction/science-fiction/frank-herbert"' | \
        cut --delimiter=';' --fields='1-4' | less

    gwt 'frank-herbert' […]
    ~~~

#### 未来标签功能

未来工作：由于缺乏工具，Gwern.net 标签系统是不完整的。
标签是一个未解决的问题，目前由人力蛮力解决，但深度学习可以实现更好的标签未来。

当我看标签的历史、[Folksonomy (大众分类法)](https://en.wikipedia.org/wiki/Folksonomy) 和像维基百科、[del.icio.us](https://en.wikipedia.org/wiki/Delicious%20%28website%29) & [Archive of Our Own](https://en.wikipedia.org/wiki/Archive%20of%20Our%20Own)（参见 ["Fan is A Tool-Using Animal"](https://idlewords.com/talks/fan_is_a_tool_using_animal.htm)）这样的书签服务时，我看到的是一个对个人读者来说摩擦太大的工具。

建立一个简单的标签系统，并处理几百或几千个链接很容易。
（事实上，任何开始保存书签的人都会很快开发出一个临时的类别或标签系统。）
有效地使用它多年并不容易；所有的标签 GUI 都很笨重，做任何事情都需要几秒钟，而且它们的‘自动化’很小。

这样的系统应该随着时间的推移变得更容易、更快、更智能，但通常会变得更难、更慢、更笨。
像 [间隔重复](/spaced-repetition "‘Spaced Repetition for Efficient Learning’, Gwern 2009") 或 [复杂的个性化软件](/backstop#knuth)，普通用户尝到了使用标签的最初果实，可能有点过头，开始在维护的负担下陷入困境，没有时间拆分标签或填充晦涩的标签，系统开始失控，出现包含半个世界的‘超级’标签，而晦涩的标签只有 1 个条目——随着技术债务的升级，用户从中获得的价值越来越少，看标签变得越来越痛苦，因为人们看到未完成的工作堆积如山，就像电子邮件收件箱一样。

人们看到许多博客使用‘标签’，但方式毫无意义：有一个标签在每隔一个帖子上都有，有数千个条目，然后每个条目都有 1 个标签，几乎只用于该条目 & 再也不会使用。
没有人阅读或使用这些标签，包括它们的作者。
在这种失败模式下，尤其是在 [Tumblr](https://en.wikipedia.org/wiki/Tumblr) & [Instagram](https://en.wikipedia.org/wiki/Instagram) 上明显，正如 [Hillel Wayne](https://buttondown.com/hillelwayne/archive/tag-systems/) 指出的那样，标签通过大量多余的标签被拍在每个帖子上而完全贬值为 ["元垃圾"](https://people.well.com/user/doctorow/metacrap.htm)——如果你需要重新找到一个特定的帖子，那肯定不是通过标签……^[有趣的是，虽然对于表面上的预期目的毫无用处，但 Instagram 标签对于深度学习扩展的早期里程碑结果（特别是 [Mahajan et al 2018](https://arxiv.org/abs/1805.00932#facebook "Exploring the Limits of Weakly Supervised Pretraining")）很有用，有助于确立神经网络可以从 *数十亿* 图像中学习，当时专家的传统智慧是数百万才有用 & 神经网络‘根本无法扩展’。]
在另一个极端是 Twitter：Twitter著名的 ['Hashtag (话题标签)'](https://en.wikipedia.org/wiki/Hashtag) *曾经* 被广泛使用，是关键的组织工具……但在沿途的某个地方，真正的 Twitter 用户似乎停止使用它们 & 它们变成了垃圾邮件。
难怪大多数用户最终承认这是浪费时间，除非他们开始作为参考图书馆员的第二职业，并放弃，依靠他们的搜索技能来重新找到他们需要的任何东西？
（公平地说，对于许多用户来说，他们一开始可能真的不需要标记。这对他们来说是一个有吸引力的麻烦，一种生产力的错觉——就像按字母顺序排列书架一样。）

这就是为什么 *确实* 有效利用标签的网站往往是迎合利基市场的网站，拥有高级用户和某种高度活跃的策展人（名为‘图书馆员’或 [WikiGnomes](https://en.wikipedia.org/wiki/Wikipedia:WikiGnome)），他们会清理 & 执行标准。
例如，维基百科编辑投入了巨大的精力来维护一个极其复杂的类别系统，拥有广泛的机器人工具；维基百科编辑（如果不是普通读者）受益，因为他们广泛将其用于内容编辑和组织无限量的元编辑内容（如 [重载](https://en.wikipedia.org/wiki/Category:Categories_requiring_diffusion) [类别](https://en.wikipedia.org/wiki/Category:Overpopulated_categories) 的类别）。
Archive of Our Own 同样以其广泛的标签系统而闻名，该系统被狂热粉丝 [‘争夺’](https://archiveofourown.org/wrangling_guidelines/11) 成一个合理一致应用的角色/特许经营/主题的大众分类法，并被其读者大量用于导航 >10m 的同人小说（代替任何更清晰的方式来导航同人小说的海洋——毕竟，同人小说的重点是任何人都可以做，造成了原创作品不存在的策展问题）。

或者换句话说，当前的标签系统不像 Ted Nelson 或 _Minority Report_ 式的体验，巫师用思想的材料编织，随意分组 & 编排屏幕上的一群项目；而更像是去机动车管理局填写一式三份的表格，或者用镊子一粒一粒地移动一堆沙子。
成功的标签系统就像埃及金字塔：成千上万的人劳动多年的不朽功绩，将笨拙的积木精确地推到位。
标签由一群人脑驱动，乏味地，一个接一个地，学习总标签大众分类法的一小部分，通过笨重的软件添加它，在他们的网络浏览器通过来回的咔嗒声时敲击手指，花了几个小时将 1 个标签中的一千个条目的列表重构为 2 个标签，在盯着列表看了一会儿试图想象那 2 个标签可能是什么之后，并且做这一切没有任何可见的回报。
对于像维基百科这样的共享资源，这是值得的；对于你自己的个人文件……投资回报是可疑的。（此外，人是懒惰 & 健忘的。）

但有了现代工具，特别是像文档嵌入这样的 DL NLP 工具，标签体验可能会好得多——甚至神奇。
标签系统的 3 个主要痛点是标记新项目、将大标签重构为小标签（通常是单个标签到 2–4 个）、用现有项目填充新/小标签，以及阅读/搜索大标签。
所有这些都可以大大改善。
如果用心实施并关注性能，这 4 种技术将消除标签系统的大部分痛苦；事实上，策展标签甚至可能是令人愉快的，就像捏泡泡纸一样：

#. **自动标记文档** 且具有高精度完全在 2023 年的能力范围内。

    许多文档带有可以嵌入的摘要或概要。对于那些没有的，2023+ LLM 通常有足够长的上下文窗口来嵌入整个文档（费用较高，也许嵌入质量较低）；它们通常也能够编写准确的摘要。

    对于 >90% 的注释，对于在我现有的标签+嵌入语料库上训练的分类器（例如 [Random forest (随机森林)](https://en.wikipedia.org/wiki/Random%20forest)）来说，适当的标签将是非常明显的^[嵌入通过包含其内部链接、反向链接、手动策划的相似链接（注释的‘另见’部分）及其先前的标签而增强，值得注意的是：所有这些都应该增强嵌入的可标记性 & 可聚类性。]，并且标签可以自动生成。^[你可以直接使用 LLM 进行标记，使用微调或包含有效标签列表以供选择等技巧，但这些可能不如分类器准确，往往更慢 & 不太适合 [实时主动学习标签](#active-learning)，并且嵌入可重用于其他目的。]
    事实上，我认为我的标记工作部分是合理的，因为可以在其上训练未来的分类器，这只是昂贵的引导阶段。

    随着标签收集变大，标记的准确性提高 & 用户将被要求标记更少的项目，奖励用户。
#. **将标签重构为子标签** 更难，但可能作为一个交互式聚类问题是可行的。

    在重新标记文档几个小时后，人们想对电脑大喊：“看，这个标签应该是什么很明显，就把它们按明显的方式分开，做我想做的！”通常 *非常* 明显，人们可以用正则表达式做到一半……但做不到另一半。

    可以取一个过大标签的嵌入，并对其运行像 [_k_-means clustering (_k_-均值聚类)](https://en.wikipedia.org/wiki/k-means%20clustering)^[替代方案是 [_k_-medoids](https://en.wikipedia.org/wiki/k-medoids)，它将构建其‘中心’是特定数据点的集群（对于 _k_-均值，集群中心不一定有数据点），使用户更容易解释，并可能创建更高质量的集群。我们不想使用 [DBSCAN](https://en.wikipedia.org/wiki/DBSCAN)，因为它会忽略许多点为‘异常值’；这在现实世界的数据中是合理的，数据点可能不可预测或完全是垃圾，但在标记中，我们可以假设所有数据都是有效的，因此我们希望保留‘异常值’并考虑为它们分配自己的标签——也许它们只是不成熟。] 这样的聚类算法，对于各种 _k_，如 2–10。然后可以将不同的聚类呈现为集合，每个聚类中最中心的项目作为其原型示例。对于专家用户来说，集群是什么以及最好的 _k_ 是什么应该是显而易见的：‘这 3 个集群有意义，但在 4 时它崩溃了，我不知道 #3 和 #4 应该是什么。’

    给定一个聚类，然后可以将原型示例放入像 GPT 这样的工具中，询问它这些示例的标签名称应该是什么。（这类似于 OpenAI ChatGPT 界面如何自动‘标题’每个 ChatGPT 会话以提供有意义的摘要，而无需用户这样做。[^auto-summarization] 它们能吗？当然。但那是工作。）用户将批准或提供他自己的。

    [^auto-summarization]: 例如，我最近几次会话的自动标题/摘要：“绝缘容器温度”、“危险元数据日期”、“Haskell 递归文件列表”、“塑料管减少积聚”、“不支持引用的模板”、“缓冲区重写条件修改”、“自动合并的 Git pull”、“Grep 不可打印字符”、“`(keyboard-quit)` 的替代方案”、“反向 Markdown 列表顺序”、“目标设定理论 & 尽责性”、“奥丁的 [最爱香料](https://en.wikipedia.org/wiki/Allspice)？”、“猫躺在椅子上”、["解密诗歌信息"](https://news.ycombinator.com/item?id=34977741)、“瓢虫叉车认证”。

        为什么不对所有东西都这样做，比如文件名，并结束 `Untitled (89).doc` 的 ['闪烁的 12' 问题](https://en.wikipedia.org/wiki/Blinking%20twelve%20problem)？
        毕竟，这些问题与其说是由于 *内在复杂性* 或难度——阅读手册或弄清楚或决定叫什么文件只需要一分钟——不如说是每次都要花一分钟这样做的麻烦--每一次停电、夏令时、录像机升级、随机文档---为了最终每个实例微小的收益。（真正的文书收益，总计起来会增加，但单独来看仍然很小，因此很容易被麻烦所抵消。）但 LLM 可以轻松做到并且不会抱怨。

    选择了聚类 & 标签后，标签可以自动重构为新标签。重构标签的工作从‘几个小时极其乏味的工作，主动阅读数千个项目以试图推断一些好的标签，然后逐个应用’变成了‘一分钟愉快的考虑向人们展示的几个选项’。

    随着标签数量的增加，必要的重构数量将减少（[幂律](/doc/design/2007-halpin.pdf "‘The complex dynamics of collaborative tagging’, Halpin et al 2007")，显然，鉴于 [Zipf's law (齐普夫定律)](https://en.wikipedia.org/wiki/Zipf%27s%20law) 这很有意义），未来项目的自动标记将改进（既因为语义变得更丰富，也因为如果可以通过聚类嵌入在无监督的方式下找到标签聚类，那么给定标记数据集预测这些标签聚类将更容易），再次奖励用户并随着时间的推移提高质量。

    （频率低得多的是，我们将想要合并标签。但这很容易自动化。）
#. <span id="active-learning"></span> **填充稀有标签**：

    有时用户会创建一个有用的标签，或者一个小集群会因为非常独特而从聚类中跳出来。如果这是一个好标签，它可能有许多有效的实例，但分散在整个数据集中。在这种情况下，自动标记新项目或重构现有标签将无济于事。你需要回过头来看现有项目。

    在这种情况下，创建稀有标签将很好地与 [[主动学习]{.smallcaps}](https://en.wikipedia.org/wiki/Active_learning_(machine_learning)) 方法集成。

    最简单的主动学习方法（不确定性采样）看起来像这样：用户创建一个新标签，并添加一些初始示例。
    标签分类器立即对此进行再训练，并创建所有未标记实例的排名列表，按其估计概率排序。用户查看列表，并标记第一个屏幕上的一些。
    它们被标记，该屏幕上的其余部分此后被忽略[^negative-tags]，分类器立即再训练，并生成另一个排名列表。像随机森林这样的标签分类器可以在几秒钟内训练相当大的数据集，因此这可以近乎实时地进行，或者实际上是异步进行的，用户只需在实例弹出屏幕时点击‘是’/‘否’，而分类器在后台循环训练 & 重新分类。
    像重构一样，这比传统的‘努力工作’的手动方法对用户的要求要低得多。
    （这种半自动标记方法在机器学习行业广泛用于创建像 [JFT-300M](https://arxiv.org/abs/1707.02968#google "‘Revisiting Unreasonable Effectiveness of Data in Deep Learning Era’, Sun et al 2017") 这样的数据集，因为它们使标记效率大大提高，但在最终用户软件中并不多见。）

    几分钟内，新标签将被完全填充，看起来就像它一直都在那里一样。
#. <div id="sort-by-magic">
   按逻辑顺序呈现标签内容—**按语义相似度排序**，这看起来像“按魔法排序”：

    但我们可以更进一步。
    *为什么* 一个超级标签如此难以阅读或搜索？
    嗯，一个问题是它们往往是一大堆乱七八糟的东西，除了倒序时间外没有其他顺序。
    倒序时间在许多情况下是不好的，即使是博客（考虑一个多部分系列，你只能通过标签找到它们，当然这会以最糟糕的顺序向你展示系列！），并且仅仅因为……你还能 *怎么* 排序它们？
    至少这向你展示了最新的，这并不总是一个好顺序，但至少是 *一种* 顺序。
    要超越这一点，你需要某种语义理解，那种人类会有的更深层次的理解（当然，人脑，尤其是你的人类用户的大脑，太昂贵了，不能用来提供某种合理的顺序）。

    幸运的是，我们就手头有那些文档嵌入。
    我们可以尝试再次使用 _k_-均值聚类 & 用 LLM 标题，并一个接一个地显示每个集群，将集群视为‘临时’或‘伪’标签。^[事实上，这可能就是我们开始聚类重构的方式：我们简单地默认聚类（任意跨集群排序，然后集群内语义排序），用户可以点击一个小按钮将集群‘规范化’为新标签。]
    （我们可以通过输入标题等元数据并询问标签名称，轻松地 [用 LLM](https://en.wikipedia.org/wiki/tagguesser.py) 命名匿名集群。用户可能会拒绝它，但即使是错误的标签名称对于通过明显的正确名称也是非常有用的，并打破了“空白页暴政”和决策疲劳。）
    集群不尊重我们的 2D 阅读顺序，但有其他的聚类方法旨在将高维嵌入的聚类几何 [投影到更少的维度](https://en.wikipedia.org/wiki/Nonlinear%20dimensionality%20reduction)，如 2D，用于图形，甚至 1D——例如 [t-SNE](https://en.wikipedia.org/wiki/t-distributed%20stochastic%20neighbor%20embedding) 或 [UMAP](https://arxiv.org/abs/1802.03426 "‘UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction’, Lel et al 2018")。

    我不知道它们在 1D 中是否效果良好，但在稍高维度下效果更好，那么它可以作为一个 [Traveling salesman problem (旅行商问题)](https://en.wikipedia.org/wiki/Traveling%20salesman%20problem) 轻松转化为具有最小总距离的序列。
    不需要重量级机器的简单‘排序’方法是‘按语义排序’：然而，不是按距特定点的距离，而是贪婪地成对排序。
    人们选择一个任意起点（‘最近的项目’是标签的逻辑起点），找到‘最近’的点，将其添加到列表中，然后找到离 *那个* 点最近的未使用点，依此类推递归。

    我发现对于 Gwern.net 注释，贪婪列表排序算法效果出奇地好。
    它自然产生一个相当合乎逻辑的序列，随着潜在集群的变化偶尔‘跳跃’，这与朴素的‘按距离排序’形成对比，后者往往会根据距离的微小差异在集群之间‘乒乓’或‘之字形’往返。^[想象一下，你正在排序一个项目列表 A–Z ([ABCDEFGHIJKMLNOPQRSTUVWXYZ])，你有成对的距离，比如‘A 离 B 比 C 或 Z 更近’。如果你选择，比如说，‘H’，然后简单地‘按距离’到‘H’排序形成 1D 列表，结果只会来回‘乒乓’：[HIGJFKEMDOCPB...]。（等距集群越多，这种乒乓效应越严重。）这将是有意义的，因为‘P’确实比‘B’稍微接近‘H’，但这来回对于任何读者来说看起来都是混乱的，他们看不到底层的 A–Z。然而，如果你贪婪地成对排序，你会得到一个列表如 [HIJKMLN...YZABCDEFG]，除了 A/Z 处的‘跳跃’，这对读者来说是有意义的，浏览起来要愉快得多。这也更容易策展，因为你可以 *看到* 序列以及‘跳跃’，并，比如说，决定将 A–G 编辑到自己的标签中，然后进一步将剩余的细化为 H–L & M–Z 标签。]

    这将通过保留局部几何形状（即使‘全局’形状没有意义）隐式地暴露底层结构，并帮助读者浏览，因为他们感到‘热’和‘冷’，并且可以专注于看起来最接近他们想要的标签区域。（如果标签真的需要按时间顺序排列，或者嵌入线性化很糟糕，可以设置一个设置来覆盖它。）

    这种方法适用于任何可以有用嵌入的东西，并且考虑到现在的图像嵌入如 CLIP 变得多么好（例如 [Concept](https://github.com/MaartenGr/Concept) 或 [SOOT](https://every.to/napkin-math/6-new-theories-about-ai "‘6 New Theories About AI: Software with superpowers § GPT-4’, Armstrong 2022")），对于图像可能效果更好。
    这最终不可避免地会在集群之间产生一些突然的过渡，但这告诉你自然类别在哪里，你可以轻松地将图像集群拖放到文件夹中 & 在每个目录内重做这个技巧。
    这将使拖放一组数据点，选择它们，并定义适用于它们的新标签变得容易。

    而且因为嵌入是如此广泛使用的工具，有很多技巧可以使用。
    例如，默认嵌入可能没有给你想要的足够的权重，并且最终可能按像‘平均颜色’或‘现实世界位置’之类的东西聚类。
    但 [嵌入器可以被提示](https://arxiv.org/abs/2212.09741 "‘One Embedder, Any Task: Instruction-Finetuned Text Embeddings (INSTRUCTOR)’, Su et al 2022") 以针对特定用例，如果不可能，你可以根据特定点的嵌入（如原型文件（如果是纯文本则查询/关键字提示，或使用像 CLIP 的图像+文本这样的跨模态嵌入））直接操作嵌入：嵌入新文件或提示，用它加权乘以所有其他的（或类似的东西），然后重新组织。
    （当然，你可以用用户的改进微调任何嵌入模型，对比地：将用户指出的不像嵌入指示的那样相似的点推得更远，反之亦然。
    这对于生成嵌入的模型最容易工作，但人们也可以想出技巧来根据用户操作微调其他模型。）

    或者你可以尝试“嵌入算术”：如果默认的 2D 布局没有帮助，因为最可见的变化集中在无用的部分，人们可以‘减去’嵌入来改变显示的内容。你可以通过首先对它们进行算术运算来对任意数量的嵌入这样做。例如，你可以从每个数据点‘减去’一个标签 _X_ 来忽略它们的 _X_-性，通过平均所有带有标签 _X_ 的数据点得到一个“原型 _X_”；新的嵌入现在是“除了编码标签 _X_ 的概念之外那些数据点的含义”。^[如果你有一个餐厅评论语料库，你可能想按食物类型聚类，但是在简化为 2D GUI 时，你的默认嵌入一直按地理位置分组；没问题，只需减去像“纽约市”这样的所有城市标签，然后剩下的可能会按法国 vs 亚洲融合 vs 中国等聚类，你可以轻松套索每个集群并命名它们并创建新标签，几乎没有任何辛苦。]（如果正确的标签或数据点不存在——只需编一个！）
    通过依次减去，人们可以在整个数据集中查找‘缺失’的标签；事实上，如果减去每个标签，剩余的集群可能仍然令人惊讶地有意义，因为它们具有尚未编码的标签结构。
    人们也可以尝试 *添加* 以强调特定的 _X_。
^[这就足够抽象了，我怀疑这能否轻易向用户解释，但我认为它可以以可用的方式编码到 UI 中。就像人们可以呈现一个 2D 图，其中呈现每个数据点和平均标签，并且可以点击它们来‘加强’或‘削弱’它们（其中每一级强度对应于一个嵌入算术操作，但是加权的，如每次点击 10%）。如果你对所有数据点的 _X_-性感兴趣，你只需点击 _X_ 点‘加强’几次，直到更新的 2D 图有意义。]
    </div>

[^negative-tags]: 我还没见过太多的一个想法，但随着自动化的增加，这将是有用的，那就是‘负标签’或‘反标签’的概念：断言一个项目绝对 *不是* 一个标签。

    标签通常呈现为一个二值变量，但因为标签系统的默认选项通常是未标记，并且因为大多数标签系统是不完整的，这意味着错误高度偏向于遗漏错误而不是委托错误。一个有标签 _x_ 但没有标签 _y_ 的项目，几乎总是 _x_ 的实例；然而，它通常也是 _y_。所以标签的缺失比标签的存在信息量少得多。但没有办法区分“这个项目没有标记为 _y_ 是因为没人顾得上”和“因为有人仔细看了，它绝对不是 _y_”。

    在常规标签使用中，这只会导致一些浪费的努力，因为用户定期查看项目并仔细检查它不是 _y_。有了自动化，这可能成为像主动学习工作这样的事情的严重障碍：如果我们没有办法标记‘它 *绝对* 不是 _y_’，那么当我们试图找到未标记为 _y_ 的 _y_ 实例时，我们将每次都不得不忽略相同的误报。（而且我们也无法训练我们的分类器忽略那些误报，即使那些是最有价值的训练，因为它们是最愚弄我们的分类器的。）

# 废弃

[**参见 Gwern.net 设计墓地。**](/design-graveyard "'Design Graveyard', Gwern 2010"){#gwern-designgraveyard-2 .include-annotation .backlink-not .redirect-from-id}

# 工具

整个网站使用的软件工具 & 库：

- 源文件是用 [Pandoc](https://pandoc.org/) [Markdown](https://en.wikipedia.org/wiki/Markdown) 编写的（Pandoc: John MacFarlane et al; GPL）（源文件：Gwern Branwen, CC-0）。Pandoc Markdown 使用了许多扩展；除了最简单的表格外，管道表格是首选；我使用 [语义换行](https://rhodesmill.org/brandon/2012/one-sentence-per-line/)（也称为 ["语义换行"](https://sembr.org/) 或 ["通风散文"](https://vanemden.wordpress.com/2009/01/01/ventilated-prose/)）格式。
- 数学是用 [<span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">X</span></span>](https://en.wikipedia.org/wiki/LaTeX) 编写的，编译为 [MathML](https://en.wikipedia.org/wiki/MathML)，由 MathJax（Apache 许可证）静态渲染为 HTML/CSS/字体；原始数学表达式的复制粘贴由 JavaScript 复制粘贴侦听器处理
- <span id="syntax-highlighting-algol">语法高亮</span>：我们最初使用 [Pandoc 内置的](https://github.com/jgm/skylighting) [Kate](https://en.wikipedia.org/wiki/Kate%20%28text%20editor%29) 派生主题，但大多数与整体外观冲突；在查看了所有现有主题后，我们从 [Pygments 的](https://pygments.org/) [algol\_nu](https://xyproto.github.io/splash/docs/longer/algol_nu.html) (BSD) 中获得灵感，基于原始 [ALGOL](https://en.wikipedia.org/wiki/ALGOL_60) 报告，并在 [IBM Plex](https://en.wikipedia.org/wiki/IBM_Plex) Mono 字体中排版^[一个不寻常的选择，因为人们并不把 IBM 与字体设计卓越联系在一起，但尽管如此，这是我们在盲目比较了约 20 种带有 [变体零](https://en.wikipedia.org/wiki/Slashed%20zero)（我们要认为这是代码的要求）的代码字体后的选择。一个吸引人的较新替代品是 [JetBrains Mono](https://www.jetbrains.com/lp/mono/)（它与 Gwern.net 的风格不太搭配，但可能适合其他网站）。]
- 该网站是用 [Hakyll](https://github.com/jaspervdj/Hakyll/)v4+ 静态网站生成器编译的，用于生成 Gwern.net，用 [Haskell](https://en.wikipedia.org/wiki/Haskell%20%28programming%20language%29) 编写（Jasper Van der Jeugt et al; BSD）；有关血腥细节，请参见 [`hakyll.hs`](/static/build/hakyll.hs)，它实现了编译、RSS 提要生成、& 跨维基链接解析。这只是生成基本网站；我在上传前后做了许多额外的优化/测试，由 [`sync.sh`](/static/build/sync.sh) 处理（Gwern Branwen, CC-0）

    我首选的使用方法是使用 Emacs 本地浏览 & 编辑，然后使用 Hakyll 分发。使用 Hakyll 最简单的方法是你 `cd` 进你的仓库并 `runghc hakyll.hs build`（`hakyll.hs` 带有你喜欢的任何选项）。Hakyll 将在 `_site/` 内构建一个静态 HTML/CSS 层次结构；然后你可以做类似 `firefox _static/index` 的事情。（因为为了 [酷 URI](https://www.w3.org/TR/cooluris/) 的利益未指定 HTML 扩展名，截至 2014 年 1 月，你不能使用 Hakyll `watch` 网络服务器。）Hakyll 对我的主要优势是与 Pandoc Markdown 库相对直接的集成；Hakyll 并不那么容易使用，所以我除非已经熟练掌握 Haskell，否则不建议将 Hakyll 作为通用静态网站生成器使用。
- CSS 借用自各种来源，并经过大量修改，但其起源是 [Hakyll 主页](https://jaspervdj.be/hakyll/) & [Gitit](https://github.com/jgm/gitit)；具体细节见 [`default.css`](/static/css/default.css)
- Markdown 语法扩展：

    - 我为 Gitit 中的自定义跨维基链接语法实现了一个 Pandoc Markdown 插件，然后将其移植到 Hakyll（在 `hakyll.hs` 中定义）；它允许链接到英语维基百科（以及其它），语法如 `[malefits](!Wiktionary)` 或 `[antonym of 'benefits'](!Wiktionary "Malefits")`。CC-0。
    - <span id="inflation"></span> 通胀调整：[`Inflation.hs`](/static/build/Inflation.hs "'InflationAdjuster', Gwern 2019") 提供了一个 Pandoc Markdown 插件，允许自动调整美元金额的通胀，呈现名义金额 & 当前实际金额，语法如 `[$5]($1980)`。
    - 书籍联盟链接通过在 `hakyll.hs` 中附加的 [Amazon Affiliates](https://en.wikipedia.org/wiki/Amazon%20Associates) 标签
    - 图像尺寸在编译时查找 & 作为浏览器提示插入 `<img>` 标签
- JavaScript：

    - HTML 表格可通过 [tablesorter](https://mottie.github.io/tablesorter/docs/) 排序（Christian Bach; MIT/GPL）
    - MathML 使用 [MathJax](https://en.wikipedia.org/wiki/MathJax) 渲染
    - 分析由 [Google Analytics](https://en.wikipedia.org/wiki/Google%20Analytics) 处理
    - [A/B testing (A/B 测试)](https://en.wikipedia.org/wiki/A%2FB%20testing) 使用 [ABalytics](https://github.com/danmaz74/ABalytics)（Daniele Mazzini; MIT）完成，该工具钩入 Google Analytics（参见 [测试笔记](/ab-test "'Gwern.net 上长篇可读性的 A/B 测试', Gwern 2012"){#gwern-ab-testing-2}）进行个人级别的测试；当进行像 [广告 A/B 测试](/banner "'Banner Ads Considered Harmful', Gwern 2017"){#ads-3} 这样的全站长期测试时，我只是手动编写 JavaScript。
    - [广义工具提示弹窗](/static/js/popups.js "'<code>popups.js</code>', Achmiz 2019") 用于在鼠标悬停在链接上时加载所有链接的介绍/摘要/预览；读取手动编写 & 从许多来源（维基百科、Pubmed、BioRxiv、Arxiv、手写...）自动填充的注释，并特别处理 YouTube 视频（Said Achmiz, Shawn Presser; MIT）。

        请注意，这里的‘链接’被广泛解释：几乎所有东西都可以‘弹出’。这包括指向当前或其他页面上的部分（或 div ID）的链接，PDF（通常使用晦涩但方便的 `#page=N` 功能进行页面链接），源代码文件（由 Pandoc 语法高亮），本地镜像的网页，脚注/侧边注，弹窗本身内部的任何此类链接递归...

        - 浮动脚注由广义工具提示弹窗处理（最初通过 [`footnotes.js`](https://ignorethecode.net/blog/2010/04/20/footnotes/) 实现）；当浏览器窗口足够宽时，浮动脚注被替换为边缘笔记/*侧边注*[^sidenotes-history]，使用自定义库 [`sidenotes.js`](/static/js/sidenotes.js)（Said Achmiz, MIT）

            ![在 [_Radiance_](/doc/radiance/2002-scholz-radiance "'Radiance: A Novel', Scholz et al 2013") 上演示侧边注。](/doc/cs/css/sidenotes.png "单栏布局网页的图像，但在左右页边空白处排版脚注为‘侧边注’，靠近它们注释的文本。"){.invert}
    - 图像大小：全尺寸图像（图形）可以点击进入幻灯片模式放大——对于不适合窄正文的图形或图表很有用——使用另一个自定义库 [`image-focus.js`](/static/js/image-focus.js)（Said Achmiz; GPL）
- 错误检查：像断链这样的问题分 3 个阶段检查：

    - [`markdown-lint.sh`](/about#markdown-checker)：写作时
    - [`sync.sh`](/static/build/sync.sh)：编译期间，健全性检查文件大小 & 计数；grep 断开的跨维基链接；对页面运行 HTML tidy 以警告无效 HTML；测试上传后各种页面的活性 & MIME 类型；检查重复项、只读、禁止的文件类型、过大或未压缩的图像等。
    - [链接腐烂工具](/archiving "'Archiving URLs', Gwern 2011"){#archiving-2}：[`linkchecker`](https://github.com/linkchecker/linkchecker)，[ArchiveBox](https://github.com/ArchiveBox/ArchiveBox)，和 [archiver-bot](https://hackage.haskell.org/package/archiver)

[^sidenotes-history]: 侧边注长期以来一直被用作像 [日内瓦圣经](https://en.wikipedia.org/wiki/Geneva%20Bible%23Format) ([前 2 页](https://github.com/raphink/geneve_1564/releases/download/2015-07-08_01/geneve_1564.pdf)) 这样的密集注释文本的排版解决方案，但在网上还没怎么出现。

    ![[Pierre Bayle's](https://en.wikipedia.org/wiki/Pierre%20Bayle) [_Historical and Critical Dictionary_](https://en.wikipedia.org/wiki/Dictionnaire%20Historique%20et%20Critique)，演示递归脚注/侧边注（1737，第 4 卷，第 901 页；来源：Google Books）](/doc/design/typography/sidenote/1737-bayle-dictionary-vol4-pg901.jpg "Google Books https://books.google.com/books?id=JmtXAAAAYAAJ&pg=PA900 的截图，显示了 Pierre Bayle 著名的启蒙文本‘历史和批判词典’（1737 年英文版第 4 卷第 900 页）单个页面中的高级排版，其中包含正文、脚注和（递归地）脚注的侧边注。")

    边距/侧边注的早期 & 鼓舞人心的使用。

## 实现细节

<div class="epigraph">
> 程序员信条：“我们做这些事情不是因为它们容易，而是因为我们以为它们会很容易。”
>
> [Maciej Cegłowski](https://en.wikipedia.org/wiki/Maciej%20Ceg%C5%82owski) ([2016-08-05](https://x.com/Pinboard/status/761656824202276864))
</div>

网页设计师可能会发现一些技巧 & 细节很有趣。

效率：

- **字体**：

    - Adobe [[Source]{.smallcaps} Serif](https://en.wikipedia.org/wiki/Source%20Serif%20Pro)/[Sans](https://en.wikipedia.org/wiki/Source%20Sans%20Pro)（Gwern.net 最初使用 [Baskerville](https://en.wikipedia.org/wiki/Baskerville#Digital_versions)）

        <div class="collapse" id="webfonts">
        <div class="abstract-collapse"><p>为什么使用我们自己的 [Web typography (webfonts)](https://en.wikipedia.org/wiki/Web%20typography) 而不是仅仅使用现有的网络安全/系统字体？有人可能会问，字体开销（像 [GPT-3 小说页面](/gpt-3 "‘GPT-3 Creative Fiction’, Gwern 2020"){.backlink-not} 这样最复杂的页面~0.5MB 字体的非阻塞下载）与信任可能已经安装并且网络方面‘免费’的字体相比是否值得。这是我们的 webfonts 给我们带来的：</p></div>

        - *正确性*（一致的渲染）：

            不使用系统字体的根本原因是它们不多，在操作系统 & 设备之间变化，通常不是很好（缺乏替代品 & 像小型大写字母这样的功能，& 经常缺乏基础如 Unicode），并且可能有错误（例如 Apple 发布了一个 [Gill Sans](https://en.wikipedia.org/wiki/Gill%20Sans) 数字化——不是晦涩的字体！——它 [>22 岁 & 有损坏的字距](https://github.com/ForumMagnum/ForumMagnum/issues/6713)).

            我最初使用系统 ["Baskerville"](https://en.wikipedia.org/wiki/Baskerville)，但它们在一些屏幕上看起来很糟糕（类似于模仿 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 的人在屏幕上使用 [Computer Modern](https://en.wikipedia.org/wiki/Computer%20Modern) 的问题），而且系统字体的极其有限的选择并没有给我很多选项。[Google Fonts](https://en.wikipedia.org/wiki/Google%20Fonts) Baskerville 还可以，但缺乏许多功能 & 比托管我自己的 webfont 慢，所以 Said Achmiz 说服我切换到自托管 ['screen serif'](https://blog.obormot.net/Screen-serif-fonts) Source 系列，我喜欢它的外观，它可以子集化到只有必要的字符以比 Google Fonts 更快 & 不会成为瓶颈，而且当时尽管是 FLOSS & 高质量 & 积极维护，但并未被广泛使用（所以有助于我的个人品牌）。

            然后我们多次被迫添加更多字体来修复显示错误：字体在 Linux & Mac 上看起来可能会有很大不同，Windows 上的系统 "sans" 目录看起来很糟糕。外观设计得越仔细，不同平台上‘相同’字体的尺寸或外观的微小差异就越会搞砸事情。链接图标、侧边注、表情符号、返回箭头、各种 Unicode 看起来相当不同或破坏——所有的这些都遇到了平台问题，后来的功能如引用下标或 [通胀调整](#inflation) 肯定会遇到问题，如果我们不能将它们的 CSS 调整到已知字体。

            （我们应该让读者设置他们自己的字体吗？读者，现实点。现在是 2023 年，不是 1993 年。今天没有人设置自己的字体或编写自定义 CSS 样式表——这无论如何都会破坏许多网站上的布局 & 图标——而且他们 *特别* 不会在占我网站流量 ~50% 的移动设备上这样做。）
        - *小型大写字母*：在网站设计中广泛用于粗体 & 斜体之间的不同级别的强调，所以高质量的小型大写字母至关重要；真正的小型大写字母由 Source 提供（斜体可能还在 [应我的要求](https://github.com/adobe-fonts/source-serif/issues/46) 添加），而大多数字体中不可用
        - *一致的单色表情符号* 通过 [Noto](https://en.wikipedia.org/wiki/Noto_fonts) [Emoji](https://en.wikipedia.org/wiki/Noto_fonts#Emoji)（以前，表情符号在链接图标中大小不一，有些在某些平台上颜色不可预测，并在页面上尖叫）
        - [IBM Plex Mono](https://en.wikipedia.org/wiki/IBM%20Plex%20Mono) 用于源代码：与普通等宽系统字体相比，IBM Plex Mono 中的 *易混淆字符更独特*（Plex Mono 有一个 [OpenType](https://en.wikipedia.org/wiki/OpenType) 功能，用于斜杠零，只能在源代码中启用），并且在 Mac 上看起来不错。^[IBM Plex Mono 部分是通过使用 [CodingFont](https://www.codingfont.com/) ‘锦标赛’选出的；[Adobe Source Code Pro](https://en.wikipedia.org/wiki/Source%20Code%20Pro) 排名也很高，我们最初使用了它，但 Plex Mono 以其有用的替代品和稍好的整体外观险胜。（谁知道 IBM 能委托这样一种漂亮的等宽字体？）]

            - Source 系列还提供 [**表格 & 比例数字**](https://en.wikipedia.org/wiki/Typeface#Typesetting_numbers)（也称为 ["旧式"](https://practicaltypography.com/alternate-figures.html#oldstyle-figures)），大多数字体不提供，这使得表格与文本更易读（比例数字会破坏类似于代码的比例与等宽字体在表格内的视觉对齐，而表格数字在常规文本内看起来很大 & 突兀）
        - *图标* 通过 [Quivira 字体](http://www.quivira-font.com/)，以及像 [Interrobang (疑问惊叹号)](https://en.wikipedia.org/wiki/Interrobang)、[Asterism (星号)](https://en.wikipedia.org/wiki/Asterism%20%28typography%29)、[Irony punctuation (反向问号)](https://en.wikipedia.org/wiki/Irony%20punctuation)、带十字的盾牌（用于链接图标）、黑色方块 ■ 这样的稀有字符，以及子集中没有的稀有 Unicode 点的回退字符的一致性。

        </div>
    - 高效的首字下沉字体 [通过 [子集化]{.smallcaps}](/dropcap#web-dropcap-implementation)
- **图像优化**：PNG 通过 `pngnq`/`advpng` 优化，JPEG 通过 `mozjpeg` 优化，SVG 被缩小，PDF 通过 [`ocrmypdf`'s](https://github.com/ocrmypdf/OCRmyPDF) [JBIG2](https://en.wikipedia.org/wiki/JBIG2) 支持压缩。（GIF 完全不使用，取而代之的是 WebM/MP4 `<video>`。）
- **JavaScript/CSS 缩小**：因为 [Cloudflare](https://en.wikipedia.org/wiki/Cloudflare) 做 [Brotli](https://en.wikipedia.org/wiki/Brotli) 压缩，缩小 JavaScript/CSS 几乎没有优势^[或者至少，我们这么认为？Google PageSpeed 一直声称缩小会减少总时间多达半秒。] 并且使开发更难，所以不做缩小；除了子集化外，字体文件也不需要任何特殊压缩。
- **MathJax**：获得渲染良好的数学方程需要 MathJax 或类似的重量级 JavaScript 库；更糟糕的是，即使在禁用功能后，加载 & 渲染时间也非常高——像 [胚胎选择页面](/embryo-selection "'Embryo Selection For Intelligence', Gwern 2016"){#es-2} 这样既大又有许多方程的页面明显需要 >5s（正如一个有用地弹出的进度条告诉读者的那样）。

    这里的解决方案是 [在 Hakyll 编译后在本地预渲染 MathJax](https://joa.sh/posts/2015-09-14-prerender-mathjax.html)，使用本地工具 [`mathjax-node-page`](https://github.com/pkra/mathjax-node-page/) 加载最终的 HTML 文件，解析页面以找到所有的数学，编译表达式，定义必要的 CSS，并写回 HTML。页面仍然需要下载字体，但总速度从 >5s 变为 <0.5s，并且根本不需要 JavaScript。
- **自动链接化正则表达式**：我编写了 [`LinkAuto.hs`](#linkauto-hs)，一个 Pandoc 库，用于自动将用户定义的正则表达式匹配字符串转换为链接，以自动将所有科学术语转换为维基百科或论文链接。（手动注释太多了，特别是随着新术语添加到列表或为弹窗生成摘要。）

    “根据正则表达式列表测试所有字符串并在匹配时重写”听起来简单容易，但朴素的方法是指数级的：_n_ 个字符串，每个测试 _r_ 个正则表达式，所以总共 𝒪(_n_^_r_^) 匹配。Gwern.net 上有 >600 个初始正则表达式 & 数百万个单词……正则表达式匹配很快，但没 *那么* 快。将其纳入‘可接受’范围（~3× 减速）需要一些技巧。

    主要的技巧是将每个文档转换为简单的纯文本格式，并且正则表达式针对 *整个* 文档运行；在平均情况下（想想短页面或弹窗注释），将有零匹配，整个文档可以被跳过。只有匹配的正则表达式才会用于全强度 AST 遍历。虽然针对整个文档检查正则表达式很昂贵，但它比针对该文档内的每个字符串节点检查该正则表达式要便宜一两个数量级！

正确性：

- <span id="dark-mode"></span> [**深色模式**](https://en.wikipedia.org/wiki/Light-on-dark%20color%20scheme) (<span class="dark-mode-selector-inline"></span>)：我们的深色模式是自定义的，试图使深色模式成为一等公民。

    #. [避免闪烁 & 滞后滚动]{.smallcaps}：它以创建两个调色板的标准最佳实践方式实现（为每个元素关联一组颜色变量，用于浅色模式，然后通过反转 & 伽马校正自动生成深色模式颜色），并使用 JavaScript 切换媒体查询以立即启用该颜色。

         这避免了常规基于 JavaScript 的方法产生的页面加载时的‘白色闪烁’（因为 CSS 媒体查询只能实现自动深色模式，而深色模式小部件需要 JavaScript；然而，当 JavaScript 决定将深色模式 CSS 注入页面时，为时过晚，该 CSS 将在读者已经暴露于闪烁之后最后渲染）。单独的调色板方法还避免了使用反转 CSS 过滤器的滞后 & 抖动（人们会认为 `invert(100%)` 从性能角度来看是免费的，因为有什么像素操作比否定颜色更简单？——但它不是）。
    #. [原生深色模式配色方案]{.smallcaps}：我们根据需要修改配色方案。

        由于对比度的变化，仅反转配色方案 *大多* 有效。特别是，行内 & 代码块往往会消失。为了解决这个问题，我们允许从纯单色稍微偏离以添加一些蓝色，并且源代码语法高亮微调了一些蓝色/紫色/红色颜色以获得深色模式可见性（因为 ALGOL 语法高亮风格没有任何逻辑上的深色模式等价物）。
    #. [反转图像]{.smallcaps}：彩色图像默认去饱和 & 灰度化以降低其亮度；灰度/单色图像，由机器学习 API [InvertOrNot.com](https://invertornot.com/) 自动反转。

        这避免了常见的失败模式，即博客使用正确实现类方法的深色模式库……但随后他们所有的图像仍然有刺眼的亮白色背景或整体着色，违背了初衷！然而，人们也不能盲目地反转图像，因为许多图像，特别是人的照片，作为‘照片底片’是垃圾。

        <div class="admonition tip">
        <div class="admonition-title">将您的设备默认为深色模式</div>
        如果您向您的应用程序或网站添加深色模式，请将 *您的* 设备设置为深色模式——即使您不喜欢深色模式或它不合适。

        您会有仅限深色模式的错误，但您的读者 [永远不会告诉你关于错误](https://pointersgonewild.com/2019/11/02/they-might-never-tell-you-its-broken/ "‘They Might Never Tell You It’s Broken’, Chevalier-Boisvert 2019"){#chevalier-boisvert-2019-2}，特别是奇怪的一次性错误。由于注销的设备或截图或常规开发，您会经常看到您的浅色模式，所以您需要 **强迫自己** 使用深色模式。</div>
    #. <span id="tri-state-dark-mode-toggle"> </span> [三向深色模式切换]{.smallcaps}：许多深色模式是用存储在 cookie 中的简单二进制开/关逻辑实现的，忽略浏览器/操作系统偏好，或简单地将‘深色模式’定义为当前浏览器/操作系统偏好的否定。

        这是不正确的，并导致奇怪的情况，如网站在白天启用深色模式，然后在 *晚上* 启用 *浅色模式*！
        使用自动/深色/浅色三态切换意味着读者可以强制深色/浅色模式，但也可以将其保留在‘自动’以全天遵循浏览器/操作系统偏好。

        这需要一个 UI 小部件 & 它仍然会产生 [仅自动深色模式](/design-graveyard#auto-dark-mode) 的一些问题，但总的来说，在不经询问启用深色模式、读者控制/混淆和避免在错误的时间使用深色模式之间取得了最佳平衡。
- **可折叠部分**：管理页面的复杂性是一种平衡行为。提供重现结果所需的所有代码是好的，但读者 *真的* 想看一大块代码吗？有时他们总是想，有时只有少数对血腥细节感兴趣的读者想阅读代码。同样，一个部分可能会详细讨论一个切题的主题或提供额外的理由，大多数读者不想费力读完以继续主题。代码或部分应该被删除吗？不。但将其归入附录或完全单独的页面也不令人满意——特别是对于代码块，如果代码块被打乱顺序，就会失去文学编程的方面。

    一个好的解决方案是简单地使用一点 JavaScript 来实现 [Code folding (代码折叠)](https://en.wikipedia.org/wiki/Code%20folding) 方法，其中部分或代码块可以在视觉上缩小或折叠，并通过鼠标点击按需展开。折叠部分由 HTML 类指定（例如 `<div class="collapse"></div>`），并且可以显示折叠部分的摘要，由另一个类定义（`<div class="abstract-collapse">`）。这允许代码块在冗长或分散注意力的地方默认折叠，并且整个区域可以折叠 & 总结，而无需诉诸许多附录或强迫读者转到完全单独的页面。
- **侧边注**：人们可能会想，当大多数侧边注使用像 [Tufte-CSS](https://edwardtufte.github.io/tufte-css/#sidenotes) 这样使用静态 HTML/CSS 方法时，为什么 `sidenotes.js` 是必要的，这将完全避免 JavaScript 库并在加载后可见地重绘页面？

    问题是 Tufte-CSS 风格的侧边注不回流并且仅在右边距（浪费左侧相当大的空白），并且根据实现，可能会重叠，被推到页面下方远离它们的地方，当浏览器窗口太窄时断裂或根本不在智能手机/平板电脑上工作。（这是 [可修复的](https://github.com/edwardtufte/tufte-css/issues/93#issuecomment-670695382)，Tufte-CSS 的维护者只是没有修复。）JavaScript 库能够处理所有这些，并且可以处理最困难的情况，如 [我的 _Radiance_ 注释版](#scholz-et-al-2013)。（然而，[Tufte-CSS 风格的题词](https://edwardtufte.github.io/tufte-css/#epigraphs) 没有这样的问题，我们采取相同的方法定义 HTML 类 & 使用 CSS 样式化。）
- **链接图标**：为 Gwern.net 中使用的所有文件类型和大多数常用链接网站（如维基百科）定义图标，或者 Gwern.net（页面内部分链接获得上/下箭头以指示相对位置，'¶' 作为无 JavaScript 的回退；跨页面链接获得徽标图标）。

    它们是在 [标准方法失败](/design-graveyard#static-link-icon-attributes) 时以可扩展的编译时方法实现的。
- **重定向**：静态网站在重定向方面有麻烦，因为它们只是静态文件。AWS 3S 不支持类似 `.htaccess` 的机制来重写 URL。为了允许移动页面 & 修复断开的链接，我编写了 [`Hakyll.Web.Redirect`](https://jaspervdj.be/hakyll/reference/Hakyll-Web-Redirect.html) 用于生成带有重定向元数据+JavaScript 的简单 HTML 页面，它只是从 URL 1 重定向到 URL 2。在转移到 Nginx 托管后，我将所有重定向转换为常规 Nginx 重写规则。

    除了页面重命名，我还监控 Google Analytics 中的 404 点击以尽可能修复错误，以及 Nginx 日志。事实证明，拼写错误 Gwern.net URL 的方式多得惊人，到目前为止我已经定义了 >20k 重定向（除了用于修复错误模式的通用正则表达式重写）。

# 外部链接

- 讨论：[HN](https://news.ycombinator.com/item?id=30928081)
- ["体验真实水平"](https://www.youtube.com/watch?v=-MwCJpEuC44) ([_Rick and Morty_](https://en.wikipedia.org/wiki/Rick%20and%20Morty), S3E8 "Morty's Mind Blowers")

# 附录
## 回归设计？

<span id="perfection"></span> <span id="perfection-premium"></span>

<div class="abstract">
> 工业设计、UI/UX、排版等投资回报的‘形状’是什么？
> 它是努力与回报的黄金均值的 S 形曲线……还是平庸的不快乐山谷的抛物线？
>
> 我对 Gwern.net 设计改进的经验是，读者我很早就赞赏使其内容更令人愉快的更改（哪怕只是与互联网的其他部分相比！），但在某一点之后，这一切都‘结合在一起’，在某种意义上，读者开始对设计赞不绝口，并指向 Gwern.net 的 *设计* 而不是其内容。
> 这与‘收益递减’的默认直观模型不一致，在该模型中，每一个连续的设计调整都应该比前一个价值低。
>
> 是否存在‘[完美](/doc/psychology/collecting/2020-isaac.pdf "'The Perfection Premium', Isaac & Spangenberg 2020") [溢价](/doc/psychology/writing/2020-blunden.pdf "'Beyond the Emoticon: Are There Unintentional Cues of Emotion in Email?', Blunden & Brodsky 2020")’（也许作为 [潜在不可观察质量](/doc/statistics/bayes/regression-to-mean/index "'Regression To The Mean Fallacies', Gwern 2021") 的信号，或者也许读者互动就像 [O 形环过程](/doc/statistics/order/selection/pipeline/index "'Leaky Pipelines', Gwern 2014")）？
</div>

<div class="epigraph">
> *归因*——通过心理转移传播媒介的特征形成对产品、公司或人的印象的过程……人们 **确实** 通过封面判断一本书……Apple Computer Inc. 的总体印象（我们的形象）是客户从 Apple 看到、听到或感觉到的所有东西的综合结果，不一定是 Apple 实际上是什么！我们可能有最好的产品、最高的质量、最有用的软件等；如果我们以粗制滥造的方式展示它们，它们将被视为粗制滥造；如果我们以创造性、专业的方式展示它们，我们将归因出所需的品质。
>
> [Mike Markkula](https://en.wikipedia.org/wiki/Mike%20Markkula), ["The Apple Marketing Philosophy: Empathy • Focus • Impute"](https://archive.computerhistory.org/resources/access/text/2019/03/102789075-05-01-acc.pdf#page=9) (1977-12)
</div>

<div class="epigraph">
> _Si paulum summo decessit, vergit ad imum_
>
> [Horace](https://en.wikipedia.org/wiki/Horace), [_Ars Poetica_](https://en.wikipedia.org/wiki/Ars_Poetica_(Horace))
</div>

特别是对于排版，似乎有无限数量的繁琐细节可以花时间（其中大部分似乎是 [为了新颖](/font "'Who Buys Fonts?', Gwern 2021")，而像 [广告危害](#ads-2) 这样重要得多的事情却被所谓的设计师忽略了）。
最初的猜测是，像大多数事情一样，它会是收益递减的：随着人们接近柏拉图式的理想，每一个额外的调整都会花费更多的努力。
一个更复杂的猜测是，它看起来像一个 [S 形曲线](https://en.wikipedia.org/wiki/Sigmoid%20function)：起初，有些东西是 *如此* 糟糕，以至于任何修复对读者来说都无关紧要，因为那只是意味着他们遭受 *不同* 的问题（如果网站因为 JavaScript 错误而不渲染，那么文本渲染得太浅以至于无法阅读也没多大关系）；然后每个改进都会对一些读者产生影响，因为它接近可敬的平庸；在那之后，又回到了收益递减。

我改进 Gwern.net 设计 & 阅读有关设计的经验让我怀疑这两个是否正确。
形状可能更像抛物线：S 形曲线，在某一点，飙升并回报 *增加* 而不是减少？

我注意到在前五年左右的时间里，没有人太注意我做的调整，因为它是一个普通的基于 Markdown 的静态网站。
随着我不断修补，偶尔会有评论。
当 Said Achmiz 借出他的才华添加功能 & 增强功能并探索新颖的调整时，评论更频繁地出现（与花费在上面的时间的大幅增加一致）；到 2019 年，重新设计已基本稳定，大多数标志性功能 & 视觉设计已实施，2020 年更多的是关于错误修复而不是增加活力。
根据直观理论，评论率将大致相同：虽然错误修复可能涉及巨大的努力——深色模式重写是 3 个月的痛苦——但改进越来越小——所述重写除了消除缓慢之外没有读者可见的更改。
但是，虽然 [网站流量](/traffic "'Gwern.net Website Traffic', Gwern 2011") 保持稳定，但 2020 年吸引了比以往更多的赞美！

同样，LW 团队投入了不寻常的精力来设计 [2018 年论文汇编](https://www.lesswrong.com/posts/TTPux7QFBpKxZtMKE/the-lesswrong-2018-book-is-available-for-pre-order)，使其时尚（甚至重绘所有图像以匹配颜色主题），[他们惊讶于](https://marginalrevolution.com/marginalrevolution/2020/12/what-is-the-meta-rational-thing-to-do-here.html#blog-comment-160189881 "'What is the meta-rational thing to do here? [comments]', Pace 2020") 预订量有多大：不是几个百分点，而是很多倍。
（有许多关于数据可视化的书，但我怀疑 Edward Tufte 的书销量超过它们，即使是最好的，也有类似的数量级。）
我们应该如何看待 [Apple & 设计](/review/movie#rams)，其设备 & 软件有明显的缺陷，但通过做更多的尝试，获得了溢价并受到公众的好评？或者 Stripe？^[也许设计的回归也会 *随着时间的推移而增加*，因为互联网设计师越来越得到他们上吊所需的所有绳索？浏览器开发者 & 摩尔定律给予的，半恶意的网页 [designer (设计师拿走)](https://en.wikipedia.org/wiki/Wirth%E2%80%99s%20law)。每年，从最差到最好网站的范围都在扩大，因为降低浏览体验的全新方法——不是 1 个而是 100 个跟踪器！通讯弹窗！支持聊天！Taboola 诱饵箱！'请求浏览器通知'！50MB 的英雄图像！就在你点击某物时的布局偏移！——被发明出来。BBS 上的 80 列 ASCII 文本文件几乎没有设计上的伟大之处，但它们也很难搞砸。要制作一个 *非常* 糟糕的网站需要最新的 CMS，A/B 测试基础设施以 [Schlitz 你的方式](/banner#schlitz) 盈利，CDN，广告网络拍卖技术，以及仅使用 Apple 笔记本电脑的高薪网页设计师。（[2021 年的讽刺](https://how-i-experience-web-today.com/)；请注意，你需要禁用广告拦截。）鉴于这种向退化 & 短期利润蠕动的微妙性以及与健康/盈利能力的相对较弱的相关性，[我们不能指望任何快速进化](/backstop "'Evolution as Backstop for Reinforcement Learning', Gwern 2018") 向更好的设计发展，不幸的是，但对于那些有品味的企业来说，这是一个机会。]

如果 S 形曲线是正确的，那么需要多大的努力才能引出这样的跳跃？
多几个数量级？
我 & Said 肯定投入了精力，但有无数的网站（即使仅限于个人网站并排除拥有专业全职开发人员/设计师的网站），其创建者肯定投入了更多时间；通过自出版每年出版数百万本书；Apple 肯定不是唯一一家试图设计好产品的科技公司
