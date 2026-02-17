---
title: "风格手册"
description: "Gwern.net 论文和代码写作约定的风格指南文档。"
thumbnail: /doc/ai/nn/transformer/gpt/dall-e/4o/2026-01-07-gwern-gpt5-thevelveteenrabbit-velveteenaishoggoth-simplifiedforthumbnail.png
thumbnail-text: "天鹅绒修格斯：如果一个男孩爱修格斯足够长、足够深，它能变成一只<em>真正的</em>兔子吗？"
created: 2025-05-07
modified: 2026-01-14
status: in progress
confidence: certain
css-extension: dropcaps-kanzlei
...

<div class="abstract">
> 本页是 Gwern.net 的风格手册，以简洁的“经典风格”定义了散文、排版和引文的内部惯例。
> 它被编写为可供人类和工具使用，包括第三方编辑器和LLM。
>
> 它指定了 Pandoc Markdown 和 HTML 实践，包括旨在保持页面密集但可导航的“冰山”信息层次结构（摘要、页边注释、脚注、折叠和附录）。
> 它还标准化了链接和引用行为（最小 `Surname Year` 链接、深层锚点以及弹出窗口和存档的元数据）。
>
> 它编码了表格、图形和代码的表示规则（语言标记块、Bash/Haskell/Elisp 约定和 lint 友好的源格式），以及文件命名和格式白名单以实现长期稳定性。
> 它包括针对生成媒体的明确政策：仅允许人工编辑、明确来源以及积极删除模型讲述。
>
> 目标是“长内容”：持久的、自记录的超文本，可以干净地编译，在源代码管理中读取良好，防止链接腐烂，并保持数十年的可维护性。
</div>

这是 Gwern.net 的[风格指南](!W)，记录了格式/写作/编码偏好和注意事项。
它主要面向 LLM 等第三方，本着 [`.cursor/rules`](https://docs.cursor.com/context/rules "‘Rules file’, Cursor 2024") 文件的精神。

背景：[Design](/design "‘Design Of This Website’, Gwern 2010") [原理](/design#principles)、[拒绝设计](/design-graveyard "‘Design Graveyard’, Gwern 2010")、[实时功能测试](/lorem "‘Lorem Ipsum’, Gwern 2020")、[下标](/subscript "‘Subscripts For Citations’, Gwern 2020")、[关于如何为 LLM 编写内容的思考](/llm-writing "‘Writing for LLMs So They Listen’, Gwern 2024")；[英文维基百科 MoS](!W "Wikipedia:Manual of Style")。

# 浓缩 MoS {.collapse}

2026 Gwern.net 风格要求简洁的“经典风格”：分析性、声明性和非对冲性，优先考虑清晰度、精确性和长期一致性。
它使用 [Pandoc](!W) [Markdown](!W) 编译为 [HTML5](!W)。

严格遵守美式拼写（默默地编辑引号以保持一致性，原始文件已存档）、公制单位（提供英制引用的转换）、牛津逗号和逻辑引用。
句号后使用单倍行距。
使用凯塞尔曼估计词来表示概率。
写入 `statistical-significance testing`（连字符）并将“I/II 类错误”替换为 `false positive/negative`。
省略缩写词句（CIA、AI）和个人头衔（先生/女士）；第一次使用时应拼写出不熟悉的术语并**粗体定义**，维基百科风格。
书目引文（特定作品支持的声明）通常应使用最少的 `Surname Year[a–z]` 全文链接，因为这会驱动弹出窗口和链接书目生成。
散文中的普通超链接可以使用自然锚文本。
理想情况下，参考文献是带有特定于页面的锚点（例如 `#page=N`）的本地存档 PDF。
超过 ~1,000 的数字或那些容易与年份混淆的数字使用数字组逗号（例如 `$1,234.56`）；货币需要通货膨胀调整语法，例如 `[$1]($2026)`{.Markdown} 或比特币日期标记 `[₿1](₿2026-01-01)`{.Markdown}。
日期为 `YYYY-MM-DD` 或“2026 年 5 月 8 日”。
为了源代码的可读性和版本控制，请使用“通风的散文”：每个源代码行一个句子，段落之间用双换行符分隔。
嵌套突出显示的强调循环为 **strong** → *斜体* → `span.smallcaps`{.HTML}（无限重复）。

页面遵循信息密度的“冰山”模型：初始的 `div.abstract`{.HTML}（一个块引用，理想情况下分为多个块，遵循科学结构：背景、方法、结果、结论）在从左到右的细节层次结构之前 - 边注（简短的、左对齐的段落摘要；如果多个，它们形成一个部分的微型目录），然后是段落、简洁的脚注/旁注（≤200 个字）用于离题，绝不是简单的引用），可扩展的 `div.collapse`{.HTML} 元素用于更长的旁白或摘录（≤500 个单词，`.abstract-collapse`{.HTML} 用于摘要文本），最后是附录（也以摘要开头）。
自定义 HTML，支持显式 `<div>`{.HTML}/`<span>`{.HTML} 包装器，以实现对可能有问题的标准标签（例如 `<details>`{.HTML}、`<abbr>`{.HTML}）的控制和一致性，使用*通用 → 特定*类名称（例如`link-live`{.HTML}) 和 `-not`{.HTML} 否定（例如 `link-live-not`{.HTML}）；最具体的元数据（例如链接的类属性）会覆盖站点范围的配置。
链接可以通过 `title="‘Title’, Author Year"`{.HTML} 属性来丰富（主要是为了作者的编辑方便，其次作为后备工具提示；例如 `[display text](/url "'Essay Title', Smith 2026")`{.Markdown}），自动扫描本地存档以防止链接腐烂，并分配文件类型/域图标，除非明确抑制（例如 `.icon-not`{.HTML}）。
URL 是短的、非复数的 slugs（例如 `/sidenote`）或精确锚定的深层链接。
文件遵循 `YYYY-surname[-description][-nth].ext` 命名（例如 `2025-01-01-gwern-gpt4o-frogmeme-desc.png` 以增强可查找性），并使用为稳定性和安全性而选择的批准格式的保守白名单（例如 JPG/PNG、XZ-tarball、DjVu 上的 PDF）。

图像在 `<figure>`{.HTML} 元素中呈现，这些元素可能具有详细的多部分标题 (`**Figure X**: _Summary statement._<br>(*A*) Detail one. (*B*) Detail two.`{.Markdown})，并支持点击缩放轮播；默认情况下，暗模式反转由 InvertOrNot.com 控制，但可以使用 `.invert`{.HTML}/`.invert-not`{.HTML} 类覆盖。
列表始终按逻辑顺序排列（按相似性、重要性或字母顺序）；如果包含 >6 个短项目（<30 个字符），则应通过 `<div class="columns">`{.HTML} 使用两列布局。

代码块必须指定语法突出显示的语言，包括关注“为什么”和“为什么*不*”的注释，并干净地编译/运行。
具体来说：[Bash](!W) 脚本必须 `set -e`{.Bash}（显式忽略 `|| true`{.Bash} 的错误）并使用长标志（例如 `sort --unique`{.Bash}）； Haskell 使用 `ghc -Wall -Werror`{.Bash} 进行编译，采用完全枚举的标准合格导入； Emacs Lisp 必须产生零字节编译警告。

*仅*经过严格的人工打磨以满足高质量标准，在正文中或通过文件名/标题（记录模型和日期，例如 `2025-gwern-gpt4o5-concept.png`）进行明确标记，并仔细去除常见伪影或刻板风格告诉（例如，没有“棕褐色 GPT-4o 图像”或“深入研究”）后，才允许生成 AI 输出（文本或图像）。
排版华丽——例如针对特定主题的首字下沉（请咨询 `/dropcap` 了解当前使用情况，针对未使用的字母）、用于强调的 `span.smallcaps`{.HTML}、铭文（斜体引用、罗马出处）或警告 (`div.admonition [tip/note/warning/error]`)——必须通过真正提高可读性或信息密度来“赢得”，而不仅仅是装饰性地使用。

总体目标是持久的、自我记录的超文本：散文精确且明确，代码明确且健壮，并且几十年来最大限度地抵抗链接腐烂或风格漂移。

# 写作

- 尽管探索了复杂主题，预期风格与态度仍应是**分析性、探究性、精确性**，遵循西方写作中的[“经典风格”](/review/book#clear-and-simple-as-the-truth-thomas-1996)。

    - *恒定的新颖性*：正式程度应该与主题的新颖性成反比：[事物越奇怪，就越正式](https://www.lesswrong.com/posts/5GnwjxbL3SQ7gjRn6/open-thread-july-16-22-2013#gFRKkcyXDTiKkug56 "‘Spending Writing ‘Weirdness Points’ Wisely’, Gwern 2013")。
      对于“更安全”的话题，人们应该摆脱幽默、铭文、印刷特技和实验等。
    - 我尽量“避免对冲和排位”，即使冒着提出过于强烈主张的风险。这是一个滑坡。
- **使用网站功能隐藏详细信息**：因为它的参考文献太多，没有充分注意减少读者疲劳，所以它有可能成为难以阅读的引文海洋、不透明的超链接和块引用：读者需要帮助导航所有链接，以链接图标的形式，将内容推迟到弹出窗口、折叠、词汇标准化等。

    这些功能可能会让初次阅读的读者感到混乱，但它们是为高级用户设计的。当经历足够多之后，他们就会懂得欣赏。
- 长期**维护很重要**：Markdown 源代码的可读性“几乎”与最终产品一样重要。

    如果作者不能阅读它，那么他们就不能轻易地改进它，他们也不会享受写作的乐趣，并且会厌恶风险或倦怠。

    如果机器无法读取它，则无法检测到错误、添加新功能或避免回归；损坏的语法和链接、拼写错误、视觉故障和其他微妙的问题会随着时间的推移而堆积起来，而不会被注意到。
- **美式拼写**；我冒昧地以一致性的名义默默地编辑引用和标题，除非有特殊原因要保留原始拼写，例如。在诗歌中。

    （由于我总是提供原始全文的存档，因此我会毫不犹豫地修改写作版本以方便读者。）
- 默认情况下为**公制**单位。 （如果是引用，应该默默地编辑为公制；如果是习语，则不要管它。）
- [**牛津逗号**](!W)
- [**逻辑报价**](!W)

    - *与运算符*：“&”与“and”用于消除“and”等逻辑运算符的使用歧义，其中预期的嵌套可能不清楚（例如，如果一个意思是 `X AND (Y OR Z)` 或 `(X AND Y) OR Z`）。

        （比较“链接标题可能包括作者和日期或来源标识符。”与“链接标题可能包括作者和日期或来源标识符。”）
- <span id="editorial"></span> **编辑评论**，无论是文本还是 UI/UX，都写在方括号中。

    它们使用 `div/span.editorial`{.HTML} 进行标记，其样式与常规正文文本不同（[示例](/doc/biology/2025-glanville.pdf "‘Snake venom protection by a cocktail of varespladib and broadly neutralizing human antibodies’, Glanville et al 2025"){.backlink-not}）。

    在 Markdown（但不是 HTML）文件中，由于双括号的语法风险，所有内括号都应该转义；不要写 `[[commentary]]{.editorial}`，而总是写更安全、更明确的 `[\[commentary\]]{.editorial}`。

    `div.editorial`{.HTML} 对于提供文件或图像的冗长描述（尤其是 AI 生成的文件或图像；[例如 ](/doc/math/humor/2025-05-03-gwern-gpto3-demotivationalposter-heraclitus-youcanneverreproducethesamebugtwice.png "‘You Can Never Reproduce The Same Bug Twice demotivational poster’, Gwern 2025"){.backlink-not}）也很有用。
- **编辑省略**：省略号，但没有空格且不在方括号中（“A...B”，而不是“A ... B”或“A \[...\] B”）。

    考虑到大量使用摘录，括号会显得唐突，而省略空格既可以节省空间，又不会与使用省略号结尾产生歧义（“A...B”≠“A...B”）。
- **内联作者/年份引文**：在编写正式的书目引文时（与运行文本中的正常锚点相反），引文以 Markdown 中尽可能小的形式编写：“Surname Year\[a--z\]”、“Surname-1 & Surname-2 Year\[a--z\]”或“Surname et al Year\[a--z\]”。

    该规则仅适用于书目引用。
    当锚点正在进行语义工作时（例如“令人惊讶”、“复制失败”、“参见讨论”），请勿扭曲运行散文以强制姓氏年份作为锚文本。
    在这些情况下，要么（1）在同一作品中添加一个附近的姓氏年份引用，要么（2）接受它“只是一个链接”，而不是正式引用。

    消歧后缀“\[a--z\]”按照现场首次使用的顺序分配。例如，如果我引用“John Smith 2020”，然后引用“Jane Smith 2020”，则它们将分别是“Smith 2020a”/“Smith 2020b”。

    它们不是以括号的形式写的；引用文本中的实例（例如注释）必须重写为 Gwern.net 引用样式。

    引文风格很重要，因为它们将被自动检测并编译成我开发的带下标的椭圆形式，以便于阅读。
    有关 Pandoc API 从书面 Markdown `Foo et al 2026` 转换为显示的“Foo et al 2026”形式的详细信息，请参阅 [`Typography.hs`](/static/build/Typography.hs)。

    首次使用引文时应始终使用全文 URL，最好带有注释；例如，`[concept name](/doc/topic/source.pdf "‘Full Title’, Author Year")`{.Markdown}。
    （URL 会自动转换为参考书目，无需手动参考书目。）

    无论多么方便，自引通常都会写出来；然而，它们通常不会写成“Gwern YYYY”，而是更自然的写法，例如“正如我之前写的......”。
- **缩略词/缩写词删除句点**，因为不必要（例如“CIA”，而不是“C​.I​.A​.”；“AI”，而不是“A​.I​.”）

    - 同样，*标题应该被删除*。虽然《纽约时报》可能坚持总是提到“奥特曼先生，OpenAI 首席执行官”，但我们其他人发现“奥特曼，OpenAI 首席执行官”更容易阅读。
    - *拉丁缩写*保留句点（例如“eg.”、“ie.”、“cf.”、“etc.”）；在出现完整的外来短语之前不要使用斜体

        没有句号写起来更容易，但我发现这样看起来很奇怪，因为它们不是英语。
    - *可选*：更多*不寻常术语在首次使用时以粗体*定义，维基百科风格。 （对于其他术语，弹出注释被认为是足够的——不熟悉它们的读者可以简单地弹出它们并找出答案。）示例：“**国家航空航天局（NASA）**是一个独立机构......”
- **科学**：

    - *统计数据*：

        - [“统计显着性检验”术语]{.smallcaps}：始终用连字符和“统计”书写，以强调这些技术术语的含义远比它们看起来的要少，并减少错误的解释

            “I/II 型错误”也被禁止，以支持“假阳性/阴性”
        - [潜在变量]{.smallcaps}之类的因素总是大写以强调它们也不一定符合外行对这个词的理解。

            例如，大五人格因素“责任心”是一种技术性很强、具体的测量方法，存在缺陷和局限性，并不一定是非心理测量学家对“责任心”一词的理解，而写出诸如“我们测量士兵的责任心并预测未来职业成功......”之类的内容是有误导性的。
        - <span id="kesselman"></span> [概率置信术语]{.smallcaps}：尝试使用[凯塞尔曼估计词](/doc/statistics/bayes/2008-kesselman.pdf "‘Verbal Probability Expressions In National Intelligence Estimates: A Comprehensive Analysis Of Trends From The Fifties Through Post-9/11’, Kesselman 2008")（“确定”•“极有可能”•“可能”•“可能”•“不太可能”•“极不可能”•“远程”•“不可能”）。

            我们的一组估计词还包括“fiction”“log”（数据、经历、回忆录等）、“emotional”（感受、自我表达）。 <!-- `Config.Misc.yamlValidConfidences` -->
    - *化学*：手性用[smallcaps](!W){#wp-smallcaps-1}书写，例如。氨基酸茶氨酸的左手形式写为“<span class="smallcaps">1-</span>theanine”（请注意，“l”是小写字母，因为大写字母在小写字母时不起作用，即 `<span class="smallcaps">l-</span>`{.HTML}）。
- **数字**：以逗号分隔。 （特别是如果它们可能会混淆一年。）对于大于 1 的数字，最好使用数字来保持紧凑性。

    - *单位*：更喜欢紧凑，例如。 “55s”而不是“0m55s”。
      '大约'可以用'~'代替；类似地，“>”可以代替“大于”、“超过”、“至少”、“高于”等。
      （请勿使用 `&gt;`{.HTML} 等 HTML 实体写出不等式，除非编写原始 HTML 或在危险的上下文中。）
    - *通用单位基础*：当混合“十亿”或“百万”等单位时，尝试将它们转换为通用基本单位，以便于直观比较和子化。
      “1万亿美元”和“1亿美元”很难比较，但“1万亿美元”和“1亿美元”比较容易。
    - *科学记数法*：除了源代码文字外，不要写`1.5e3`这样的数字；更喜欢小数（如“1,500”）或完整的科学记数法（如“1.5 × 10^3^”）。
- **外来短语、单词或句子**：如果受过教育的英语读者不熟悉或不熟悉，则使用斜体； “海啸”或“等等”不是斜体，但“_pluralis auctoris_”是斜体。
- **日期**：日期写作“YYYY-MM-DD”或“日月年”。
  前者对于数据/表格/等来说是首选，但在散文中可能会很尴尬，而后者是可以接受的。这使得机器解析更容易并消除歧义。
- **句子**：句号后的单空格，而不是打字机的双空格。
- **语义换行**/“通风散文”：段落之间用双换行符分隔，每个句子之间用换行符分隔。 （即 `This is a sentence.\nThis is another sentence in the same paragraph.\n\nThis is a new paragraph.`）

    这种“通风的散文”使编辑和阅读 Markdown 源代码和 [diffs](!W "Diff").
    由于上下文依赖性并且不想在短句子中必然中断，因此不强制执行此操作。

    （请注意，“通风散文”并不意味着每个段落只有 1 句话长。
    它纯粹是关于 Markdown 源格式，不应该影响显示的文本。）
- **[_Pluralis auctoris_](!W)**：在描述作者所做的具体事情时使用“I”，例如进行实验（除非是合作，在这种情况下必须是“我们”）；当读者参与的一般性讨论时，使用复数“我们”。

    例如，“我”对一种药物进行自我实验，但“我们”阅读小说中的一段摘录并从中得出批判性结论；或者在本 MoS 中，我并不期望读者同意许多选择，并且我含蓄地排除了它们。
- **脏话**：像“f---k”或“d---n”这样的脏话会用破折号进行审查，以符合半学术风格（并且因为借用旧式维多利亚时代的写作惯例让我觉得很有趣）
- **与符号缩写**：为了消除逻辑歧义，“and”应缩写为“&”，其中“&”结合得更紧密。
- **章节交叉引用**：链接或引用时，“章节”一词缩写为章节符号“§”
- **作者链接**：链接作者时，如果可用，他们的首选规范 URL 在 [`Config.Metadata.Author`](/static/build/Config/Metadata/Author.hs).h] 中定义。

# 结构

不包括折叠的文本，理想的长度应如下所示：脚注应小于 200 个字；注释评论应<1000字； [“博客”帖子](/blog/index) 应<1,500 字；论文应小于 10,000 字。
超过这些长度，它们可能应该被重构或“升级”（可以使用[“锚点技巧”](#annotation-anchor)]分割注释；远低于他们，他们可能会更好地“降级”并转移到其他地方。

页面应该是信息密集的“冰山”：相对较短，很少有块引用，但有许多链接和摘录以及相关材料，只需将鼠标悬停在弹出窗口和折叠窗口中即可隐藏，并且可以通过带注释的链接参考书目、[反向链接](/design#backlink "‘Design Of This Website § Backlink’, Gwern 2010"){#backlinks-1}部分和类似链接阅读列表来获取。

节标题采用混合格式[标题大小写](!W)。
（标题大写则不用管——我对它们是否应该是[句子大小写](!W)或标题大写或其他大写没有强烈的感觉。）
标题长度不应超过 6 个单词，以尽量减少目录 (ToC) 中的换行。
由于 ToC 是由 Pandoc 自动生成的，因此很难调整或调整。

节应该是像程序一样的大块元素，或者至少有两个段落长。
（它们不应该是 1 句话长。）

各节应按详细程度进行组织，大致从左到右：节标题 → [边注](#margin-notes) → 段落 → 脚注/旁注 → 折叠元素 → 摘录或在弹出窗口内书写。
这与离题的层次结构并行：脚注/旁注 < 折叠 < 附录

可以在末尾添加“另请参阅”部分，以链接尚未链接的相关现场论文；相关的外部链接或文档可以包含在“外部链接”部分中。

未完成或草稿或未来的部分应使用 HTML 注释进行注释：`<!-- TODO -->`{.HTML}。

# 降价

论文被编写为独立的 Pandoc Markdown 文件：带有 Pandoc YAML 标头和尾随换行符的非空 Unix 文本文件。

Markdown 文件名为 `/directory/slug.md`，其中 slug 是 Unix 风格的小写字母数字连字符缩写或页面内容的助记符；例如。此页面为 `/style-guide.md`。
目录也是如此；除了 `/review/`、`/newsletter/` 和 `/fiction/` 等少数例外之外，目录在论文中的使用并不多。
（它们*大量用于在标签类别层次结构中组织文件和文档。）

- **列表**：

    - *应按深度在 3 个循环中强调关键字：顶级为粗体，第二级为斜体，第三级为小号，第四级为粗体，第五级为斜体，依此类推。
    - *无序列表*：应该有意义地排序，例如按相似性排序；如果没有顺序，则按字母顺序。
    - *有序列表*：使用 `#.`{.Markdown} 语法编写以进行自动编号，除非需要特定数字（例如，在编号列表的引用中，如格言列表）

        有序内联列表应使用全括号整数，牛津逗号分隔，例如“(1)一，(2)二，(3)三”。 （这有助于确保可扫描性、明确性和[自动平衡检查](#balanced-parentheses)。）
    - *列*：包含许多短项目的列表可以使用 `div.columns`{.HTML} 布置在多个列中。
      （可以给这些 ID 并链接、嵌入、折叠等）
      这会相应地创建 1--3 列。
- **标头**：标头 ID 在两种情况下必须被覆盖：

    - *无 ID 句点*：如果标头包含句点，则必须覆盖其 ID 以删除句点，否则 Pandoc 将生成无效的 HTML ID！

          因此，像 `# Gwern.net`{.Markdown} 这样的标头**必须**写为 `# Gwern.net {​#gwernnet}`{.Markdown}。
    - *手动标头编号*：如果标头是数字，Pandoc 的自动 ID 算法将（令人惊讶地）删除它并用 `section` 等替换。

      因此，像年份这样的数字标头必须写成 `# 2026 {id=2026}`{.Markdown}，以确保预期的 ID `#2026`{.HTML} 存在。
- **调查**：当报告我进行的调查结果时，他们应该遵循以下大致流程：“调查设计”→“调查问题”（引用的文书）→“结果”→“解释”。

    除了原始调查数据（通常是 CSV）之外，每个问题的结果还应随项目一起报告。

    如果可能，请提供文本可视化，例如 Unicode 迷你图（“▂▃▅▇”，例如 [`spark`](https://github.com/holman/spark) 或 [`termgraph`](https://github.com/mkaz/termgraph)]）。或进度条，例如。 `\[████████▒▒▒▒▒▒▒▒▒▒▒▒ 40%\]`{.Markdown}（20 块规模，每块 5%，使用“█”/“▒”）。
- **图像**：不需要 `**Figure N**`{.Markdown} 或替代文本（使用 Pandoc 的属性语法（如 `![](/foo.jpg){alt="..."}`{.Markdown}）编写，并且可能包含内联 HTML，受 `image-focus.js` 支持）。

    - *标题文本*（Pandoc 图标题）位于 `![…]`{.Markdown} 中。
    - 辅助功能*alt 属性可选*：但如果使用，则进入 `{alt="…"}`{.Markdown}。

## 论文元数据

Markdown 文章必须以 [YAML](!W) [Pandoc 元数据标头](https://pandoc.org/demo/example33/8.10-metadata-blocks.html#extension-yaml_metadata_block);每个文件只有一个 YAML 元数据标头。
枚举和每页唯一性的验证是在编译期间在 `hakyll.hs` 中完成的。

所有字段的顺序为：`title`{.YAML}、`author`{.YAML}、`description`{.YAML}、`thumbnail`{.YAML}、`thumbnail-text`{.YAML}、`created`{.YAML}、 `modified`{.YAML}、`thumbnail-css`{.YAML}、`status`{.YAML}、`confidence`{.YAML}、`importance`{.YAML}、`css-extension`{.YAML}。

必填字段：<!-- NOTE: if adding a new one, update `Config.Misc.pageMetadataFieldsMandatory` -->

- `title`{.YAML}：设置页面标题与第一个 `<h1>`{.HTML} 标题；使用简单内联 HTML（如斜体、小型大写、上/下标，但不要粗体或链接/脚注）； <!-- `Config.Misc.pageTitleMaxWords` --> <13 个词。
- <span id="metadata-field-description"></span> `description`{.YAML}：页面的简短内联 HTML 摘要（20--650<!-- `Config.Misc.pageDescriptionMinLength` - `Config.Misc.pageDescriptionMaxLength` --> 字符）；详细程度应介于标题与摘要之间。

    轻量级“博客”帖子（以 `/blog/` 开头的路径）不受描述要求的约束。
- `created`{.YAML}: "年-月-日";必须在“2008-01-01”之后明天之前。
- `status`{.YAML}：写作完成度的枚举值（“finished”“in progress”“draft”“notes”“abandoned”“obsolete”） <!-- `Config.Misc.yamlValidStatuses` -->

可选字段：

- `author`{.YAML}：以逗号分隔的作者列表，格式与注释相同。

    如果未设置，则假定作者是“Gwern”。
    如果是其他人，最好在页内包含一个明确的 [byline](!W)，使用 `<div class="text-center">by author</div>`{.HTML}。

    作者应在 `Config.Metadata.Author`{.Haskell} 中定义主页/个人资料 URL。
    人工智能作者应与人类作者一样被列出；除非一篇文章是 ~100% AI 生成的（并且明确指出了这一点），否则应首先列出主要人类作者，因为他们对整个页面负责。
- `modified`{.YAML}: "年-月-日";必须在“2008-01-01”之后明天之前。
- `confidence`{.YAML}：单个[扩展凯塞尔曼估计词](#kesselman)
- `importance`{.YAML} 0--10
- <span id="css-extension"></span> `css-extension`{.YAML}：空格分隔的 HTML 类，将在每个页面中替换

    这些用于设置整个页面的样式并控制诸如[页面 dropcaps](/dropcap "‘Dropcap Generation With AI’, Gwern 2023")、深色、浅色和假日主题等。

    字段示例：`css-extension: dropcaps-cheshire reader-mode`{.YAML} 将使页面使用 [Cheshire Art Deco dropcap](/dropcap#cheshire "‘Dropcap Generation With AI § Cheshire’, Gwern 2023")，同时默认打开阅读器模式以减少视觉混乱。

    值示例： `dark-mode`{.CSS} • `dropcaps-not`{.CSS} • `dropcaps-cheshire`{.CSS} • `dropcaps-de-zs`{.CSS} • `dropcaps-dropcat`{.CSS} • `dropcaps-gene-wolfe`{.CSS} • `dropcaps-goudy`{.CSS} • `dropcaps-kanzlei`{.CSS} • `dropcaps-yinit`{.CSS} • `extract-not`{.CSS} • `index`{.CSS} • `reader-mode`{.CSS} • `test-april-fools-2024`{.CSS} • `test-april-fools-2025`{.CSS} • `test-april-fools-2026`{.CSS} • `test-christmas`{.CSS} • `test-easter`{.CSS} • `test-halloween`{.CSS} • `toc-not`{.CSS} <!-- `Config.Misc.yamlValidCssExtensions` -->
- `thumbnail`{.YAML}：绝对图像路径（例如`/doc/cs/shell/2024-01-17-cmatrix-matrixstylescreenscroll.png`）；本地镜像必须存在。
  缩略图用于社交媒体预览、页面的注释弹出窗口，并且可以自动显示在页面摘要中以添加风格。

    - *缩略图重复使用*：通常（尤其是在诗歌/小说页面上）使用相同的图像作为 `thumbnail`{.YAML} 和体内全角人物。
        在这种情况下，请将 `thumbnail-text`{.YAML} 重新用作 `img title=`{.HTML}（或以其他方式确保它们保持一致）。
- `thumbnail-text`{.YAML}：缩略图的内联 HTML 标题文本（显示在链接预览/弹出窗口中）。

    可能很长并包含超链接等。理想但可选。
- `thumbnail-css`{.YAML}：应用于缩略图的 CSS 类（例如，`.invert-not` 用于不应在深色模式下反转的图像，如 `thumbnail-css: invert-not outline`{.YAML}）
- `placeholder`{.YAML} 布尔值“True”/“False”
- `index`{.YAML}：布尔值
- `error404`{.YAML}：布尔值
- `backlink`{.YAML}：布尔值

示例 YAML front-matter，基于此页面：

<!-- NOTE: zero-width spaces inserted into hyphen header below to fix Emacs markdown-mode syntax highlighting errors -->

~~~{.YAML}
​-​--
​title: "Manual of Style"
​description: "Style guide documentation of Gwern.net writing conventions for essays and code."
​thumbnail: /doc/ai/nn/transformer/gpt/dall-e/4o/2026-01-07-gwern-gpt5-thevelveteenrabbit-velveteenaishoggoth-simplifiedforthumbnail.png
​thumbnail-text: "The Velveteen Shoggoth: if a boy loves a shoggoth long enough and hard enough, can it turn into a <em>real</em> rabbit...?"
​created: 2025-05-07
​modified: 2026-01-14
​status: in progress
​confidence: certain
​css-extension: dropcaps-kanzlei
​...
~~~

# HTML

- **大端命名**：属性或类以从左到右的一般→特定样式命名，以便于[制表符完成](!W "Command-line completion")]和内存。

    它们通常被写为 `div`{.HTML}/`span`{.HTML} 元素。^[即使有一个在 [CanIUse.com](https://caniuse.com/) 上具有 >95% 的全球支持的标准化标签，它通常也有太多的限制，比如硬连线行为或跨浏览器不一致，与滚动我们自己的标签相比是有用的。这就是为什么我不使用 `<details>`{.HTML}、`<abbr>`{.HTML} 而不是 `<span title="...">`{.HTML}、新标准化的 [HTML5 popovers](https://developer.mozilla.org/en-US/docs/Web/API/Popover_API)、`skip-ink`{.CSS} 等]

    因此，有例如。 `link-live`{.HTML}、`link-live-not`{.HTML}、`link-icon`{.HTML} 和 `icon-not`{.HTML} 类：它们属于“链接”，指定某些属性（原始 URL 是否可以在弹出窗口中显示，或者是否具有链接图标），并且可以以相同的方式覆盖（例如，禁用链接图标，`[foo](bar){.icon-not}`{.Markdown}）。

    - *`-not`{.HTML} 后缀*：总会有例外，因此通常可以使用 `-not`{.HTML} 后缀来否定自定义类。 （与标签或 URL 一样，不鼓励使用复数形式。）
    - Gwern.net CSS 类的*主列表*保存在 [`sync.sh`](/static/build/sync.sh) 的 `html_classes_whitelist`{.Bash} lint 变量中。
    - 当存在冲突时，*最具体的元数据获胜*。
      如果链接位于站点范围配置文件（[Haskell](!W) 源代码中的 `Config.*`{.Haskell} 层次结构）中指定的黑名单/白名单上，则链接上的属性将覆盖它。
      因此，如果某个 URL 位于站点范围的实时链接黑名单中，则将 `.link-live`{.HTML} 类放在特定的 `<a>`{.HTML} 上将覆盖黑名单并使其成为实时链接。
- **页面元数据**：

    - “*创建*”指的是当我有了核心想法或编写第一个版本时，这可能是当我在社交媒体上写评论时，而不是当 Gwern.net 页面首次出现时。
    - （最后）“*修改*”是指文章的最后一次重大修改，例如添加新的部分或附录。

        它不包括较小的修改，例如更新损坏的链接或添加参考或段落，或修复小错误。

        如果存在重大错误或过时的材料，应解释其发生位置，可能存储在脚注或折叠中。
        删除原文可能会有用。
    - ["*重要性*"](/about#importance-tags)标签为1个整数1--10；请参阅该页面以了解正确用法。 （索引等基础设施页面为 0。）
    - “*状态*”：论文完成的粗略顺序。不言自明。 （当前：“已完成”•“进行中”•“草稿”•“注释”•“放弃”•“过时”）
    - [“*信心*”](/about#confidence-tags)：总体而言，我对内容的信心如何；必须是凯塞尔曼词
    - <span id="auxiliary-links"></span> *辅助链接*部分：页面可以有一个特殊的附加三元组 [backlinks](/design#backlink "‘Design Of This Website § Backlink’, Gwern 2010"){#backlinks-2}/[similar-links](/design#similar-links)/[link-bibliography](/design#link-bibliographies)] 部分
- <span id="abstracts"></span> 所有论文都应以**摘要**开头，它是包含块引用的 `div.abstract`{.HTML}。这些对于弹出窗口和类似链接嵌入建议至关重要。

    - 附录也应该以摘要开始。
- **HTML5 输出**：应该通过 [W3C Validator](https://validator.w3.org/)，除了一些必须忽略的警告/错误；目前，您应该忽略：

    没有脚注部分标题（Pandoc-ism） • 图像上没有替代标题（目前手动添加到数千个当前图像的工作量太大，尽管我希望LLM很快就能以经济实惠的方式添加可接受的替代标题） • “考虑仅使用 `h1`{.HTML} 元素作为顶级标题”（Pandoc-ism）
- **自记录**：所有元素都应该可读为文本，或者在交互时具有有用的元数据（例如，通过直接或使用 span/div 包装器设置 `title`{.HTML} 属性来在元数据字段上显示工具提示。）
- Div 是使用 **原始 `<div>`{.HTML}** HTML 元素以 Markdown 和 HTML 编写的，因为 ['本机' Pandoc 语法 ](https://pandoc.org/MANUAL.html#divs-and-spans) 很丑陋且危险的挑剔；跨度应在 Markdown 中以 Pandoc `[foo]{.class ...}`{.Markdown} 语法编写，并在 HTML 中以 `<span>`{.HTML} 编写
- **折叠**非常适合用于题外话和类似附录的整个部分（例如 `# Appendix {.collapse}`{.Markdown}）、大型引用或列表、草稿或替代方案，或者 [嵌入注释](#transclusion)。
    它们通常是巨大脚注或附录的替代品。

    折叠元素是 `div.collapse`{.HTML}/`span.collapse`{.HTML} 包装器。
    它们是 [`<details>`{.HTML} 披露元素](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/details) 的高级实现。

    默认情况下，整个元素是折叠的；要定义折叠时显示的内容，请使用 `.abstract-collapse`{.HTML}。
    要显示*仅*在折叠时显示，并使其在未折叠时消失，请使用 `.abstract-collapse-only`{.HTML}。
    （当您想要显示前缀以外的内容时，例如经过大量编辑的摘要或“整个”折叠区域的摘录，而不仅仅是前几句话，这可能很有用。）

    几乎每个块或内联元素都可以以相同的方式折叠：节、块引用、表格、代码块......
    由于历史原因，Pandoc 允许仅在 *某些* 元素（如节）上直接设置类，但不允许在其他元素（如块引号）上直接设置类；但类本身保持不变，无论它是直接设置在元素上还是在 div 包装上。
- **链接元数据**：链接可以选择将标题/作者/年份的基本元数据编码到 URL 的 `title`{.HTML} 属性中（例如，`[foo](/bar.pdf "'Title', Surname Year")`{.Markdown} 创建一个 `<a href="/bar.pdf" title="'Title', Surname Year">foo</a>`{.HTML}，在禁用 JS 的情况下，将在鼠标悬停时显示工具提示`'Title', Surname Year`{.HTML}。）
  可选，因为这对于许多链接来说是不必要的，这些链接是不相关的或自动生成的，如 [interwiki links](#interwiki).

    这并不是因为我希望读者看到它（除了作为后备），而是因为如果我有标题来唤起我的记忆，那么编辑 Markdown 源代码会更容易，特别是对于更不透明或不熟悉的 URL。
    （对于可能没有记住给定 URL 的LLM来说，这可能也很有用。）

    这*通常*是注释链接的下游，因为 `link-titler.hs` 会自动重写 Markdown 和 HTML 以在可能的情况下插入标题属性。
    `title` 属性将覆盖任何注释标题，因此可以出于其他目的而重载；对于 Twitter 推文，由于它们很短并且本身没有“标题”，因此可以将推文文本存档到标题中。
- **Lint/Rewrite 覆盖**：Gwern.net 严重依赖 lint 和自动重写来保持一致性和正确性。
  这可能会失败，尤其是在编写像这样故意包含错误或不推荐使用的示例的文档时。

  通常可以通过插入不可见的 [Unicode](!W) 字符（例如零宽度空格）来禁用这些匹配并将其列入“白名单”。
  在某些情况下，例如星号 (ASTERISK) 会触发 lint（在这种情况下，因为最终编译的 HTML 中出现的字面星号几乎总是 Markdown 错误），它们可能会被类似的 Unicode 点替换，例如 HEAVY ASTERISK（“✱”）。
- **标签**：HTML5 中从不使用自闭合标签上的斜线（SVG 除外，因为它是 XML），特别是 `<img>`{.HTML}、`<br>`{.HTML} 和 `<hr>`{.HTML}。

    它们显然是现已过时的 XHTML 的遗留物，并且在 HTML5 中毫无意义（在 HTML5 中，没有斜线，它们现在只是“void”元素）。
    除了触发验证警告并导致语法不一致（可能有（至少）3 种方法来编写元素之外）之外，自闭合标签不断在整个 Gwern.net 堆栈中引起神秘的零星问题，例如自闭合 `<br>`{.HTML} 会以某种方式变成其中的两个，或者水平标尺会完全破坏。
    它们**永远**不应该被使用。
    - [Pandoc 定义列表](https://pandoc.org/MANUAL.html#definition-lists) 从未使用过。
      我在 Gwern.net 上没有找到它们的任何用例；带注释的链接、列表和嵌入效果很好。
- **反向链接/类似链接/链接参考书目**：这些都是自动生成的。

    对于反向链接，可以在链接级别 (`.backlink-not`{.HTML}) 或页面级别（YAML 元数据中的 `backlink: False`{.YAML}）禁用反向链接。

    这对于充当聚合器、更改日志或索引的页面非常有用，以防止它们混乱其他页面的“反向链接”部分，或者当页面的讨论与该页面的读者无关时——例如，在本风格指南中，我们经常链接到恰好使用某个功能的示例文章，但该文章的读者不会关心这一点。
    （这对于[当我们重定向多个 ID](#sub-page-moves) 时也很有帮助，这会产生无用的反向链接。）
- **Markdown 源代码可用于论文**，使用扩展名 `.md`。 （例如，此 HTML 页面 `/style-guide` 的 Markdown 源代码位于 `/style-guide.md`）。

    默认情况下，这些 Markdown 源也会提供给代理，这些代理在其 [Accept headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Accept)（例如：`curl --follow --include --header 'Accept: text/markdown' "https://gwern.net/archiving"`{.Bash}）中指定他们更喜欢 Markdown 而不是 HTML。
- **LLM 输出/对话** 格式：

    在呈现 ChatGPT 等 LLM 的输出时，Gwern.net 的惯例是用户输入/提示以粗体书写，而 LLM 输出则以罗马体书写。
    提示或输出的常见重复部分用省略号标记（因此对单个提示的多个响应用粗体省略号表示，然后是响应）。
    对于您不希望读者阅读的长文本，可以将它们呈现在折叠的代码块中。
    如果必须在 Markdown 栅栏内包含文字三个反引号，请在反引号之间插入零宽度空格。

    由于人工智能的快速发展，输出应该包括准确的日期。
- **杂项**：

    - `.display-not`{.CSS}：隐藏元素，例如超链接。

        - `.desktop-not`{.CSS}/`.mobile-not`{.CSS}：有选择地隐藏不同尺寸屏幕上的元素
    - `reader-mode-not`{.CSS}：在阅读器模式下隐藏元素

        对于带注释的诗歌/小说等内容特别有用，我们通过设置[页面级 `reader-mode`{.CSS} 变量](#css-extension) 并删除其中会分散阅读注意力的部分，默认提供干净的“纯粹”阅读体验。
    - 内联图标：站点 UI 中使用的一些 SVG 图标可以使用相应的图标 CSS 类作为空范围显式包含在文本中，例如 `[]{.icon-single-white-star-on-black-circle}`{.Markdown}。

        这些图标可能是站点控件，例如 `span.reader-mode-selector-inline`{.HTML}，它提供可点击的切换小部件以将阅读器模式设置为开/关/自动模式。 （这对于浮动主题切换栏来说是多余的，但允许我们明确地告诉读者它，这在链接较多的页面上很有用，因为读者特别可能想要使用阅读器模式但不知道它。）T-
    - `.link-annotated-not`{.CSS}：禁用链接上的弹出窗口

## 嵌入

Gwern.net 站点的标志性功能是一组丰富的客户端 [transclusion](!W) 原语（请参阅 [`transclude.js`](/static/js/transclude.js)]），它允许将几乎任意一组其他页面或页面部分或有关页面的元数据复制到当前页面。
这可以避免重复，并紧密集成到弹出窗口、反向链接和本地存档功能中。
（这是一个主要的 Gwern.net 设计模式，用于构建许多东西，例如注释弹出窗口——延迟加载文档，以及[辅助链接](#auxiliary-links)。）

它们是[“惰性”](!W "Lazy evaluation")，并在 JS 中在客户端完成，以允许任意大量深度的递归嵌入，包括循环。
它们被编写为链接上的 HTML 类。

用例：

- [**DRY**](!W) 样板或重复文本
- **[部分页面的迁移](#sub-page-moves)**：嵌入注释以总结过去的内容，同时自动将读者重定向到新位置
- 通过使用 ID 定义 `span/div`{.HTML} 包装器并链接或嵌入该 ID，对句子、段落或部分的特定部分进行**精确范围引用**
- **读者友好的长格式**：通过将其包含在折叠区域内，以读者友好的方式包含大文本块 (`[text URL]{.include .collapse}`{.Markdown})
- **将自动生成的页面与手写的页面相结合**：自动生成的页面只是简单地嵌入了手写页面的路径。
  （例如：像 `/doc/foo/index` 这样的标签目录索引将嵌入 `/doc/foo/abstract`（如果存在）来总结或描述标签。）

常见用途：

- `.include`{.CSS}：复制 URL 中的所有内容；这仅限于 ID（例如，一个部分）

    - `.include-strict`{.CSS}：尽快执行嵌入，非惰性；通常可用于性能优化，以确保读者不必等待，或确保链接目标 ID 存在
- `.include-annotation`{.CSS}：将注释嵌入为块，及其元数据标题、摘录/摘要/评论等。

    在类似参考书目的页面中特别有用。

## 网址

网站文章 URL 遵循“slug”模式：一两个字母数字连字符分隔的关键字，避免使用复数结尾以减少歧义（例如 `/sidenote`，而不是 `/sidenotes`）。
HTML 论文页面是没有扩展名的“酷 URI”。
约定：

- **“墓地”**：包含最终成品的“片段”、“失败”、“原型”、“草稿”等的页面；它们以 `-graveyard` 后缀命名，因此 `/foo-graveyard` 代表 `/foo`（例如，`/face-graveyard` 记录在 `/face` 中生成成功的 StyleGAN 动漫面孔的失败尝试）。
- **“Lorem”**：测试网站功能的页面前缀，由于大小和浏览器压力而分割
- **主题组**：按主题组织论文的目录（例如 `fiction haskell newsletter nootropic review sicp zeo`）。通常是不言自明的，但请注意，时事通讯遵循严格的 `/newsletter/YYYY/MM.md` 命名约定，并为年度时事通讯提供可选的 `/newsletter/YYYY/13.md`。

    或按文档类型：`blog doc note`。 （博客是短篇文章，旨在比完整的论文页面更容易编写；文档层次结构对层次标签系统和所有托管文件进行编码，而注释目前有点返祖现象，已被弃用，有利于更复杂地使用带有嵌入摘要的博客或标签。）

如果可能的话，所有 URL 都应该是全文链接。

URL 应链接到 URL 内最相关的 [anchor](!W "HTML element#Anchor")。
对于 PDF，应使用锚点 ID（例如 [`#page=n`{.HTML}](/doc/cs/css/2007-adobe-parametersforopeningpdffiles.pdf#page=5).

用外语编写的 URL 应使用语言代码进行标识（例如 `[Chinese](/URL)^zh^`{=Markdown}）。

文件遵循命名模式 `YYYY[-MM[-DD]]-surname[-description][-nth].ext`。
（这是令人难忘的、可预测的、简短的，并且在命令行上排序得很好。）
如果没有姓氏，则使用最接近的可用实体名称；如果什么都没有，就“匿名”。
如果存在冲突，则通过添加计数来消除歧义：例如。 `2026-foo-1.pdf` 与 `2026-foo-2.pdf`。
对于更复杂的文档，例如书籍或生成的图像，可能值得对描述或标题进行编码；比如一本书最好命名为`2026-foo-title.pdf`，这样更容易找到。
对于图像文件，考虑到稍后使用或重新查找它们的难度，最好指定“大量”数据，例如作者（和/或工具）、确切日期、“和”描述（例如 `2025-01-01-gwern-gpt4o-frogmeme-description.png`）。

文件格式应位于文件类型白名单中。
我们对允许的文件格式持保守态度；图像应为 JPG/PNG，避免 WebP/AVIF（请参阅 [Image.hs](/static/build/Image.hs)）；文档应为 PDF 且 [不是 DjVu](/design-graveyard#djvu-files)；存档应该是 XZ 压缩的 tarball 等。
>250MB 的大文件[特别支持](/blog/2025/large-files "‘Gwern.net large file support’, Gwern 2025")。
所有文件格式都应该[有一个链接图标](/lorem-link#file-type)。
（链接图标测试页兼作文件类型白名单。）

图像文件会自动压缩。

## 内联

- **破折号**：我需要正确使用——连字符用于常规拼写，短破折号用于范围，长破折号用于注释。 （长破折号不是空格分隔的。）
- **首字下沉**：首字下沉按主题选择（[tests](/lorem-dropcap "‘Lorem Ipsum: Dropcaps’, Gwern 2020")）：

    <div class="columns">
    - 掉落猫：猫
    - 古迪：生物学
    - 柴郡：文学
    - De-Zs：非技术或一般文章
    - 坎兹雷：技术
    - [yinit](https://www.tug.org/TUGboat/tb12-1/tb31hara.pdf#page=8)：技术性很强
    - 吉恩·沃尔夫：沃尔夫小说相关的文章

    <!-- padding to fix the div -->
    </div>

    当写一篇新文章并选择首字大写集时，应查阅该首字大写集当前使用的列表（存储在[首字大写页面](/dropcap "‘Dropcap Generation With AI’, Gwern 2023"){#dropcap-2}中），并重写第一段（在摘要之后）以尝试使用未使用的首字大写字母。
    （或者，如果这很困难，因为未使用的字母是像“Z”这样的罕见字母，至少避免使用最过度使用的字母。）

    如果需要首字下沉，请勿以引号或数字开始页面。

    首字下沉在[页面级](#css-extension) 上设置为`dropcaps-$THEME`{.CSS}（例如`css-extension: dropcaps-yinit`{.YAML}），并在每个块上设置为`dropcap-$THEME`{.CSS}（例如`<div class="abstract-collapse dropcap-yinit">`{.HTML}）；后者覆盖前者。 （首字下沉在两个版本中始终可用。）
- **货币/通货膨胀**：所有货币金额均应使用美国十进制表示法（例如 `$1,234.56`）。

    如果美元/₿价格或价值反映了一些实际交易或金额，则它们应该是[通货膨胀调整后的](https://www.bls.gov/data/inflation_calculator.htm)，而不是占位符，特别是在任何历史背景下。
    这包括在引号中，因为读者仍然可以使用原始名义金额。

    如果您在 2026 年以“1 美元”的价格购买某物，则应写为 `[$1]($2026)`{.Markdown}，以便根据未来的通货膨胀进行适当调整 [Inflation.hs](/static/build/Inflation.hs "‘InflationAdjuster’, Gwern 2019");然而，如果它描述的是经济学或思想实验，并且只是一个任意的价值单位，那么它应该保持原样。
    （如果 10 年后，一篇文章要求你想象 Omega 飞向你，如果它正确预测你的反应，并为你提供“1.21 美元”，那将会令人困惑......）

    由于波动性极大，₿ 金额 *必须* 以特定的 YYYY-MM-DD 日期书写，例如 `[₿1](₿2026-01-01)`{.Markdown}。
    详细信息请参见`Inflation.hs`/[`Config.Inflation.hs`](/static/build/Config/Inflation.hs)。
- **感叹**：我没有写“？​！”，而是压缩为[interrobang](!W)。^[但主要只是为了可爱——我喜欢添加微妙的风格，比如首字下沉，它们可以用于多种目的。]
- **链接**：任何术语或引文的第一个实例都应带有超链接。

    所有后来的使用都应该取消链接，或者它们应该链接到第一个的锚点。
    （这通常是不必要的，但在大型论文或具有相对独立部分的论文中，这可能会有所帮助。）
- **列表**：列表项的开头大写。
    列表项应以标签开头：以冒号分隔的可以强调的关键字或短语。

    <span id="list-inline"></span> 内联列表可以用逗号分隔，也可以选择使用 BULLET '•' 点。
- **[[边注](https://edwardtufte.github.io/tufte-css/#sidenotes)]{#margin-notes}**：*非常*简短的摘要。

    我们的“页边注释”是一种自定义的旁注，它在*左*页边距中排版，没有数字，或者内联左斜体。 （它们可以在注释和论文中启用。）
    它们总结了一个段落，但“不”用于旁注或脚注等旁白或题外话。
    （这就是为什么他们留下了他们总结的段落。）
    如果有多个页边注释，它们也会被复制到该节开头的缩进列表中，以维多利亚风格作为微型目录。

    从概念上讲，它们就像更深层次的标题； HTML 标题仅允许 6 级（[`h1`{.HTML}--`h6`{.HTML}](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/Heading_Elements "‘The HTML Section Heading elements’, MDN 2023")），这并不总是足够的，特别是当你想要总结每个段落时。
    （例如，如果这不是列表项，则短语“页边注释”将是可接受的页边注释。）
    因此，我们的 `span.marginnote`{.HTML} 类允许采用 1--3 个单词的短语（较长通常看起来不自然），并将其设置在左边距或将其保留为内联和斜体。

    如果一个节只有 1 个段落（即使它是一个长而复杂的段落），则不应使用页边注释，因为节标题应该已经覆盖它。
- [数学]{#inline-math}：

    - *HTML 内联数学*：内联方程是使用纯 HTML/Unicode/CSS 编写的：许多数学字形已经在 Unicode 中可用

        - <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> [方程自动转换]{.smallcaps} 使用脚本 [`latex2unicode.py`](/static/build/latex2unicode.py "‘<code>latex2unicode.py</code>’, Gwern 2023")，该脚本有一套完整规则与示例。

            如果 `latex2unicode.py` 拒绝转换表达式，则可能不应该转换它。目前不支持复杂的分块方程，特别是水平线（但在某些时候可能可以使用带有行跨度/列跨度的原始 HTML `<table>`{.HTML}，[例如 ](https://www.readthesequences.com/An-Intuitive-Explanation-Of-Bayess-Theorem)]。
        - *简单的 Markdown 上标/下标*：使用标准 Pandoc `^superscript^`{.Markdown}/`~subscript~`{.Markdown} 语法；
        - *复杂的 HTML 上标/下标*：就像下标变量上的上标变量一样，可以在自定义 CSS 中完成。

            我定义了一个 `span.subsup`{.HTML} 来执行此操作。
            要使用它，只需编写 `<span class="subsup"><sub>Bottom</sub><sup>Top</sup></span>`{.HTML} 即可。
            （我们先写下标，以减少 Pandoc 将其误解为脚注的风险。）
        - *乘法*：使用乘法符号“×”进行算术乘法；中间点“·”表示可能存在 _x_ 变量的上下文（例如，不是 𝒪(_n_ × log _n_) 而是 𝒪(_n_ · log _n_)）。
        - *除法*：[使用 FRACTION SLASH](https://gwern.net/design-graveyard#fraction-slash) 表示紧凑的粗俗分数（例如“7/11 是食物链”与“7⁄11 接种疫苗的小鼠幸存”）
        - *标识*：使用 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span>/<span class="logotype-tex">T<sub>e</sub>X</span> 标识（写为`<span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span>/<span class="logotype-tex">T<sub>e</sub>X</span>`{.HTML})。复合词的书写方式很明显。
- **序数**：扩展名（例如“th”、“nd”）带有上标（不是“1st”，而是 `1<sup>st</sup>`{.HTML} 或 `1^st^`{.Markdown}）

    请注意，序数的某些用途*可以*被我们的[“进度指示器”](/design-graveyard#ordinal-word-counts) 取代，但它们很难手工编写，通常最好留给基础设施。
- **[Smallcaps](!W){#wp-smallcaps-2}**：小型大写字母是使用 `span.smallcaps`{.HTML} 类编写的（类似于 Pandoc 的默认 CSS）。
  如果可能，我们更喜欢 Markdown 语法，例如 `[Smallcaps]{.smallcaps}`{.Markdown}。
  （请注意，小型大写字母需要一些小写字母，否则就没有意义，因为大写小型大写字母 = 大写字母，因此永远不应该将全大写字符串设为小型大写字母。）

  它们用作强调[第三级](#emphasis-cycle)，并且在站点 UI 中，例如对某些级别的标题进行样式化。

    为了风格起见，文章第一段的第一行采用小写字母；如果不需要，可以使用 `.smallcaps-not`{.CSS} 显式禁用它。
- <span id="interwiki"></span> **维基百科链接**：应使用 [Interwiki.hs](/static/build/Interwiki.hs) `!W`{.HTML} 快捷语法：即。不是 `[George Washington](https://en.wikipedia.org/wiki/George_Washington)`{.Markdown}，而是 `[George Washington](!W)`{.Markdown} 或 `<a href="!W">George Washington</a>`{.HTML}。

    WP 文章是从锚文本推断出来的，并通过指定链接 *title* 在 Markdown/HTML 中被覆盖，例如 `[President Washington](!W "George Washington")`。
    切勿重复目标或使用冗余的完整 WP URL（即，不要写入 `[George Washington](!W "George Washington")`{.Markdown} 或 `[George Washington](https://en.wikipedia.org/wiki/George_Washington)`{.Markdown}，而只写入 `[George Washington](!W)`{.markdown}）。
    目标可能经过 URL 编码，也可能不经过 URL 编码。
    （仅支持英语维基百科之外的少数跨维基目标：`!Hackage`{.Markdown}、`!Hawiki`{.Markdown}、`!Hoogle`{.Markdown}、`!Wikiquote`{.Markdown}、`!Wiktionary`{.Markdown}。其他 wiki 或各语种维基百科都必须按普通链接写。） <!-- see `Interwiki.interwikiMap`{.Haskell} ` -->

    前端JS代码通过调用WP API自动处理WP文章的注释。
- **诗歌**：内联诗歌使用斜杠和 `span.poem`{.HTML} 类进行格式化。有关详细信息，请参阅[§ Poetry](#poetry)。

    请注意，如有必要，诗歌可以违反*所有*常规风格规则，只要违规行为被记录为故意并在评论中列入白名单。
- **注释**：

    您不能在注释*内部*链接 ID。如果您需要对注释进行精细寻址，请参阅[注释锚点技巧](#annotation-anchor)。

    <div id="annotation-anchor">*注释锚点技巧*：注释设计模式是为同一 URL 提供多个单主题注释，而不是一个大型多主题注释。
    例如，PDF 可以重复注释，每次使用不同的页面，例如 `/doc/foo.pdf`、`/doc/foo.pdf#page=10` 与 `/doc/foo.pdf#page=15`（添加章节标题以消除歧义，例如“标题”、“标题§方法”与“标题§结论”）；网页同样可以使用不同的锚点进行注释。
    当然，注释可以相互链接，或者相互嵌入（使用 `.include-annotation-core`{.CSS} 来避免重复元数据标头），可能会折叠，因此可以有一个裸 URL 的“主”注释，然后嵌入 3 个子注释（例如，[Raphelson 1980](/doc/psychology/animal/maze/1980-raphelson.pdf "Psychology at Michigan: The Pillsbury years, 1897–1947"){.backlink-not}）。

    有时已经没有有用的 ID；对于 Gwern.net 上托管的文档，可以根据需要对其进行编辑以包含锚点 ID，但对于其他 URL（例如完全没有 ID 的网页），我们可以简单地为每个单独的主题*创建一个假锚点 ID*，并注释*这些*。
    （这可能会在检查链接时产生误报，但是好吧。）
    </div>

## 块

- [**警告**](https://casual-effects.com/markdeep/features.md.html#basicformatting/admonitions) ([demos](/lorem-admonition "‘Lorem Ipsum: Admonitions’, Gwern 2020"))：警告（有时是“标注”或“拉引号”）用于警告或警报，仅将某些文本加粗是行不通的。它们是 `div.admonition [tip/note/warning/error]`{.HTML} 包装器，围绕 `<p>`{.HTML}，也可能是 `div.admonition-title`{.HTML}。

    完全写出的示例（像往常一样避免“本地”Pandoc div 语法）：

    ~~~{.HTML}
    <div class="admonition tip">
       <div class="admonition-title"><p>Tip Title</p></div>

       <p>Tip.</p>
   </div>
   ~~~
- **铭文**：是块引用的 `div.epigraph`{.HTML} 包装。

    块引用是斜体的；文本通常不会用双引号括起来（除非是对话），因为这对于整个铭文周围的精美 CSS“引号”来说是多余的。
    可选的最后一段是罗马字体，通常是引用的出处；这由破折号表示。
    示例：

    ~~~{.Markdown}
    <div class="epigraph">
    > Fourscore and 7 years ago...
    >
    > ---Abraham Lincoln (1863)
    </div>
    ~~~

    归属通常是作者、全名或姓氏，然后是括号中的来源和年份。但这可能因效果而异——有时将其归因于*字符*会更有趣（在这种情况下，我将作者放在括号中）。
- **脚注/旁注**：同样的事情，基于响应式设计选择。
  脚注的标准 Pandoc Markdown 语法，例如 `[^id]: Content.`{.Markdown} 或 `^[Content.]`{.Markdown}。

  ID 应该可用作描述性的人类可读的 HTML ID——类似于 URL slugs 的小写字母数字连字符分隔短语，并且应该有意义地总结上下文。 （它们不应该只是数字。）

    它们不用于简单引用，因为通过链接全文 URL + 注释可以更好地处理这种情况。
    它们用于详细引用（例如翻译）、多次引用、复杂引用（例如摘录）以及离题或切线。
    从长度上看，它们应该少于200字；任何更长的内容最好重构为其他内容（注释、折叠、附录......）。

    块脚注（脚注主体是单独定义的）通常紧接在它们所使用的 Markdown 元素之后，以便于编辑。
    （它们*不*分组在 Markdown 文档的末尾。）
    如果位于句子的末尾，则将它们放置在句子结束标点符号之后而不是之前。

    脚注有时值得链接。
    不幸的是，由于担心产生冲突，Pandoc 选择不使用 ID 来定义可链接锚点。
    在这种情况下，可以通过使用 ID 定义一个空范围来链接它们，例如 `[^id]: <span id="id"></span> Content.`{=Markdown} 这些 ID 与所有其他 ID 一样，必须是唯一的。
- **段落**：与通常的互联网社交媒体/博客写作风格（每段 1 句话）相比，相对较长的段落是首选。
- **列表**：

    - *有序与无序*：如果列表可以通过数字/位置引用，那么它应该是有序的。如果不是，则应该是无序的。

        然而，即使是“无序”列表也应该尽可能有序（或[“系列”](!W "Seriation (archaeology)”））。可能没有规范的排序，但几乎所有列表都可以放入比随机洗牌更有意义的*某些*顺序：相似性、重要性降序排列，甚至只是按字母顺序排列！
    - *列*：如果列表由>6 个“短”项目（可能<30 个字符）组成，那么它很适合格式化为多列列表，该列表将换行为2 列。这是 `div.columns`{.HTML} 包装器。
- <span id="emphasis-cycle"></span> 强调：嵌套级别，特别是在强调关键字或短语的无序列表中，由 3 个循环表示：**强** → *斜体* → [小写]{.smallcaps} → **强** ...

    我更喜欢使用 Markdown 粗体和斜体语法。
- **摘要**：摘要是一个 `div.abstract`{.HTML}，其中包含总结一个部分或一个页面的块引用。一页上可能有多个摘要，尤其是附录。

    所有摘要应分为多个段落。
    他们应尽量遵循<span id="b-m-d-r-c">“背景、数据、方法、结果、结论”</span>的标准科学写作。 （[`paragraphizer.py`](/static/build/paragraphizer.py "‘<code>paragraphizer.py</code>’, Gwern 2022") 尝试使用 LLM 自动执行此操作。）
    它们可能包含其他块元素，例如列表或嵌套块引用或警告。

    论文摘要为其 URL 的注释提供支持，因为它们每月都会被抓取并转化为注释。
    如果不希望出现这种情况，请在摘要上设置 `.scrape-abstract-not`{.CSS}。
- **图像**：使用 `<figure>`{.HTML} 元素。

    - *标题格式*：以粗体“图”开头，然后1句摘要为斜体，并以换行符（`<br>`{.HTML}）^[理论上，最近版本的Pandoc现在支持图标题中的多个段落，但我没有详细检查这一点。]分隔详细描述。详细描述有括号标签 A--Z，为斜体。 （如果需要进一步强调，则按照粗体/斜体/小型大写字母约定，使用小型大写字母。）
      因此，论文“图 1”的 Markdown 标题可能如下所示：`**Figure 1**: _Levitating a frog magnetically._<br>(*A*) A frog. (*B*) Frog, levitated.`{=Markdown}

        由于许多图像标题是从文档中复制的，并且不一定是我会编写的内容，因此最好包含描述图像的 `title`{.HTML} 属性。 （当读者放大图像时，标题和 `title`{.HTML} 都会由 [`image-focus.js`](/static/js/image-focus.js) 显示，因此两者都不会浪费。）

        论文中的图形通常不会命名或编号，因此不需要 `**Figure N**`{.Markdown} 前缀。
    - *布局*：可以使用 `.width-full`{.HTML}、`.float-right`{.HTML} 和 `.float-left`{.HTML} 来布局图像。
      它们也可以折叠。

        全角图像对于装饰性插图或高度详细的图像非常有用（例如，科学论文中的图形可能将 10 个图形打包到一个图形中）。

        浮动对于较小的图像很有用；通常，按照从左到右的模式，图像会向右浮动。如果有多个图像，它们可能会向右/向左/向右呈之字形以避免“堆叠”。
    - *深色模式*：默认情况下，深色模式期间的反转由 [InvertOrNot.com](/invertornot "‘InvertOrNot.com Proposal’, Gwern 2021") 控制，但可以通过指定 `.invert`{.HTML}（例如，黑白线条艺术）与 `.invert-not`{.HTML}（例如，照片、彩色艺术）来覆盖。

        （如果时间允许，请使用 `.invert`{.HTML}/`.invert-not`{.HTML} 明确标记图像，因为这样更可靠并节省网络请求/延迟。）
    - *边框*：默认为轮廓。

        可以使用 `.outline`{.HTML}/`.outline-not`{.HTML} 手动勾勒出它们的轮廓或不勾勒出轮廓（这在暗模式下或对于 `.width-full`{.CSS} 装饰图像可能很重要）。
    - *导航*：图像可以通过 `image-focus.js` 点击缩放并自动在“轮播”中查看；不需要额外的元数据。
- **视频**：Pandoc 没有任何视频语法，因此必须使用反引号语法以原始 HTML 编写。

    视频通常应避免循环（除非明显“类似 GIF”）、自动播放或加载整个视频（即默认为 `preload="none"`{.HTML}），并应提供控件；允许的视频格式为 MP4/WebM。
    它们应包括宽度/高度/纵横比（在自定义数据属性中定义）和标题

    统计可视化的示例视频，启用循环以帮助观看者看到从开始到结束的演变：

    ~~~{.Markdown}
    ```{=HTML}
    <figure>
        <video controls="controls" preload="none" loop height="1080" width="1920" data-aspect-ratio="16 / 9">
            <source src="/doc/tea/gwern-tea-mineralwaters-bestarm-sequential.mp4" type="video/mp4">
        </video>
        <figcaption> 矿泉水味道测试动画，显示后验分布如何从 <em>n</em> = 7 演变到 <em>n</em> = 67，以贝叶斯最佳臂采样为指导。 MP4测试箱.</figcaption>
    </figure>
    ```
    ~~~
- **采访**：采访的格式经过特殊设计，可以垂直排列演讲者并缩进回答，并按主题对对话进行分组。

    它们是 `div.interview`{.HTML} 包装器，包含粗体发言者姓名/冒号/引用的无序列表（不一定是严格的问答），其中 `<hr>`{.HTML} 水平标尺分隔“主题”。
    示例：<!-- NOTE: zero-width spaces inserted into triple-hyphen horizontal ruler syntax below to fix Emacs markdown-mode syntax highlighting errors -->

    ~~~{.Markdown}
    - **A**: Question 1?
    - **B**: Answer 1.
    - **A**: Commentary.

    ​-​--

    - **A**: Question 2?
    - **B**: Answer 2.
    ~~~
- **GTX 元数据数据库**：注释和元数据以称为 GTX 的自定义行分隔文件格式存储，这避免了 YAML/JSON 在编写许多复杂的 HTML 片段时的缺点。

    有关语法和设计原理的详细说明，请参阅 [`GTX.hs`](/static/build/GTX.hs)]。

    GTX 按质量级别划分，以便于编辑/修订控制：[`me.gtx`](/metadata/me.gtx)（Gwern 撰写的论文等）、[`full.gtx`](/metadata/full.gtx)（手工注释）、[`half.gtx`](/metadata/half.gtx)（编辑和自动生成的混合）] [`auto.gtx`](/metadata/auto.gtx)（完全自动生成）。
- **数学**：复杂的块方程以 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 编写，并由 [MathJax](!W) 排版。
  它们以正常的 Pandoc `$$block equation$$`{.Markdown}/`$inline equation$`{.Markdown} 语法编写。

    在某些情况下，块方程可能像[许多内联数学方程](#inline-math)]一样，使用纯 HTML/Unicode/CSS 是可行的；如果是（即 `latex2unicode.py` 脚本可以处理它们，并且它们不是复杂的嵌套分数、积分、矩阵等），则应该这样做，因为纯方法有几个优点（它可以消除加载重量级 Mathjax CSS/字体的需要，看起来更自然，降低长期风险 [bitrot](/holy-war#bitrot)，更易于搜索等）
- **表格**：Pandoc支持[几种Markdown表格](https://pandoc.org/demo/example33/8.9-tables.html)。
  我通常使用“简单”表，或[管道表](https://pandoc.org/demo/example33/8.9-tables.html#extension-pipe_tables);尽管有 [Emacs](!W) 模式，但“网格表”已被证明比其价值更麻烦。
  （通常，如果您发现自己在简单表中重新调整空白，那么是时候转移到管道表了。）

  理想情况下，所有表格都将在纯 Markdown 中重新创建，但这通常工作量太大，或者在可能拆分列等的复杂表格的情况下不可行（例如[1](/doc/psychiatry/bipolar/energy/1987-andreasen-ratesofmentalillnessiniowawritersworkshopwriterscomparedtocontrol.jpg)，[2](/doc/psychiatry/bipolar/energy/1987-andreasen-table2-ratesofmentalillnessinfirstdegreerelativesofiowaworkshopwriters.jpg)]）；允许使用屏幕截图。

    表格通常有标题/说明文字； Pandoc 语法是一个空行，然后是“Table: ...”。
    表格标题是具有正常格式的完整句子。
    （我们不会在 Markdown 中编写 `<figcaption>`{.HTML} 标题。）

    *布局*：Pandoc 支持简单的表格布局控制，例如列的相对宽度（列标题中的连字符数），以及每列的左/右/中心对齐（标题中左/右/两侧的冒号）。

    我们提供额外的控制：就像图形图像一样，表格可以向左/向右浮动，或者设为全角；它们也可以使用 `.table-small`{.HTML} 进行压缩。
    特别是在注释中，对于非常小的表格，例如 2×2 的表格，最好同时使用两者并将其包装在 `<div class="float-right table-small">`{.HTML} 中。
    示例：

    ~~~{.Markdown}
    <div class="float-right table-small">
    | 1 | 2 |
    |---|---|
    | 3 | 4 |
    | 5 | 6 |

    Table: A small 'inline' table writen as a demo for the Style Guide.
    </div>
    ~~~

    表格通过自定义 CSS 进行斑马条纹，并使用 [`tablesorter.js`](/static/js/tablesorter.js); 完成排序；使用 `.table-sort-not`{.CSS} 禁用排序。
    它们通常没有其他风格。

    桌子可以折叠；折叠将显示前几行。
    如果想要提供摘要或关键行，可以使用 `.abstract-collapse-only`{.HTML}。
- **水平标尺**：可以被视为“匿名部分”，当我们不想编写标题并添加另一个目录时，或者我们已经深入到令人不舒服的深度，例如 7 级深度。

## 诗歌

<span id="poem"></span> Gwern.net 上的诗歌未使用块或代码块标签进行格式化，而是使用 `div`{.HTML}/`span`{.HTML}/`pre`{.HTML} 标签上设置的自定义 CSS 类进行格式化。
（有关设计原理的背景，请参阅详细的[“诗歌 HTML 排版”](/poetry-html) 文章。）

移动设备没有受到任何特殊待遇：移动诗歌的渲染方式就像桌面诗歌一样，尽管窗口很窄。

### 行内诗

内联诗歌被放入 `span.poem`{.HTML} 中。

这通常用于引文（例如，著名的诗[“玫瑰是红色的/紫罗兰是蓝色的”]{.poem}）。

它们将以不同的字体呈现（[Nimbus Mono L](!W)），并且正斜杠将巧妙地淡出以提高可读性。

### 块诗
####简单的块诗

我们的块诗歌排版试图复制传统的英语诗歌排版：诗歌以等宽衬线字体呈现，以保持间距对齐；段落开头没有缩进；如果一行必须断行，则断行部分由 JS+CSS 缩进。
（如果是一首诗，则首行的小写字母将被禁用。）

围绕诗歌的 `div.poem`{.HTML}，其中使用反斜杠表示换行符（变成 `<br>`{.HTML} 元素），完整的节由单个空行分隔。大型“分隔符”可以写为水平标尺（并且在 `div.poem`{.HTML} 内不会进行特殊处理）。
[示例](/fiction/christmas "‘A Christmas Protestation’, o1-pro et al 2024"){.backlink-not}：

~~~{.HTML}
<div class="poem">
**_Dear Santa_**, pray accept this urgent plea \
And burn your police reports regarding me. \
I write to clear my name of wicked lies, \
That cast me as a fiend in festive guise!
</div>
~~~

<div class="admonition error">
<div class="admonition-title">反斜杠必须结束其行</div>

Pandoc Markdown 仅将反斜杠视为换行符（如果它是*该行的最后一个字符*）。
因此，用注释注释的行必须将所有 HTML 注释放在反斜杠*之前*。
</div>

如果块诗的行包含空格分隔的正斜杠 (`" / "`{.HTML})^[您也可以使用 `<br>`{.HTML}，但为了可读性和统一性，在 Markdown 中首选正斜杠。
要在 `.poem`{.HTML} 内键入文字正斜杠或文字双竖线，您可以通过添加 Unicode 实体（如 [零宽度空格](!W)，即改写 `&ZeroWidthSpace;/&ZeroWidthSpace;`{.HTML} 或 `&ZeroWidthSpace;||&ZeroWidthSpace;`{.HTML}）或完全使用不同的字符来故意破坏 JS 正则表达式匹配（例如 BIG SolidS '⧸' 或拉丁字母双管 'ǁ'）。]，这被解释为*缩进换行*，其中下一行的开头与上一行的结尾垂直对齐。

这对于表示 [caesuras](!W)、[enjambments](!W)、[half-lines](!W "Alliterative verse#Meter and rhythm")] 等）很有用。
[示例](/fiction/silver-bird "‘Silver Bird Above San Francisco’, Gwern et al 2025"){.backlink-not}：

~~~{.HTML}
<div class="poem">
So much / depends upon
...
</div>
~~~

会渲染成这样：

~~~{.default}
So much
        depends upon
~~~

如果一行包含多个正斜杠，那么它们会重复缩进，看起来像一个“楼梯”，[像这样](/fiction/snowbank#past){.backlink-not}：

~~~{.HTML}
<div class="poem">
For we can always see and feel much that the people in old photos and newsreels could not:

that their clothing and automobiles were old-fashioned, \
that their landscape lacked skyscrapers and other contemporary buildings, \
that their world was black / and white / and haunting / and gone.
</div>
~~~

会渲染成这样：

~~~{.default}
For we can always see & feel much that the people in old photos & newsreels could not:

that their clothing and automobiles were old-fashioned,
that their landscape lacked skyscrapers and other contemporary buildings,
that their world was black
                           and white
                                     and haunting
                                                  and gone.
~~~

对于“不”意味着换行的半行，例如许多头韵诗句符号，[caesura](!W) 标记由空格分隔的双竖线 (`" || "`{.HTML}) 表示；与换行符分隔符类似，停顿标记被淡化以减少其干扰性。
（作为特殊情况，如果使用 `div.text-center`{.HTML}，则停顿标记将垂直对齐。）
正斜杠换行符和停顿标记可以在同一行中使用。
[Normal example](/review/book#the-legend-of-sigurd-and-gudrun-tolkien-2009){.backlink-not}:

~~~{.HTML}
<div class="poem">
> In they hacked them, || out they hurled them, \
> bears assailing, || boars defending. \
> Stones and stairways || streamed and darkened; \
> day came dimly— || the doors were held.
</div>
~~~

说明垂直对齐的特殊情况：

> <div class="poem">
> <div class="text-center">宋是礼物||我们把它们还给他们。 <!-- 2+2: SONG GIFT || GIVE BACK [g-g] --> \
> 我们以节奏加冕||我们无法保留的东西。 <!-- 2+2: CROWN CA-DENCE || CAN-NOT KEEP [k-k] --> \
> 协议成立； ||我们用黄金支付。 <!-- 2+2: PACT HOLDS || PAY GOLD [p-p] --> <!-- Ring structure: "gold" returns to opening line, completing the ode-as-payment --> \
> 计数是一种||的冷藏。 <!-- 2+2: COUNT KIND || COLD KEEP-ING [k-k] -->
> </div>
> </div>

如果不是独立的诗歌页面，例如引文，它可能位于块引用中（div 是否位于块引用内并不重要）。
仅当您已位于块引用/脚注/列表缩进内时，才在行前添加 `>`{.Markdown} 前缀；否则省略。
一个简单的[示例](!W "The Cremation of Sam McGee")：

~~~{.HTML}
> <div class="poem">
> There are strange things done in the midnight sun \
> By the men who moil for gold; \
> The Arctic trails have their secret tales \
> That would make your blood run cold; \
> The Northern Lights have seen queer sights, \
> But the queerest they ever did see \
> Was that night on the marge of Lake Lebarge \
> I cremated Sam McGee.
> </div>
~~~

[`.poem`]{.HTML} 与铭文 (`.epigraph`{.HTML}) 兼容。
所以这会起作用（复杂的例子）：

~~~{.HTML}
<div class="epigraph poem" id="example-poem-2">
> Roses are red <!-- 4: RO1-ses2 are3 RED4. [red/—] --> \
> Violets are blue <!-- 5: VI1-o2-lets3 are4 BLUE5. [blue/you] --> \
> And I love you. <!-- 4: and1 I2 LOVE3 YOU4. [blue/you] --> <!-- NOTE: foo -->
>
> ---[Anonymous](!W "Roses Are Red")
</div>
~~~

#### 复杂块诗

有些诗歌需要不寻常的空白，例如[具体诗歌](!W)或[calligrams](!W)。
对于需要*精确*空格的诗歌，可以使用 `<pre class="poem-html">`{.HTML} 以原始 HTML 编写。

这些 HTML 块 **必须** 完全从 Pandoc 处理中转义，Pandoc 处理 [将吃掉所有空白，甚至*内* HTML 元素 ](https://github.com/jgm/pandoc/issues/10077 "‘Pandoc Proposal (#10077)：保留前导、尾随和多个字间空格 <span class='editorial'>[拒绝]</span>'，me-kell 2024"），使用 Pandoc [`raw_attribute` 扩展 ](https://pandoc.org/MANUAL.html#extension-raw_attribute)（即封闭）它是三个反引号）。
这些必须完全用原始 HTML 编写； no Markdown interpretation will happen.

当由客户端 JS 渲染时，`<em>`{.HTML} 或 `<a>`{.HTML} 等标签占用的水平空间将被空白替换，使创作更容易、更接近所见即所得。
例如，为了将斜体单词排列在另一个单词下面，这两个单词必须垂直排列（`<em>`{.HTML} 标签除外）； [例如](/lorem-block#kintsugi-form){.backlink-not}：

~~~{.HTML}
```{=HTML}
<!-- NOTE: `pre.poem-html` to force exact vertical alignment rather than enjambment: -->
<pre class="poem-html" id="complex-block-poetry-example">
他们的手记住了空气中的寂静，
                                    <em>care</em>
...
</pre>
```
~~~

将在“air”正下方使用“_care_”进行渲染：

> ```{=HTML}
> <pre class="poem-html" id="complex-block-poetry-example">
> 他们的手记住了空气中的寂静，
>                                     <em>care</em>
> ...
> </pre>
> ```

因此对于整体空白：

#.使用 `\`{.Markdown} 进行正常划线。
#.当您想要带有缩进的视觉半行分隔符时，请使用 `" / "`。
#.仅当您需要精确的列/几何形状时才使用 `pre.poem-html`{.HTML}。

### 各种诗歌格式

- **扫描/韵律元数据**：在可行的情况下，诗歌应提供行的注释版本，注释其关键的格律属性，如节奏、音节数或韵律（韵词或其行）。
  由于米数变化很大，因此应根据诗歌调整行距，并最好在注释中记录在顶部。
  一些例子：

    - *平达里克高压锅*：`<!-- [Stress Count]: [SCANSION CAPS] || [SCANSION CAPS] [scheme/notes] -->`{.HTML}

        示例：`Gold is the wrought word, || god-gift to the world; <!-- 3+3: GOLD WROUGHT WORD || GOD-GIFT WORLD [g-g]; Apollo ref -->`{.Markdown}
    - *押韵诗*：`<!-- [Syllable count]: A1-b2 c3 D4 e5 f6 GI7-h8, i9 J10 k11 l12 M13. [A-rhyme/B-rhyme] -->`{.HTML}

        示例：`Checking for ghosts with his rifle, he paced through the night, <!-- 13: CHECK1-ing2 for3 GHOSTS4 with5 his6 RI7-fle8, he9 PACED10 through11 the12 NIGHT13. [night/tight] -->`{.Markdown}

        `before dawn,</p> <!-- 3: be1 FORE2 DAWN3 [dawn/dawn@46] -->`{.Markdown}（突出显示第 46 行的重复项）

        在自由诗中，人们可能会明确地写出 `[-/-]` 来表示没有韵律被跟踪或不相关。
  这些对于安全修订和LLM文档很有用。

    [示例](/fiction/this-last-pain "‘The Fourth Truth Of Pain’, Gwern et al 2022"){.backlink-not}，它跟踪音节的运行计数、重音和尾韵：`<!-- 10: this1 LAST2 PAIN3 for4 the5 DAMNED6 the7 FA8-thers9 FOUND10. [found/crowned] -->`{.HTML}

    值得跟踪的内容取决于具体的诗（例如，俳句不需要跟踪押韵）。

    （不寻常的措辞选择或故意的拼写错误等也应记录在同一行的 HTML 注释中。）
- **注释**：同样，理想情况下，每首完整的诗都会包含详细的注释（隐藏在 HTML 注释中），解释背景、主题、格式、典故和相关诗歌/诗人/流派，以及对这首诗的解释。

    “LLM 元块”是给编辑的简短交接说明；它适用于LLM编辑量大的页面，不适用于手写或历史页面。

    诗歌/小说可能还包括较长的“评论”HTML 评论块（无限制长度），用于扫描、典故、修订理由等。评论块不受 ≤10 行的限制。

    这应该放在 YAML 元数据和摘要之间，以供人类/LLM可读。
- **自定义水平标尺**：水平标尺有时可用于分隔没有节标题的节或节，通常写作 `---`{.Markdown}。

    默认的 Gwern.net 标尺外观是在 [Vergina sun](!W) → 阿拉伯式花纹月亮 → Source-Serif-Pro-stars 图标三个图标之间循环。
    出于主题目的硬连线*特定*图标可能很有用，例如。像[“Silver Bird”](/fiction/silver-bird "‘Silver Bird Above San Francisco’, Gwern et al 2025"){.backlink-not #silver-bird-2} 中那样用 `<div class="horizontal-rule-nth-1"><hr></div>`{.HTML} 硬连线太阳。
    （警告：在 Markdown 中，使用反引号语法转义原始 HTML！）
    标尺图标类型和基本原理应记录在 HTML 注释中。
- **页面级外观调整**：诗歌页面受益于设置多个[页面级CSS属性](#css-extension)，这通常会减少混乱并有助于设置正确的情绪。

    - `.toc-not`{.HTML}：目录通常无用，有时由于无法修复的微妙 CSS 错误而与文本重叠
    - `.reader-mode`{.HTML}：主要是为了抑制诗歌文本中的超链接装饰，例如。评论/注释
    - `.dark-mode`{.HTML}：强制页面进入[黑暗模式](!W)
    - `.index`{.HTML}：简化整体页面外观
    - `.dropcaps-not`{.HTML}：明确记录页面上任何地方都没有使用首字下沉，因为它们使诗歌更难阅读并且是非传统的。 （本地覆盖为 `.dropcap-not`{.HTML}；另请参见 `.smallcaps-not`{.CSS}）
    - `.extract-not`{.HTML}：适用于根本不应该弹出的页面，因为这是一种糟糕的阅读体验（例如，大量超链接的 `.reader-mode`{.HTML} 或具体的诗歌）
    - `div/span.reader-mode-not`{.HTML}：在摘要或 [descriptions](#metadata-field-description) 上使用此选项以在弹出窗口/预览中显示内容，但将其隐藏在（阅读器模式）页面本身上，以及 `span.reader-mode-disable-when-here`{.HTML} 在某个点（例如末尾）禁用阅读器模式。

        对于诗歌页面等艺术页面很有用，我们可以在其中全局启用阅读器模式，然后隐藏摘要（同时仍保留其用于弹出窗口/类似链接提取）。
- **节标题**：通常已弃用，因为不必要且首选简单粗体（例如 `<p><strong>1. Section Title</strong></p>`{.HTML}），但只要使用 `.toc-not`{.HTML} 就可以接受。

    - 对于*多部分诗歌*：更喜欢包含整首诗的单个 `div.poem`{.HTML}。
    使用独立的粗线（即 `**1. Title**`{.Markdown}）而不是 Markdown 标题标记内部面板/部分，以避免 ToC 污染并保留诗歌排版。
仅当诗歌被分割成多个 .poem 块时才使用 div.text-center 舞台方向。
- **HTML ID**：请注意，所有元素都支持常见的 HTML 功能，例如 ID，因此如果您在诗歌上设置 ID，则可以直接链接（并弹出）诗歌 — 包括内联跨度引号。 （这对于我们可能想要弹出一首诗中的特定短语的详细评论特别有用。）
- **折叠兼容性**：所有 `.poem`{.HTML} 元素都与 `.collapse`{.HTML} 兼容，因此可以轻松隐藏一首诗的选定部分，或隐藏整首诗（可能因为它是一个变体）
- **插图**：为了避免分散对诗的注意力，如果不直接说明特定的诗节，通常会附加插图。它们的质量应该足够高，值得全角显示，例如 `.width-full .invert-not`{.HTML}；但它们不一定需要任何标题或替代文本或说明文字，因为它们通常只是为了美观而存在。

    如果有多个，可以将它们随机化 <!-- TODO: document the randomized-div feature in general --> 以在每个页面加载时显示一个，以避免过载，[例如 ](/blog/2025/bell-crow-moon "‘Bell, Crow, Moon: 11 Variations’, Gwern et al 2025"){#bell-crow-moon-1 .backlink-not}

    ~~~{.HTML}
    <div class="display-random-1">
      <div class="display-entry">
      ![](…){.width-full .invert-not …} <!-- first illustration -->
      </div>
      …
    </div>
    ~~~
- **致谢、主题、评论、章节标题、归属行等**：可以使用 `div.text-center`{.HTML}（[例如 ](/fiction/poem "‘Poems’, Gwern 2011"){.backlink-not}）在 `.poem`{.HTML} 之外呈现。

    它们与铭文不同：没有引号样式，没有属性括号，只有一条中心线（可以选择块引号以保持一致的间距）。
- **诗间标题/舞台方向**：在多个 `.poem`{.HTML} 块之间使用 `div.text-center`{.HTML} 来标记地点/时间/语音转换。
- **变体集或列表**：使用普通编号列表（[例如](/blog/2025/bell-crow-moon "‘Bell, Crow, Moon: 11 Variations’, Gwern et al 2025"){#bell-crow-moon-2}）
- **版权页，讨论**：默认情况下可以追加和折叠（[例如](/fiction/christmas#colophon){.backlink-not #christmas-2}）。一般格式为：

    #. `div.collapse`{.HTML}；
    #. `span/div.abstract-collapse`{.HTML} 社论；和
    #.像 `[Colophon.]{.marginnote .abstract-collapse}`{.HTML} 这样的边注标签，如下所示：

        ~~~{.HTML}
        <div class="collapse editorial">
        [Colophon.]{.marginnote .abstract-collapse} By …

        Full colophon text…
        </div>
        ~~~

<!-- 草案：诗歌页面模板骨架（尚未正式；诗歌模式待定）。

&#45;&#45;&#45;
​标题：“标题”
作者：格温·布兰文
描述：“1-3 句话简介（20-650 个字符）。”
​创建时间：YYYY-MM-DD
​修改：YYYY-MM-DD
缩略图：/doc/PATH/TO/IMAGE.jpg
缩略图文本：“‘缩略图标题’：缩略图/预览标题。（如果全角附加相同的图像，请逐字重复使用。）”
​#thumbnail-css: invert-notoutline-not#可选
​状态：已完成
​信心：虚构
​重要性：4
css-extension: dropcaps-not reader-mode toc-not index # TODO: 考虑 `poem-mode` 快捷方式
...

&lt;!&#45;&#45;
评论（可选；可以很长）：

结构与形式：
- ...

关键的正式技巧：
- ...

主题/典故：
- ...

注意事项：
- 如果您故意违反全局 MoS 规则（拼写/措辞/打字错误等），请在相关行上内联记录。
&#45;&#45;&gt;

<div class="abstract reader-mode-not">
> 第一段：钩子 + 1-2 句话总结这首诗的内容。
>
> 第二段：正式注释（韵律/韵律/副歌）、背景和/或要寻找的内容。
>
> 第三段（可选）：变体/版权页/为什么启用阅读器模式/折叠中隐藏的内容。
</div>

<div class="poem" id="poem-main">
诗的第一行。 &lt;!&#45;&#45; 10: SCAN1 sion2 GO3 es4 HERE5。 [韵/韵@N] &#45;&#45;&gt; \
第二行；注释必须位于反斜杠之前。 \

新节在一个空行之后开始。 \

使用缩进的半换行符“/”（空格-斜杠-空格）：\
这么多/取决于\

使用带有“ || ”的停顿标记（空格-双管-空格）：\
他们黑了他们，||他们把它们扔出去，\
</div>

&lt;!&#45;&#45; 可选：不带标题的节/节分隔符 &#45;&#45;&gt;
&#45;&#45;&#45;

&lt;!&#45;&#45; 可选：硬连线图标（例如“太阳”/Vergina sun）&#45;&#45;&gt;
<div class="horizontal-rule-nth-1"><hr></div> &lt;!&#45;&#45; 太阳 &#45;&#45;&gt;

&lt;!&#45;&#45; 可选：多个诗块之间的诗间标题/舞台方向 &#45;&#45;&gt;
<div class="text-center">[I。 SECTION TITLE.]</div>

<div class="poem" id="poem-2">
第二首诗/部分放在这里。 \
</div>

&lt;!&#45;&#45; 可选：插图（经常重复使用 `thumbnail` + `thumbnail-text`）&#45;&#45;&gt;
![](/doc/PATH/TO/IMAGE.jpg "‘THUMBNAIL TITLE’: Thumbnail/preview caption."){.invert-not .width-full}

&lt;!&#45;&#45; 可选：多个插图，随机（每页加载显示一个）&#45;&#45;&gt;
<div class="display-random-1">
  <div class="display-entry">
  ![](/doc/PATH/TO/IMAGE-1.jpg "…"){.width-full .invert-not}
  </div>

  <div class="display-entry">
  ![](/doc/PATH/TO/IMAGE-2.jpg "…"){.width-full .invert-not}
  </div>
</div>

&lt;!&#45;&#45; 可选：变体/附录/替代形式（默认折叠）&#45;&#45;&gt;
<div class="collapse" id="variant-1">
<div class="abstract-collapse">
> 变体：一行描述（例如“替代版本：品达里克颂歌（未经编辑）。”）
</div>

<div class="poem" id="poem-variant-1">
变体文本位于此处。 \
</div>
</div>

&lt;!&#45;&#45; 可选：精确空白具体诗歌 &#45;&#45;&gt;
~~~{=HTML}
<pre class="poem-html" id="poem-html-1">
Exact whitespace here (Pandoc-safe raw HTML block).
</pre>
~~~

&lt;!&#45;&#45; 可选：版权页/致谢/讨论（折叠）&#45;&#45;&gt;
<div class="collapse editorial" id="colophon">
[版权页]{.marginnote .abstract-collapse} 作者：...

完整版权页/致谢/讨论文本见此处。
</div>

&lt;!&#45;&#45; 可选：如果您想要在诗后使用正常的链接样式，尽管 `reader-mode` &#45;&#45;&gt;
<span class="reader-mode-disable-when-here"></span>
-->

# 注释

注释通常是论文的摘要，后面是摘录。
他们有时会有[广泛的评论或社论插入](#editorial)（并不总是来自我自己），它们位于方括号中。
这些评论可能是小论文。

注释基础设施很复杂，并且支持手动、半自动和自动创建注释的混合。

- **自动**：WP
- **半自动**：[arXiv](!W)、[BioRxiv](!W)/[MedRxiv](!W)]、一些带有摘要的 PDF 可通过 [Crossref](!W)、带有 `.abstract`{.HTML} 摘要的 Gwern.net 论文获得
- **手册**：其他一切

注释不支持章节或脚注。
各部分由水平标尺 (`<hr>`{.HTML}) 和页边注释替换。
脚注简单地写在方括号内，并且可以折叠。

大的摘录也可以折叠。

在某些情况下，折叠注释的一部分是不够的——比如当我们想要在 2 个不同的上下文中链接一个 URL，重点关注 2 个不同的摘录时，所以我们不能简单地折叠任何一半。
在这种情况下，我们可以使用涉及锚点 ID 的 hack：我们只需将两个新 ID 添加到原始 URL，例如 `/doc/2026-foo.html#bar`{.HTML} 与 `/doc/2026-foo.html#baz`{.HTML}，然后为它们编写*单独的注释*，因为它们现在在技术上是“不同的 URL”，即使它们加载相同的网页。[^cross-link-annotations]
在 PDF 的特殊情况下，当发生这种情况时，我们通常可以通过为两个不同的用例指定最相关的 `#page=N`{.HTML} 来利用内置页码锚点来获取更有用的 ID。

[^cross-link-annotations]:然后我们可以交叉链接它们：`#bar`{.HTML} 版本可能有一个[编辑评论](#editorial)，如下所示：

    ~~~{.HTML}
    <span class="editorial">[see also <a href="/doc/2026-foo.html#baz">Baz excerpts</a>]</span> Abstract...
    ~~~

“关键字”已从提供它们的论文中删除。
While they may have been highly useful for librarians indexing documents in the pre-computer era, they are almost never useful now due to extreme inconsistency in the controlled-vocabulary across all authors/publishers---and even the small benefit they still provide to skimming is obsoleted by the fact that all of the keywords will usually be hyperlinked or bolded & jump out that way.
（它们可以隐藏在注释中以向嵌入器提供提示，但否则会浪费空间。）

一些学术出版商或作者使用项目符号列表摘要来总结摘要。正常布局时，它们占据了大量的垂直空间，同时又与适当断行或主题分割的摘要显得多余。
我们保留它们，但我们将它们压缩为带有 BULLET 的单个内联列表，并用水平标尺分隔。

同样，一些出版商在科学摘要的同时提供“外行”或“简单”或“公共”摘要。
这些应该首先呈现，并用水平尺分隔。

# 代码

- **评论**：应该关注“为什么”，尤其是“为什么*不*”，而不是“如何”。
- **需要语法高亮**：所有代码块都应该为[语法高亮](!W)]指定一种语言，如果可能的话，使用[Pandoc语法高亮](https://pandoc.org/MANUAL.html#syntax-highlighting)。
  这包括差异等文档格式。
  （即使代码块中的某些内容是伪代码或严格来说不是任何语言，[skylighting suite](https://github.com/jgm/skylighting) 通常具有*某些*，它将提供有用的结果。如果想要纯文本，请使用 `~~~{.default}`）

    - *内联可选*：内联代码语法突出显示（<code class="Markdown">&grave;code&grave;{.LANG}</code>）是可选的，因为它通常是无用的（由于缺乏上下文）或分散注意力
- **显示输出但注释掉**：对于交互式可运行代码，如 shell 或 REPL，输出通常不能进行语法突出显示。
  因此应该包含输出，但注释掉一级深度；如果该语言的语法允许，常规注释可以嵌套得更深。
  例如，在 Bash 中，我们可以使用 `#`{.Bash} 为输出添加前缀，并使用 `##`{.Bash} 为注释添加前缀：

    ~~~{.Bash}
    $ echo "Hello world!"
    # "Hello world!"
    ~~~
- <span id="balanced-parentheses"></span> **平衡分隔符**（方括号/圆括号/双引号）：[默认 Emacs Markdown 设置](/static/build/markdown.el) 检查这些分隔符是否始终平衡（使用 [`check-parens`{.Elisp}](https://www.gnu.org/software/emacs/manual/html_node/emacs/Parentheses.html)）。

    这很重要，因为它捕获了许多 Markdown/HTML 语法错误，但它天真地包含了代码块或生成的文本示例，而某些结构没有也无法平衡（例如 Bash case 语法）。
    要将这些情况列入白名单，请包含带有匹配“缺失”分隔符的 HTML 注释；如果是双引号，则插入零宽度空格。
    在某些情况下，这些可能必须直接插入到源代码片段中。
- **再现性海市蜃楼**：代码的再现性不是一个主要优先事项，因为它很少有用，并且可能需要复杂的脆弱管道和过高的资源使用（例如归档整个操作系统映像）才能实现真正的再现性。
- <span id="javascript"></span> **JavaScript**：JS 编码留给[Achmiz](https://wiki.obormot.net/)，他可能会在某个时候写一个 JS 风格指南，所以我们不会在这里介绍它。
- <span id="emacs-lisp"></span> **Emacs Lisp**：字节编译时没有 lint 警告

## 重击

Gwern.net [Bash](!W){#bash-wp-2} 脚本**仅适用于 Bash**，[仅适用于 GNU/Linux](!W)，有据可查，并且针对长期维护而不是极简主义进行了优化。
可读性、明确性和调试性是关键。

- **Shell**：GNU `bash`，而不是 POSIX `sh`。

    允许使用数组、关联数组、`[[ … ]]`、`${var^^}`、进程替换和导出函数。
- **用户空间**：除非另有说明，否则假定为 GNU/Linux coreutils。

  - Apple/BSD 不重要且不受支持，特别是考虑到[过时且支持不佳的 macOS 用户区](/review/movie#apple)。
- **工作目录**：通常为 `~/wiki/static/build/` 或 `~/wiki/`。使用 `path2File`{.Bash}/`file2Path`{.Bash} 实用程序函数转换绝对 Gwern.net 路径（例如 `/doc/foo.pdf` → `~/wiki/doc/foo.pdf`）
- **辅助函数**：实用函数在 [`bash.sh`{.Bash}](/static/build/bash.sh).h] 中定义。
- **错误处理**：

    - 脚本必须“快速失败”，使用 `set -e`{.Bash}；致命先决条件（缺少工具、缺少目录、错误参数）必须立即通过 `exit`{.Bash}（脚本）/`return`{.Bash}（库）提供明确的消息*和唯一的退出代码*。

    - *明确忽略错误*：使用 `|| true`{.Bash} 或范围明确的 `set +e … set -e`{.Bash} 岛来选择性地运行可能失败的测试（请参阅[包装惯用法](#bash-wrapping)）
      切勿依赖隐式 `set -e`{.Bash} 异常或启用 `set -e`{.Bash} 的 `bash.sh`。
    - 允许 `set -euo pipefail`{.Bash} *在包含的帮助程序中*，其中所有变量和管道都受到控制（例如 `find_colliding_files()`{.Bash}）

        除非每个变量扩展都经过审核，否则不要全局启用。
        每个 `exit`{.Bash}/`return`{.Bash} 应使用不同的整数，以便更轻松地查找出处。
        （整数不需要表示任何含义，但如果它们按粗略的执行顺序排列，则会很有帮助。）
    - 可恢复的故障*记录为警告*（使用辅助函数 `red`{.Bash}）并继续执行。
- **标志、选项和命令样式**：

    - *始终使用长标志*：`sort --unique`{.Bash}，而不是 `sort -u`{.Bash}。

        如果这可能很麻烦，例如 `grep --fixed-strings`{.Bash}，可以将别名添加到硬连线长标志中（例如 `grep`{.Bash} DSL、 `gf`{.Bash}/`ge`{.Bash}/`gfv`{.Bash}/`gev`{.Bash}/`gfc`{.Bash}/`gec`{.Bash}：`g` grep、`v` 用于否定或过滤 *out*、`f/e` 用于固定与正则表达式、`c` 用于正命中的终端着色）
    - 在任何文件参数场景中显式*终止选项*以降低风险：`rm -- "$FILE"`{.Bash}。
    - *优先使用显式 GNU 标志*而不是位置魔法（`--max-args`{.Bash}、`--recursive`{.Bash}、`--null`{.Bash} 等）。
- **引用所有内容**，除非分词或通配符是故意的并记录在案。

    [Gwern.net 文件名](#files) 要求不含空格，但这样假设是不安全的，并且应处理带有空格的文件名。
- **数组优于字符串**用于列表。
- **阅读线**必须坚固：

    ~~~{.Bash}
    while IFS= read -r line; do
        …
    done
    ~~~

    任何临时 `IFS` 修改都必须严格限定范围并进行注释。
- **变量和命名**：

    - *全局/配置*：`ALL_CAPS`。
    - *局部变量*：用 `local`{.Bash} 声明，分组在函数顶部。
    - *数组*：扩展时为 `("${array[@]}")`{.Bash}。
    - *关联数组*：仅当键在语义上有意义时。
- **别名**：如果不处理参数，则优于函数；特别适合更符合人体工程学的名称或防止拼写错误（例如 `alias pdfcut="pdf-cut"`{.Bash}）
- **函数定义**：如果读起来更好，可以在函数内部声明一次性内部函数
- **Haskell 互操作性**：

    对脚本使用 `runghc`，对单行代码使用 `ghci -e`{.Bash}。

    请注意，您必须在单行代码中显式导入模块：例如。 `ghci -e 'do { md <- LinkMetadata.readLinkMetadata; ... }'`{.Bash}。
    不要假设任何模块是隐式导入的。

### 脚本结构和分解

大型脚本的结构如下：

#.元数据头
#.严格模式设置
#.进口
#.常量/配置
#.帮手

    一旦逻辑超过一屏，就更喜欢“小型的、命名的帮助程序”而不是内联管道。
#.标准化输入
#.主要逻辑

### 输出和记录

- 状态输出**响亮且可浏览**。
- 错误转到 **stderr**。
- **ANSI 终端颜色**：通过小型帮助程序允许（`bold`{.Bash} 表示重要信息，`red`{.Bash} 表示错误，`green`{.Bash}/`yellow`{.Bash} 表示常规日志消息等）。
- 长脚本在主要工作之前打印**阶段标题**。
- <span id="bash-wrapping"></span> 要报告运行 lint 过程中的警告/错误，请使用我们的 `wrap`{.Bash} + `λ`{.Bash} 习惯用法：

    ~~~{.Bash}
    λ(){ …; }
    wrap λ "warning message"
    ~~~

    这是为了更复杂的管道检查/lints：我们定义一个[“匿名函数”](!W)（重用名称`λ`{.Bash}）并将其传递给`wrap`{.Bash}。
    `wrap`{.Bash} 执行该函数，捕获 stderr/stdout，并在存在任何输出时打印格式化警告。
    （`wrap`{.Bash} 不会隐藏错误，因为我们可能希望尽快崩溃；因此，如果匿名函数可能抛出非致命错误，则必须显式忽略它。）

### 依赖关系和飞行前检查

- **首先检查依赖关系**：在实际工作开始之前，必须检查所有必需的外部命令。

    使用 `command -v`{.Bash} 检查是否存在必要的二进制文件。
- **列出所有失败**：特别是，依赖项失败应该列出“所有”缺少的工具，而不仅仅是第一个，以便用户可以有效地批量安装它们，而不是痛苦地一次循环一个。

### 资源友好性

- **等待**：后台作业必须在阶段结束时跟随显式的 `wait`{.Bash} 以避免竞争条件。
- **超时**：后台作业可能需要 `timeout` 包装器——尤其是网络绑定作业（例如 `timeout 5m git pull`{.Bash}）

    根据经验，Web HTTP 查询应花费 <30 秒，完整网页下载不应花费 <80 秒，而更复杂的操作（如 git 文件系统操作）应花费 <250 秒。
- **避免过度并行**：太多并行可能会导致错误*并且*速度变慢。因此，`parallel`{.Bash}/`xargs`{.Bash} 必须显式指定批处理和并发性。

    `$N`{.Bash} 定义允许的并行计数。

    惯用语注释：定义一个Bash函数，然后是`export -f function`，现在可以与`parallel`{.Bash}并行
- **最低功耗**：如果脚本主要用于后台或维护，则应使用 `nice`/`ionice`/`renice` 降低资源优先级（例如，降低您自己的 CPU 优先级，`renice --priority 19 --pid "$$"`{.Bash}，或启动新的低优先级作业，`nice --adjustment=19 ionice --class 3`{.Bash}）
- **基于日期的条件执行**：使用 `everyNDays` 帮助程序每 _n_ 天运行一些内容，避免每次执行或 cron 作业的成本，但确保它偶尔运行

### 临时文件和原子性

- `/tmp/`：使用 `/tmp/` 中的 `mktemp`{.Bash}/`mktemp --directory`{.Bash} 作为暂存空间。不要使用主目录或点文件等。
- **原子写入**：将输出写入临时文件，然后将 `mv`{.Bash} 写入到位以获得更大的原子性。
- **Catch**：使用 `trap`{.Bash} 在多步转换中进行清理。设置为`trap EXIT HUP INT TERM`{.Bash}，成功后取消设置（`trap - EXIT HUP INT TERM`{.Bash}）

### ShellCheck

- 目标是**零 [ShellCheck](https://www.shellcheck.net/) 警告**。

    某些警告可能需要列入白名单。
- **单独列入白名单**：窄范围、内联、有理由的抑制。

    - 白名单*导入*：为 ShellCheck 显式注释源路径。

### 命令内的内嵌注释

对于复杂的管道，允许并鼓励注释 *inside* 命令调用：

~~~{.Bash}
command \
    --option-1 \
    `# rationale for option-2` \
    --option-2 \
    `# --option-3  # TODO: re-enable after fixing upstream bug`
~~~

在解释“为什么”选项存在时，这比尾随注释更受欢迎。

### Bash 脚本模板

<!-- balance brackets: (((((( -->

~~~{.Bash .collapse}
#!/usr/bin/env bash
#
# script-name.sh—one-line description of purpose
#
# Author: Gwern Branwen
# Date: YYYY-MM-DD
# When: Time-stamp: "<YYYY-MM-DD HH:MM:SS gwern>"
# License: CC-0
#
# Usage:
#   ./script-name.sh [OPTIONS] ARG…
#
# Notes:
# - Bash-only; GNU userland assumed.
# - Fails fast; recoverable errors are explicitly ignored.
#

set -e

cd ~/wiki/static/build/

########################################
# Imports
########################################

# shellcheck source=./bash.sh
. ./static/build/bash.sh

########################################
# Configuration
########################################

VERBOSE=0
DRY_RUN=0

########################################
# Helpers
########################################

usage() {
    cat <<'EOF' >&2
Usage:
  script-name.sh [--verbose] [--dry-run] ARG…

Options:
  --verbose     Extra logging
  --dry-run     Print actions without executing
EOF
    exit 2 # '2' because we might exit after successfully checking deps
}

## exit early with all missing dependencies to avoid wasting user time/effort:
require_cmds() {
    local missing=()
    for cmd in "$@"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done
    if ((${#missing[@]})); then
        echo "Missing required commands: ${missing[*]}" >&2
        exit 1 # '1' because first place we would exit
    fi
}

log() {
    ((VERBOSE)) && echo "$@" >&2
}

########################################
# Argument parsing
########################################

ARGS=()

# simple parsing, no need for getopts
for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h) usage ;;
        --) shift; ARGS+=("$@"); break ;; # safer calls by explicitly separating flags from parameters
        -*) echo "Unknown option: $arg" >&2; usage ;;
        *) ARGS+=("$arg") ;;
    esac
done

if ((${#ARGS[@]} == 0)); then
    usage
fi

########################################
# Main
########################################

require_cmds rsync sed grep

log "Starting script-name.sh"

for item in "${ARGS[@]}"; do
    if ((DRY_RUN)); then
        echo "Would process: $item"
    else
        process_item "$item" || true   # non-fatal
    fi
done

# disable warnings temporarily
set +e
optional_command1
optional_command2
set -e

log "Done."
~~~

## 哈斯克尔

- **无 GHC 警告**：使用 `ghc -Wall -Werror`{.Bash} 进行编译

    - 应尽可能*[hlint](https://github.com/ndmitchell/hlint)-clean*
- **列表**：超过 2 行的列表应该是悬空逗号前缀样式，以便于编辑，因为它使行级差异更清晰，并允许盲目添加条目，例如。

    ~~~{.Haskell}
    a = [b
       , c
       , d]
   ~~~
- **进口**：

    - *枚举导入*：所有导入都应完全枚举
    - *标准缩写*：`Data.Text`{.Haskell} 始终导入为 `T`{.Haskell}，如 `T.pack`{.Haskell}：

      ~~~{.Haskell}
      import qualified Data.ByteString.Char8 as C8 (...)
      import qualified Data.ByteString.Lazy.Char8 as LBS (...)
      import qualified Data.ByteString.Lazy.UTF8 as U (...)

      import qualified Data.Map.Strict as M (...)
      import qualified Data.Set as S (...)
      import qualified Data.Text as T (...)
      import qualified Data.Text.IO as TIO (...)
      import qualified Data.Vector as V (...)

      import qualified Debug.Trace as DT (trace)
      ~~~
- **注释**：超过 10 行的注释块应始终采用括号语法 `{- ... -}`{.Haskell}，而不是双破折号语法。
- **限制**：

    - *类似集合的列表*：应使用 `Utils.setLike` 随机洗牌运算符定义被视为集合的配置列表（唯一的重复错误，调用者应以顺序不变的方式使用它们）。
    - *配置测试*：配置数据通常应尽可能测试唯一性：唯一键、唯一值、唯一键值、无隐式循环等。
    有关可用约束，请参阅 `Unique`；有关测试套件，请参阅 `Test`。
    应用于配置数据的约束应该在注释中。

# 生成媒体

像 LLM 或图像生成器这样的生成模型是好仆人，但截至 2025 年初，它们就成了糟糕的主人。

我对生成媒体的政策是[生成模型输出必须*改进*](https://www.lesswrong.com/posts/eZa37pZtxsQirE84d/please-do-not-use-ai-to-write-for-you?commentId=atnhgZqDZC8Mef6LM "‘LLM acceptable-use policy’, Gwern 2024")。

模型的输出应在文件名/标题或正文中明确标识；他们应该被批评为正确或错误，并指出错误。

除非在“随机未经策划的输出”的明确上下文中，否则不应使用随机未经策划的输出。

如果使用文本或图像（也许是为了说明），它们应该是[高质量且经过仔细考虑的](/blog/2025/good-ai-samples "‘Adding bits beats AI slop’, Gwern 2025")。
如果它们可以在短短几分钟的提示内生成，并且它们与论文没有明确的联系或任何深度，则根本不应该使用它们。
理想情况下，它们在 10 年后看起来会像今天一样好，而且不会看起来明显过时或有缺陷。
（在 [Substack](!W) 上广泛使用廉价的 [DALL·E 3](https://openai.com/index/dall-e-3/) 图像，通常只比 [Bing](!W "Microsoft Bing") 风格的“虾耶稣”图像] 进步了一步，是*不*做什么的一个很好的例子。）

特别是，他们应该避免使用模型的伪影和刻板的 [mode-collapsed](/doc/reinforcement-learning/preference-learning/mode-collapse/index) 风格。
不应该出现任何可见的伪影，例如畸形的手或没有几何意义的怪异背景。
从风格上来说，Midjourney 样品绝不能以“Instagram 女性”为主题； LLM 输出应避免臭名昭著的说法，如“delve”或 GPT-4o“em-dash 扭曲结尾”。
图像应具有强烈的美感并趋于单色；如果没有特定的颜色主题，则应该是灰度。
（HDR 式的“同时提供所有颜色”是 RLHF 过程将生成模型简化到最低公分母的更可靠的说法之一。）
您可以通过个性化、大量使用类似高温的设置、从 GPT-4.5 等最具创意的模型中获取插图创意以及顽固地坚持修复错误来对抗这种懒惰。

# 文件

文件命名：

- **最重要到最不重要**：文件名应该自动完成。文件名应该尊重自动完成和可预测性。
- **Gwern.net 上的通用文件名形式是 `YYYY[-MM[-DD]]-SURNAME[-TOOL[-TOPIC[-DESCRIPTION]]][-N].EXT`。 （*注意***：文件扩展名是强制性的）。

    - 文件名应该是*全小写拉丁字母数字*（即没有空格或外来字符）。
      如果可行，请使用罗马化，如 [ß](!W) → 'sss;除非有完善的罗马化或翻译，否则通常应保留中文/日文等外来字符集。
      这使得制表符补全和 grep 文件名变得容易。
    - *描述*：可以是自由格式，并且可以嵌入内容的简短英文描述，或附加元数据，例如原始 ID/哈希值。
- *唯一的文件名*：文件的基本名称理想情况下应该是唯一的。
  因此，如果有两个文件，如 `/doc/psychology/2026-wang.pdf` 和 `/doc/biology/2026-wang.pdf`，其中之一仍应重命名为 `2026-wang-2.pdf`。

    为了统一，仅在必要时才对递增的 _N_ 进行零填充。 （因此，如果有 *10* 个这样的 Wang PDF，它们都会被重命名为零填充，如 `2026-wang-01.pdf` ... `2026-wang-10.pdf`。）
- **独特的文件扩展名**：如果常用多个文件扩展名，请对大多数文件扩展名进行标准化（即 `.jpg`，而不是 `.jpeg`；`.png`，而不是 `.PNG`）。
- **重命名**：不应使用 `mv` 移动文件，而应使用自定义 `gwmv`{.Bash} 脚本移动，该脚本将处理文件格式转换特殊情况、全局搜索和替换以及 nginx 重定向。

    目前，Markdown 文章无法随该脚本一起移动，必须手动更新。

文件类型：

- **很少**：尽可能少。
- **长期**：强调向后兼容性。
- **>95% 的浏览器支持**：如果相关，它应该在 [CanIUse.com](https://caniuse.com/){#caniuse-2} 上具有 >95% 的全球支持。 （这可能包括填充。）
- **音频**：为了与 Apple 兼容，必须使用 MP3，而不是 OGG Vorbis。
- **CSV**：我们首选的“电子表格”或“表格格式”。 CSV 必须是 UTF-8 且以逗号分隔，并且必须清晰地读入 LibreOffice 和 R。

## 重命名

为了一致性和方便性，页面/文件应该自由重命名。

- **文件移动**：为了避免过时的引用和 404，请使用 `gwmv` 脚本（在 [`bash.sh`](/static/build/bash.sh){#bash-sh-2} 中）使用 git 移动文件，重写所有现有的超链接，并生成 nginx URL 级重定向。
- **页面移动**：必须手动完成，因为 `gwmv` 尚未覆盖 Markdown 页面

    - <span id="sub-page-moves"></span> *子页面移动*：要执行“将一个部分拆分为独立页面”之类的操作而不破坏“太多”读者体验，请使用 `redirect-from-id` 类和数据属性。
      （有关实例，请参阅 [Lorem Links](/lorem-link#redirect-skipping)，包括重定向多个旧 ID。）

        在简单部分的情况下，只需为页面 `/foo` 编写：

        ~~~{.Markdown}
        # Original Title

        [**See main article.**](/bar){.redirect-from-id}
        ~~~

        现在，每个访问 URL `/foo#original-title` 的读者都会自动重定向到 `/bar`。
        URL 可以有一个锚点（即可以重定向到 `/bar#baz`）。

        如果当前节的 ID 不是已损坏的哈希锚 ID，则可以指定旧 ID：

        ~~~{.Markdown}
        [**See main article.**](/bar){redirect-from-id="old-id"}
        ~~~

        由于我们可能希望重定向许多 ID，而不会使页面混乱，因此它与 `.display-not`{.CSS} 和 `.backlink-not`{.CSS} 类兼容（因为我们不想触发反向链接，因为新页面的读者不感兴趣），并且我们可以包含一些供屏幕阅读器或 LLM 代理使用的编辑文档；给出这样的最终链接，它将“默默地重定向”任何访问 `/foo#old-id` 的人到 `/bar`：

        ~~~{.Markdown}
        [[\[Moved to this article.\]]{.editorial}](/bar){redirect-from-id="old-id" .display-not .backlink-not}
        ~~~

        如果强制重定向不合适，我们可以通过简单地在页面中的有用点定义一个带有错误 ID 的空范围来消除虚假的页内 404——可能在链接本身上设置一个 ID。
        您可以堆叠多个空跨度，以便在一个位置提供多个旧 ID，以捕获每一个可能的拼写错误或过时的 URL，因为文件内容可能会在几十年内多次移动。

    当单个 ID 足够时，在标头/链接上首选 Pandoc `{​#id}`{.Markdown}；当您需要 (1) 多个 ID、(2) 段落中间锚点或 (3) 避免接触周围标记时，请使用 `<span id="...">`{.HTML}。

# LLM写作指南 {.collapse}

<div class="abstract-collapse">
如何为 Gwern 写作：本指南指导LLM交付一篇接近可发表的 Gwern 风格论文**并**为 Gwern 提供快速编辑所需的最少元数据。
本指南主要针对非小说类论文，而不是诗歌等其他资源。

它提炼了 Gwern.net 风格手册 (MoS)、[“牛顿彗星”](/newton "‘Newton’s System of the World and Comets’, Gwern 2016")、[“Project Xanadu”](/xanadu "‘Project Xanadu: Even More Hindsight’, Gwern 2025")] 和 [“沙丘遗传学”](/dune-genetics "‘Genetics and Eugenics in Frank Herbert’s Dune-verse’, Gwern 2018")] 等论文的经验教训，以及该网站 15 年的演变。
</div>

## 心态

- **受众**：具有技术素养的通才，他们会浏览概述、深入挖掘细节并存档内容。你的写作必须既适合浏览者（清晰的结构、摘要、页边注释），又适合深度挖掘者（密集的信息、丰富的链接、全面的脚注/折叠）。
- **语气**：简洁、陈述性、分析性和批判性怀疑。避免对冲、填充和过度热情或促销语言。直接陈述主张，然后提供证据。

    - *尼克常见的LLM主义：*“深入研究”、“它至关重要”、“至关重要”、“值得注意”、“探索…的细微差别”、“挂毯”、“展示”、“作为…的证明”。用具体动词和直接陈述替换。
- **目标**：旨在提供新的综合信息或分析（例如将 X 领域的发现与 Y 领域的方法联系起来以解释 Z 现象）、对现有数据/来源进行更深入的重新分析，或不易获得的意想不到的角度。努力获得持久的见解，而不是短暂的评论。假设读者很聪明，但可能不是该主题的专家。

## 工作流程草案（“冰山构建”）

<div class="width-full">
|步骤|该怎么办 | MoS Hooks（参见[Condensed MoS](#condensed-mos)）|
| :--------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------- |
| **0。范围定义** | **LLM 行动**：用一个精确的句子重述核心请求/主题。列出范围内的关键点和故意超出范围的点以确认理解。将其放入初始元块中。                                                        |元区块|
| **1.来源获取和准备** | **LLM行动**：对于任何引用的外部信息，优先查找和链接到全文、稳定的 URL（PDF、学术页面、信誉良好的档案）。如果有用，请使用 `title`{.HTML} 属性格式化链接：`[display text](URL "'Title', Author Year")`{.Markdown}。如果主库脆弱，请查找 archive.org / archive.is 链接。 |链接、引用、工具提示 |
| **2.概要与结构** | **LLM 行动**：草案标题→摘要（`div.abstract`{.HTML} 块引用）→H2 部分标题（如果可能，≤5 个字）→每个 H2 下的关键要点。识别章节内段落的潜在旁注短语（1-3 个单词）。                                 |信息层次结构、摘要|
| **3.散文一代** | **LLM行动**：使用“通风散文”撰写内容：每行一句话，段落之间空行。内联引用为 `Surname Year`{.Markdown}，带有超链接。没有单独的“参考文献”部分。强调精确性和清晰度。                               |通风的散文、引文|
| **4.冰山建筑** | **LLM行动**：审查草稿是否离题。降级内容：简短旁注（≤200字）到脚注`^[Footnote text.]`{.Markdown}；较长的题外话、数据或代码示例（> 500 个字）至 `<div class="collapse">`{.HTML}（如果需要，可使用 `.abstract-collapse`{.HTML}）；附录（也需要摘要）的大量补充材料（> 500 字）。 |信息密度、结构|
| **5.风格波兰** | **LLM 行动**：应用美式拼写、公制单位（必要时自动转换）、牛津逗号和逻辑引用。使用 Kesselman 估计词来表示概率。重新检查并消除禁用/填充短语。确保正确使用破折号（连字符、短破折号、长破折号 - 长破折号周围没有空格）。 | MoS 语言规则 |
| **6。代码、表格和媒体** | **LLM 行动**：用语言标记代码块。遵守 Bash（长标志、`set -e`{.Bash}）、Haskell（`ghc -Wall -Werror`{.Bash}、合格导入）和 Elisp（字节清理）规则。设置表格标题的格式。对于图像：确保说明性目的，符合 MoS 标准的 `<figure>`{.HTML} 标题（论文与论文摘录），如果生成，请注明 AI 模型+日期。如果默认暗模式反转有问题，请应用 `.invert`{.HTML}/`.invert-not`{.HTML}。 | MoS 代码和媒体 |
| **7.最终自检** | **LLM 行动**：严格应用“交接前检查表”（如下）。                                                                                                                                                                                              |质量保证|
| **8.元块插入** | **LLM 操作**：在 YAML 前面内容*之后和正文*之前*插入简洁的 HTML 元块（模板如下）。                                                                                                                                               |编辑器的透明度 |
</div>

### 迷你元块模板

放置一次，在 YAML 前面内容*之后和摘要/正文*之前。确保凯塞尔曼的话准确无误。

~~~{.HTML}
<!-- LLM_NOTES_START

SCOPE_SUMMARY: [One-sentence summary of the LLM's understanding of the task]
MOS_CONFIDENCE: [Kesselman Word, eg. Likely] [LLM's confidence in adhering to the MoS]
CONTENT_CONFIDENCE: [Kesselman Word, eg. Highly likely] [LLM's confidence in the substantive quality of content]
ASSUMPTIONS_CRITICAL: [Brief list of key interpretation choices affecting the draft,
    eg. "Interpreted 'X' as Y for analysis."]
KNOWN_WEAKNESSES_AREAS: [Brief list of sections/points needing most editorial review,
    eg. "Section 3 argument needs strengthening", "Source for statistic Z is indirect."]
BANNED_PHRASES_TICS_CHECK: Passed [Or: "Self-corrected: removed 'delve', 'pivotal'."]

LLM_NOTES_END -->
~~~

只不过是这个元块结构。简洁是最重要的。

### 内联注释键

这些有助于格温的审查；它们不适用于最终发布的页面。格温会移除它们。
（谨慎且有目的地使用：每节不超过 1--2 个。）

*   `<!-- LLM_REASONING: [Concise rationale for a non-obvious MoS application, structural choice, or interpretation, eg. "Used collapse instead of footnote due to code block inclusion."] -->`{.HTML}
*   `<!-- LLM_ALT_CONSIDERED: Current: "[text snippet]"; Alt: "[alternative wording/structure]" (Rejected because: [brief reason, eg. "less precise", "MoS conflict X"]) -->`{.HTML}
*   `<!-- LLM_TODO: [Action needed, eg. "Verify statistic for X from primary source", "Find original publication year for Y"] -->`{.HTML}

### 工艺细节

- [**摘要**](#abstracts)：必须是包含块引用的 `<div class="abstract">`{.HTML}。

    按照科学模型将此块引用构造为多个段落：“背景”→“数据/方法”（如果适用）→“结果/分析”→“结论/含义”。

    诗歌/小说摘要可以是非科学的预告片；它们仍然应该是多段落且信息丰富的。
- **页边注释**：多段落部分中关键段落的 1--3 个字斜体摘要。不适用于单段落部分。如果一个部分中有多个，它们也会在该部分开始处形成一个微型目录。
- **链接**：任何重要术语、名称或概念的第一个实例都应该有超链接（维基百科通常为 `!W`{.Markdown}）。

    将引文直接链接到全文。尽可能使用深锚点（对于 PDF 为 `#page=N`，对于 HTML 为 `#specific-section`）。

    `<a>`{.HTML}标签优选地具有带有引文元数据的`title`{.HTML}属性。
- **列表**：必须有清晰的逻辑顺序（重要性、相似性、字母顺序，如果没有其他）。

    对于 [非内联](#list-inline)/>6 个短项目（每个 <~30 个字符）的块列表，请使用 `<div class="columns">`{.HTML} 进行两列布局。
- **图像/图形**：仅在真正具有说明性且信息丰富的情况下使用。输出 HTML 必须位于 `<figure>`{.HTML} 标记内。

    最好为科学论文中的图形提供完整的符合 MoS 标准的标题：`**Figure X**: _Summary._<br>(*A*) Detail. (*B*) Detail.`{.Markdown} 如果由 AI 生成，文件名和标题必须注明型号和日期。假设本地存储。
- **脚注与折叠**：脚注 (`^[text]`) 用于简短（≤200 个字）旁白或说明。折叠 (`<div class="collapse">`{.HTML}) 用于更实质性的题外话（>200 个字）、大块引用、代码块或对主流程不重要的数据表。
- **分析立场**：采取批判性评价立场。质疑假设，评估证据强度，并且不要羞于指出论点中的缺陷或不一致（包括历史论点，如[`newton.md`](/newton "‘Newton’s System of the World and Comets’, Gwern 2016"){#newton-2}）。

### LLM要避开的陷阱

<div class="width-full">
|陷阱|修复策略|
| :------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
|过度解释明显的概念/步骤 |相信有技术素养的读者。将重要但次要的细微差别移至脚注或折叠处。专注于新颖/分析方面。 |
|过度对冲/谨慎的填充语言|删除。直接陈述主张，然后提出支持证据或推理。信心通过 Kesselman 词（MoS/Meta-block）来表达。   |
| “虚构”或过度描述的语气 |优先考虑分析清晰度。去掉过多的形容词/副词。用具体的例子或直接的解释代替模糊的隐喻。    |
|悬空引用占位符（例如 `[REF]`）| **切勿使用。**查找并链接到主要来源（或其最佳可用存档）。如果找不到源，请使用 `<!-- LLM_TODO: Find source for X -->`{.HTML}。 |
|不必要的/装饰性图像或表情符号 | **不包括。** 图片仅供参考。禁止使用表情符号。                                                           |
|来源的一般总结|综合并“分析”来源以构建论点或提供新的见解。不要只报道消息来源所说的内容；解释它们的重要性或缺陷。 |
|听起来像通用人工智能输出 |积极改写平淡、过于笼统的句子，或使用常见的 AI 介绍性/链接短语。喜欢精确和强有力的动词。 |
</div>

## 成功指标

“冰山构建”过程的标题：

<div class="width-full">
|步骤|成功指标|
|:-----|:----------------|
| **0。范围定义** | • 主题以单个、精确的句子进行定义，没有任何掩饰<br>• 范围内的点是实质性的，而不是琐碎的，并且全面详尽地阐述了核心主题<br>• 范围外的点预测了读者的期望并澄清了界限<br>• 范围定义可以单独作为论文的任务说明|
| **1.来源获取和准备** | • 每个事实主张都有链接的全文来源或明确标记为您自己的见解<br>• >90% 的链接指向稳定的格式（学术页面、PDF、知名网站）<br>• 所有链接均包含带有作者和日期的正确`title`{.HTML} 属性<br>• 关键声明缺乏时不会出现“数据空白”采购<br>• 为任何可能不稳定的来源提供存档链接|
| **2.概要与结构** | • 章节标题≤5 个单词，声明性和描述性（没有创意/可爱）<br>• 章节遵循构建论证（不仅仅是分类）的逻辑进程<br>• 为每个多段落部分至少确定一个候选页边注<br>• 摘要草案包含可定义的背景、方法、结果和结论元素<br>• H2 标题是足够——避免过多的 H3+ 嵌套 |
| **3.散文一代** | • 每个句子在源文件中恰好占据一行<br>• 所有段落均由空行分隔<br>• 没有强有力的理由，任何段落都不会超过~8 个句子<br>• 所有正式/书目引文均使用所需的`Surname Year` 格式并带有超链接；散文链接应使用正常的超链接文本。<br>• 对文本进行分析并删除常见的LLM 填充短语<br>• 句子平均为15-25 个单词（偶尔较长的句子是可以接受的） |
| **4.冰山建筑** | • 内容布局遵循从左到右的层次结构：基本→ 边距→ 段落→ 脚注→ 折叠→ 附录<br>• 每个折叠元素都有一个有意义的标题或摘要折叠<br>• 脚注不超过200 个字；否则使用折叠<br>• 不重要的内容被降级，但从未完全删除<br>• 随着读者在页面上从左向右移动，信息密度增加|
| **5.风格波兰** | • 一致使用美式拼写，包括在引号中<br>• 所有测量均使用公制单位并在必要时进行转换<br>• 所有列表中均使用牛津逗号<br>• 应用逻辑引号（引号外标点符号）<br>• 长破折号周围没有空格；所有列表均使用牛津逗号。破折号用于表示范围<br>• 概率语言始终使用凯塞尔曼词<br>• 没有保留禁止/填充短语的实例|
| **6。代码、表格和媒体** | • 每个代码块都指定一种语言<br>• Bash 使用长标志和 `set -e`<br>• 表格具有清晰的描述性标题和适当的列对齐方式<br>• 图像使用完整的`<figure>`{.HTML} 元素以及结构正确的标题<br>• AI 生成的图像正确归因于模型和date<br>• 所有媒体均用于信息目的，而不仅仅是装饰<br>• 应用深色模式注意事项 (`.invert`{.HTML}/`.invert-not`{.HTML}) |
| **7.最终自检** | • 预交接清单上的每一项都经过验证<br>• 元块准确地反映了对MoS 遵守情况和内容质量的信心<br>• 明确识别了已知的弱点，而不是模糊地描述<br>• 可以从头到尾阅读文本，而不会出现逻辑或演示的不连续性<br>• 文章可以独立存在，无需额外的上下文|
| **8.元块插入** | • 元块立即出现在 YAML 前面的内容之后<br>• 所有字段均使用具体的、可操作的信息完成<br>• 置信度评估使用精确的凯塞尔曼术语<br>• 明确陈述了关键假设<br>• 总共不超过10 行<br>• HTML 注释格式已正确实现|
</div>

## Troubleshooting Common Problems

<div class="width-full">
|如果你的输出有这个问题 |它很可能违反了这一原则 |通过这样做修复它 |
|:--------------------------------|:----------------------------------|:---------------------|
| **摘要是一个段落** |摘要必须是遵循科学结构的多段落 |将摘要分成 2-4 个段落，遵循以下模式：背景 → 方法 → 结果 → 结论 |
| **章节标题太多** |章节应该是实质性的，而不是分类的 |合并密切相关的部分；确保每个部分至少有 2 段 |
| **文章感觉“内容丰富”** |格温的风格是陈述性和分析性的，而不仅仅是描述性的 |添加对索赔的明确评估；直接陈述结论；对重要性做出比较判断|
| **尽管有标题，内容似乎还是非结构化的** |信息应遵循从左到右的详细层次结构 |将核心主张移至段落开头；将详细信息向右推至脚注/折叠；确定清晰的边注主题|
| **频繁的对冲语言** |写作应该是直截了当的、分析性的、精确的 |将“似乎”或“可以争论”等短语替换为通过凯塞尔曼词语校准的直接主张 |
| **LLM“帮助”短语出现** |文本应该是直接的，而不是元文本 |删除“让我们探索一下”、“值得注意”、“深入研究”等短语；直接陈述内容即可 |
| **链接缺乏有意义的标题** |许多链接应该有标题属性 |添加`title="'Title', Author Year"`{.HTML}到相关链接；对于维基百科，使用 `!W` 语法 |
| **项目符号列表太多** |列表应该是稀有且有目的的 |尽可能转换为散文；如果需要，请确保列表按逻辑排序（按重要性、相似性或字母顺序）|
| **离题扰乱了正文** |离题应该降级到适当的容器|将题外话<200 words to footnotes; 200--500 words to collapses; >500字移至附录|
| **引文以参考列表格式出现** |引文应该是内联超链接 |将任何参考样式引文转换为内联 `Surname Year`{.Markdown} 格式，并带有全文超链接 |
| **内容感觉过于介绍性** | Gwern 文章假定受众具有技术素养 |删除不必要的基本概念定义；专注于新颖合成与分析|
| **段落似乎没有结构** |每个段落都应该有一个重点|确保段落有明确的主题；考虑为多段落部分添加页边注释 |
| **复杂方程作为纯文本** |数学应使用适当的格式 |对于复杂方程，请使用 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> (`$$equation$$`{.Markdown})；考虑使用 Unicode/HTML 进行简单的内联数学 |
| **论文缺乏“冰山”质量** |内容应通过弹出窗口/注释具有隐藏深度 | Add collapses for supporting material;确保链接有信息丰富的弹出窗口；创造探索的“兔子洞”|
| **表格格式不一致** |表格应遵循 MoS 约定 |使用带有适当对准指示器的管表；添加字幕；考虑 `.table-small`{.HTML} 紧凑型桌子 |
| **过于密集的文本块** |视觉层次清晰的“通风散文”|分成一行一句；段落之间使用空行；考虑对密集部分使用折叠 |
| **一般介绍/结论** |论文应该以实质内容开始和结束|删除任何“在这篇文章中，我们将......”或“结论......”的陈述；替换为实质性主张|
| **元区块没有具体弱点** |元区块必须确定具体的审查领域 |用需要编辑注意的具体部分或主张替换模糊的陈述 |
| **风格选择似乎是任意的** |所有格式均应服务于信息目的 |根据信息层次结构而不是美观来证明每个折叠、脚注或特殊格式的合理性 |
| **论文感觉与示例脱节** |写作应建立在 Gwern 现有语料库的基础上 |参考类似的 Gwern.net 文章；使用与更广泛的网站一致的术语|
</div>

## 样式示例

为了说明将聊天机器人风格的输出改进为 Gwern 风格，以下是一些之前/之后的示例：

#.之前：

    ~~~{.Markdown}
    It is pivotal to recognize that mathematics can be conceptualized as analogous to
    the study of pure Turing machines, where formal patterns and computational structures
    are explored independent of the complicated details that exist in the physical world.
    Rather than focusing on concrete examples such as sequences of alternating physical objects
    like apples and oranges, or even more abstract but still specific sequences of integers,
    mathematicians typically examine generalized binary sequences that can be generated by
    concise, elegant Turing machines alternating between two distinct outputs. This
    abstraction process serves as a testament to mathematics' power in distilling
    complex phenomena into their essential logical structures.
    ~~~

    之后：

    ~~~{.Markdown}
    Mathematics resembles the study of pure Turing machines,
    formal pattern and computation liberated from the messy real-world details.
    We do not study a long line of, say, alternating apples and oranges,
    nor do we even study a sequence of integers; we study a *binary* sequence,
    which is computed by a very short, simple Turing machine which alternates
    between two arbitrary but distinct outputs.
    This shift from concrete objects to abstract patterns explains why mathematics
    developed independently across cultures, while [speedrunning](!W "Speedrunning")
    remains bound to specific artifacts^[Unlike mathematics, gaming speedruns document
    exploitation of specific implementation quirks that rarely generalize beyond their
    original context—precisely why they remain entertaining but yield no broader insights.].
    ~~~
#.之前：

    ~~~{.Markdown}
    When we explore the capabilities of Large Language Models in relation to mathematics,
    it becomes evident that there are important parallels worth noting. These models can be
    compared to diligent students who have meticulously studied mathematical textbooks and
    completed numerous homework problems, but haven't yet ventured into the realm of
    original research. While LLMs excel at solving problems that have predetermined answers,
    they fundamentally lack the crucial ability to formulate novel and meaningful problems
    on their own. This creative aspect of mathematics—the art of problem creation—isn't
    something that can be learned from textbooks or assigned as homework exercises, with only
    rare exceptions like George Pólya's famous work "How to Solve It" attempting to address
    this gap in mathematical education.
    ~~~

    之后：

    ~~~{.Markdown}
    If we analogize math-oriented LLMs to mathematics, the LLM is closest to
    a knowledgeable student who has studied textbooks and homework problems,
    but has never done research.
    You can set them a problem which has an answer, and they may well be able to find the answer.
    But at no point have they ever learned to solve the problem of coming up with problems.
    That is written down in no textbook, nor is there any homework problem for it
    (almost by definition, despite occasional valiant efforts like
    [Pólya's](!W "George P%C3%B3lya") [_How to Solve It_](!W)).
    This explains why even superhuman performers on benchmarks fail to produce
    truly novel insights—they optimize for answer-finding, not question-creation^[The
    distinction between answer-finding and question-creation parallels the difference
    between [exploitation and exploration](/explore-exploit) in reinforcement learning.].
    ~~~
#.之前：

    ~~~{.Markdown}
    The common 'baby face' theory for our cat fascination seems lacking, especially when
    considering our intense interest in even their most mundane actions and the way
    we often see them as embodying a kind of universal 'Cat-ness'. This essay explores
    an evolutionary psychology perspective: that our captivation stems from a history
    where felids in Africa were significant, often underestimated, predators of primates
    for millions of years. This ancestral pressure may have hardwired us to
    vigilantly observe felines, a trait not as strongly activated by other common pets,
    explaining their unique, indefinable appeal—a paradoxical mix of the captivating
    and the subtly unnerving, much like our engagement with controlled thrills
    such as horror movies.
    ~~~

    之后：

    ~~~{.Markdown}
    Do people like watching cats because of their neotenous appearance?
    I doubt it, but then why do we have odd this fascination with every ordinary action
    of a cat and in treating them as examples of some Platonic Cat?

    I speculate that maybe there is an evolutionary psychology reason: cats in Africa
    prey on primates to a degree I suspect few people appreciate, and this seems to
    have been true for millions of years.

    So perhaps we are still slightly hardwired to closely observe cats,
    in a way we aren't for most other potential pets.
    This accounts for the indefinable appeal of cats: they are paradoxically
    both pleasant and unpleasant, like horror movies.
    ~~~

## 切换前检查清单

验证最终草案的每个项目：

- [ ] **元块**：正确插入（在 YAML 之后、文本之前）并遵守 ≤10 行模板。
- [ ] **摘要**：目前，使用`div.abstract`{.HTML} > `blockquote`{.HTML}，多段，遵循[B-M/D-R-C结构](#b-m-d-r-c)。
- [ ] **通风散文**：每个源行一个句子，段落之间有空行。
- [ ] **禁用短语**：消除了常见的 LLM 填充词/对冲词（请参阅 [Mind-set](#mind-set)）。
- [ ] **引文**：内联**姓氏**格式，超链接到最佳可用全文 URL。
- [ ] **链接 `title`{.HTML} 属性**：有用的 `<a>`{.HTML} 标签具有 `title="‘Title’, Author Year"`{.HTML} （或类似的，如果不是论文）。
- [ ] **深层链接**：在适当的情况下链接到特定部分/页面（`#anchor`{.HTML}、`#page=N`{.HTML}）。
- [ ] **`!W`{.HTML} 维基百科间链接**：用于相关维基百科概念。
- [ ] **脚注/折叠**：适当用于长度/内容（脚注≤200w，折叠≤500w）。
- [ ] **页边注释**：在多段落部分（不适用于 1 段落部分）中的相关段落呈现并正确格式化。
- [ ] **代码样式**：Bash 使用长标志 & `set -e`{.Bash}； Haskell：`ghc -Wall -Werror`{.Bash} & 合格进口； Elisp：字节干净。语言声明。
- [ ] **图说明**：图像使用 `<figure>`{.HTML} 并具有完整的 MoS 说明；注明了 AI 图像的出处。如果默认反转有问题，则应用暗模式 `.invert`{.HTML}/`.invert-not`{.HTML} 类。
- [ ] **MoS 术语**：正确使用“统计显着性检验”等关键术语和 Kesselman 词语。
- [ ] **破折号**：正确使用连字符、短破折号和长破折号（长破折号周围没有空格）。
- [ ] **心理编译论文**：想象一下在提交之前它会如何出现在 Gwern.net 上，并激活其所有功能（弹出窗口、折叠等）。

遵守本手册将提高草稿与 Gwern.net 标准的一致性，从而促进更顺畅的编辑过程。
