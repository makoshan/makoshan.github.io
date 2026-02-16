---
title: 设计墓地
description: "关于 Gwern.net 网站设计实验与复盘的元页面。"
thumbnail: /doc/cs/linkrot/archiving/2020-03-03-meganwarnock-picardfacepalmcartoon.jpg
thumbnail-text: "皮卡德卡通头像捂脸，表达了我对网页开发、读者以及世界的无奈。"
thumbnail-css: "outline invert-not"
created: 2010-10-01
modified: 2025-04-26
status: finished
confidence: highly likely
importance: 2
css-extension: dropcaps-kanzlei
...

<div class="abstract">
> 任何设计中最有趣的部分，往往是“不可见”的部分——那些尝试过却没成功的方案。有时它们是多余的，有时读者无法理解，因为方案过于特立独行，更多时候是因为“好东西”也不总能落地。
>
> 这篇设计墓地收录了我在 Gwern.net 上尝试过的想法和实验：它们要么最终被放弃，要么反复迭代后改变。
>
> 这些内容大致按时间顺序排列。
</div>

<div class="epigraph">
> 105\. 你无法完整传达复杂性，只能让人意识到其存在。
>
> ---[艾伦·J·珀利斯](/doc/cs/algorithm/1982-perlis.pdf "《编程札记》，Perlis，1982")
</div>

# Gitit

[Gitit](https://github.com/jgm/gitit) wiki：我更喜欢在 Emacs/Bash 中编辑文件，而不是基于 GUI/浏览器的 wiki。

一个基于 [Pandoc](!W) 的 wiki，使用 [Darcs](!W) 作为历史机制，主要用作演示； “一页编辑 = 一个 Darcs 修订版”的要求很快变得令人窒息，我开始直接编辑 Markdown 文件并在每天结束时记录补丁，并将 HTML 缓存与我的主机同步（当时是 `code.haskell.org` 上的个人目录）。

最终我对此感到厌倦，并认为由于我没有使用 wiki，而仅使用静态编译页面，所以我不妨切换到 [Hakyll](https://jaspervdj.be/hakyll/) 和普通的静态网站方法。

## RSS 源

Gitit，作为版本控制方法的一部分，以 RSS 源的形式公开每个页面的历史记录（使用查询）和整个 wiki，其中也包括差异。

这对于协作式 wiki 来说效果相当好，编辑者希望监控每一次编辑；或者对于文档维基，更新往往很大；或者以离散、独立、每日为单位进行更新的博客。
但它从一开始就不太适合 Gwern.net 长篇论文/资源：虽然 Darcs/git 并不特别关心跟踪数以万计的微小编辑，而且我不再尝试跟踪每个编辑，而是将它们批量化，这使得 RSS 对于任何 Gwern.net *读者*来说不太有用。

知道今天我 `+links` 是没有用的，就像我昨天或前天所做的那样。
由于 `fixed dead links`，今天看到更新了 30 页也没有什么帮助。
这只是一系列不重要的调整；没有人（包括我）真正需要阅读如此细粒度的更改。
这就是 RSS 历史很快变成的样子，随着语料库的增长和需要维护，我大量修改了格式或进行了各种实验。

最终，我只是将其删除。

这并没有让每个人都高兴，因为有些人以某种方式使用它来跟踪网站更新。
我设置了 [Changelog](/changelog) 和 [每月通讯 ](https://gwern.substack.com/ "‘Gwern.net newsletter (Substack subscription page)', Gwern 2013") 试图通过每月发布新论文列表来解决这个问题，但对他们来说，现在的总结“太”了。
（我也并不总是及时邮寄出去。）

所需的粒度可能是这样的，“包括在论文中添加章节，但不添加链接或几句话”；然而，这比我想要投入的工作要多。
然而，它可能与 GPT-4 等 LLM 一起使用：传入 Git 日志以提取关键提交，然后将它们适当地总结为逐项列表。
（这种功能几年前就已经通过 Github 工具从 git 存储库中提取重大更改得到了演示，所以它应该可以工作。）

# jQuery 香肠滚动条

[jQuery sausages](https://christophercliff.com/sausage/examples/couchdb.html)：截面长度的 UI 可视化无用。

UI 实验“香肠”添加了第二个滚动条，其中垂直菱形对应于页面的每个顶级部分；它向读者指示每个部分的长度和位置。 （它们看起来像一长串淡白色香肠。）我认为这可能会帮助读者定位自己，就像流行的“浮动突出显示目录”UI 元素一样，但如果没有文本标签，香肠就毫无意义。在 jQuery 升级破坏了它之后，我没有费心去修复它。

# 直线阅读器

[Beeline Reader](/ab-test#beeline-reader-text-highlighting)：一种让读者恼火的“阅读辅助工具”。

BLR 尝试通过对行的开头和结尾着色来指示连续性来帮助阅读，并使读者的眼睛更容易扫视到正确的下一行而不会分心（显然，阅读困难的读者尤其难以正确地关注行的连续性）。 A/B 测试表明页面停留时间指标没有任何改进，我收到了很多关于它的投诉；我对浏览器的性能或外观也不太满意。

我对这个目标表示同情，并认为语法突出显示辅助工具没有得到充分利用，但 BLR 有点不成熟，与更直接的干预措施（例如减少段落长度或更严格地使用 ['语义缩放'](/design#semantic-zoom) 格式）相比，不值得付出成本。 （未来我们也许能够利用新技术以不同的方式进行排版，例如配备了[眼动追踪](!W)技术，旨在用于[注视点渲染](!W)的 VR/AR 耳机——忘记一些简单的技巧，例如当读者到达当前行的末尾时强调下一行的开头，如果我们可以做诸如即时显示下一段文本以创建“无限行”之类的事情，那么我们是否需要“行”？）

# Google 自定义搜索引擎

<span id="google-cse"></span> <span id="cse"></span>

[Google CSE](!W "Google Programmable Search Engine")：很少有人使用的网站搜索功能。

CSE 是一个“自定义搜索引擎”，是一个增强的 `site:gwern.net/` Google 搜索查询；我写了一篇涵盖 Gwern.net 和我在其他网站上的一些帐户的文章，并将其添加到侧边栏 2013-05-25。
[检查分析](/ab-test#cse)，也许 227 个页面浏览量中有 1 个使用了 CSE，其中相当多的人只是偶然使用它（例如搜索“e”）；对使用如此少的功能进行 A/B 测试是无能为力的，因此我在 2015 年 7 月 20 日删除了它，而不是尝试正式测试它。

我怀疑网站搜索功能没有用，因为 Gwern.net 根本不是读者搜索的那种网站。
读者通常会到达特定的登陆页面（例如，在社交媒体上链接），或者他们首先从搜索引擎到达，或者他们正在阅读页面并跟踪其中的链接（并且通过添加精心策划的标签等功能可以更好地服务）。
没有人加载该网站，然后搜索随机主题——它不够大或不够全面，像维基百科一样值得这样做。

此外，为静态站点提供自己的搜索功能有点困难：搜索通常需要*某处*的服务器，以避免下载大型[倒排索引](!W)。
<span id="range-queries">（尽管有一些方法试图使倒排索引足够小，以便可以下载到阅读器浏览器中，以便可以用 JS 交互处理它，并且有 [an](https://github.com/psanford/sqlite3vfshttp) [有趣的](https://phiresky.github.io/blog/2021/hosting-sqlite-databases-on-github-pages/ "‘Hosting SQLite databases on Github Pages (or any static file hoster)', phiresky 2021") [hack](https://news.ycombinator.com/item?id=27016630) [which](https://ansiwave.net/blog/sqlite-over-http.html) 下载一个小型 JS 数据库引擎，例如 [WASMed](!W "WebAssembly") [SQLite](!W)，然后查询一个标准的大型数据库，使用 [HTTP 范围查询](!W "Byte serving") 的数据库仅下载几个特定字节并避免下载整个数据库。[^db-site])</span>

[^db-site]：这提出了一个有趣的可能性：一个真正以数据库为中心的网站——不仅调用隐藏所有内容的 REST 端点之类的 API，而且几乎是一个野蛮的、可能类似 [“裸对象”](/doc/cs/algorithm/2001-pawson.pdf "‘Naked objects: a technique for designing more expressive systems’, Pawson & Matthews 2001") 的网站，它只是一个数据库引擎 JS 存根和一个用于下载数据/HTML 的数据库查询列表。因此，用户（或任何正在运行的代码）只需编写 SQL 查询即可执行任何操作；与数据语义在传递给客户端之前可能被丢弃的网站相比，这将实现对网站的强大搜索和可扩展性，例如任意级别的重新设计。 （您甚至可以提供[浏览器内 SQL 数据库查看器](https://sqliteviewer.app/)！）

    由于客户端和服务器对数据库具有平等的访问权限，因此可以在任何阶段完成查询：所有查询都可以在客户端完成，以获得最大的灵活性，但为了加快速度，页面可以在将其提供给客户端之前进行[部分](!W "Partial evaluation")或完全预渲染。

    Gwern.net 对 HTTP 范围查询的一​​个有趣的使用是我们的 [gwtar HTML 存档格式](/gwtar "‘Gwtar: a static efficient single-file HTML format’, Gwern 2026")。

---

2024 年 4 月，由于读者偶尔会要求搜索，而我们仍然没有找到任何我们喜欢的搜索，因此我们尝试重新添加旧的 Google CSE。
我们的逻辑是，自 2015 年以来的 9 年里，该网站已经扩展，使搜索变得更加有用，并且通过主题工具栏，我们现在可以在某个地方放置一个不混乱的搜索小部件（并且可以根据需要通过使用 CSE JS 小部件嵌入*单独的* HTML 页面来完成）。

令人惊讶的是，谷歌并没有杀死 CSE（[像那个时代的许多其他 ](/google-shutdown "‘Predicting Google closures’, Gwern 2013") 服务/产品一样并迎合高级用户），并且一些研究表明它似乎仍然有效。
它允许与制表符完成完美集成。

这让读者只需在任何地方拉起眼镜搜索图标即可进行搜索，如下所示：

![将鼠标悬停在网站主题切换上以拉出 Google 网站搜索界面并搜索主题 `cat illusion` 的屏幕截图，显示一些相关页面和研究论文。](/doc/cs/css/2024-04-27-gwern-gwernnet-googlecsepopup.png)

---

2024 年 11 月，我们不得不*再次*删除 Google CSE。

在[Dwarkesh Patel 采访](https://www.dwarkesh.com/p/gwern-branwen#%C2%A7transcript "‘Gwern Branwen—How an Anonymous Researcher Predicted AI’s Trajectory’, Gwern & Patel 2024")之后，一位读者对我对[“Suzanne Delage”](/suzanne-delage "‘Interpreting ‘Suzanne Delage’ as <em>Dracula</em>’, Gwern 2009")的讨论感兴趣，便在主页上使用术语“Dracula”进行搜索，CSE 只返回了一个结果：主页。
Gwern.net 上有许多页面使用“Dracula”一词；雪上加霜的是，如果您在 CSE 中搜索“Suzanne Delage”，那么它会拉出正确的页面*并*显示页面元数据中包含“Dracula”一词的片段！
对“中途”等其他查询的一些快速测试表明，CSE 非常不完整和/或有错误，因此比无用更糟糕。

由于 Google CSE 现在是有害的，即使它已修复，我们也不再信任它，因此我们已将其最后一次删除，并且永远不会再使用 CSE。

我们用一种更可靠但不太方便的替代方案取代了它：一种只需在新选项卡中打开 Google 搜索 `query site:gwern.net` 的表单。^[因此，与据称搜索多个站点的 CSE 不同，当前的站点搜索实际上只是一个*站点*搜索。令人沮丧的是，它“曾经”可以使用多个 `site:` 运算符和 `OR` 来近似 CSE——这是我很久以前在设置任何 CSE 之前所做的——但这个功能显然在 Google 搜索中已经被削弱，并且没有像 Bing 或 Yandex 这样的竞争免登录搜索引擎实现更好的 `site:` 运算符。 （Kagi 可能会，但需要帐户。）]

# Tufte-CSS 旁注

[Tufte-CSS](https://edwardtufte.github.io/tufte-css/#sidenotes) [旁注](/sidenote "'Sidenotes In Web Design', Gwern 2020")：从根本上被破坏，并被取代。

作为 Tufte-CSS 旁注的早期崇拜者，我尝试了 Pandoc 插件，却发现了一个可怕的缺点：CSS 不支持块元素，因此该插件只是删除了它们。
这个错误显然可以修复，但脚注的密度导致使用 `sidenotes.js` 代替。

# DjVu 文件

[DjVu](!W) 文档格式的使用：DjVu 是一种节省空间的文档格式，其致命缺点是 Google 忽略它，“如果它不在 Google 中，它就不存在”。

DjVu 是一种优于 PDF 的文档格式，尤其是标准 PDF：
过去，我使用 [DjVu](!W) 来处理我自己生成的文档，因为它生成的扫描结果比 gscan2pdf 的默认 PDF 设置要小得多 [由于有问题的 Perl 库](https://sourceforge.net/p/gscan2pdf/bugs/157/ "#157 gscan2pdf generates large file size PDFs")（至少是一半大小，有时是 10% 大小），使它们更容易托管并提供卓越的浏览体验。

它在我的文档查看器中运行良好（尽管不是所有的文档查看器，尽管我已经 20 岁了），Internet Archive 和 Libgen 更喜欢它们（直到 2016 年 IA 放弃了 DjVu），所以为什么不呢？直到有一天，我想知道是否有人链接它们，并尝试在 [Google Scholar](!W) 中搜索一些。一击未中！ （碰巧的是，GS 似乎专门过滤掉了书籍。）
困惑之余，我尝试谷歌——还是一无所获。
哈‽ 我的扫描件多年来一直可见，DjVu 可以追溯到 20 世纪 90 年代，并且被广泛使用（如果远不如 PDF 那么流行），G/GS 会获取我所有托管相同的 PDF。
`filetype:djvu` 怎么样？
我惊恐地发现，在整个互联网上，Google 索引了大约 50 个 DjVu 文件。 *全部的*。
虽然 Google 显然曾经对 DjVu 文件建立过索引，但那个时代一定已经过去很久了。

由于不愿意承受空间占用，这会显着增加我的 Amazon AWS S3 托管成本，因此我更仔细地研究了 PDF。
我发现 PDF 技术比 gscan2pdf 生成的默认 PDF 有了很大的进步，并且通过 [JBIG2](!W) 压缩，它们的大小更接近 DjVu；我可以使用 [ocrmypdf](https://github.com/ocrmypdf/OCRmyPDF).[^ocrmypdf] 方便地生成此类 PDF
这让我以适中的成本进行转换，现在我的文档确实出现在 Google 中。

[^ocrmypdf]：为什么不是所有 PDF 生成器都使用它？

    [软件专利](!W)，这使得安装实际的 JBIG2 编码器变得困难（据说所有 JBIG2 编码专利都已在 2017 年到期，但没有人像 Linux 发行版那样愿意冒未知专利浮出水面的风险），它必须与 ocrmypdf 分开发布，并且担心 JBIG2 中的边缘情况，其中数字可能会在视觉上更改为不同的数字以节省位。

    这意味着您可能必须使用 pip 或其他工具自行安装 ocrmypdf。
    这就是为什么我的快速而肮脏的 ocrmypdf shellscript 有一个 virtualenv 调用卡在中间：

    ~~~{.Bash}
    convertDjvuToPDF () { TARGET="${@%.djvu}.pdf";
        ddjvu -format=pdf "$@" "$TARGET" &&  \
        source activate fastai && \
        ocrmypdf --skip-text --optimize 3 --jbig2-lossy "$TARGET" "$TARGET" && \
        du -ch "$@" "$TARGET"
        rm "$@"
    }
    for DJVU in ./*.djvu; do
        convertDjvuToPDF "$DJVU"
    done
    ~~~

# Darcs/Github 存储库

Darcs Patch-tag/Github Git 存储库：没有提交有用的贡献或补丁，增加了相当大的流程开销，而且我通过从失败的 DjVu 优化后传递中检入太大的 PDF，意外地破坏了存储库（我误认为结果更小，而实际上它要大得多）。

我删除了站点内容存储库，并将其替换为[基础设施特定的存储库](https://github.com/gwern/gwern.net/)，以便更轻松地与 Said Achmiz 进行协作。

# 长网址

使用 [Gitit](#gitit) 启动我的个人 wiki 的结果是默认使用长 URL。
Gitit 鼓励您使用 filename+`.page` = title = URL+`.html` 来简化事情。
因此，“DNB FAQ”页面将只是 `./DNB FAQ.page` 作为磁盘上的文件，以及 `/DNB%20FAQ.html` URL 作为呈现页面来访问/编辑。
然后，因为我当时对此没有意见，而且这样做在技术上听起来很可怕（HTTPS，以及许多关于子域和 A 或 C [DNS 记录 ](!W "List of DNS record types") 的术语），所以我开始在 `http://​www.gwern.net` 托管页面。
因此，最终 URL 将是 `http://​www.gwern.net/DNB%20FAQ.html`

所以，我的网址是：

#. [HTTP](!W)，而不是 [HTTPS](!W)
#. [`www.`](!W "World Wide Web#WWW prefix") [子域](!W)，不是裸域；
#.长 URL/标题而不是单字 slugs，它们在哪里
#.混合大小写/大写的单词而不是小写^[我最初有一个约定，其中所有小写的 URL 都是“草稿”（因为所有小写在网上被理解为“非正式”或“幽默”，这意味着您输入的速度太快而无法正确地大写），并且只有混合大小写的 URL 才被“完成”。但几年后我放弃了这个约定，转而支持在元数据标头中明确的“状态”描述。没有人注意到这一约定，而且我的完美主义、范围蔓延以及早期缺乏 HTTP 重定向支持（需要断开链接）意味着我很少翻转开关。所以这很令人困惑：没有读者理解它，我必须记住特定页面是小写还是大写。]，并且
#.以空格分隔，而不是以连字符分隔（或者更好的是单个单词），并且
#.文件/目录的复数不一致。

[全错。]{.marginnote}回想起来，*所有*这些选择^[一个不错的选择是获得 `gwern.TLD` 域名，并将 `.net` 作为其 [TLD](!W "Top-level domain")：没有其他名称可以多年来发挥作用或令人难忘，而 `.com` 的内涵仍然很差——即使 `gwern.com` 没有被域名抢注，这也将是一个糟糕的选择。 （不过，我确实会定期访问 `gwern.com`，欺骗域名抢占者提高价格，这样就没有人可以购买它并用它来对付我。截至 2025 年，它已膨胀到令人印象深刻的 [$10,000]($2025)+ 标价，并且占用者的成本 >[$150]($2025)，看不到回报。）] 是错误的：[Derek Sivers](https://sive.rs/su "Short URLs: why and how") 和 [Sam Hughes](https://qntm.org/urls "On short URLs") 是对的：我应该使 URL 尽可能简单（然后再简单一点）：一个单词，小写字母数字，没有连字符或下划线或空格或任何类型的标点符号。^[就 [Zooko 的三角形 ](!W) 而言，因为我控制域，所有 URL 都是“安全”的，并且它们不能变得更加“去中心化”，所以唯一的改进就是使它们更加“分散”。 “人类有意义”——但以用户体验的方式，有意义、简短且易于输入，而不是试图近似写出的英语句子或标题。]
也就是说，URL *应该*是 `https://​gwern.net/dnb` 或 `https://​gwern.net/faq`，如果这不会造成任何混淆的话——但不能长于 `https://​gwern.net/dnb-faq`！[^Schelling-link]
（源 Markdown 文件的 `.page` 扩展名本身就是一个小麻烦：很少有东西可以识别 Markdown 的扩展名，而且它也是一个 4 个字母的扩展名。）

[^Schelling-link]: <span id="schelling-url"></span> <span id="schelling-link"></span> <span id="schelling-urls"></span> <span id="schelling-links"></span> 一个有用的技巧是设置 [HTTP 301](!W) 从符合逻辑且可猜测的 URL 重定向到“完整”URL，但作为 slugs 风险太大或只是被读者（错误地）猜测。
    这些自然可猜测的 URL slugs 可以被称为 [**Schelling links/URLs**](!W "Schelling point")，并且本着 [“铺平愿望路径”](!W) 的精神，你可以简单地让它们工作

    例如，标签目录通常对于链接很有用，但很难记住或输入；所以我设置了从 `/mode-collapse` 到 `/doc/reinforcement-learning/preference-learning/mode-collapse/index` 的重定向，这使我可以在需要时轻松获取 URL，或者让读者*猜测它*。
    （同样，我不会使用[我的窗口管理器热键快捷键](/search#hotkey-shortcuts)来搜索或找到我需要访问的维基百科文章的正确标题；我只是猜测标题直到它起作用，然后我将所有错误的标题变成[维基百科重定向](!W "Wikipedia:Redirect")，所以将来，我和其他人都会被自动发送到正确的地方。）

这些剪纸将花费我大量的精力来修复，同时保持向后兼容（即不破坏十年来创建的数以万计的入站链接）。

## HTTP

<span id ="https"></span> <span id ="http-https"></span>

[拖延。]{.marginnote} 当我开始编写使用 HTTP 的网站时，HTTP → HTTPS 迁移已经是不可避免的了。
即使对于一个不起眼的主页或博客来说这似乎有些过分，HTTPS 仍然更好。

[CCP](!W "Great Cannon")（DDoS 恶意软件）和 ISP（广告/间谍软件）的注入攻击、对隐私的普遍担忧、日益严厉的搜索引擎处罚和令人震惊的 GUI 广告（例如搜索引擎和网络浏览器的丑陋的红色警告框）、我偶尔托管的有争议的文件可能会触发审查......
自 2016 年以来，出现了更多选择 HTTPS 的原因，例如我们使用 iframe 弹出窗口来显示外部网站：出于[“混合内容”安全原因](https://developer.mozilla.org/en-US/docs/Web/Security/Mixed_content)，网络浏览器将“不允许”使用 HTTP 的网站“嵌入”使用 HTTPS 的网站，反之亦然，并且使用 HTTPS 的网站比 HTTP 多。
（我预计，由于[“bitcreep”](/holy-war#bitcreep)，将来会出现更多原因，但我们将幸福地不知道这一点，因为我们做了明智的事情并很久以前就进行了迁移。）

我知道一切都将采用 HTTPS，我只是不想支付证书费用（[Let's Encrypt](!W) 不存在）或弄清楚它，因为它不像我的网站以任何有意义的方式*需要* HTTPS 的安全性。
拥有它真是太好了。
最终，在 2016 年 11 月，[Cloudflare](!W) 使交钥匙变得简单，只需点击几下，即可在 CDN 级别启用 HTTPS，而无需更新我的服务器。

由于 Web 浏览器安全策略，该切换继续导致问题^[主要是混合内容问题：因为 Cloudflare 最初处理 HTTPS，所以我遇到了 [nginx](!W) [redirects](!W "URL redirection") 重定向到 *HTTP* 明文的问题，浏览器拒绝接受该明文，从而破坏了它是什么。我最终不得不在 nginx 本身中设置 HTTPS。]，但这是值得的——只要这样 Web 浏览器就不会再通过显示丑陋但不相关的安全警告来吓唬读者了！

## 空格分隔的 URL

URL 中的空格：一个不错的主意，但人是我们不能拥有美好事物的原因。

[容易出错。]{.marginnote} 在可读性和语义方面，我喜欢用空格分隔文件名的想法，并让文件名=标题上的双关语，节省时间；我把这个交给 Hakyll，但通过监控分析逐渐意识到这是一个可怕的错误——就像 [URL-encoding](!W) 空格和 `%20` 看起来一样简单，*没有人*可以正确地做到这一点。
我不想修复它，因为当我意识到问题有多严重时，它需要破坏或稍后重定向数百个 URL 并更新我的所有页面。
最后一根稻草出现在 2017 年 9 月，当时 [The Browser](https://thebrowser.com/) 错误链接了一个页面，导致约 1,500 人访问了 404 页面。哎呀。

我屈服了，用连字符替换了空格。
（下划线是另一种可行的选择^[我找不到任何确凿的证据表明下划线对 SEO 不利，所以我更担心损坏的 URL 和下划线比连字符更难输入的可能性。] 但由于 Markdown，我担心这会用一个错误换另一个错误。）

## `www` 子域

下一个更改是从 `www.gwern.net` URL 迁移到 `gwern.net`。

[`www` 又长又旧。]{.marginnote} 虽然我一直有 `gwern.net` → `www.gwern.net` 的重定向，所以转到前者不会像空格分隔那样导致链接损坏，但它仍然会导致问题：人们会假设缺少 `www` 并使用这些 URL，从而导致重复失败或搜索问题；特别是在移动设备上，人们会跳过它，表明额外的 4 个字母很麻烦（在设计移动设备外观时我开始理解自己的挫败感）；我还需要不断地输入更多字母，同时在我的网站的其他地方写出链接（例如，在提供 PDF 参考文献时）；我注意到网络浏览器和 Twitter 等网站越来越少地显示 URL（因此前缀意味着您看不到重要的部分，即实际页面！）或完全隐藏前缀（导致混乱）；最后，我开始注意到这个前缀越来越让我觉得“老”了，味道不好，闻起来像一个旧的、无人维护的网站，读者会不愿意访问。

这些都不是“大”问题，但为什么我会遇到这些问题呢？前缀对我有什么作用？
我稍微研究了一下。

[没有长度优势。]{.marginnote}这确实是过时的并且远非普遍；在我链接的域中，只有 40% (2,008 / 4,978) 使用它，而且使用率似乎正在下降 [~每年 2%](https://discuss.httparchive.org/t/historical-decline-in-www-subdomain-use/2507/2 "‘Historical decline in <code>www</code> subdomain use?’, Farrugia 2023").
支持www的讨论似乎相对较少，甚至还有[讨厌www的网站](https://no-www.org/)。
它不是一个标准化或特殊的子域，历史上甚至没有被第一个 WWW 域使用，而且显然是偶然开始的，所以切斯特顿的围栏是满意的。
似乎唯一的好处是，该前缀在涉及 cookie/安全或 [负载平衡](!W "Load balancing (computing)") 细节的少数技术上非常狭窄的方式中很有用，我看不到它们的应用；它与更多域名注册商兼容，尽管我可能使用的所有域名注册商都已经支持它；这是我的现状，但迁移看起来就像在 Cloudflare DNS 设置中翻转开关然后进行大型全局重写一样简单（这将确保安全，因为该字符串非常独特）。

因此，在为此压力了数周并询问人们是否有我错过的理由不这样做之后，我继续在 2023 年 1 月做了这件事。
这出人意料地简单^[主要的故障完全是在站外的：虽然[Google Analytics](!W)似乎已经大步进行了迁移，但我一个月没有注意到[Google Search Console](!W)已经崩溃到零流量并报告所有索引页面现在都被阻止了。 （当然，旧的 URL 现在正在重定向，GSC 将其视为错误。）GSC 确实支持“整个域”而不是子域注册，但它只能通过使用 DNS 证明您拥有整个域来实现这一点，而且我选择了在主页中插入一些元数据的更安全（但仅限子域）验证方法。因此，在将旧 GSC 迁移到新 GSC 之前，我丢失了一两个月的数据。一个小但烦人的小故障。]，我立即欣赏到更容易的打字。

## 简化的 URL

命名实践的最后一个重大变化是总体上简化 URL：全部小写，尽可能缩短助记符，并尽可能删除复数形式——我在命名方面一直不一致，尤其是在文档目录中。

这与子域的原因类似，但更重要。

[大小写/复数不敏感。]{.marginnote} 混合大小写的 URL 更漂亮且更具可读性，但它们会导致许多问题。
由于可能大小写的组合数量，使用长大小写混合 URL 会导致“无休无止”的 404 错误。
（是“死亡笔记匿名”还是“死亡笔记匿名”？是“比特币更糟更好”还是“比特币更糟更好”还是“比特币更糟更好”？等等）
在智能手机上输入混合大小写尤其令人痛苦，因为智能手机键盘现在通常是模式键盘，因此它不像按住 Shift 键那么简单。
设置单独的重定向会消耗时间，有时会适得其反，创建重定向循环或重定向其他页面。
长名称意味着需要大量输入，而像“the”这样的共享前缀使得避免使用 [tab-completion](!W) 进行输入变得更加困难。
我（和读者）必须猜测记不清的名字，并且偶尔会因为输入 `/doc/foo.pdf` 而不是 `/docs/foo.pdf` 的链接而搞砸。

这是一个重大变化，部分原因是我对由错误 URL 引起的问题采取了所有措施——我为每个遇到的错误设置的所有重定向和 lint 检查都必须撤消或更新——添加到 Gwern.net 的功能的复杂性（例如反向链接或本地存档）加剧了这一问题，这些功能传播陈旧的 URL 和其他类型的缓存（CS 中的*其他*难题...）问题。
所以我直到 2023 年 2 月用尽更简单的修复方法后才开始着手解决这个问题。

但现在 DNB 常见问题解答的 URL *是* `https://gwern.net/dnb-faq`——在移动设备上更容易输入，至少敲击 6 次按键（前缀加两个班次），一致、难忘且永恒。

# 广告

[AdSense](!W) 横幅广告（以及一般广告）：对读者不利，可能会造成净财务损失。

我讨厌投放横幅广告，但在我的 Patreon 开始工作之前，这似乎是两害相权取其轻。
随着我的财务状况变得不那么糟糕，我开始好奇“减少了多少”——但我找不到任何互联网研究来衡量像广告造成的流量损失这样基本的东西！
所以我决定 <span id="gwern-ads">[自己运行 A/B 测试](/banner "'Banner Ads Considered Harmful', Gwern 2017")</span>，并进行适当的样本量和成本效益分析；事实证明，危害点估计太大了，以至于没有必要进行分析，当我第一次看到结果时，我就永久删除了 AdSense。
考虑到流量的减少，我损失的潜在捐款可能比我从广告中获得的收入多几倍。 （亚马逊附属链接似乎不会触发这种反应，所以我没有理会它们。）

# 捐赠链接

Bitcoin/PayPal/Gittip/Flattr 捐赠链接：与 Patreon 相比，效果从来都不好。

这些方法要么是单次的，要么从未达到临界质量。
一次性捐款失败了，因为如果是手动的，人们就不会养成习惯，而且太不方便。
Gittip/Flattr 与 Patreon 类似，将捐赠者捆绑在一起，并使其成为一种常态，但从未达到足够的规模。

# 谷歌网络字体

[Google Fonts](!W) 网络字体：缓慢且有缺陷。

Google Fonts 的最初想法是一个值得信赖的高性能提供商，提供各种现代、多语言、子集的嵌入式字体，如果您使用通用字体，这些字体可能会被浏览器缓存。
您想要一个像样的 [Baskerville](!W) 字体吗？只需自定义一些 CSS 即可开始！

事实证明有点不同。
事实证明，缓存的故事主要是一厢情愿的想法，因为缓存过期得太快了，而且无论如何，隐私问题意味着主要的网络浏览器都跨域分割缓存，因此在您的域上下载 Google 字体对我的域上的下载没有任何帮助。
由于没有缓存帮助并且需要另一个域连接，Google Fonts 结果在页面渲染中引入了明显的延迟。
事实证明，提供的字体种类有些虚幻：虽然随着时间的推移而扩展，但当时的字体选择很有限，而且字体已经过时或不完整。
谷歌字体根本不被信任，并且经常被引用为谷歌圆形监狱入侵的一个例子（据我所知，没有任何滥用行为记录——尽管如此，它确实是），而且更有趣的是，谷歌字体可能因欧盟对 [GDPR](!W "General Data Protection Regulation") 的弹性解释而被[宣布为非法](https://rewis.io/urteile/urteil/lhm-20-01-2022-3-o-1749320/ "LG München: 3 O 17493/20 vom 20.01.2022")。

删除 Google 字体是 Said 所做的首批设计和性能优化之一。
我们通过采用 Adob​​e Source Serif/Sans Pro 的 [主 Github 版本](https://github.com/adobe-fonts/source-serif)（当时的 Google Fonts 版本既过时且不完整）并将其子集专门用于 Gwern.net，获得了更快、更美观的页面。

# 数学贾克斯

[MathJax](!W) JS：在编译期间切换到静态渲染以提高速度。

对于数学渲染，MathJax 和 [Ka<span class="logotype-tex">T<sub>e</sub>X</span>](!W "KaTeX") 是合理的选择（因为 [MathML](!W) 浏览器的采用已经停滞不前）。
MathJax 渲染在某些页面上非常慢：加载和渲染所有数学最多需要 6 秒。
不是很好的阅读体验。
当我了解到可以预处理使用 MathJax 的页面时，我在同一天放弃了 MathJax JS 的使用。

我最终也开始在 Unicode+HTML+CSS 中渲染尽可能多的 <span class="logotype-tex">T<sub>e</sub>X</span> ，事实证明这对于几乎所有内联和许多块表达式都令人惊讶地可行，[可使用 LLMs](/static/build/latex2unicode.py "‘<code>latex2unicode.py</code>’, Gwern 2023") 实现自动化，并且速度更快且美观。
（因为每个版本的 <span class="logotype-tex">T<sub>e</sub>X</span> 渲染都会导致明显的“外来”渲染，从而改变行高等，而“本机”版本则不会跳出太多。）

# 引用语法高亮

[`<q>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/q) 英语引用标签 [语法突出显示](!W)：巧妙地使用了晦涩的语义 HTML 元素，但会造成分裂并增加维护负担。

我喜欢将英语更像是一种正式语言（例如编程语言）的想法，因为它具有语法突出显示等优点。
在程序中，读者可以从语法突出显示中获得指导，指示“参数”的逻辑嵌套和结构；在自然语言文档中，它是一个又一个该死的字母，偶尔还带有标点符号或缩进。
（如果Lisp由于缺少“[语法糖](!W)”而看起来像“混有指甲屑的燕麦片”，那么英语一定是纯燕麦片！）
最基本的语法突出显示之一就是简单地突出显示字符串与代码：作为一名编码新手，我很早就了解到语法突出显示是值得的，只是为了确保您没有忘记某处的引用或括号。
常规写作也是如此：如果你大量引用或命名事物，读者可能会迷失在弯引号的丛林中，不确定谁说了什么。

我发现了一个由模糊的 Pandoc 设置启用的模糊 HTML 标签：引号标签 `<q>`，它替换引号字符并由浏览器呈现为引号（通常）。
引号标记是显式解析的，而不仅仅是不透明的自然语言文本 blob，主要是为了允许用户的浏览器在不修改源 HTML 的情况下适当地设置所有不同类型引号的嵌套样式，特别是对于使用不同引用约定的外语（例如，法语双引号和单引号 [guillemets](!W)）。
但它们也可以被作者的 JS/CSS 操纵用于其他目的，例如......语法突出显示。
一对引号内的任何内容都会被染成灰色，以在视觉上将其衬托出来，类似于块引号。
我对这种调整感到自豪，这是我在其他地方从未见过的。

问题是并不是每个人都是它的粉丝（至少可以这么说）；它并不总是正确的（有许多双引号并不是任何东西的字面引用，例如反问句）；而且它与其他一切相互作用很糟糕。
有一些令人费解的缺点：例如。 Web 浏览器从复制粘贴中删除它们，因此我们必须使用 JS 复制粘贴侦听器将它们转换为普通引号。^[不像最初看起来那么大的缺点，因为我们最终需要复制粘贴侦听器来处理其他事情，例如数学转换或软连字符。]
即使最终解决了，所有的 HTML/CSS/JS 也必须不断地重新调整以处理与它们的交互，浏览器更新会默默地破坏正在运行的内容，而 Said 讨厌这种外观。
我尝试手动注释引号以确保它们都是正确的并且不会以危险的方式使用，但即使有交互式正则表达式搜索和替换来协助，不断标记引号的手动工作也是写作的主要障碍。

所以我屈服了。这不是故意的。

# 红字

[印刷红字](/red "'Rubrication Design Examples', Gwern 2019")：寻找问题的解决方案。

红色强调是一种视觉策略，对于许多风格都非常有效，但我在 Gwern.net 上找不到。在常规网站上使用它会导致“过多”强调，而其他地方缺乏颜色使设计不一致；我们尝试在黑暗模式下使用它来添加一些颜色并通过将标题/链接/首字下沉变为红色来保留夜视能力，但正如一位读者所说，它看起来像“吸血鬼粉丝网站”。这是一个好主意，但我们只是还没有找到它的用途。 （也许如果我制作另一个网站，它将围绕红字设计。）

# `wikipedia-popups.js` {#wikipedia-popups-js}

`wikipedia-popups.js`：一个为模仿维基百科弹出窗口而编写的 JS 库，它使用 WP API 来获取文章摘要；被更快、更通用的本地静态链接注释所取代。

我不喜欢这种延迟，当我想到这一点时，我突然想到，如果其他网站有弹出窗口，比如 Arxiv/BioRxiv 链接，那就太好了——但它们没有*有*可以查询的 API。如果我通过在编译文章时获取 WP 文章摘要并将其内联到页面中来解决第一个问题，那么就没有理由仅包含 Wikipedia 链接的摘要，我可以从任何工具、服务或 API 获取摘要，而且我当然可以编写自己的摘要！但这需要几乎完全重写才能将其变成 `popups.js`。

通用弹出窗口功能现在将 WP 文章作为特殊情况处理，它恰好调用它们的 API，但也可以调用另一个 API，在 iframe 中弹出 URL（无论是在当前页面内、在另一个页面上，甚至完全在另一个网站上）、重写在 iframe 中弹出的 URL（例如尝试获取链接文件的语法突出显示版本，或获取 Arxiv 论文的 Ar5iv HTML 版本），或者获取预先生成的页面，例如注释或反向链接或类似链接页面。

# 链接截图预览

链接截图预览：自动截图质量太低，不受欢迎。

为了弥补几乎所有链接缺乏摘要的情况（即使在我编写了抓取各个网站的代码之后），我尝试了我在其他地方看到的“链接预览”功能：网页或 PDF 的小缩略图大小的屏幕截图，当鼠标悬停在链接上时使用 JS 加载。 （它们太大了，约 50kb，无法像链接注释那样静态内联。）它们给出了目标内容的一些指示，并且可以使用无头浏览器自动生成。我使用 Chromium 内置的网页截图模式，并截取了 PDF 的第一页。

PDF 工作正常，但网页经常崩溃：由于广告、时事通讯和 GDPR，无数网页会弹出某种巨大的模式，阻止页面内容的任何视图，从而破坏了重点。 （我安装了像 [AlwaysKillSticky](https://git.sr.ht/~achmizs/AlwaysKillSticky.git) 这样的扩展程序来阻止此类垃圾邮件，但 Chrome 屏幕截图*不能*使用任何扩展程序或自定义设置，并且 Chrome 开发人员拒绝改进它。）即使它确实有效并生成了合理的屏幕截图，许多读者仍然不喜欢它并抱怨。我对周围有 10,000 个小 PNG 也不太高兴。因此，当我稳步扩展链接注释时，我终于停止了链接预览。太多而太少。

- **链接存档**：我的链接存档在多个方面改进了链接屏幕截图。首先，SingleFile 将页面保存在普通 Chromium 浏览实例中，该实例“确实”支持扩展和阅读器设置。仅删除即时贴就可以消除一半的不良档案，广告拦截扩展可以消除更多的内容，而 NoScript 则可以将特定域列入黑名单。 （我最初在白名单的基础上使用 NoScript，但现在禁用 JS 会破坏太多网站。）最后，我决定在每个快照上线之前手动检查它，以捕获不良示例，然后手动修复它们或将它们添加到黑名单中。

# 自动深色模式

<span id="auto-dark-mode">Auto-[黑暗模式](!W "Light-on-dark color scheme")</span>：一个好主意，但“读者是我们不能拥有好东西的原因”。

操作系统/浏览器定义了一个“全局暗模式”开关，如果读者想要在任何地方都使用暗模式，则可以进行设置，并且该功能可用于网页；如果您正在为您的网站实施深色模式，那么将其作为一项功能并打开（如果切换已打开）似乎很自然。
不需要具有复杂实现的复杂 UI 混乱小部件。
然而，如果你“这样做”，读者会经常抱怨该网站在白天表现得很奇怪或很黑，显然忘记了他们启用了它（或者从来不理解该设置的含义）。

一个小部件对于让读者进行控制是必要的，尽管即使在那里它也可能会搞砸：许多网站满足于全局切换的简单否定开关，但如果你这样做，在白天设置黑暗模式的人将在晚上暴露在令人眼花缭乱的白色......
我们的小部件比那更好用。大多。

有没有可能有一天，黑暗模式会变得如此普遍，用户受教育程度如此之高，以至于我们可以悄悄地放弃这个小部件？
是的，即使到 2023 年，深色模式也已经变得相当流行，而且我怀疑自动深色模式在 2024 年或 2025 年会造成更少的混乱。
然而，我们被小部件困住了——一旦我们有了小部件，就无法抗拒添加更多控件（用于阅读器模式，然后禁用/启用弹出窗口）的诱惑，谁知道呢，它可能还会增加更多功能（站点范围的全文搜索？），从而使删除变得不可能。

# 多栏脚注

多列脚注：神秘的错误和重叠。

由于大多数脚注都很短，而且没有人阅读尾注部分，我认为将它们呈现为两栏，就像许多论文所做的那样，会更节省空间，也更整洁。这是个好主意，但没有成功。

# 连字多连字

[Hyphenopoly](https://github.com/mnater/Hyphenopoly)：事实证明，在编译期间对 HTML 进行连字符比在客户端运行 JS 更有效（并且实现起来也并不困难）。

为了解决 Google Chrome 长达 20 年之久的拒绝在桌面上提供连字词典并启用 [justified text](!W "Typographic alignment#Justified")（并顺便使用更好的 [<span class="logotype-tex">T<sub>e</sub>X</span>](!W "TeX#Hyphenation and justification") [连字算法](!W "Hyphenation algorithm")）的问题，JS 库 Hyphenopoly 将下载 <span class="logotype-tex">T<sub>e</sub>X</span> 英语词典并排版网页本身。
虽然性能成本出人意料地最小（在中等大小的页面上<0.05秒），但它确实存在，并且它导致了像 Internet Explorer 这样的模糊浏览器的问题。

因此，我们放弃了 Hyphenopoly，后来我使用 [<span class="logotype-tex">T<sub>e</sub>X</span> 连字算法和字典的 Haskell 版本 ](https://hackage.haskell.org/package/hyphenation "'hyphenation': Configurable Knuth-Liang hyphenation; uses the UTF8 encoded hyphenation patterns provided by hyph-utf8 from https://ctan.org/tex-archive/language/hyph-utf8") 实现了编译时 Hakyll 重写，以在编译时在浏览器可以有效地打破单词的任何地方插入一个 '[soft hyphen](!W)'，这使得 Chrome 能够正确连字，而内联它们和一些边缘的成本适中^[具体来说：有些操作系统/浏览器在复制粘贴时保留软连字符，这可能会让读者感到困惑，所以我们使用JS删除软连字符；这对于禁用 JS 的读者来说会中断，并且在 Linux 上，X GUI 完全绕过 JS 进行*中*单击，但没有其他复制粘贴方式。还有一些额外的成本：软连字符使最终的 HTML 源代码更难阅读，使正则表达式和字符串搜索/替换更容易出错，而且显然有些 [屏幕阅读器](!W) 非常无能，以至于他们会发音每个软连字符！]
因此，与 Hyphenopoly 的字典下载 + JS 重写整个页面相比，编译时软连字符方法有其自身的问题。
我们对这两种方法都不满意。

桌面 Chrome *终于*在 2020 年初提供了连字符支持，并且我在 2021 年 4 月删除了软连字符连字符通行证，当时 [CanIUse](https://caniuse.com/?search=hyphenate) 表示全球支持 >96%。

2022 年，Achmiz 重新讨论了使用 Hyphenopoly（但不是编译型连字符）的主题：兼容性问题每年都会变得不那么重要，并且通过对它更有选择性并将其使用限制在狭窄的列/屏幕的情况下，性能影响可以变得几乎看不见，在这些情况下，更好的连字符会产生最大的影响。
因此，我们重新启用了 Hyphenopoly：非 Linux 上的页面摘要^[再次使用 X11 中键单击。] 桌面（因为它们是读者首先看到的内容，并通过目录缩小了范围）；旁注；弹出窗口；以及所有移动浏览器。

# Knuth-Plas 断线

![_XKCD_ #1741, ["Work"](https://www.explainxkcd.com/wiki/index.php/1741:_Work)](/doc/design/2016-10-03-xkcd-1741-work.png){.float-right .outline-not alt="'有时候，我会因为想到周围普通物体的工作量而感到不知所措。尽管这是虚构的，但我已经对电线开关触发事件有了如此强烈的看法。' [显示一张桌子，左边是一杯水，右边是一盏标准型台灯。这三个项目的不同部分有九个标签。对于每个标签，一个或两个箭头指向相关部分。五个标签写在桌子上方，两个在桌子上，两个在桌子下方前腿之间。最后两个标签导致后面的桌腿消失，并且还将桌子下方的灯线切成两半。每个标签下面将写下它们所指向的内容的描述，按从左到右的正常阅读顺序，表格上方两行，表格上方一行，表格下方一行。] • [箭头指向沿着灯罩曲线的一条线：] 一位工程师在 AutoCAD 中工作到很晚，在 AutoCAD 中绘制了这条曲线 • [箭头指向位于灯杆上方的灯罩背面。灯罩正面有四个可见的通风口。箭头指向的部分不可见：] 添加额外的通风孔以避免加州安全召回 • [箭头指向玻璃：] 与玻璃供应商进行长达数年的谈判 • [双箭头放置在玻璃中心上方，结束于玻璃边缘上方的两条线：] 4 小时的会议 • [灯杆两侧的两个箭头：] 9 小时的会议 • [两个箭头，一个指向底部，另一个指向玻璃内底部：]数月的翻倒测试 • [箭头指向灯座底部的灯信息标签。贴纸上的细线无法辨认：] 正在进行的辩论 • [箭头指向桌子的前边缘，以边缘的星爆结束：] 由于大熊雨林伐木问题长达 20 年的法律斗争，木材来源发生了变化。 • [箭头指向灯线上的开关，可以看到灯线上的开关越过桌子的右边缘并悬挂在桌子下方。在桌子边缘下方可以看到开关：]关于将开关放在电线上的争论导致有人被解雇”}

[Knuth-Plass](/doc/design/typography/tex/1981-knuth.pdf "'Breaking paragraphs into lines', Knuth & Plass 1981") [换行](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap)：不要与之前讨论的[Knuth-Liang *连字符*](#hyphenopoly-hyphenation) 混淆，它只是优化合法连字符集，Knuth-Plass 换行尝试优化实际选择的换行符。

[特别是在窄屏幕](https://en.wikipedia.org/wiki/Typographic_alignment#Problems_with_justification)上，对齐的文本不太适合，必须通过[微印刷](!W "Microtypography") [技术](/doc/design/typography/tex/2000-thanh.pdf "'Micro-typographic extensions to the TeX typesetting system', Thành 2000")，例如在单词之间/内部插入空格或更改字形大小来扭曲以适应。
网络浏览器使用的默认换行是一个糟糕的方法：它是一种贪婪算法，会产生许多不必要的不良布局，导致许多单词延伸和明显的[rivers](!W "River (typography)")。
文本越窄，这种糟糕的布局就会变得更糟，因此在移动设备上的 Gwern.net 列表中，当完全合理地使用贪婪布局时，会出现“很多”看起来很糟糕的列表项。

相反，Knuth-Plass 将段落视为一个整体，并计算每种可能的布局以选择最佳的布局。
从任何 <span class="logotype-tex">T<sub>e</sub>X</span> 输出中可以看出，结果要好得多。
Knuth-Plass（或其竞争对手）将解决合理的移动布局问题。

不幸的是，没有浏览器实现任何这样的算法（除了所有浏览器中的 Internet Explorer [显然实现了？](https://news.ycombinator.com/item?id=5189258)）。
我们有什么？

- <span id="text-wrap-pretty"></span> CSS：[CSS4](https://www.w3.org/TR/css-text-4/#text-wrap)、[`text-wrap: pretty`](https://developer.mozilla.org/en-US/docs/Web/CSS/text-wrap#pretty)（[CanIUse](https://caniuse.com/?search=text-wrap%3A%20pretty)）中有一个属性，有一天可能会被某些浏览器以某种方式实现并成为 Knuth-Plass，但没有人知道何时或如何实现。

    截至 2024 年 4 月，仅 [Chrome v117+](https://developer.chrome.com/blog/css-text-wrap-pretty/) 声称 [支持 `pretty`](https://chromestatus.com/feature/5145771917180928)；虽然基于[Minikin Android's ](https://raphlinus.github.io/text/2022/11/08/minikin.html) Knuth-Plass（和Knuth-Liang...？）的衍生产品，但尚不清楚它*做什么*，并且[设计文档](/doc/cs/css/2024-ishii.pdf "‘Score-based Paragraph-level Line Breaking’, Ishii 2023")似乎说它是高度有限的，除其他问题外，仅适用于段落的最后4行。 （看起来确实是[fast](https://codersblock.com/blog/nicer-text-wrapping-with-css-text-wrap/#performance "'Nicer Text Wrapping with CSS text-wrap § Performance', Will Boyd 2024-01-28")。）

当[我们在 Gwern.net 的完全合理的文本 ](https://github.com/w3c/csswg-drafts/issues/3473#issuecomment-2032718416) 上尝试它时，我们发现它降低了间距太多，不值得使用，尽管帮助修复了段落末尾的 [orphan-words](!W "Widows and orphans")，但我们无法使用它。
  Firefox [没有任何实现的积极讨论](https://bugzilla.mozilla.org/show_bug.cgi?id=630181)。
- JS：与 Knuth-Liang 连字不同，我们不能在 JavaScript 中自行实现，因为可用的 JS 原型在 Gwern.net 页面上会失败。 （还有一个问题是，长页面上的性能是否可以接受，因为 JS 库依赖于插入和操作大量 DOM 元素，以强制浏览器在应该中断的地方中断，而我们的页面本身就需要如此多的 DOM 元素，从而成为性能问题。）

- [Bramstein 的 `typeset`](https://github.com/bramstein/typeset) 明确排除列表和块引用，Bramstein 在 2014 年评论说“这主要是一个技术演示，而不是应该在生产中使用的东西。我仍然希望浏览器在某个时候能够在本机实现此功能。”
    - [骑士的 `tex-linebreak`](https://github.com/robertknight/tex-linebreak) 也存在致命错误。
- 其他：[Matthew Petroff](https://mpetroff.net/2020/05/pre-calculated-line-breaks-for-html-css/ "Pre-calculated line breaks for HTML / CSS") 有一个演示，它使用了一种极其愚蠢的蛮力方法，离线预先计算 Knuth-Plass 换行符的*每个可能的宽度*——毕竟，显示器宽度只能在 ~1--4000px 范围内，而人们关心的“可读”范围只是其中的一小部分。

    至少可以说，目前还不清楚我如何在 Gwern.net 上使用这样的东西（尽管它可以用于服务器端渲染），并且毫无疑问它有自己的错误或限制（特别是对于动态文本）。

但是，当原型如此根本不完整且没有被损坏时，所有对正确性或性能的担忧都毫无意义。
（我的预测是，通过仔细优化并添加无害的约束（例如考虑最多 _n_ 行），成本是可以接受的；请参阅 [West 2006](https://defoe.sourceforge.net/folio/knuth-plass.html)。）

所以断线的情况在可预见的将来都无法解决。

我们决定在窄屏幕上禁用完整的对齐方式，并满足于右对齐。

# 自动寻呼机

Autopager 键盘快捷键：绑定 Home/PgUp 和 End/PgDwn 键盘快捷键以转到“上一个”/“下一个”逻辑页面（元数据功能 [我最终也删除了](#navbar-previousnext-links)）结果是有问题且令人困惑。

HTML 支持链接上的上一个/下一个属性（[`rel="prev"`/`"next"`](https://developers.google.com/search/blog/2011/09/pagination-with-relnext-and-relprev)），指定哪个 URL 是逻辑上的下一个或上一个 URL，这在许多上下文中都有意义，例如手册或网络漫画/网络连续剧或系列文章（[通常无法使用它](#gwern-idea--prefetch)，但是）；浏览器很少使用这些元数据——通常甚至不会[预加载](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel/preload)下一页！ （歌剧显然是少数例外之一。）

默认情况下，此类元数据通常在较旧的超文本系统中可用，因此较旧的更面向读者的界面（例如 Web 之前的超文本阅读器，例如 [info](!W "info (Unix)"）浏览器经常重载标准的向上/向下翻页键绑定，如果已经位于超文本节点的开头/结尾，则转到逻辑上一个/下一个节点。
这很方便，因为它可以快速地翻阅一长串信息节点，几乎就像整个信息手册是一个长页面一样，而且很容易发现：大多数读者会在某些时候意外地点击它们两次，要么是反射性的，要么是没有意识到它们已经在顶部/底部（就像大多数信息节点由于过短而出现的情况一样）。
相比之下，浏览信息手册的 HTML 版本是令人沮丧的：您不仅必须使用鼠标来翻阅潜在的数十个单段落页面，而且每个页面的加载时间都相当长（因为无法利用预加载），而本地信息浏览器是即时的。
HTML 版本遇到了我所说的“曲折的迷宫般的段落”问题：读者面临着无数的超链接，所有这些超链接都需要花费大量的时间/精力来导航（其中一个不符合流程），但其中大多数几乎毫无价值，而少数则非常重要，并且几乎无法区分这两种类型。广告和其他视觉上浪费的设计元素使每个页面变得混乱和缓慢；未能设置 `a:visited`{.CSS} CSS 意味着读者将在他“已经”访问过的页面上浪费时间；在每个链接上添加新的困境时，损坏的链接仍然会变慢——尝试搜索实时副本，因为它可能很重要，还是放弃？等等。对于一种目标是像想象中那样流畅和轻松的媒介来说，它通常更类似于涉水穿过被乐高积木包围的流沙坑。]

在为 Gwern.net 页面定义了一个全局序列，并在每个页面的底部添加了一个“导航栏”，其中上一个/下一个 HTML 链接对该序列进行了编码，我认为支持 Gwern.net 中的连续滚动会很好，并编写了一些 JS 来检测是否在页面的顶部/底部，以及在每个 Home/PgUp/End/PgDwn 上，是否在前 0.5 秒内按下了该键，如果是，则继续执行上一页/下一页。

这确实有效，但在实践中被证明是有缺陷和不透明的，甚至偶尔也会绊倒我。
由于很少有人知道 WWW 之前的超文本 UI 模式（尽管它很有用），因此不太可能发现它，或者即使他们确实发现它也不会经常使用它，所以我将其删除。

# 自动小写字母

`.smallcaps-auto`{.CSS} 类：Gwern.net 的排版依赖于 [“smallcaps”](!W "Small caps")。我们广泛使用小型大写字母作为强调斜体、粗体和 [capitalization](!W "Letter case") 的另一种形式（这促使从系统 Baskerville 字体切换到 Source Serif Pro 字体）。例如，列表中的关键字可以强调为 **bold 1^st^ top-level**、_italics 2^nd^ level_ 和 [smallcaps 3^rd^ level]{.smallcaps}，使它们更易于扫描。

然而，小型大写字母还有其他用途](!W "Small caps#Uses")：首字母缩略词/首字母缩写。 2个大写字母，如“AM”，不显眼；但诸如“NASA”之类的名称或“HTML/CSS”之类的短语之所以引人注目，其原因与使用全大写字母书写“大喊大叫”相同——大写字母很大！将它们放在小写字母中以压缩它们是一些印刷师推荐的印刷改进。^[例如。第 47 页，_[印刷风格的要素](!W)_（第三版），[Bringhurst](!W "Robert Bringhurst") 2004； [理查德·鲁特](https://webtypography.net/3.2.2 "The Elements of Typographic Style Applied to the Web: § Numerals, Capitals & Small Caps: 3.2.2 For abbreviations and acronyms in the midst of normal text, use spaced small caps")； [戴夫·布里克](https://speakipedia.com/book-design-part-5/ "Book Design Basics: Small Capitals—Avoiding Capital Offenses")等]

即使使用交互式正则表达式搜索和替换，手动注释每个此类情况也需要大量工作。
一两个月后，我决定在 Pandoc 中自动完成此操作。
因此，我创建了一个重写插件，它将在 Pandoc AST 中的每个字符串上进行正则表达式以进行匹配、分割，并在标有 `.smallcaps-auto`{.CSS} 类的 HTML span 元素中注释匹配，该元素由 CSS 设计，就像现有的 `.smallcaps`{.CSS} 类一样。 （[最终代码版本.](https://github.com/gwern/gwern.net/blob/0880d27302dc61ffa4f7c10317e13696af7186ae/build/Typography.hs#L51)）

由于存在一系列问题，使用 Pandoc 的树遍历库来执行此操作被证明非常具有挑战性，而且速度很慢。
（我相信，由于遍历代码的效率极低以及在每个可能的节点上重复运行复杂的正则表达式的成本，它至少使网站编译时间增加了一倍。）
重写方法意味着跨度可以重复嵌套，生成无意义的 `<span><span><span>...`{.HTML} 序列（通过“更多”重写代码来检测和删除这些序列仅部分改善）。
小写正则表达式也很难正确，并且不断出现新的特殊情况和例外情况。
注入的 span 元素会导致下游进一步复杂化，因为它们会破坏模式匹配或将原始 HTML 添加到文本中，而我没想到其中会包含原始 HTML。
小写字母本身有许多奇怪的副作用，例如与斜体的交互以及下划线链接所需的链接阴影技巧。速度损失并没有停止在网站编译上，而是影响了读者：Gwern.net 页面已经在浏览器上密集使用，因为大量的超链接和格式产生了最终的大型 [DOM](!W "Document Object Model") （其中每个原子导致了同样扩展的 JS 和 CSS 集的额外负载），并且小型大写标记向某些页面添加了数百个额外的 DOM 节点。
我还怀疑小型大写字母的可见性导致了许多 Gwern.net 读者抱怨的“太花哨”或“过载”的感觉：即使他们没有明确注意到小型大写字母是小型大写字母，他们仍然注意到所有首字母缩略词都有一些不寻常的地方。
（如果小型大写字母更常见，这将不再是一个问题；但它就是一个问题，并且只要小型大写字母是一种必须为每个实例显式启用的异国印刷繁荣，它就会一直存在。）

最后一根稻草是对 Gwern.net 文章的注释进行了更改，以包含其目录以便于浏览，其中注释中的 ToC 获得了小写自动，但原始 ToC 没有（仅仅因为原始 ToC 是在重写完成后很久由 Pandoc 生成的，并且 Pandoc 插件无法访问），造成了不一致并需要“甚至更多”CSS 解决方法。
此时，由于 Said 不是小型汽车汽车的粉丝，而且我自己也有点厌倦了，所以我们决定减少损失并废弃该功能。

我仍然认为自动使用小型大写字母表示首字母缩略词等全大写短语的想法是有效的——尤其是在技术写作中，由于大写字母，首字母缩略词汤*是*压倒性的！——但是在 HTML DOM 中这样做的成本（因为普通文本上的 CSS/HTML 标记）对于作者和读者来说都太高了。

将这种非语义更改视为 [ligature](!W "Ligature (writing)") 并由字体完成可能更有意义，这将更好地控制布局并避免特殊情况的需要。
通过字体自动完成的小型大写字母，它可以成为在线文本的普遍特征，并消除其令人不快的陌生感。

# Disqus 评论

[Disqus](!W){#disqus} 基于JS的评论系统：

评论系统是 2000 年代博客的必备条件，但它们要么需要服务器来处理评论（静态网站除外），要么需要使用经常不兼容的插件（博客除外）的昂贵服务；它们也是通过填充垃圾邮件来杀死博客的最可靠方法之一（在由于 [WordPress](!W "WordPress#Vulnerabilities") 而被黑客攻击之后）。
Disqus 通过在基于 JS 的免费服务中提供垃圾邮件过滤功能，帮助颠覆了现有企业；虽然当时是专有的且很少有广告支持，但它具有一些不错的功能，例如电子邮件审核，并且支持评论导出和匿名评论的关键功能。
它很快成为需要评论系统的静态网站的默认选择——就像我的一样。

我于2010年10月10日建立了Gwern.net的Disqus； 4,212 天后，我于 2022 年 4 月 21 日将其删除（[评论导出的存档](/doc/traffic/2022-04-21-gwern-disqus-gwernnet-commentsexport.tar.xz)）。

废弃 Disqus 的原因并不单一，只是一些小问题的不断积累：

- 转向**社交媒体**：2000 年代活跃的博客圈在 2010 年代让位于 Digg、Twitter、Reddit、Facebook 等社交媒体——即使在极客圈子里，势头也从博客评论转移到了 Hacker News 等聚合器。

    虽然仍然有比聚合器有更多评论的博客（例如 SlateStarCodex/Ast​​ral Codex Ten 或 LessWrong），但这越来越只能通过以该博客为中心的离散“社区”来实现。独立读者定期发表评论的文化已经消失。我经常看到聚合器：网站的评论比率 >100:1。在删除前一年，我[在 [>900,000](/traffic#july-2021january-2022) 综合浏览量中收到了 134](/doc/traffic/2022-04-21-gwern-disqus-gwernnet-comments-analytics-april2021april2022.csv) 条评论。相比之下，最近的[头版黑客新闻讨论](https://news.ycombinator.com/item?id=30928081)有254条评论，而上周的[星体法典十“开放线程”](https://www.astralcodexten.com/p/open-thread-220)讨论有>6×评论。

因此，现在我在页面的“外部链接”部分添加这些社交媒体讨论的链接，以达到评论部分过去的目的。如果没有人“使用”Disqus 评论，何必费心呢？ （更不用说转向像[Commento](https://commento.io/ "A comments widget that just works")这样的替代方案，其成本>[$100]($2022)/年。）我不是第一个观察到他们的评论系统已经退化并删除它的博主。
- **货币化衰退**：这是互联网公司的法则，随着风险投资资金耗尽和投资者要求回报，斗志旺盛的颠覆性初创公司会变成榨取性僵化的老牌企业。

    Disqus 从未成为独角兽，最终被[某种广告公司](!W "Zeta Global") 收购。新的所有者并没有像许多收购那样破坏它（例如[SourceForge](!W)），但它显然不再像以前那样充满活力或投入，垃圾邮件过滤似乎偶尔落后于攻击者，并且 Disqus 注入的广告逐渐变得越来越重。

    许多 Disqus 用户网站都不知道 Disqus 允许您禁用网站上的广告（它深埋在配置中），但 Disqus 在广告方面的声誉非常糟糕，以至于读者*无论如何*都会指责您有 Disqus 广告！ （我认为他们会查看Disqus作为推荐提供的同一网站上其他页面的小方框/页卡之一，并且没有检查每一个，就假设其余的都是广告。）我的[广告实验](#gwern-ads)只调查了真实广告的危害，所以我不知道虚假广告的效果有多糟糕——但我怀疑它是否有好处。

    - [奇怪的错误]{.smallcaps}：这种衰退的一个例子是我永远无法弄清楚为什么 Gwern.net 上的一些 Disqus 评论就这样……消失了。

        他们并不是页面重命名更改 URL 的受害者，因为评论在从未重命名的页面上消失了。它们没有被删除，因为我知道我没有删除，而且作者会抱怨我删除它们，所以他们也没有删除。它们没有在仪表板中被标记为垃圾邮件（考虑到它们最初已获得批准，就像追溯垃圾邮件过滤一样奇怪）。事实上，它们并不在我能看到的仪表板“任何地方”，这使得向 Disqus 报告问题相当奇怪（考虑到 Disqus 的衰退，我不相信报告错误会有帮助）。我知道它们存在的唯一方法是我是否有它们的 URL（因为我将它们链接为参考）或者我是否可以检索评论的原始 Disqus 电子邮件。

        因此，有人在 Gwern.net 上留下了批评性评论，并确信我删除这些评论是为了审查它们并掩盖我的智力欺诈行为。不太理想。 （将评论外包给社交媒体的好处之一是，如果有人因错误而受到指责，那不会是我。）
    - [深色模式]{.smallcaps}：Disqus 是为 2000 年代设计的，而不是 2020 年代设计的。从 2010 年代末开始，“深色模式”成为一种时尚，主要是由智能手机在夜间使用网络浏览器推动的。

Disqus 对深色模式进行了一些修补，但它并没有无缝集成到网站的本机定制深色模式中。由于我们投入了大量精力来让 Gwern.net 的黑暗模式变得更好，Disqus 却令人沮丧。
- **性能**：Disqus 从来都不是轻量级的。但它引入的所有（动态、未缓存的）JS 和 CSS 的绝对重量，充满了警告和错误，多年来似乎只增加了。

    即使 Gwern.net 添加了所有功能，我认为 Disqus 仍然胜过它。大部分负担看起来与评论无关，更多地与广告和跟踪有关。与性能优化作斗争是令人沮丧的，只有在 Disqus 加载后，任何收益都会消失，或者在调试过程中，看到浏览器开发控制台立即变得不可读。

它有助于使用 [IntersectionObserver](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserver) 这样的技巧来避免加载 Disqus，直到读者滚动到页面末尾，但这些也带来了自己的问题。 （让 IntersectionObserver 工作起来非常棘手，这个技巧会产生新的错误：例如，我一次只能使用 1 个 IntersectionObserver 而不会神秘地中断；或者，如果读者单击包含 Disqus ID 锚点（如 `#comment-123456789`）的 URL，则当 Disqus 尚未加载时，该 ID 不能存在，因此浏览器将加载页面而不跳转到评论。由于我们有代码来检查错误的锚点，这进一步导致虚假错误这些内容的重量并不算太糟糕（Disqus 的 Gwern.net 端只有约 250 行 JS、20 行 CSS 和 10 行 HTML），但交互的复杂性却增加了。
- **集成度差**：Disqus 越来越不适合 Gwern.net，也无法实现。

    黑暗模式和性能问题就是这样的例子，但它更进一步。例如，Disqus 评论框不尊重 Gwern.net CSS，并且总是看起来不平衡，因为它与主体不对齐。 Disqus 不“知道”页面移动，因此当我移动页面时注释将会丢失（这阻止了我重命名任何内容）。处理垃圾评论*很*烦人，但除了锁定评论之外没有其他解决方案，这违背了要点。

    随着设计复杂性的增加，缺乏控制成为剩余问题的一个主要部分。

所以最终，一根稻草压断了骆驼的背，我移除了 Disqus。

# 双倍行距的句子

[考虑过，但由于 HTML+CSS 实现的证据不足和困难而被拒绝，即使它可以被证明更好。](/doc/design/typography/sentence-spacing/index){.include-annotation}

# 链接图标 CSS 正则表达式 {.collapse}

<div class="abstract" id="link-icons">
> Gwern.net 站点的一个主要功能是作为符号注释附加到链接的“链接图标”。链接图标很全面，涵盖数百种不同的情况。
>
> 标准 CSS 解决方案使用正则表达式在客户端浏览器内运行时匹配 URL，虽然适合简单用途，但在正确性、可维护性和性能方面扩展性较差。
>
> 我们最终转向了编译时解决方案，其中给定 URL 的属性指定了它们的链接图标（如果有），这允许轻松定义复杂的规则，进行单元测试以保证结果正确，并且客户端渲染仅限于简单地读取和渲染属性；这种方法很容易编写正确的规则，很容易“保持”规则正确，并且对于客户来说始终是轻量级的。
</div>

它们的灵感主要是[来自维基百科](!W "Help:External link icons")：链接图标有点后缀^[人们可以想象使用*超级脚本*链接图标，但像任何其他[在HTML](/subscript#ruby)中使用'ruby'，这最终会看起来[相当疯狂](/doc/cs/css/2023-11-12-jojowiki-superscriptlinkicon-screenshot.png)。]图像表明有关链接类型的信息。最熟悉的类型是“外部链接箭头框”，它告诉您链接“离开”当前网站。
WP 的默认皮肤很大程度上将链接图标限制为外部链接或表示 PDF ^[人们看到的主要链接图标（维基百科的 Adob​​e Acrobat“PDF”字形）是如此丑陋，这可能无助于链接图标的流行。维基百科，你可以做得更好。]（对于喜欢警告的读者来说仍然令人不快和有问题），维基百科之外的“外部链接”（在其他地方很常见的用法，小箭头或框内箭头已成为普遍接受的图标），语言注释，例如警告链接不是英语而是用日语^ja^或德语^de^编写的；其他 WP 皮肤，如 [Monobook](/doc/design/2023-03-05-gwern-wikipedia-monobookskin-externallinkiconsdemonstration.png)（这是我十年来最喜欢的皮肤）提供了更丰富的链接图标集，但很少有读者见过它们，并且链接图标现在似乎逐渐不受青睐，作为界面普遍简化的一部分。

因为 Gwern.net *如此* 严重依赖参考文献和引文，并且具有比典型博客更多的数据格式，并且普通链接会导致读者过载，所以我已经远远超出了 WP 链接图标。
只要稍加思考，您就可以使用链接图标来传达一个身份（或至少是一个“主题”），从而摆脱在下划线海洋中平淡无奇的带下划线的超链接的困扰。
如果做得好，链接图标不会使页面变得过于混乱，并且一旦高级读者了解了一些关联，他们就能一目了然地提供宝贵的摘要。
（由于它们非常紧凑，因此在弹出窗口中特别有效，可以帮助读者了解他们是否想要深入了解特定链接。）

## CSS 正则表达式

实现链接图标的标准方法是 WP 建议用于编辑器自定义并在通常的[博客文章](https://www.paritybit.ca/blog/styling-external-links.html/) 中描述的方法，是将链接图标视为正则表达式问题：如果您想要 PDF 上的链接图标，您可以执行像 `.*\.pdf$` 这样的正则表达式，它与 URL 末尾的字符串“.pdf”匹配，然后这可以使一个小文本字符串或图像作为一个`::after`{.CSS} CSS 属性。
对于您想要的每个链接图标，都是这样的：

~~~{.CSS}
a[href$="\.pdf"]::after { 内容: "PDF"; }
~~~

这是一种简单的、普遍支持的旧 CSS，处理图像就像处理文本或 Unicode 一样容易（Unicode 是避免需要图像的绝佳方法），也是 Gwern.net 最初用来表示 PDF 和 Wikipedia 链接的方法。

### 问题

这种方法除了挑剔的样式细节之外还有其他问题，例如从链接中分割图标的换行符。
首先，很难获得正确的正则表达式：上面的正则表达式在很多方面都是错误的——它与我的许多指定*页码*的PDF链接不匹配，因为它们的形式为`foo.pdf#page=N`。
所以你需要匹配这种大小写，或者放松它以中缀匹配，如 `.*\.pdf.*`。[^Wikipedia-PDF-regexp]
它将命中任何恰好包含字符串 `.pdf` 但不是 PDF 链接的 URL，并且仍然不会匹配许多实际上 * 是 * PDF 的 URL，就像一些学术出版商将其 PDF URL 写为 `https://publisher.com/pdf/12345` 之类的内容，这将为您提供带有适当的 [MIME](!W) [媒体类型](!W) [HTTP header](!W "List of HTTP header fields") 的 PDF，但不会匹配该正则表达式。
（或者更糟糕的是，他们将 PDF *内部* HTML 包装器+[iframe](!W "Frame (World Wide Web)"），所以标题是不够的......）

[^Wikipedia-PDF-regexp]：MediaWiki 使用正则表达式方法，并努力涵盖所有有用的情况，正如其 CSS 通过具有 6 种不同的正则表达式所表明的那样：

    ~~~{.CSS}
    .mw-parser-output a[href$=".pdf"].external,
    .mw-parser-output a[href*=".pdf?"].external,
    .mw-parser-output a[href*=".pdf#"].external,
    .mw-parser-output a[href$=".PDF"].external,
    .mw-parser-output a[href*=".PDF?"].external,
    .mw-parser-output a[href*=".PDF#"].external {
        background: url(//upload.wikimedia.org/wikipedia/commons/4/4d/Icon_pdf_file.png) no-repeat right;
        padding: 8px 18px 8px 0;
    }
    ~~~

    这可以简化为 3 个正则表达式，并通过使用不区分大小写的匹配（即 `[href$=".pdf" i]`{.CSS} 等）来扩展以处理可能的混合大小写/拼写错误扩展，例如 `.Pdf`。无论如何，这个套件将错过我尝试处理的 `/pdf/` 或包装器案例，但确实处理带有 `?foo=bar` [查询参数 ](!W "Query string") 的案例，我跳过了。 （大概对于坚持使用各种元数据、跟踪和授权的服务器来说，而不是仅仅提供 PDF，而没有任何进一步的麻烦。我倾向于认为此类 URL 是危险的，只是从不链接它们，而是立即重新托管 PDF。）

假设您有一个满意的 PDF 正则表达式^[我对该问题的解决方案是更频繁地手动镜像 PDF（保证它们遵循 `.pdf` 模式），并最终创建一个“本地存档”系统，该系统将快照大多数远程 URL，从而确保涉及 PDF 的网页将作为 PDF 显示给读者。]，并且您还创建了一个 [Arxiv](https://en.wikipedia.org/wiki/ArXiv) 链接图标，因为这对读者来说是信息丰富的，现在您注意到指向特定页面的许多 Arxiv PDF 链接不太理想：要么您更喜欢 Arxiv 链接图标，但它们正在获取通用 PDF 链接图标，或者您可能更喜欢 PDF 链接图标，但 Arxiv 会覆盖它。
您最终会发现，“覆盖”只是因为 CSS 规则有关“最长且最具体的规则获胜”（为了大大简化），而其中一条规则恰好更长。
您需要修改正则表达式。
幸运的是，还有更多 CSS 功能允许您“否定”匹配，例如 `:not()`，因此您可以编写“其中包含“pdf”，但不能写“arxiv.org””。

您执行此操作，就会显示更多链接图标。
你注意到你在 Arxiv 上链接了很多 DeepMind 论文，对于精通机器学习的读者来说，比仅仅使用 Arxiv 符号更具体并标记那些与“DeepMind”相关的论文会很有帮助。^[有人可能有点怀疑，但正如笑话所说，对于一只羊来说，所有的羊看起来都很不同，我经常在读完摘要之前就知道一篇论文是由 DeepMind 小组写的，有时甚至从标题来看，即使是在这表面上是盲目的同行评审。]
这可以通过重载标识符并将哈希附加到 URL（例如 `#deepmind`），以简单的链接图标友好方式完成。
所以现在 DM Arxiv 论文可能看起来像 `https://arxiv.org/abs/1610.09027#deepmind`。
这读起来很愉快，在搜索或浏览时非常方便，不会破坏 URL（只会触发链接检查器中虚假的 [anchor](https://en.wikipedia.org/wiki/HTML_element#Anchor)-缺少警告），并且不需要任何网站工具或数据库跟踪元数据。
您还可以将其与页码结合起来，以获得类似 `https://arxiv.org/pdf/1809.11096#page=8&org=deepmind` 的 URL。
您可以唯一地匹配 `#deepmind`，并使用更多的正则表达式和条件覆盖 PDF 或 Arxiv 选择器。
这个技巧适用于我想要跟踪的所有组织，例如 Facebook、OpenAI、微软、百度等；如果您想跟踪另一种方便地编码到 URL 本身的每 URL 元数据，它也同样适用。
到目前为止，一切都很好！

直到现在，错误才开始定期出现，每次你添加另一个合理的链接图标、另一个小的 CSS 规则、另一个调整、另一个读者期望的合理例外时，你就有触发一系列问题的风险：这个链接图标曾经是正确的，现在是错误的；除非你开始添加无意义的条件来尝试通过“最长的获胜者”来应用它，否则你无法使用这个新的；这个让你感到困惑，因为你需要在“PDF”和“Arxiv”等优先级之间插入一个链接图标，但现在你必须重写一大堆；有时它们会无缘无故地崩溃，你只有在很久之后偶然看到一篇旧帖子时才会发现。
（您是否想添加 `.icon-not`{.CSS} 类来偶尔禁用特别有问题的链接上的链接图标？
绝对不行，你必须将 `:not()`{.CSS} 选择器添加到*所有内容*中，并冒着纸牌屋再次倒塌的风险。）
由于组合的全局交互，对于一两个链接图标来说几乎完美的效果开始崩溃。
也不清楚如何“测试”当前的规则集，除了创建一个页面只是为了列出一堆链接并在每次更改链接图标时用眼睛扫描它们的粗略方法之外，因为任何调整都可能会破坏规则/例外/长度的脆弱级联。

当您有数百条规则的分数时，您会开始注意到另一个问题：它变得*慢*。
您正在为每个链接图标编写 CSS 规则，这些链接图标中编码了更多的条件/选择器（由于添加/补丁的交互和临时性质而快速扩展），并且无论如何，它们都必须在每个链接上运行。
每个页面都必须为每个链接图标的每个链接付费。
当您撰写带有一两个链接的 500 字的小型博客文章时，这不是问题（如果是这样的话），但当一个人的野心扩大到带有数百个链接和引用的 10,000 多字文章时......
最终，尤其是在长页面上，页面加载开销变得显而易见。 （CSS 不是免费的！）

## 静态链接-图标属性

那么，我们的解决方案是什么？

Said Achmiz 提出了一种据他所知在这种情况下新颖的方法（尽管它在其他领域也有相似之处）：从许多必须消除冲突的单独的全局正则表达式匹配规则切换到运行指定链接图标图像或文本的单个大型嵌套规则。
然后 CSS 只执行样式，避免任何更复杂的逻辑。

### `links.js` {#links-js}

第一阶段使用 [JavaScript 实现 ](/static/js/old/links.js) 对其进行原型设计，该实现先实现了 CSS，然后实现了 JS 函数（带有一个小型测试套件），并将现有的大量 CSS 规则（覆盖约 160 类链接）转换为单个巨型规则。

JS 实现证明了这个概念是合理的，一旦解决了细节，显然将其移至编译时会更好——毕竟，任何链接图标分配都不会在阅读器浏览器内部发生变化，因此后期绑定只不过是浪费。
（这是 Gwern.net 上的一个常见循环：尽可能多地用“原始”CSS/JS 做一些事情，逐步建立一个由网站需求驱动的用例/示例的大型语料库，几年后一旦问题被充分理解，然后才重写到编译时。
编码很容易——知道设计代码来做什么是困难的部分。）

### `LinkIcon.hs` {#linkicon-hs}

以 JS 作为明确的参考，我可以[切换到 Pandoc Haskell 库](/static/build/LinkIcon.hs)，其中每个链接在编译时通过通常的 Pandoc API 设备进行处理，类似于 JS，单个函数是按优先级顺序排列的大型规则列表：“如果其中任何地方都有字符串‘DeepMind’，那么它会获得 DeepMind 图标；否则，如果它是 Arxiv.org，它会获得 Arxiv（即使它是PDF）；等等”。

这可以通过创建一个简单的小测试套件来测试，该套件在 DeepMind URL、Arxiv URL、Arxiv PDF URL 和常规 PDF URL 上运行规则——如果任何 URL 得到错误的结果，那么它会立即出错并可以修复。

当链接*确实*匹配规则时，该规则指定两部分数据：一个指定外观，另一个指定内容。
它们被编码到 HTML 中，作为 `<a>`{.HTML} 元素本身设置的两个 `data-`{.HTML} 属性。
因此 DeepMind URL 将得到 `<a href="https://arxiv.org/abs/1610.09027#deepmind" data-link-icon="deepmind" data-link-icon-type="svg">foo</a>`。

然后，SVG 通过 JS 实际使用（最初是通过编译时生成的 CSS 块）。
JS 添加了一个内联样式，将 `--link-icon`{.CSS} [CSS 变量 ](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) 的值设置为 `data-link-icon`{.CSS} HTML [数据属性](https://developer.mozilla.org/en-US/docs/Learn/HTML/Howto/Use_data_attributes) 的值。
然后每个特定图标或样式的 CSS 声明仅使用 CSS 变量（与 HTML 属性不同，它可以通过任何 CSS 属性访问，而不仅仅是“内容”。）

我们不想为*每个*链接[^making-SVGs]创建一个SVG，所以还有许多其他选项：首字母缩略词特别常见，因此可以将`data-link-icon`{.CSS}内容设置为像['NBC'](https://en.wikipedia.org/wiki/NBC)这样的文本字符串，然后由于NBC将其首字母缩写词设置为无衬线字体而不是Gwern.net的默认衬线字体，我们用`data-link-icon-type="text, sans"`{.CSS}作为类型。
（支持许多其他样式：等宽、斜体、3 个字母的单词、排列为 2×2 块的 4 个字母的单词...）
所有链接均按此方式处理。

[^making-SVGs]：制作 SVG 链接图标需要时间，但不一定像听起来那么难。

    许多网站已经有 SVG 图标或徽标；如果他们不这样做，他们的维基百科条目可能已经包含 SVG 徽标，或者 Google 图片可能会出现一个。如果没有，则有时可以使用“跟踪位图”在 [Inkscape](!W) 中跟踪 PNG/JPG。 （我直接使用 [Potrace](!W) 的运气并不好。）一旦导入 Inkscape，即使是像我这样的新手通常也可以将其设为单色并简化/夸大它，使其作为一个微小的链接图标清晰可见。然后像 [vecta.io](https://vecta.io/nano) 这样的 SVG 压缩实用程序可以将脂肪减少到 1--4kb。然后，暗模式 CSS 通常可以自动反转它们，无需进一步的工作。

    一个有趣的调整是，我们通过生成一个带有文本的小型 SVG 来生成文本链接图标，如四边形链接图标！这对于控制字距调整和换行是必要的。

在 Web 浏览器中运行时，CSS 不会进行任何“思考”。
它只是遍历页面中的每个 `<a>`{.HTML}，并查找这两个属性。

~~~{.CSS}
a[data-link-icon-type='svg']::after {
    内容：“​”；
    背景图像：var(--link-icon-url);
}
~~~

由于相对较新的 CSS 功能，这可以用于*读取特定的 URL*，在本例中是我们存储的 SVG 图标集。
对于参数 `deepmind`，它会查找 `--link-icon-url`{.HTML} 的值，当然它已经被定义为 `/static/img/icon/deepmind.svg`，并且被替换，并且 `::after`{.CSS} 运行就像我们用旧的方式编写它一样 - 但不必在每个链接上运行数百个正则表达式的老鼠巢以最终找出它与“DeepMind”匹配。
我们实际上不需要手动编写任何引用 `deepmind` 的 CSS，除非我们认为默认情况下它看起来不太正确并且我们需要调整它，我们可以这样做，并且可以这样做：

~~~{.CSS}
a[data-link-icon='deepmind']::after {
    --链接图标大小：0.8em；
    --link-icon-offset-x: 0.15em;
    --link-icon-offset-y: 0.2em;

不透明度：0.7；
}
a[data-link-icon='deepmind']:hover::after {
    不透明度：0.5；
}
~~~

#### 特征

所以这解决了所有问题。
编写规则很容易，因为我拥有所有熟悉的 Haskell 工具，并且可以在 REPL 中测试整个集，并且测试套件会提醒我任何回归；因为它很容易编写，所以我添加了约 500 个链接图标。
对于客户端来说速度很快，因为所有计算都是提前完成的，并且避免了由于滥用正则表达式而导致的交互或指数。
而且它的功能更加丰富，因为通过变量从外观中分解内容意味着很容易支持 2×2 块等风格化功能，而在数百个实例上一一实现会太乏味。
（它也可以与 [本地链接存档功能](/archiving#preemptive-local-archiving "‘Archiving URLs § Preemptive Local Archiving’, Gwern 2011") 一起正常工作：它只是将规则应用于原始 URL，而不是保存在属性中的重写 URL。）

![~130 个 Gwern.net 链接图标示例.](/doc/design/2023-03-05-gwern-gwernnet-lorem-linkicons-130examplelinkicons.png)

使用静态 `LinkIcon.hs` 方法，添加新的文本图标及其相应的测试可以像两行一样简单，最多需要一分钟：

~~~{.哈斯克尔}
-- u'' 匹配单个整个域（不包括前缀）；其他帮助功能匹配多个域，
-- URL 中的任何位置或扩展名。
+ | u'' "thelastpsychiatrist.com" = aI "TLP" "text,tri,sans"
……
+ , ("https://thelastpsychiatrist.com/2011/01/why_chinese_mothers_are_not_su.html", "TLP", "文本,tri,sans")
~~~

这定义了一个匹配特定博客的低优先级规则，给它一个可立即识别的链接图标（至少，对任何认为“最后的精神病医生”意味着任何东西的人来说），不需要编辑网站内容（它自动应用于该域的所有现有链接），看起来合适（既不太大也不太小，并且是无衬线体），自动测试每个网站构建的正确性，如果不是的话，会破坏（规则写起来很简单，它开始了正确且从未损坏），并且如果我对域进行[站点范围的重写](/archiving#fixing-redirects)（事实上我已经这样做了，因为它在某个时候转移到了 HTTPS），我将继续检查正确性。

此外，因为规则在编译时可用，而不是在运行时在浏览器中隐式存在，所以我可以添加一些漂亮的功能，例如“域优先级排序器”：通过规则运行 Gwern.net 上的每个链接，查看所有*不*有任何链接图标的链接，按其域名分组，如果有任何域具有 >3 个链接，并且既没有链接图标，也没有在故意无图标域的黑名单上（通常没有图标是可行的），则打印一条消息建议域被检查。
这使得套件随着时间的推移变得全面，进一步减轻了维护负担——当链接图标代码告诉我时，我只需要考虑链接图标。

# 反应式归档

我最初的[linkrot对抗方法](/archiving "‘Archiving URLs’, Gwern 2011")是反应性的：检测linkrot，用新链接或互联网档案备份修复损坏的链接，并使用机器人确保它们都被IA提前存档。
结果发现，当 IA 无法获取某些链接时，就会丢失这些链接，因此我添加了本地归档工具来制作本地快照。
这也被证明是不够的，有时会丢失 URL，并且在每个链接损坏时修复它（有时会重复）需要大量工作。
最终，我不得不求助于[抢占式本地链接归档](/archiving#preemptive-local-archiving "‘Archiving URLs § Preemptive Local Archiving’, Gwern 2011"){#preemptive-2}：在添加每个链接时制作并检查并使用本地归档，而不是等待它们损坏并以劳动密集型打磨的方式手动处理损坏。

# 出站链接跟踪

2021 年，我们尝试对 Google/Google Scholar 的链接实施出站链接跟踪，以查看它们是否被足够的点击来证明它们在弹出窗口顶部占据的空间是合理的。

我在 Twitter 上进行了一次快速民意调查，询问

> **站点使用情况调查**：在链接弹出窗口上，[有帮助链接](/doc/design/2021-01-06-gwern-gwernnet-popup-annotationwithlinkstointernetarchiveandgooglequeriesforaurl.png) 到互联网档案馆和 Google/Google Scholar 的帮助链接，以防读者想要访问 IA 档案或进行反向引用链接（通过 [DOI](!W "Digital object identifier") 或 Google 中的 `link:` ^[该操作符[很久以来已删除](https://x.com/methode/status/1023835318548455424)，所以我转为按标题搜索]）。
>
> ![\[投票图像：用黑色大箭头指出的帮助链接。\]](/doc/design/2021-01-12-gwern-gwernnet-popup-annotationwithlinkstointernetarchiveandgooglequeriesforaurlwitharrowemphasisfortwitterpoll.png)
>
> 您是否曾点击过其中一个并发现它很有用？ [_n_ = 127]
>
> - 是：41.7% [_n_ = 53]
> - 否：58.3% [_n_ = 74]

我一直希望得到一些明确的结果，比如 90% 的人回答“从不”，但这是模棱两可的：60% *从不*使用它并不好，考虑到它们有数千个注释，我希望任何对我的 Twitter 帐户感兴趣的人都会弹出数百个注释；但注释上也没有那么多空间，40% 的人仍然至少使用过一次。

所以我们决定获取更难的数据。
理论上，跟踪 GS/G/IA 链接很容易：甚至可以在 `<a>`{.HTML} 链接上设置一个简单的 HTML [`ping`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#ping) 属性来实现此目的。
`ping`{.HTML} [在 FF](https://kb.mozillazine.org/Browser.send_pings) 中被禁用，但据称[在 Safari/Chrome](https://caniuse.com/ping) 上启用（2023-03 年占全球用户的 93%），这代表了绝大多数 Gwern.net 读者。
Said 实现了它，它似乎在他的服务器上工作，但最初在超过 8,000 次浏览量中返回了 0 个点击，当我自己测试它时，我自己的点击似乎只有 1⁄15 注册正确！
我们无法弄清楚 `ping` 出了什么问题——看起来我们正在以教科书的方式使用它，但什么也没有。
它是否已被悄悄禁用？
是否存在一些模糊的跨[origin](!W "Same-origin policy") 安全策略问题？
任何。

因此，我们恢复到[基于 Google Analytics JS 的出站链接跟踪](https://support.google.com/analytics/answer/1136920 "Analytics Help: Capture outbound links: Find out when users click a link to leave your site")（与仅在我们感兴趣的链接上设置属性相比，具有侵入性）^[我之前在 2012--2015 年使用过它，因为我有一个模糊的想法，即查看读者点击的链接将有助于确定哪些链接有用，哪些链接需要更好的标题/描述，哪些链接可能值得更长的处理，例如块引用摘录（自取代以来）我最终没有使用它来实现任何目的，因为点击率非常低，随着读者的流失，整篇文章的点击率都在下降，而且我发现它们无论如何都毫无意义。]，而且......我们看到了许多常规的出站链接，但*零*搜索链接。
弹出窗口是否干扰了它？是不是没发挥作用？或者这些链接*不*受欢迎？
我们也无法调试它。

由于对日志记录问题的不透明性感到沮丧，我认为这些链接很混乱，并将其删除。

当递归弹出窗口+[transclusion](!W) 让我将相似链接作为弹出窗口添加到注释弹出窗口中时，我最终会恢复它们，然后将 G/GS （加上更多）链接附加到 [相似链接的底部](/doc/design/2023-03-13-gwern-gwernnet-popups-recursive-similarlinksplussearchlinks.png) ---任何滚动到那么远的人都可以使用搜索引擎链接来查找更多相似链接，并且它不会占用初始弹出窗口中的空间。

从那时起，我们一直对某些功能的读者使用率感兴趣，但我们在 `ping`{.HTML} 和 GA 方面的糟糕经历阻止了我们再次尝试。

# 弹出注释

<div class="abstract">
> Gwern.net 技术上最复杂和最标志性的功能是悬停弹出窗口和点击 [popovers](/doc/cs/css/2021-03-28-gwern-gwernnet-annotations-mobilepopins-darkmode.png)，它提供元数据和广泛的注释/摘要/超链接。
> 一些网站提供有限的弹出功能，例如维基百科，但缺少全部功能。
>
> 这是因为好的弹出窗口很难设计和实现。
> Gwern.net 注释系统并不是一夜之间就完全形成的；事实上，根据你的计算方式，2023 年 3 月的系统并不亚于我们实施的*7^th^* 弹出系统。
>（开发过程中反复出现“时间是一个扁圆”和“这一切都曾经发生过，并且还会再次发生”的笑话。）
>
> 但到那时，我们就有了一个快速、灵活、经过调试、美观的系统，我们认为没有重大缺陷，未来的工作将集中在“进入”弹出窗口的内容上（例如通过使用机器学习自动编写摘要）
</div>

## 无

![XKCD [#1741](https://xkcd.com/1741/)](/doc/design/xkcd-1741-work.png "XKCD #1741, 'Work' (2016-10-03)：标题，“有时候，一想到我周围的普通物体需要做多少工作，我就会不知所措。 /尽管这是虚构的，但我已经对电线开关触发事件有了强烈的看法。这本漫画详细介绍了一系列理论示例，说明日常用品的设计和制造需要付出多少努力。这个笑话的核心是这样一个事实：现代大多数人总是被人造物体包围，我们通常不加思考地使用它们。兰德尔暗示，他偶尔会想象周围看似简单的物体（在本例中是他的桌子、水杯和上面的台灯）的内部结构，并发现它令人难以承受。这是因为我们周围有如此多的建筑物品，其中许多价格低廉且批量生产，但仍然是大量人类努力的结果。这与经典论文<em>I, Pencil</em>的论点类似。"){.float-right}

早在 2009 年，当我在日益删除主义的氛围中结束我的维基百科编辑活动并开始专注于为我自己的网站编写自己的材料（我会制作自己的 WP，带有二十一点和块引用）时，我开始考虑如何编写参考文献和链接的问题。

我应该使用 [Zotero](!W)，一种流行的开源学术参考书目工具，具有 Web 浏览器集成功能？
我曾使用 Zotero 进行一些维基百科编辑，它为我节省了大量时间来生成（有时极其）复杂的 MediaWiki 标记，以便对书籍和网页进行“适当”的学术风格引用。
这在编辑包含许多文章但有一些核心参考文献的主题时特别有用，例如 _[Neon Genesis Evangelion](https://en.wikipedia.org/wiki/Neon_Genesis_Evangelion_%28TV%29)_ 相关页面。
但它给我的印象是相当复杂，并且是为 [Bib<span class="logotype-tex">T<sub>e</sub>X</span>](!W "BibTeX")/[CiteProc](!W) 和老式学术写作而设计的；在以多种样式格式化引文条目的细节上花费了大量的精力，每种样式“几乎”相同但又不完全相同。
很明显，除非您计划为学术期刊撰写大量 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 论文，否则这些不适合您。
他们认为基本单位是最重要的*引文*（在插入参考书目的无限微小的变体中），全文的存在考虑了读者的问题，而我认为基本单位是全文资源的*链接*（而“引文”只是一种不方便的方式来呈现有关全文链接的元数据^[并不是说我对阅读经典的“et-al”风格的内联引文的丑陋和困难感到兴奋我还记得当我第一次开始阅读学术论文而不是书籍时，我在处理页面上的大量姓名和日期时遇到了困难，这使得我很难回忆起特定的游行甚至应该被引用*为*......（最终习惯了它，并忘记了负担，这不是一个好的借口。）我的不喜欢会导致我的[下标符号](/subscript "‘Subscripts For Citations’, Gwern 2020")。]）。
同时，没有考虑“网络原生”材料，例如链接评论、单独的 PDF 页面或部分、补充材料、YouTube 视频或 Twitter 评论等社交媒体。
我发现这个无可救药地过时了，任何基于 Bib<span class="logotype-tex">T<sub>e</sub>X</span> 的系统可能会继续永远浪费我的时间，因为它适用于学术 PDF 而不是 HTML 论文。

我打算使用 Pandoc，它通过其 [`citeproc`](https://github.com/jgm/citeproc) 库集对 Bib<span class="logotype-tex">T<sub>e</sub>X</span> 提供内置支持。
那值得吗？
在使用 Pandoc 时，我没有过多研究 citeproc，但我*已经*注意到 citeproc 似乎触发了向 Pandoc 邮件列表发送最多数量的支持电子邮件 — 如此之多，以至于我编写了一个 Gmail 过滤器来删除它们。
如果我要使用 Bib<span class="logotype-tex">T<sub>e</sub>X</span>，也许我会使用 `citeproc`，但由于我对 Zotero/Bib<span class="logotype-tex">T<sub>e</sub>X</span> 的不满和对 `citeproc` 问题严重程度的担忧，我完全放弃了这个想法。

似乎没有其他选择特别有吸引力。
最诱人的是[org-mode](!W)，它很有趣，因为我已经使用了[Emacs](!W)，但看起来像是对“组织模式生活方式”的过多承诺，当我只是想写一些东西时，我不想陷入兔子洞。

因此，我没有沉迷于寻找“最佳参考书目”，而是开始使用最简单的参考书目工具进行写作：没有。只是超链接，谢谢。
如果问题值得解决，我会稍后解决；直到那时，“逐步自动化”。

## 工具提示

第一个“弹出系统”是对 HTML [tooltips](!W "Tooltip").

一段时间后，我注意到很难再次搜索我需要的参考文献：如果我在可见文本中明确包含标题/作者/日期，那很好（例如像 `["Title"](URL), Author Date`{.Markdown} 这样的东西很容易重新找到），但如果我只是以“标准超链接样式”内联编写它，则可能很难重新找到。
如果 URL 已被链接损坏，那么要想找到有效的链接，弄清楚它“是什么”可能会是一场考验！
（许多链接不会在 IA 中，即使是，也可能会花费很多时间。）

幸运的是，我不必将每个链接重写为正式的“参考书目”，也不必扭曲我的写作以在各处塞满标题。
HTML、Markdown 一直原生支持链接上的“标题”[attribute](!W "HTML attribute")，它与一切兼容，不需要 JS 等；这些非常熟悉，它们只是当您将鼠标悬停在链接上时弹出的小文本片段。
您已经见过一百万个，即使您无法告诉我它们的名称或解释它们与 [alt attribute](!W) 有何不同，或者除了 `<a>`{.HTML} 链接之外您还可以在哪里使用 `title=`{.HTML} 属性。
它们还有可读、简单的 Markdown 语法，只需在 URL 后面加上引号：`[text](URL "Title")`{.Markdown}。
这不需要对 Hakyll、Pandoc 或 Gwern.net 进行任何更改，而只需根据需要对 Markdown 源进行更改即可。

这解决了我的搜索和归档问题：我可以简单地输入标题，或者如果我喜欢，可以将标题放在单引号中并包含作者/日期。
（所以它会读取 `[text](URL "‘Title’, Author Date")`{.Markdown}。）^[有趣的是，在 2021 年，我会回去解析所有现有的工具提示以提取注释的元数据。它运作得相当好。]

我还发现它在阅读时很有帮助，因为我只需将鼠标悬停在链接上即可立即看到引文。
（这有助于避免密集超链接超媒体的经典失败模式[之前讨论过](#autopager)。）
因为我可以依赖工具提示，所以我可以删除更多大量的明确引用。

我使用它们越多，我就越想使用它们——工具提示长度限制取决于浏览器，但与标题+作者+日期相比通常非常慷慨，允许您使用数百或数千个字符。
通常，我只需要链接中的几句话，如果愿意的话，我可以打包整条推文，从而避免读者点击进入 Twitter 本身的不愉快（对于未登录的读者来说，这是一种越来越敌对的体验）。
为什么不...将它们放入工具提示中？
所以我做到了。

这导致了可以忍受的现状，但存在 3 个主要缺点：

#. HTML 工具提示在设计上非常简单。它们将显示纯文本 (UTF-8)，仅此而已。

    您不能为任何内容添加 HTML 标签，即使您想要斜体也是如此，因此书名的呈现方式与常规标题相同（如果您确实添加了 HTML 标签，它们将按字面呈现，如 `<em>Great Expectations</em>, Dickens 1861`{.HTML}）；你不能使用 CSS 来设置它们的样式；您无法与他们互动，例如复制引文；并且您绝对不能使工具提示内的任何链接可点击或具有“工具提示中的工具提示”。 （您可以使用 JS 修改它们，因为它们只是属性，但您对此无能为力。）

您*可以*向工具提示添加换行符，[根据标准](https://html.spec.whatwg.org/multipage/dom.html#the-title-attribute)（除了您应该避免使用它们之外，该标准并没有详细说明标题工具提示）...但该标准还警告说，它可能会适得其反，以及如何在不编写原始 HTML 的情况下稳健可靠地做到这一点？
#.没有移动支持！几乎所有工具提示都仅为鼠标悬停在链接上而定义。智能手机和平板电脑没有鼠标。所以...

据我所知，没有办法向移动用户呈现工具提示内容，而不涉及其他一些替代演示，这些替代演示将是工具提示的全面替代品。
#.最小指定的与浏览器相关的行为：必须将鼠标悬停在链接上多长时间才能弹出工具提示？工具提示将如何设计或布局？它会显示在链接附近还是状态栏中？尽管可以追溯到 1993 年（！），但是当谈到工具提示时，你并没有太多可以依赖的东西。
#. Tooltips是独立编写的，简单，但是多余。

我对工具提示条目进行了大量的复制粘贴，因为没有将工具提示与 URL 关联起来的机制。除了复制粘贴的麻烦之外，这还导致了一些小问题：Markdown 源代码变得更大，URL/工具提示会变得不一致，因为一个实例已修复但其他实例未修复，重复会悄悄出现...
#.临时标签、索引和列表：

    缺乏任何类型的可查询数据库意味着我越来越多地维护临时手册列表和“转储”页面——我会看到相关的 URL，并且必须编辑一篇文章来添加它，这样我就可以再次查找它。

我本来想做点什么，但我一直在拖延。
对于整个参考书目问题，仍然没有明确、简单的现有解决方案。

我可以看到我想要实施的解决方案......
我想要的解决方案是简单地创建一个 URL/元数据/摘录的集中数据库（可能只是一个文本文件），然后为每个 URL 生成一个页面，并弹出*那个*而不是文本工具提示。
它可能非常美丽，因为读者将鼠标悬停在每个引文上，立即看到相关摘录，根据需要单击全文链接，或者在弹出窗口中递归地弹出*另一个*链接。
这是一种我希望自己能够一直体验到的阅读体验——明显是正确的实现超文本的方式，与像[Project Xanadu](!W)这样笨拙的尝试相比，它们笨拙地使用了多栏。
我在写作中大量引用大段引用，是我希望让像我这样对某一主题着迷的人尽可能容易地获得相关文本的愿望，与拥有一个可读的页面之间的一个糟糕的妥协；在“语义缩放”的优先级中使用弹出窗口和折叠可以让我鱼与熊掌兼得。
（每当我实现一个简单版本作为论文的“带注释”摘录时，我会将关键部分摘录到一个大的块引用中，将每个引用超链接到工作全文 URL 并根据需要越狱它们，并使用工具提示技巧对其元数据进行编码，我总是发现最终的带注释版本非常有用 - 其他人会评论说它比通常的方法好得多。）

但我害怕它会耗费多少时间和精力。实现它需要远高于我水平的 JS/CSS，然后我可以用我的余生为它编写工具、调整它，并为我在 Gwern.net 上已有的数万个链接手动编写注释。
所以我试图忽略诱惑。

## WP 弹出窗口

同时，['浮动脚注'](https://ignorethecode.net/blog/2010/04/20/footnotes/)的成功使用提醒我使用[“卢平的工具”](https://en.wikipedia.org/wiki/Wikipedia:Tools/Navigation_popups) ~2005年编辑/浏览维基百科是多么美好：将鼠标悬停在维基链接上会弹出链接文章的预览和一套编辑工具。

![我已经 14 年没有使用或看过 Lupin 工具的屏幕截图了，但是将它与 Gwern.net 弹出窗口进行比较显示了趋同演化（包括 [recursion](/doc/design/2014-01-23-quiddity-wppopups-lupinstooltour-catarticleexamplepopup-recursive.png)）.](/doc/design/2014-01-23-quiddity-wppopups-lupinstooltour-catarticleexamplepopup.png)

卢平的工具反过来又激发了许多变体。
例如，维基百科默认为注销用户提供一个极其简化的['预览'](https://www.mediawiki.org/wiki/Page_Previews)弹出窗口，其中只显示介绍性段落和缩略图；简介中的链接甚至无法点击。
这是由特定的 API 端点提供支持，该端点提供了一个方便的简化 HTML 片段，其中包含标题/作者/摘要，因此弹出窗口只不过是创建一个空框，调用 API，并使用一些适当的布局在该框内呈现 HTML。

<!-- patch: 69fa063e9f7afcb6c023dbc7c6019e4063878ea2 -->

当 Said Achmiz 开始在 Gwern.net 上工作时，他最初关注的是外观和基本功能，但最终将注意力转向了浮动脚注。
为什么不开始概括这一点呢？
2019 年 7 月，他实现了 [`wikipedia-popups.js`](/static/js/old/wikipedia-popups.js "‘<code>wikipedia-popups.js</code>’, Achmiz 2019") 的第一个版本，其操作方式类似于简化的 WP 弹出窗口：将每个链接挂钩到维基百科^[有一些实现不会挂钩链接来按需加载片段，而是在页面加载时对每个链接进行 API 调用。我们发现这作为性能优化是完全没有必要的，因为 WP API 通常会在大约 50 毫秒内返回片段（而您通常需要 > 500 毫秒的 UI 延迟，以避免读者只是移动鼠标时出现虚假弹出窗口），并且每个页面加载可能会浪费数百次 API 调用——在维基链接特别多的 Gwern.net 页面上，API 结果可能占整个页面的很大一部分！因此，如果您自己制作 WP 弹出窗口，请不要这样做。]，并在悬停时动态创建一个框并用 WP API 结果填充它。

我们喜欢这个结果，即使它们不如原始 Lupin 的工具。^[为什么不使用*那个*？登录用户预览，Lupin 的页面导航弹出工具（[当前版本](https://phabricator.wikimedia.org/project/profile/2055/)），*确实*包含内联链接。但仔细检查[其来源](https://en.wikipedia.org/wiki/MediaWiki:Gadget-popups.js)表明没有秘密API返回正确的HTML。相反，它下载页面的整个 MediaWiki 源代码，并通过 [JS 库](https://github.com/cscott/instaview) 自行将其编译为 HTML！后来我尝试使用 Pandoc 进行编译，对于简单的文章来说这已经足够好了，但是对于任何大量使用模板（其中很多，特别是 STEM 模板）的文章来说，它会严重失败，并且手动替换或替换无法跟上 WP 模板的无限长尾。]

## 内嵌弹出窗口

<!-- patch: 696a234cf42d53825114c632f0bd1f43b080fa07 -->

WP 弹出窗口足够好，我们希望将其扩展到其他地方的标题/作者/日期/摘要片段； Arxiv 是一个特殊的目标，因为我链接了很多 Arxiv（和 BioRxiv）论文，Arxiv 登陆页面已经提供了比弹出窗口更多的功能，而且我知道它有一个带有 R/Haskell 库的 API，这应该会让抓取变得容易。
最重要的想法是，我会编写插件来为所有来源生成注释，这使得这变得相当简单，然后为重要链接手动编写注释，然后最终使用机器学习来完成其余的工作。^[神经网络摘要器已经变得很好，GPT-2 已于 2019 年 2 月问世，并表明它已经自己学会了摘要（有趣的是，当 Reddit `tl;dr:` 提示时），虽然我还没有完全参与 [缩放假设](/scaling-hypothesis)，我非常确定神经网络摘要在接下来的十年中将会变得*很多*更好。但我不想等十年才开始使用弹出窗口，而且我似乎需要自己的语料库来微调我的注释的摘要器。所以我不妨开始吧。]

但如何呢？我想要一个实现是：

#.轻松集成到 Hakyll 中，特别是作为 Pandoc 编译器阶段，可以单独、隔离地处理每个链接，无需任何全局状态。我现在已经熟悉了在 Pandoc 遍历中重写文档，而修改 Hakyll 每年都变得越来越困难——我从来没有很好地理解它的架构或类型，而且我已经忘记了我所拥有的东西。
#.静态，即没有服务器端状态或支持，因此没有像 WP 版本那样的数据库或 API 调用。
#.独立且不受链接腐烂影响，从某种意义上说，100 年后拥有档案副本的人只需一点点努力就可以使其工作。

我一直不愿意转向弹出窗口的原因之一是它会产生 linkrot：Gwern.net 页面不再是所见即所得的，因为它现在依赖于可能不再存在的“外部”资产。如果我全力以赴地使用弹出窗口和注释，并开始在脑海中考虑它们，故意将更多材料推入弹出窗口，并依赖标签、交叉引用和反向链接，那么可见页面将越来越仅仅是预期阅读体验的外壳——难以或不可能存档。 （这就是过去先进的超媒体系统往往影响不大并被遗忘的原因之一：一旦它们被比特腐烂或源代码丢失，就不再有任何有意义的版本可供查看。同时，普通论文可以像在 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 中一样轻松地被凿成石头，几乎没有损失，从未有过太多损失。）
#.启用未来的功能：特别是递归弹出窗口。

这些要求将被证明是矛盾的，特别是#3和#4：递归弹出窗口和自包含页面的基本问题是，如果注释完全相互链接，那么每个页面很快就需要在几乎所有注释的传递闭包中进行链接；如果它们“不”相互关联或者相互关联很弱以至于只能引入一些其他注释，那么该功能就毫无用处。
我们最终会放弃“独立”的财产，并接受 Gwern.net 不会完美存档。

第一个实现进一步采用了工具提示的逻辑：不只使用 `title`{.HTML} 属性（以及一些类似于将 JSON 对象序列化到其中的 hack），而是使用更多属性。
HTML 允许您定义自定义属性，该属性将以 `data-`{.HTML} 开头并存储您需要的任何字符串。
因此，弹出窗口 JS 可以泛化为从每个链接读取属性 `data-popup-title`{.HTML}/`-popup-author`{.HTML}/`-popup-date`{.HTML}/`-popup-doi`{.HTML}/`-popup-abstract`{.HTML} 并将其弹出。

编译时实现很简单：一个静态只读数据库（为了方便起见，一个 Haskell 文件，然后 [YAML](!W) 因为更容易手动编辑复杂的 HTML）被传递到链接重写阶段，它只是检查链接的 URL 是否在数据库中，如果是，则将字段添加到其中。
对早期链接重写阶段的简单改编，如跨维基/膨胀代码、纯/幂等、易于扩展以在遇到未知链接时创建注释或插入比 Arxiv/BioRxiv 更多的源。

我很快就会插入模块来从 Pubmed、PLOS、通过 Crossref 的任意 DOI 中提取摘要，以及对实时网页/PDF 进行屏幕截图的回退（[由于质量低而最终删除](#link-screenshot-previews)），并且 Said 将添加新功能，例如在新框架内弹出 PDF 和 YouTube 视频及其他网站以及本地托管源代码文件的语法突出显示版本，以及弹出同一页面的任意区域/ID（例如，来自目录），这允许脚注也会在*相反*方向弹出。
如果您可以弹出当前页面的任意区域，为什么不能弹出另一个页面上的任意区域？如果你可以弹出这些，为什么不弹出整个页面，从摘要开始......？
（这将是引导我们走向“超越一切！”作为策略的重要方向。）

当然，这有一些缺点：每个链接实例都是独立的，无论是跨站点还是在同一页面内，因此存在重复。 （我认为我们测量到 HTML 的初始大小增加了约 10%。）

但它成功了！我很高兴在[新闻通讯问题](/newsletter/2019/07 "‘July 2019 News’, Gwern 2019")中注释链接并看到它Just Work™。
将鼠标悬停在链接上即可获取摘要*与我想象的一样好。

到 2020 年初，我们已将旧的 WP 弹出窗口合并到新的弹出窗口中。
除此之外，我们更专注于完善和调试弹出式 UI，添加屏幕截图和图像预览，直观地集成 [本地档案](#preemptive-2)，以及创建黑暗模式（整个奥德赛本身）。

（大约在这个时候，我们还将尝试“轻量级”注释的想法，它会弹出一些文本，但没有关联的 URL，以 [definitions](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dfn) 为模型，并与 `LinkAuto.hs` 重叠。这个想法是，它在视觉上不那么突兀，并且可以定义所有技术词汇。
这没有任何进展：事实证明，任何需要定义的东西都可以通过超链接来实现。）

### 内联 WP

WP 弹出窗口如何合并？简单：我只是在编译时调用 API 并存储结果。
从设计上来说，它们几乎是一样的。

除了组合代码库和泛化之外，这还有一个性能优势：我可以托管并有损地优化 WP 缩略图，从而避免缩略图加载造成的延迟。
（虽然片段可能会在 <50 毫秒内下载并渲染，但图像需要更长的时间。）

当然，这意味着更多的链接将获得内联注释......

### 链接 ID 启用反向链接

由于内联注释的重复，我很早就想呈现每个页面唯一的链接。
一种方法是在每个链接上放置一个“ID”，正如它听起来的那样：一个唯一标识符，这也是您每次链接像 [`/foo#bar`](https://en.wikipedia.org/wiki/HTML_element#Anchor) 这样的 URL 时使用的内容（页面中的某处有一个 `id="bar"`{.HTML}，可以方便地知道您是否需要链接页面的特定部分，而且作者没有提供任何方便的“永久链接”功能）。
如果同一 ID 存在多个实例，则这是一个 HTML 错误。

作为注释重写过程的一部分，这很容易做到，更有用的是，我可以使 ID 采用 `surname-2020` 的形式，因为现在我可以从注释中获得作者姓名和日期。
这使得在页面中其他任何地方引用引文变得很容易：如果我讨论了一篇论文“Smith 2020”，那么我知道我可以稍后像 `see [Smith 2020](#smith-2020) previously discussed` 一样引用它，现在该链接既可以使用，也可以与之前的讨论一起弹出。

这是一个次要功能，但更重要的是，这是您在 HTML 中实现*真正的反向链接*所需要的。
大多数 wiki，比如 MediaWiki，都注重反向链接：维基百科会告诉你“这里有什么链接”，但它不会告诉你这些页面“这里有什么链接”。
链接只是汤的一部分，没有名字。你不能参考它。
即使你寻找它，它也可能不是唯一的。
（您可以任意分配 ID，也许作为 URL 转换，但这不太好：如果 URL 发生变化，就会不稳定，而且作者很难查找参考，这与我的助记符相反。）

但是，一旦所有链接都具有一致的 ID，并且每个页面都是唯一的（多次链接时手动给出不同的 ID），那么您就可以进行真正的反向链接。
由于弹出窗口会弹出调用者的区域，就像脚注一样，因此您可以双向浏览每个页面：您可以简单地弹出上下文并查看为什么当前页面 A 链接到其他页面 B 中。
（这比维基百科的“这里有什么链接”有用得多，维基百科只是给你一个巨大的不透明列表。）

此时我根本没有考虑反向链接，所以这是一次愉快的意外。

### 递归内联

<!-- 597cdaebf32e83eb614f74368dc07f73485849ad -->

一直以来，弹出窗口都存在一个巨大的缺陷：它们越来越丰富地相互关联和注释......
这对读者来说毫无用处，因为它们只能弹出 1 级。如果 Arxiv 弹出窗口链接了十几篇其他论文，那就太糟糕了。如果您想了解它们的内容，则必须在选项卡中将它们全部打开。

这很令人沮丧。
但是，如果弹出窗口只是本地存储在链接本身中，那么弹出窗口如何“知道”如何弹出另一个链接？
它是“调用 API”还是什么？
这是否需要彻底重新思考和重写？

正确的选择是“是”（这就是为什么大多数弹出窗口的网站不尝试递归弹出窗口的部分原因）。
我选择了“不”的强烈拒绝，因为我有一种反常的认识，如果我可以将一段带有链接的 HTML 内联到一个链接中，那么我就可以*递归地*内联。
就代码而言，它只是更多的字符串。
我会重复运行该过程，直到 HTML 停止变化（实际上是 3 倍）。那时，所有链接及其链接等都将被内联。
这也需要对 JS 前端进行相对较少的更改。

这有效。当然，HTML 变大了……有时会变大很多，翻倍甚至更多，有些页面达到 10MB。您不想太仔细地查看 HTML 源代码，以免看到五元组转义的 HTML 会破坏您的理智。
但如果你没有调查过香肠工厂，递归弹出窗口就是稀有设备的奇迹！
我会阅读我的注释只是为了有借口弹出更多内容。
（Said 向弹出窗口添加了允许移动、“固定”、调整大小、全屏、平铺以及通过键绑定控制的功能，这有点过分了；到最后，它大致具有 Windows 95 的窗口管理功能。）

（递归内联仅适用于常规注释，而不适用于维基百科注释——因为 WP 注释不包含任何链接，回想一下，因为它们只是一个简化的介绍段落。）

## 链接参考书目

<!-- 2Fatboy3d5d54420354fd0bc2b7ecb0c1a9a d38d5c4871ac4af25af5cf1f7dae5c89454db1fe -->

我并没有完全否认尺寸问题。
10MB HTML 的页面加载和渲染速度明显很慢。
我已经把它当作小事了——如今浏览器已经高度优化，你总是加载 10MB 的图像，对吧，这也不算太糟糕。
不幸的是，HTML 和图像之间的比较是错误的：图像数据简单且统一，而处理 HTML，甚至是因为它​​是字符串属性而什么也不做的 HTML，相比之下是非常昂贵的。
浏览器，尤其是移动浏览器，在 Gwern.net 页面上出现卡顿现象，而且问题只会变得更糟。
大约在这个时候，Said 开始为注释实现适当的移动支持，采用“popin”方法（后来转换为“popovers”）；移动读者意味着桌面上的糟糕性能问题在移动设备上也会很严重，我在 Google Analytics 中注意到，移动读者现在已经占了读者的一半（从屏幕截图来看，似乎包括几乎所有我的 Twitter 读者——他们特别喜欢时髦的新深色模式）。

到 2020 年 12 月，我提出了对递归内联的改进，类似于迭代或自下而上的[动态编程](https://en.wikipedia.org/wiki/Dynamic_programming)（如果有帮助的话），我称之为**链接参考书目**，因为它本质上创建了页面中所有带注释的链接的一个大参考书目部分，将它们列出一次且仅一次。

第一次重写是合并页面内的链接。
大量的膨胀来自于多次内联相同的注释，有时是在同一基本链接的多个级别上。
相反，链接的传递闭包将按页面收集，生成一个唯一的“平面”注释列表，附加到页面末尾，然后递归弹出窗口将根据需要简单地获取每个注释。
这对于两个相互链接的注释来说是没有问题的：弹出窗口 JS 会简单地在从链接参考书目复制的条目之间来回循环。
这也意味着不存在组合爆炸，因此我可以取消深度限制。

这大大减少了尺寸。
它还有一个有趣的设计好处（另一个令人高兴的意外）：如果注释按其原始顺序在页面末尾进行整理（但已删除重复），那么就构成了有趣类别页面的“参考书目”——自动*注释参考书目*。
（书籍有时包含带注释的参考书目，这种方法既罕见又有用。）
您可以作为一个小组阅读注释。
我发现这很有用，并且是查看文档的好方法；我还喜欢它的存档方面：这意味着您可以存档或打印页面，现在您拥有它的完整快照。
我提出了“链接参考书目”作为性能优化，但发现它是一种有价值的注释设计模式。

### 单独的链接参考书目

处理性能问题的一种方法是撒谎，并通过移动它们来隐藏它们。
就像程序“打开”但实际上在接下来的 10 秒内无法执行任何操作。

在这种情况下，我们通过将大块 HTML（链接参考书目）移动到单独的 URL/页面（可能是延迟加载的）来撒谎。
现在页面加载速度一如既往地快！
当然，当您将鼠标悬停在带注释的链接上或将其弹出时，您可能需要等待......
但至少后续注释会很快？

## 独立注释复合体

<!-- ac3e4a26d347bb98c2932c5cd8121a5d30459aff ec325d0afe562aa01cf631b9e17e760bfd493a2f 83f1dd612bf448faac8de4f4388fbc6715c2bf44 -->

链接参考书目方法的成功和完全递归 WP 注释的失败表明，唯一可行的策略是单独存储每个注释。
也就是说，我们需要硬着头皮拥有一个包含每个注释 HTML 片段的大目录，然后 JS 就加载它。
好消息是这些都可以在编译时生成，因此不需要 API 或服务器端更改。
链接后参考书目并结合其现有的嵌入功能，JS 现在支持完成这项工作所需的大部分功能。

一旦链接参考书目被拆分出来，JS 就可以从“在 `/doc/link-bibliography/page.html` 中查找并显示注释 ID XYZ”交换为“在 `/metadata/annotation/XYZ.html` 中查找并显示注释 ID XYZ”。

我们于 2021 年 1 月完成了过渡，并松了一口气：**弹出窗口已完成**。
这是可扩展的、完全递归的，并且可以支持我们想要的所有功能。

代价是页面不再是独立的，但是链接参考书目向我展示了如何在道德上恢复这一点：链接参考书目以及链接参考书目中的每个注释的延迟加载，然后延迟加载*他们的*链接参考书目，等等_ad infinitum_。
事实上，完全递归比内联或链接书目方法能够实现更多的递归；我快速为标签目录添加了弹出窗口，刮掉了 Gwern.net 摘要作为优化^[虽然在链接时弹出其他 Gwern.net 页面非常优雅且简单，但这也遇到了与链接参考书目相同的性能问题：需要解析和渲染大量的 HTML，尤其是当读者期望弹出窗口弹出并渲染时没有明显的延迟时——在最极端的情况下，例如 GPT-3 页面，毫无戒心的读者可能会在弹出窗口最终显示任何内容之前等待 10--15 秒！]，当我重建链接参考书目功能并构建反向链接和类似链接功能时，除了另一个可以弹出的链接之外，它们还需要什么呢？

### 影子 DOM

根据计算方式，弹出窗口的最终重新实现可能是 Said 重写弹出窗口渲染系统以使用 [shadow DOM](!W) 来“离屏”组装弹出窗口，因此当悬停超时结束时，将读取弹出窗口进行渲染并因此几乎立即显示。

这避免了弹出窗口中包含缩略图的问题：虽然注释的 HTML 可在 50 毫秒内立即有效下载，并且渲染速度也差不多，但*图像*有时仍需要一段时间才能下载和渲染（由于不可预测的尾部延迟原因，因此提高平均响应时间并不能解决问题），从而打破静态页面的错觉，并向读者揭示弹出窗口是脆弱且动态的。
但是，通过完全优化的弹出窗口，弹出窗口会“自动”运行，并且看起来就像 Just Work™ 一样。

### 动态 WP（再次）

单独的片段解决了最直接的问题，因此在 2021 年 2 月左右，我开始解决 WP 弹出窗口不递归的主要问题。
我发现了一个不同的 API，它可以为 MediaWiki 提供仍在其中的链接，我可以通过 Pandoc 来获取干净的 HTML，然后我可以对其进行递归。
这次失败有两个原因。

事实证明转储 HTML...具有挑战性。
将复杂的特殊 WP/MediaWiki HTML 清理成可以插入弹出窗口的内容是非常困难的。
我会通过 Pandoc（与巴洛克英语维基百科源相比，它理解 MediaWiki 的有限子集，并且缺乏对大多数关键模板的了解）传递它，运行大量的正则表达式和重写，然后发现另一个问题。

<!-- 23c1efdc6483cd429109cbc63c978a2b5101b200 -->

在阅读了大量 MediaWiki 和 WMF API 文档之后，我发现还有第三个 *mobile* API，它逐节提供整个页面。
这反过来又可以缩小到我所需要的，即简化但仍然可用的 HTML 中的“介绍”（例如 `https://en.wikipedia.org/api/rest_v1/page/mobile-sections-lead/Dog`）。

也许我可以设置足够的规则来足够干净的 HTML，但更致命的是，我低估了 WP 维基链接的力量：经过大约一周的抓取和大约 100MB 的注释后，我承认 WP 文章是如此相互关联，即使使用“平面注释”并且只看简介，完全递归的 WP 文章也是不可能的。
我废弃了本地 WP 注释和缩略图（考虑到动态级别，我无法将它们全部缓存），并且 WP 弹出窗口恢复为动态方法，作为 JS 中的特例，而不是另一个插件。
编译时发生的主要事情是决定是否可以弹出维基百科链接，这很重要。[^Wikipedia-namespaces]

[^Wikipedia-namespaces]：有人可能会认为这很容易：维基百科文章肯定只是每个以 `https://en.wikipedia.org/wiki/` 开头的 URL，从而排除 API/基础设施页面？

    不幸的是，事实并非如此。 WP 在 `/wiki/Foo:` 下进一步命名空间页面——注意冒号，这意味着 `/wiki/Image:XYZ` 与 `/wiki/Image_XYZ` 完全不同——并且每个命名空间都有不同的行为，无论它们是否有介绍或是否可以是框架内的实时链接。例如，必须小心处理页面标题中的所有特殊字符，如 `C++` 或 _Aaahh！！！ Real Monsters_，请记住，“Bouba/kikieffect”之类的标题只是名称中的斜杠，而不是“Bouba”目录中名为“kikieffect”的页面； `Wikipedia:` 命名空间内的页面可以像普通文章一样进行注释和实时显示； `Category:` 不能注释，但可以实时； `Special:` 页面两者都不能。

    我必须在 [`Interwiki.hs`](/static/build/Interwiki.hs) 中设置一个测试套件才能最终使所有排列正确。

事实证明，Said 使用新发现的移动 API 并为 WP 条目创建高度定制的 UI（可以逐节递归或嵌入）要容易得多。
（这取决于你如何计算，这是 WP 弹出窗口的第五或第六个版本，它很像 2019 年的第一个版本——“时间是一个扁平的圆”。）
从质量角度来看，它是迄今为止最高的，并且像独立的弹出窗口一样，看起来它是最终的迭代。

### 包含

弹出窗口的逻辑进一步让我们强调[**嵌入**](!W)：如果您可以从静态 URL 加载 HTML 片段以插入到弹出窗口中，那么您离将它们加载到文章中也不远了，这允许您将不同的 HTML 片段拼接到一个页面中。
（这些片段可以是整个页面、页面的一部分、任意范围的 ID，甚至是 URL 的*注释*。）

通过将内联从编译时转移到运行时，这可以替代许多似乎需要内联或动态调用 API 的东西，并允许跨页面共享、“无限”页面（例如带有维基百科条目的完全递归链接参考书目）、由于片段的冗余编译/内联较少而加快站点编译速度，并简化 JS。
嵌入将网站设计从仓鼠轮式的定制 JS 修改模板（需要不断更新）转变为简单地写下嵌入链接并在编译时生成相应的 HTML 片段；例如，要添加链接参考书目、反向链接和类似链接，我只需将两个嵌入链接附加到弹出窗口和页面，并且 JS 根本不需要更改。

此外，它通过尽可能推迟来实现快速编译和渲染：标签和链接参考书目曾经是巨大的页面，很难正确编译，因为它们需要在编译时以与“真实”注释 HTML 片段不同的方式内联所有注释，导致编译稍有不同时出现错误，并导致标签/链接使用数量线性减慢（每次将标签添加到 URL 时，这意味着必须编译另一个实例）；通过嵌入，这些页面只是变成了简短的链接列表，这些链接是惰性嵌入的，因此它们既可以快速编译，也可以快速加载到浏览器中。

（*确实*需要仔细地实现这一点，并具有良好的性能和积极的预加载，否则只会重现“Web 2.0”网站的悲惨体验，速度缓慢[无限滚动](https://en.wikipedia.org/wiki/Scrolling#Infinite_scrolling)和不断的布局变化——Twitter 是一个特别的罪犯。）

有了这个最终版本，我觉得我已经拥有了以读者友好的方式对我的作品进行切片和切块所需的大部分内容，这避免了过去的超媒体系统创建“一个由曲折的小链接组成的迷宫，所有这些都相似”的错误，或者拥有一个重量级的用户界面，它会阻碍你试图阅读的文本。

# `srcset` 移动优化

<div class="abstract">
> `srcset` 图像优化尝试为只能显示小图像的设备提供小图像，以加快加载速度并节省带宽。
>
> 3年后，事实证明它的浏览器实现非常糟糕且不一致，以至于毫无用处，当它再次损坏时我不得不将其删除。
>
> 我不建议使用 `srcset`，并且绝对不是没有测试回归的方法。如果您尝试优化图像大小，最好使用一些服务器端或基于 JS 的解决方案。
</div>

## 背景

移动浏览器上图像的“标准”HTML 优化是提供比原始图像更小的图像。
向高 800 像素的智能手机提供 1600 像素的大图像是没有意义的，更不用说宽了。
适当调整大小的图像可以是原始大小的十分之一或更小，从而减少昂贵的移动带宽使用并加快页面加载时间。

## 实现 `srcset`

这可以由服务器通过监听浏览器（这是一些 CDN 提供的服务）来完成，但执行此操作的“官方”方法涉及对普通 `<img>` 标记的奇怪扩展，称为 [`srcset`](https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset) 属性。
此属性并不像人们可能期望的那样简单地指定替代的较小图像，而是在伪 CSS 中编码*多个* [特定于领域的语言](!W)，用于指定许多图像和各种属性，这些属性应该确定在[响应式设计](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images)中选择哪个图像。
从理论上讲，这可以让人们进行许多图像优化，例如不仅基于宽度或高度，还基于例如提供不同的图像。屏幕的像素密度，或为了“艺术指导”艺术目的而裁剪/取消裁剪或旋转图像等。

[我在 2020 年 5 月开始做这个](https://groups.google.com/g/hakyll/c/aFH9LHKyDZ8/m/-zY0SHdUBAAJ)，因为这是一个自然的优化，特别是对于 StyleGAN 文章（这些文章大量生成图像样本，并且对移动浏览器的加载尤其不利）......却发现：**`srcset` 在浏览器中被破坏了**。

## 浏览器支持问题

据推测，它已经完全标准化并且[多年来受到所有主要浏览器](https://caniuse.com/srcset)的支持，但是，每当我尝试一个片段[来自](https://web.dev/articles/use-srcset-to-automatically-choose-the-right-image) [a](https://ericportis.com/posts/2014/srcset-sizes/) [教程](https://medium.com/hceverything/applying-srcset-choosing-the-right-sizes-for-responsive-images-at-different-breakpoints-a0433450a4a3) [在](https://html.com/attributes/img-srcset/) MDN或其他地方——它不起作用。
没有什么可以像文档和教程所说的那样工作。
我会适当地指定一个图像，在 HTML 中适当地渲染它，然后观察开发工具的“网络”选项卡显示它被浏览器忽略了，而且无论如何还是下载了原始图像。
经过多次抖动和戳戳后，我得到了一个有效的调用，因为它下载了移动模拟器中的小图像，以及桌面模式下的原始图像。[^srcset-example]

[^srcset-example]：例如。

    ~~~{.XML}
    <img srcset="/doc/ai/nn/transformer/gpt/fiction/2021-07-08-gwern-meme-tuxedowinniethepooh-gpt3promptingwithwritingquality.jpg 768w,
        /doc/ai/nn/transformer/gpt/fiction/2021-07-08-gwern-meme-tuxedowinniethepooh-gpt3promptingwithwritingquality.jpg 994w"
        />
    ~~~

这是不完美的，因为它没有与弹出窗口或 [`image-focus.js`](/static/js/image-focus.js) 完全集成（如果您“专注”在图像上以缩放全屏，它会保持很小）。

后端也没有太多乐趣。
“CS 中只有两个难题，命名和缓存失效”，而存储所有图像的小版本则需要这两个问题。
生成然后避免小版本会导致长期存在的问题，特别是当我开始移动图像以真正组织它们而不是出于懒惰而将其转储到未分类的大型目录中时。

## 无法修复

而且它反复破裂。 2023 年 4 月，Achmiz 正在审查如何修复 `image-focus.js` 错误，并注意到严格来说，没有什么需要修复的，因为它“正在”放大到原始图像——首先加载了原始图像。
`srcset` 在某个时刻完全停止工作。
除了检测此类回归的困难之外，最大的问题是 `srcset` 根本没有改变。
浏览器（再次）。

Achmiz 调查了修复 `srcset` 并发现了我所拥有的：这些实现都出乎意料地被破坏了并且违反了文档——他说即使是 MDN 教程也被破坏了并且没有按照它所说的那样做（现在），并且表现出奇怪的行为，例如在移动模拟器模式下加载原始文件，然后在 *desktop* 模式下加载小文件，在“插槽”更改时更改（直接违反规范），或者（错误地）下载和显示原始图像，但通过 JavaScript 查询时会对调用者撒谎并声称这是正确的小图像！
这些是如何实现的，以及如何正确使用它？ （*有人*有人正确使用它吗？）
生命是一个苦涩的谜。

## 结论

因此，它不起作用，已经有一段时间不起作用了，除了试错之外，还不清楚如何让它再次起作用，因为文档和浏览器实现都是谎言，如果我们以某种方式弄清楚当前产生的正确行为是什么咒语，那么可能会在一两年内再次无声地失败（而且我们没有简单的方法来注意到），并且没有任何迹象表明这一切都会得到修复，因为根据寻求帮助的人判断，一般错误已经持续了五年多在 Stack Overflow 和其他地方。^[我会愤世嫉俗地猜测 `srcset` 是由 FANG 以半生不熟的方式为他们的移动网站推送的，从那以后就被忽视了（部分原因是它默默地失败了），而且他们只关心调试他们的用例。]
这是一个复杂而脆弱的功能，没有带来任何实际好处。

我决定公平地尝试一下，然后把它撕掉了。
不幸的是，带宽使用量的增加是不幸的，但是使用延迟加载图像（通过 `loading="lazy"` 属性）似乎已经消除了大多数读者可见的下载问题，并且无论如何，考虑到优化已在未知的时间内被破坏，他们一开始就没有受益。

## 后记：手册 `srcset`

我担心的一个性能情况是优化弹出窗口中的缩略图，使它们没有明显的滞后并显示为“即时”，可以在注释后端代码中作为特殊情况进行处理，而不是默认尝试 `srcset` Gwern.net 上的所有图像。
（如果我需要更多，Achmiz 可以执行 JS 传递，动态检测屏幕尺寸并重写 `<img src="foo">` 路径以指向小版本，这样小版本就会被延迟加载。）

我们于 2024 年 7 月实现了这一点：所有图像都有一个相应的 256px 宽度版本存储在 `/metadata/thumbnail/256px/` 中，并且弹出窗口 JS 知道重写弹出窗口中的图像以使用这些图像。
简单、可靠、实用——不同于所谓的“标准”。

# 采访

<div id="interview" class="abstract-collapse">
> 网站格式的一个特别令人不满意的领域是“采访”（以及一般的圆桌会议或小组讨论）。
> 没有一种公认的采访格式可以以易于编写的方式处理采访，清晰地描述主题和演讲者转换，以及漂亮的排版：使用段落、表格、定义列表和无序列表的方法都有缺陷。
>
> 在使用段落分隔扬声器的传统格式并多年来尝试各种替代方案之后，我们放弃了它，转而采用自定义方法。
>
> 访谈现在采用两级主题列表，然后嵌套在其中发言者陈述；这些双列表由 JS 解析，以正确设置扬声器样式，并使用 CSS 创建 3 列布局，可以以最小的混乱垂直阅读。
</div>

采访很难风格化，因为它们具有强烈的来回语义结构，但长度和内容不规则，这并不自然地适合标准的印刷结构。
人们希望利用各个发言者来回讨论主题的清晰语义，以标准化其外观并使阅读它们更容易，但它们不适合标准 Markdown-HTML 工具包：它们不是有序或无序列表，它们不是块引用，它们不是（只是）段落，它们可以拆分为多个部分，但通常不处于问题级别的粒度，它们不是表格......
他们有发言者，但陈述可以是多个段落，并包含其他块元素，如块引用（例如准备好的讲座或公共阅读中的引用），因此块级转换不定义发言者级转换。
发言者经常发言多次，甚至数十次，因此发言者标签可能会变得重复。
他们（通常）有问题，也有答案——通常但并非总是如此，有时甚至不止一个，因为多个人可能会回答一个问题或开始来回争论。

理想情况下，我想要一份采访的演示文稿

- **语义上**：

- 尊重自然的来回，将每个话语紧密联系在一起，其中可能有超过标准的“Q/A”对，
    - 按主题对它们进行分组时，
    - 清楚地指定说话者的转换，
- **印刷上**：

- 视觉上不会因冗余而混乱，
    - 在整齐的列中垂直对齐文本
- **技术上**：

    - 相当原生于 Markdown，并且可以由健忘的作者（我自己）编写，无需查阅手册，并且不需要重量级语义 Web/XML 风格的符号（例如使用唯一 ID 等标记每个演讲者标签和段落），并且
    - 编译为合理的本机 HTML，可在移动设备等上进行机器解析和回流。

是否有任何现有的采访排版/设计写作可供我们借鉴？
看起来并不多。
我不记得我读过的书中有任何讨论，比如 Rutter、Butterick 或 Bringhurst，CTAN 没有任何帮助（只有 [表演脚本](https://ctan.org/topic/drama-script)），大多数具有有趣采访布局的杂志更注重新颖性和图形设计，而文本是事后的想法（通常只是带有粗体问题的单独段落）。

一旦你开始在互联网上查看面试格式，你就会发现有很多方法，但它们都很糟糕：

#. **交替强调段落**：这可能是最常见和基本的方法。只需写下所说的每个段落，并将面试官的问题或评论放在非罗马文本中（如果可能的话用粗体，否则用斜体^[我还尝试将演讲者标签设置为等宽（`code`）格式。这使它们在一般使用粗体和斜体的情况下更好地脱颖而出，但具有令人困惑的含义，并导致另一个字体负载。]）。

    ~~~{.Markdown}
    **It has been alleged you huff kittens. Any comment?**

    Outrageous libel, for which I will be suing the parties responsible
    in a court of law in Trenton, New Jersey.

    **Duly noted.**
    ~~~

    *优点*：只需将 `<p>` 与一些 `<strong>` 交替使用：它将在整个 Web 存在的任何地方工作，并且编写起来很轻量级 - 几乎没有任何方法比简单地键入一些星号（如 `**foo bar**`）更容易地在文本中编码每个文本的说话者标签。它不会因为大量名字而使文本变得混乱，而且它还可以自然地处理多段落陈述：如果是面试官，则所有内容都以粗体显示，否则，什么都不做。这种方式非常简单，甚至连那些试图变得更加复杂的网络出版物（例如《纽约时报》或《纽约客》）也倾向于使用。

    *缺点*：缺点是简单到头脑简单。对于简短的两人问答来说，这很好，但对于更复杂的讨论，它开始无法充分处理材料。整体效果就是“一件接着一件”，根本没法按主题浏览。当您添加更多元数据时，缺乏更结构化的格式开始适得其反：您最终会出现大段粗体的情况（这并不像斜体那么糟糕，斜体会使它们难以阅读，并且在讨论虚构作品时尤其令人困惑，但仍然不是粗体的用途）；对于两个以上的人来说，它会变得令人困惑，因为必须插入发言者的标签（这会根据推动文本的名称引入移动列对齐方式）。粗体假设您已经抑制了名称，因此如果必须重新引入名称，那么它就会成为一个缺点，因为现在名称会被塞到语句中（因为它从隐式 `**Question?**` 变为显式 `**Name: Question?**`）。您可以将其扩展以将演讲者标签放在单独的行/段落上，但这会浪费大量垂直空间：

    ~~~{.Markdown}
    **Interviewer**:

    It is further alleged that you trade in bonsai kittens in violation of CITES.

    **Interviewee**:

    No comment.
    ~~~

    不太好：最多应该是 2 行，但扩展到 7 行。 （将扬声器标签居中并去除冒号有一点帮助，但这是猪身上的口红。）

所以，这是一个合理的解决方案，特别是当材料简单或作者的便利性非常重要时，但肯定可以做得更好吗？
#. [**Table**](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)：表格可以用列对问答进行编码，每个发言者一个，或者进行几乎任意更复杂的布局。

    *优点*：表格节省空间且本质上对齐（否则很难！），列标题清晰有效地对发言者进行编码；它们是标准的 HTML。一些布局变化：

    ~~~{.Markdown}
    ------------------------------------------|
    | **Interviewer**     | **Famous Person** |
    |---------------------|-------------------|
    | Shaken, or stirred? | Shaken.           |
    -------------------------------------------
    ~~~

    or

    ~~~{.Markdown}
    --------------------------------------------------------
    | Interviewer         | Famous Person                  |
    |---------------------|--------------------------------|
    | Shaken, or stirred? |                                |
    |                     | Do I look like I give a d---n‽ |
    --------------------------------------------------------
    ~~~

    or:

    ~~~{.Markdown}
    ----------------------------------------------
    | Speaker            | Statement             |
    |--------------------|-----------------------|
    | **Speaker 2**      | I'm on the rocks.     |
    | **Bartender**      | That's what she said. |
    ----------------------------------------------
    ~~~

    *缺点*：但是，如果被要求做比单段两人问答更复杂的事情，它们很快就会变得更加复杂，并且会丧失空间效率等优势。 （如果有 3 个发言者，而 #3 只发言一次，你会在他身上浪费一整个几乎空的栏吗？如果你没有为发言者使用栏，而是进行 1 栏布局，那么这比交替段落更糟糕。）它们不容易在 Markdown 中编写或调试，而且是 HTML 噩梦。

面试表格在 20 世纪 90 年代很有意义，当时大多数布局都是基于表格的，但从那以后你就再也没有见过它了，这是有充分理由的。
#. [**定义列表**](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dl)：HTML 和一些 Markdown 方言，如 [Pandoc](https://pandoc.org/MANUAL.html#definition-lists)，支持“定义”`<dl>` 元素。尽管可以追溯到 1995 年，但它还是很晦涩，而且我不确定我是否曾经使用过它。 （即使是预期的用例，例如词典或术语表，似乎也经常避免使用它，而转而采用更普通的 HTML 布局。）

    定义列表看起来像一个粗体“术语”，后面跟着一个缩进的“定义”。要使用它，人们要么将 Q 视为“术语”，将响应/答案视为定义，以进行严格的问答（如果超过一个人进行 Q 或 A，则可能添加演讲者标签），或者可能只是将每个定义视为单个陈述，而“术语”是演讲者标签。所以像这样：

    ~~~{.Markdown}
    **Q**

    : Question?
    : Answer.

    <-- Or: -->

    **Interviewer**

    : Question?
    **Respondent**

    : Answer.

       Humorous anecdote.
    : **Interviewer**: Followup query?
    ~~~

    *优点*：定义列表可以工作，但没有任何显着的优点：它们在技术上兼容，不太混乱，在视觉上有些对齐等，表明扬声器转换庞大，总体平庸。

    *缺点*：与交替段落一样，定义列表不太适合更复杂的采访，因为没有明确的方法来编码包含多个交换的主题的两级结构。定义列表的默认格式看起来相对庞大，而且很少使用，我很难记住语法——这并不可怕，至少在 Pandoc Markdown 中是这样，但我不需要经常转录采访，所以我必须检查或努力记住它。 HTML 标准明确强调“问题和答案”作为用例（“名称-值组可以是术语和定义、元数据主题和值、问题和答案，或任何其他名称-值数据组。”）——但指出这对于 [FAQs](!W) 等用途意味着更多，并表示它 [不适合一般对话](https://www.w3.org/TR/2011/WD-html5-20110405/links.html#conversations)。

因此，虽然不像表格那样注定没有吸引力，而且如果这是交替段落的唯一选择，我可能会满足于这些。
#. **无序列表**：定义列表可能不起作用，但还有更熟悉的列表类型，例如无序列表。 （当然，采访有时间顺序，但通常对它们进行编号没有多大意义，除非有人进行详细的引用。）例如：

    ~~~{.Markdown}
    - **Question**: Question?
    - **Answer**: Answer.
    ~~~

    *优点*：这很容易编写/记住并且在技术上高度兼容，具有视觉意义，保留一半的语义（它将说话者级别的多段落语句保留为包含缩进段落的单个列表项）并为它们提供具有清晰过渡的视觉分组（由于列表标记）。而且由于说话者之间的过渡很清晰，因此可以缩短或消除它们。它在处理任意数量的发言人交换角色时也没有任何问题；采访者可以用“Q”或他们的名字来表示，答案可以是“A”或他们自己的名字，以消除歧义等。

    *缺点*：1级深无序列表的缺点是，一旦演讲者声明换行到下一行，演讲者标签必然会使文本不对齐，尽管读者现在可以通过查看左边距中的列表标记更轻松地跟踪演讲者的变化，但仍然没有“主题”分组，并且它可以很好地处理复杂的采访，但现在“简单”采访存在视觉混乱问题，其中有很多简短的陈述，因此它变成了一个又高又瘦的列表溅满了列表标记。 （如果几乎每一行都是说话者过渡，因为每个问题都是一句台词，而且答案通常很短，如感叹词或否认，那么标记就不再有帮助，而且会分散注意力。）

然而，如果我们努力解决这个问题，我们可以通过缩进说话者标签或缩进第一行之后的每一行来修复视觉对齐；然后可以抑制列表标记并同时使用说话者标签。在排版书籍或杂志时，这比排版网页要容易得多，但仍然可行。如果有一种“规范”的方式来排版采访以提高可读性，我认为垂直对齐的无序列表就是。
#. **无序_两级_列表**：如果以前的单级无序列表解决方案不起作用（即使使用清理后的布局），因为它仅编码1级分组，那么*两级*列表又如何？在双层列表转录中，顶层对主题或交换进行编码，然后第二个子层对整个语句进行编码。这可以在 Pandoc Markdown 中使用指定列表上的“空”列表来编写。

这是 Gwern.net 上使用了一段时间的实现，但由于 Pandoc Markdown 操作的细节，事实证明它并不令人满意：虽然两级列表“看起来”编写起来很简单，但我一直遇到缩进问题，或者 Pandoc 没有将列表项适当地包装在 `<p>` 中，它会将子列表、问题和答案混在一起，破坏 HTML 验证，或破坏 JS 解析它（如果是嵌入的话，就像大多数采访那样）摘录是——通常完全打破了嵌入）。也无法通过阅读编译后的 HTML 来判断问题出在哪里或如何修复它。即使是我“以为”我仔细检查过的采访也会在某个地方出现问题。在发生这样的案例之后，我们决定放弃这种 Markdown/HTML 方法。
#. **水平标尺分隔列表**：

    [源代码编码。]{.marginnote} 在厌倦了两级列表方法之后，我注意到我们没有使用列表来编码比两级列表更复杂的东西，它也可以简单地包含某种分隔符，例如自闭合的跨度或 div。或者，更容易在 Markdown/HTML 中输入水平标尺。

    所以现在 Markdown 采访看起来就像无序列表，由水平标尺 `---` 分隔，并且 JS 重新格式化它。

    ~~~{.Markdown}
    <div class="interview">
    - **Q**: Question 1?
    - **A**: Answer 1.

         Elaboration.
    - **Q**: Skeptical query?
    - **A**: Wounded dignity!

    ---

    - **Q**: Question 2?
    - **A**: Answer 2.
    </div>
    ~~~

    [视觉显示。]{.marginnote} 这仍然给我们留下了对齐和列表标记混乱的问题。然而，既然已经将结构完全编码到 HTML 中，作为一个带有粗体冒号扬声器约定的单独列表，那么就可以使用 JS 进行解析，然后使用 CSS 对其进行样式化，以根据我们的意愿改进演示文稿，或者恢复为更简单的演示文稿。 （保留语义的优点是它是向前兼容的——如果我们根本不需要它，我们总是可以扔掉它。）

    在我们的例子中，我们选择隐藏*第二*级列表标记图标，因为扬声器转换由粗体扬声器名称明确标记，并且我们保留顶级列表标记图标来指示主题转换。然后，我们缩进每个第二级列表项的内容，以与第一行*在*说话者标签之后的文本对齐。 （我们可以看到，我们想要通过考虑[进一步缩进](/doc/cs/css/2023-09-07-commonedge-interviewformatting-twolevelindent.png)响应的示例——疯狂！）来排列发言者姓名。

    *优点*：这会产生 3 列效果：最左边的列是列表标记，指示整体主题转换，因此可以浏览内容块；第二列是“突出的”说话者标签，就好像它们是页边注释一样，可以轻松看到说话者的转换；第三栏是实际演讲。

    我们已经基本上解决了所有问题：我们可以以一种看起来不错并且可以在两个级别轻松浏览的方式对两级结构进行编码，这很容易编写和阅读 Markdown，与移动视图完全兼容，并且即使完全禁用 JS/CSS 也能很好地工作（因为它只是变得更加视觉上明确并失去了其良好的垂直对齐）。它看起来像这样：

    ![William Shatner 和 Leonard Nimoy 之间的讨论示例，它并不完全属于简单的问答，但在两级列表组织中分组和对齐时可读。另一个例子，参见[Hamming 1986's Q&A](/doc/science/1986-hamming#discussionquestions-answers){.backlink-not}（注释示例：[1](/doc/anime/1993-anno-charscounterattackfanclubbook-khodazattranslation.pdf#page=4 "‘Excerpts from the Hideaki Anno/Yoshiyuki Tomino interview from the <em>Char’s Counterattack Fan Club Book</em> (1993) § pg4’, Anno et al 1993 (page 4)"){.backlink-not}, [2](/doc/ai/1991-winograd.pdf#page=7 "‘Oral History Interview with Terry Allen Winograd (OH #237) § SHRDLU’, Winograd & Norberg 1991 (page 7)"){.backlink-not}, [3](https://stratechery.com/2023/new-bing-and-an-interview-with-kevin-scott-and-sam-altman-about-the-microsoft-openai-partnership/ "‘New Bing, and an Interview with Kevin Scott and Sam Altman About the Microsoft-OpenAI Partnership’, Thompson 2023"){.backlink-not}).](/doc/design/typography/2023-06-08-gwernnet-interview-williamshatnerleonardnimoy-startrekremiscencesaboutbicycletheft.png)

    *缺点*：这种干净的语义外观是以一些 JS/CSS 运行时复杂性为代价的^[JS 解析理论上可以静态完成，但 Pandoc 不容易：必须在 `<ul>`、`<li>`、`<strong>` 等元素上设置类，但是[由于历史原因](https://github.com/jgm/pandoc/issues/684)，Pandoc AST 不允许任意元素具有任意属性（仅允许某些元素）。因此使用 JS 更容易。] 并且作者不可避免地需要做额外的工作来编码主题。

# 最后阅读滚动标记

考虑但被放弃的另一个功能是“**滚动标记**”/“读取进度标记”，以帮助在向下翻页时（例如，在使用 PgDwn/Space 时）在桌面上标记位置。有时人们可能会迷失方向。
主要问题是概念性的：在当代网页中，您通常“不”知道读者在哪里停止阅读；因此，您无法有效地标记它。

[眼球追踪](!W) 研究表明，人们在阅读文档时经常会迷失自己的位置，尤其是在页面或屏幕等主要转换时。
滚动标记在 2000 年之前的桌面 GUI 中曾经很常见，我认为对于恢复长文本文档（如这些页面）可能很有用。

![JavaScript 中“滚动标记”的演示，由 GPT-4 编写；红线（*顶部*）应该在读者向下滚动一个屏幕之前标记最后可见行的底部，使他们能够毫不费力地重新找到自己的位置。 （该线的替代方案是在左边距中添加一个 [manicule](!W) 图标 (<span class="icon-manicule-right">​</span>)。）](/doc/cs/js/2023-08-07-gwernnet-gpt4-scrollmarker.jpg)

在使用 ChatGPT-4 模拟原型并为我编写 JS 后，我发现 Gwern.net 上的滚动在浏览器中似乎足够一致，而且原型也有足够的 bug，所以我对这个想法不感兴趣。

说阿赫米兹根本不相信这是真正的需要^[我后来发现，有*一个*用例，滚动标记会很有用：阅读按章节分页的小说，比如在[Wikisource](https://en.wikisource.org/wiki/Dracula)上，它们是类似实体书的，当一个人最后一页向下时，它肯定会失去自己的位置，但浏览器在到达页面末尾之前只能移动屏幕的一小部分——从而破坏了读者的沉浸感并使他们陷入混乱，因为他们必须醒来并重新找到自己的位置。这在网络连续剧中也是一个问题，因为人们必须找到“下一页”按钮，然后等待（[完全不必要](/idea#prefetch)）下一页加载和渲染，然后才能开始阅读。 （这些问题都不适用于纸质书籍，因为页面可以无意识地翻动，并且永远不会对从下一页开始阅读的位置产生任何困惑。）]，并且一个正确的解决方案必须处理许多恼人的边缘情况，找出像“最后一个位置”这样看似简单的东西，这将使实现起来比人们希望的这样一个小功能更困难。

一个更可行的功能是“持久”上次读取滚动标记，用于跨多个会话读取页面，类似于浏览器尝试存储上次读取位置并跳转到该位置的方式。
这可以使用本地存储以非侵入方式完成。

## 流行语

2024 年 12 月，在旧金山的[装订博物馆](!W "American Bookbinders Museum")，我想起了排版功能[**流行语**](!W "Catchword")：每页的最后一个单词被复制到下一页的页边距，既可以帮助装订者确保页面顺序正确，又可以帮助[眼睛固定](https://en.wikipedia.org/wiki/Fixation_(visual))或扫描。
我突然想到，这可能比红线或标记线的手指甲效果更好，而是在滚动后将最后一个“单词”加粗。

我使用 [ChatGPT-4 o1-pro](https://openai.com/index/introducing-chatgpt-pro/ "‘Introducing ChatGPT Pro: Broadening usage of frontier AI’, OpenAI 2024") 和 [Claude](https://www.anthropic.com/news/claude-3-5-sonnet) 对其进行了原型设计，在处理了很多边缘情况（在某些方面，比不太雄心勃勃的面向行的版本更糟糕）之后，有了一个可行的原型。

感觉它对*我*有效......但 Said Achmiz 和其他人指出，我的桌面使用情况（在使用 Space 或 Page Down 之前我习惯性地读到屏幕末尾）非常不具有代表性，而且该功能对于像他们这样的大多数用户来说根本没有意义，因为他们“没有”始终如一地读到最后一个单词，甚至最后一个可见行，所以体验是随机单词不断变粗！
（这在移动设备上可能更是如此，读者可以被宽容地描述为“分心”。）

这个原型最终打消了我的念头。
如果没有实际的眼球追踪（例如在 VR 耳机中），自由格式响应式网页（例如本例）的滚动标记原则上无法工作。

（然而，持久滚动标记仍然是可行的，因为人们只需要能够粗略地猜测到读者停止的地方的半个屏幕内，就可以帮助他们。
请注意，物理[书签](!W)也不需要找到您最后阅读的单词，而只需找到最后一个*页*。）

# 导航栏上一个/下一个链接

2020 年 11 月 5 日左右，我在 Gwern.net 页脚中尝试了“定向链接”。
与[滚动到下一页自动分页功能](#autopager)类似，这大致是受到GNU信息手册的启发。

[花式阿拉伯式花纹 SVG](https://commons.wikimedia.org/wiki/File:Filet_arabesque.svg) 被编辑为 3 个独立的 SVG，然后可以将其转换为 3 个超链接。
左边的“箭头”指向“上一页”，中间是返回顶部的链接，右边的箭头指向“下一页”。
这是作为 YAML 标头中的每页 Markdown 元数据变量（`previous: /path` 和 `next: /path`）实现的，由 Hakyll 读取（默认返回到 `/index`），并作为 2 个变量传递到 HTML 模板，这两个变量被替换到 3 个 SVG 周围的 `<a>` 包装器中。

对于时事通讯和标签目录，上一个/下一个是自动定义的；对于常规论文，我以半合理的顺序设置了一个主列表，并手动定义了顺序。
然后，我通过手动添加变量并编辑其他两个页面以将新页面拼接到位，或多或少地对每个新页面进行更新。

这是一个丰富页面导航和元数据的可爱想法，但我看到没有人使用或提及它。

它偶尔会引起问题：如果我复制粘贴时事通讯 Markdown 源文件，它是另一个必须更新的路径（而且我可能会忘记更新）；有时它们已经过时或成为断开的链接；最糟糕的是，它增加了创建或分解新论文页面的过程的繁重工作——因为除了所有基本工作之外，我还必须决定将其放在“哪里”，然后“拼接”。

由于这完全是成本，没有任何好处，所以我在 2024 年 9 月将其删除。

回想起来，这对于导航栏来说从来都不是一个好方法：蔓藤花纹（深埋在页脚中，很少有读者能够注意到）太微妙，任何人都不会注意到，而它提供的导航在 Gwern.net 上很少有用，那里通常没有严格的顺序，时间或主题。
（如果它“曾经”有用，那么将其放在页面顶部并使其更加突出会更有意义——并且在新闻通讯之类的情况下，我已经链接了上一期/下一期！）

# 分数斜杠

排版阿拉伯数字和字母分数*而不*渲染成熟的 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 或 MathML 的最佳方法是什么？^[由于先前在 [MathJax 部分](#mathjax) 中讨论的原因，这两个解决方案糟糕得令人无法接受，而 MathML 支持仍然太弱而无法使用。尽管由于 Google Chrome 在 2023 年采用 [MathML Core](https://www.w3.org/TR/mathml-core/)，采用率已达到 [>95%](https://caniuse.com/mathml)，但一两年内，MathML 完全有可能成为我们首选的数学排版解决方案！ MathML 明确支持粗俗分数作为 [`<mfrac>`](https://developer.mozilla.org/en-US/docs/Web/MathML/Element/mfrac) 的“斜角”属性，因此它应该可以正常工作。]

截至 2025 年 2 月 1 日，我决定使用 FRACTION SLASH + CSS 来表示简单的整数分数（例如 1⁄2），使用 BIG SOLIDUS 表示混合分数（例如 _a_⧸_b_），并使用 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 来表示困难情况（由于性能成本而省略了示例）。

[斜杠问题。]{.marginnote} 常规 ASCII SOLIDUS '/' 是可行的，但非常不明确（'1/2' 是小数 0.5、范围 1-2、一对离散的替代项 {1, 2}、URL 的一部分、任意名称、科学单位的一部分、指定长度的列表中的序数位置，还是完全其他的东西？）。

[外观。]{.marginnote}我们可能喜欢“垂直”分数，尽管在我看来，当在计算机显示器上的 HTML 中内联使用时，显示质量使它们阅读起来有点痛苦，因为您要么夸大行高（我们试图避免），要么将两个数字设置得太小以至于难以阅读。^[检查 [Chaundy 1954](/doc/design/typography/1954-chaundy-theprintingofmathematics.pdf#page=39 "‘<em>The Printing of Mathematics: Aids for Authors and Editors and Rules for Compositors and Readers at the University Press, Oxford</em> § Fractions’, Chaundy et al 1954 (page 39)") 了解数学排版的历史背景，对角粗俗分数不是覆盖，只是非常小的垂直分数，我怀疑这是由于他们使用的排版机制和对它们可以承受的独特符号的限制是不可行的，因为你必须转换那个精确的分数，而垂直分数更模块化，因为它们不重叠并且可以设置在不同的行上（请参阅[这个Monotype“四行”系统讨论](/doc/design/typography/tex/2007-rhatigan.pdf#page=18 "‘The Monotype 4-Line System for Setting Mathematics § Fractions’, Rhatigan 2007 (page 18)”）以获取有关经济的非计算机数学排版挑战的更多历史背景。）

另一种熟悉的在西方文字中书写分数的方式^[我不知道分数在非西方文字中是如何处理的，所以我不会在这里讨论它们。由于现在很多人使用阿拉伯数字，但除了数学水平线或 ASCII 内联版本之外，可能很少接触到任何东西，并且存在诸如不同阅读方向之类的复杂因素，因此尝试任何花哨的东西可能会有风险。] 是“对角线”或“斜角”[粗俗分数](!W)。
您可以使用 Unicode 的内置分数，例如 VULGAR FRACTION ONE HALF '½'，它会为您提供一个美观的紧凑分数斜杠，并得到普遍支持......但是[仅涵盖您可能编写的分数/除法的一小部分](https://en.wikipedia.org/wiki/Number_Forms#List_of_characters)。
所以这不能用。
（它还有一个缺点，那就是使搜索文本变得更加困难，因为每个分数都是一个新的、唯一的 Unicode 点。）

[FRACTION SLASH 问题。]{.marginnote} 幸运的是，正是出于这个原因，Unicode 有一个特殊的广义分数字符，FRACTION SLASH ' ⁄ ' (U+2044)，Unicode 标准[明确表示](https://unicode.org/versions/Unicode6.0.0/ch06.pdf#page=15)（参见[Unicode 明文数学](http://unicode.org/notes/tn28/UTN28-PlainTextMath-v3.pdf#page=5)）*应该*像庸俗分数一样呈现......有时确实如此，就像在我的 GTK Emacs 中一样。
但在我的 Firefox 或 Chromium 的大多数页面上*没有*。^[有一些异常情况，例如 Twitter，该网站可能正在做自己的事情。]
在那里，它看起来就像是一个混在一起的二分之一，[kerning](!W) 被破坏了，比 ASCII 的“1/2”还要糟糕。
（这可能是模棱两可的，看起来很平凡，但至少它看起来不像是数字几乎重叠的拼写错误——多年来，一些读者在合理的假设下联系了我，认为幼稚的 FRACTION SLASH 渲染是一个错误；而且，毕竟，它*是*。）

令人沮丧的是，因为这是一个 [OpenType font](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_fonts/OpenType_fonts_guide) （或者可能是一个字体渲染引擎？） 功能（[example](https://en.wikipedia.org/wiki/File:AppleChancery4and221-225thsExample.png)），所以很难找出它在哪里工作。

[*某些* Adob​​e 字体](https://helpx.adobe.com/fonts/using/open-type-syntax.html#frac) 提供 `frac`/`fraction` OpenType 功能，理论上该功能会自动与 FRACTION SLASH 配合使用。
但哪个？我们在 Gwern.net 上使用的 Adob​​e Source Serif 有吗？令人惊奇的是，很难找到答案！
（搜索了几十个网站，有几个提示表明它*确实*像[Github源代码](https://github.com/adobe-fonts/source-serif/blob/0c2ecc5cce0fe72359619b7c5e7e6e93fa2fb60a/family.fea#L86)或[<span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span>包](https://mirror.math.princeton.edu/pub/CTAN/fonts/sourceserifpro/doc/sourceserifpro.pdf#page=4)，但是`font-variant-numeric: diagonal-fractions;`{.CSS}和`font-feature-settings: "frac"`{.CSS}似乎都不能在Gwern.net上工作，尽管我们能够让它与Adobe的[Garamond Premier Pro](!W) 和 [Warnock Pro](!W)。
我们有过时的版本吗？也许吧，但谁知道呢？）

长期以来存在 [Firefox](https://bugzilla.mozilla.org/show_bug.cgi?id=500293 "'Built-up (vulgar) 不支持使用 Unicode 分数斜线（或其他方法）的分数'，O. Andersen 2009-06-24"）和 [Safari open bug](https://bugs.webkit.org/show_bug.cgi?id=27413 "'Bug #27,413: Built-up (vulgar) 使用 Unicode 分数斜线（或其他方法）的分数'，O. Andersen 2009-07-18"），但 Firefox 理论上应该受益于 [Harfbuzz](https://harfbuzz.github.io/shaping-opentype-features.html) 支持，因此我们可能可以排除野生动物园。
据我所知，没有 CanIUse 或 MDN 条目涵盖这一点，而且我不知道在哪里可以找到有关兼容性的信息（缺少使用像 [BrowserStack](!W) 这样的浏览器设备测试服务，该服务速度慢、手动且昂贵）。
我们也不知道兼容性是否会变得更好或更差，也不知道随着时间的推移，是否有简单的方法来检查。^[这需要众包社区的努力，但总的来说，人们似乎对这个主题没有太大兴趣，因为大多数人满足于使用常规斜杠或完整的 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 来完成所有不平凡的数学排版。]

好的，所以 FRACTION SLASH 在受支持时会做正确的事情，但在常见的 Web 浏览器中并没有得到充分的支持。
我们可以通过渐进增强在 CSS+JS 中手动执行此操作。^[以连字的形式在字体中执行此操作是可能的，但只有在我们使用少量使用的静态语料库时才会更好，而 Gwern.net 有许多且定期添加的分数；因此字体方法立即被排除。]
每页不多，重写很简单，通常不会对布局进行太大改变，也不会损害响应能力，因为它适用于所有尺寸，因此性能成本是最小的。
（可访问性、非 JS 后备、暗模式和打印渲染并不比原始的 FRACTION SLASH 差，因为我们只是在斜线周围重新定位分子和分母。）

而且实现非常简单：只需将所有 FRACTION SLASH 包装在 `.fraction` 类 HTML 范围中（我们可以在编译页面后通过 sed 重写来完成此操作，以自动完成将它们全部包装起来的工作）；运行 JavaScript 代码片段来替换分数斜杠并分别标记分子和分母，如下所示：

~~~{.JavaScript}
eventInfo.container.querySelectorAll("span.fraction").forEach(fraction => {
 fraction.innerHTML =fraction.innerHTML.replace(/^(.+?)\u2044(.+?)$/,
 （匹配，数字，分母）=> {
     返回`<span class="num">${num}</span><span class="frasl">&#x2044;</span>
             <span class="denom">${denom}</span>`；
 });
});
~~~

然后设置样式以调整间距/大小以使其看起来不错：

~~~{.CSS.折叠}
跨度.分数{
    位置：相对；
    顶部：0.1em；
}
跨度.分数 > * {
    位置：相对；
}
跨度.num,
跨度. 分母 {
    字体变体数字：oldstyle-nums；
    字体大小：0.9em；
}
跨度.frasl {
    底部：0.1em；
}
跨度.num {
    底部：0.7em；
    左：0.1em；
}
跨度. 分母 {
    底部：-0.1em；
    左：-0.12em；
}
~~~

问题解决了！

但是等等——这只在视觉上适用于数字对：具体来说，当两边都有 ~1-3 个整数时（并且 Unicode 标准指出它仅适用于数字）。
'_a_/_b_' 或 '1 / log(1.05)' 不好，而且看起来很糟糕。
（在*某些*情况下，它们可能可以用作粗俗分数，例如“_a_/_b_”，但通常不能：“mg⧸day”？“12,345/6,789”？）

![](/doc/cs/css/2025-02-21-gwern-unicode-fractionslashoptions.png "Visualization of VULGAR FRACTIONs, SOLIDUS, FRACTION SLASH, DIVISION SLASH, BIG SOLIDUS, FULLWIDTH SOLIDUS, & SOLIDUS WITH OVERBAR Unicode characters for typesetting fractions in HTML."){.float-right .invert}

[替代方案。]{.marginnote} 我们如何处理其他分数？
我们可以尝试一些棘手的重写规则，例如“如果有 `.fraction` 包装器，则将它们像粗俗分数一样对角设计，如果没有 `.fraction` 包装器，则将分数斜线替换为常规斜线”，但这很脆弱且令人困惑，并且给 `.fraction` 包装器带来了很多负担，以使其正确，并且不会给我们带来任何好处。
（作为一名作者，我会可靠地做到这一点吗？或者还记得 10 年后这是如何运作的吗？）

还有其他斜线吗？检查[斜杠字符上的WP](https://en.wikipedia.org/wiki/Slash_(punctuation)#Encoding）我们有DIVISION SLASH' ∕ '，这似乎是指示这些表达式正在被*除*的理想替代方案，即使我们没有将它们渲染为*分数*（Unicode纯文本数学：“构建一个潜在的大线性分数”）......但默认情况下渲染得与FRACTION SLASH一样糟糕。
所以这对我们没有任何好处。

还有什么？全宽斜线'/'？不，如果你尝试写“_a_／_b_”这样的东西，看起来会很糟糕。
（圆圈斜线就出来了。）

[BIG SOLIDUS.]{.marginnote} 因此，通过消除过程^[考虑到 Unicode 在某些领域有多么荒谬的字符，我很惊讶那里的 Unicode“斜杠”字符竟然如此之少。]，与 BIG SOLIDUS ' ⧸ '（相对于 SOLIDUS ' / '）。
这是一个不常见的角色。
然而，它似乎对于非粗俗分数工作正常，因为 _a_⧸_b_ 现在明显不同于常规“/”的其他可能解释，并且它看起来可以接受内联，因为它不是“太大”大。
它在性能、字体/浏览器支持、可访问性、Markdown 编辑或搜索的简易性等方面也没有明显的缺点，并且在我迄今为止的使用中，它是有效的。

[结论。]{.marginnote} 所以我对好的 HTML 分数的建议是：

#.手动设置“小”整数粗俗分数的样式，可能用分数斜线表示，以便在浏览器可靠地支持标准化排版时使向前升级变得更容易。
#.使用 BIG SOLIDUS 设计非庸俗的内联分数
#.对于其余的，使用 <span class="logotype-latex">L<span class="logotype-latex-a">a</span>T<span class="logotype-latex-e">e</span>X</span> 库

# 面包屑

[面包屑导航](!W) 是一个经典，但现在基本上被遗忘了，[Web 1.0 网站设计模式](http://www.rdrop.com/~half/Creations/Writings/Web.patterns/visible.location.html) 借用自文件系统，用于导航和构建网站。
它们只是按某种顺序垂直或水平排列的名称列表。

我们一直无法找到普通面包屑的用途，但它可能激发了[弹出系统的替代想法](#browsing-history)。

---

历史上，面包屑有两种不同的使用方式：

#. **等级制度**：

    对于被动网站来说，最常见的用途是可视化类别：按顺序列出当前网页的每个父类别；每个类别通常是某种索引或登录页面链接，其中列出了该类别中的其他条目。

    这种面包屑样式代表*空间*：您正在“向下”或“向上”或“内部”导航类别，就像您浏览老式离线图书馆一样，您必须找到正确的部分，然后是书架，然后是索书号等。

这非常适合经常按线性顺序阅读的严格分类的不变文档集，例如技术文档或书籍（例如 `book > chapter > section`），或者适合以任务为中心的浏览和修改分层文件系统。
#. **历史**：

    对于交互式网站，面包屑列表可能会列出您最近*浏览过的页面和/或您执行的*操作*（例如`account creation → settings → inbox`）。

    这种面包屑样式代表*时间*：它是按时间顺序一分钟又一分钟地记录您去过的地方或做过的事情的日志。

    这对于服务或工具很有用，在这些服务或工具中，您可能需要跳回到上一页（特别是涉及表单并且天真的浏览器后退按钮使用会很危险），或者您可能会这样做很长时间，或者只是忘记自己在做什么。

读者有时会抱怨，尽管有链接和 [tags](/design#tags "‘Design Of This Website § Tags’, Gwern 2010") 以及网站搜索功能，Gwern.net 仍然如此庞大和庞大，以至于它变成了一个博尔赫斯式的迷宫，让他们感觉迷失了方向。
这部分是因为它的视觉一致性。
每篇文章都有类似的“扁平”外观：时事通讯问题看起来并不像[DNB FAQ](/dnb-faq "‘Dual <em>n</em>-Back FAQ’, Gwern 2009"){.backlink-not}这样的文章页面“在”任何地方。
这只是文字的海洋。

因此，“分层”面包屑似乎是一个可能的解决方案：如果 DNB 常见问题解答中有类似 `psychology > intelligence > DNB FAQ` 的内容，那么也许读者会感到不那么迷失方向——他们位于庞大图书馆的“心理学部分”，可以浏览那里的书架。
我们不会将该层次结构编码到网站 URL 本身中（这是大多数此类面包屑系统的工作方式），因为[我们使用短“slug”URL](#long-urls) 以便于编写，但这并不是真正的障碍，因为元数据以标记目录系统的形式存在：DNB FAQ 除其他标记外还被标记为 `psychology/dual-n-back`。
只需从论文标题中删除现有的标签块，将其粘贴在左上角，就完成了！

但问题是，Gwern.net 上“没有”严格的层次结构，甚至没有任何特定的“阅读顺序”，事实上，越来越少的大型网站具有严格的层次结构，面包屑也越来越少。
标签式超媒体并不能很好地体现这个想法——例如，英语维基百科，尽管有元数据和大小，却没有使用这个概念。
（请注意，第二个链接使用分层面包屑，是一本技术书籍的网络版本，可以一次性阅读，这与 Gwern.net 完全不同。）
DNB 常见问题解答实际上有 *3* 个标签，包括 `iq` 和 `quantified-self`——并且应该有更多。
哪一个是“面包屑路径”？

一个“特殊”标签就是它吗？
抛开如何更新所有与元数据相关的代码以处理“特殊”或“主要”标签的想法的麻烦，并为数百篇已有的 Gwern.net 文章添加这一点，这存在概念和实际缺陷。
一般来说，您如何决定特殊标签，当一个标签没有作为页面的“the”标签跳出时会发生什么？
当您重命名或更改标签本身时会发生什么？
其他东西是否需要尊重标签的特殊性？如果标签对于任何页面来说都不是特殊的，这会改变它的含义吗？
如果它没有硬连线到 URL 中，那么当您将一个标签粘贴在左上角、格式不同（并且行为不同？）而其他标签位于正常标签位置时，读者应该如何解释这一点？
从读者的角度来看，准随机地挑选一个标签真的可以让您“知道它们在哪里”吗？

都是面包屑路径吗？
（只是以相同的格式将它们依次列出。）
那么它只是一种更笨重的显示标签的方式，因为当它们都很特殊时，就没有一个是特殊的。
它失去了空间或时间隐喻的心理益处：你不“处于”任何特定的标签或层次结构中，因为你同时处于多个标签或层次结构中；它也与你去过的地方或做过的事情没有任何联系。

总的来说，我们看不到 Gwern.net 的分层面包屑，这是有价值的并且不会造成混乱。

## 浏览历史记录

<span id="browser-history"></span> 传统定义的面包屑不符合 Gwern.net 的标签分类法或读者阅读我的页面的方式；这就是原因，以及帮助读者跟踪页面内探索的替代概念，我目前将其称为**浏览历史**。

---

如果分层面包屑不起作用，那么“历史”面包屑又如何呢？
嗯，Gwern.net 不是一个 SaaS 网站，也不是一个人们通常会连续阅读许多论文页面的网站（根据 Google Analytics，读者每次会话访问 1.2 页）...
但它的交互性仍然很高：在一个页面上，读者可以通过我们皇冠上的宝石弹出系统与任何其他网站上的许多“页面”进行交互。

我和其他人有时会在阅读文章和探索弹出窗口时感到某种对损失的恐惧，并遭受“标签爆炸”的困扰。
这似乎引起了一些读者的某种反感或焦虑。
因此，这表明 Gwern.net 的历史痕迹可能是*记录弹出窗口*。

我们将此当前未实施的提案称为**浏览历史**（或者可能是“阅读轨迹”？）。
它的灵感来自于 [Concordia 超媒体系统 ](/doc/cs/lisp/emacs/1988-walker.pdf "‘Supporting document development with Concordia’, Walker 1988") 中的 [‘当前候选’窗格 ](/doc/cs/lisp/emacs/1988-walker.pdf#page=5 "‘Supporting document development with Concordia § pg5’, Walker 1988 (page 5)")，它存储了读者点击（但尚未浏览）的超链接列表，将它们排队以供阅读完当前页面后稍后浏览。
（有点像['停靠的注释卡'想法](/doc/design/typography/sidenote/2022-11-16-gwern-gwernnet-dockedannotationsidebarmockup.jpg)；参见[“轨迹”](https://www.freecodecamp.org/news/lossless-web-navigation-with-trails-9cd48c0abb56/)。）

我们不会记录整个网站浏览过的页面列表（无论如何，这对于浏览器历史记录来说都是多余的），而是记录与页面内交互的弹出窗口和链接的列表。
当然，这个列表无法以正常的面包屑方式表示，但我们已经有一个如何呈现一长串注释和 URL 的示例：链接参考书目。
所以我们可以重用这个例子。

每当读者与弹出窗口/链接交互时，它就会自动插入到页面末尾的部分：“浏览历史记录”部分。
第一次发生这种情况时，该部分不存在，因此它被创建（插入到相似链接之后但链接参考书目之前）并插入到目录页面中。
这将是可见的，但它是一个功能而不是一个错误，因为它可以帮助读者了解此功能的存在并记录*他们的*在浏览页面时的操作：“哦，我弹出了一个链接，现在在我这样做后立即创建了一个“浏览历史记录”部分。嗯，我猜它正在记录我的弹出窗口或其他什么？”

然后，当读者读完该页面时，读者可以简单地向下滚动浏览该页面，并按照他们查看的顺序提醒他们所查看的所有内容（例如，做笔记或在新选项卡中打开或下载链接文件），以唤起他们的记忆并重建他们的阅读体验。

或者他们可以使用此功能“排队”要阅读的内容列表：在阅读文章时浏览它，弹出一些看起来有趣的链接，但只在之后阅读它们。
因为所有内容都包含在页面中，理论上他们甚至可以打印为 PDF 以便离线阅读或存档。
（非常认真的读者可以故意使用它来实现一种“推荐阅读列表”：以某种有意义的顺序与一小组参考文献进行交互，然后打印该版本！）

浏览历史记录的呈现可以添加上下文以帮助回忆：

- **部分**：列表可以按每个链接所在的部分或弹出时聚焦的部分（对于不在根页面中的链接）进行细分。
- **弹出窗口深度**：为了帮助回忆，弹出窗口可以在标题栏中显示其数字，类似于 popin 目前在 popin 标题栏中将深度显示为数字 _n_ 的方式。

    然后，该数字可以将相应的条目作为页内弹出窗口弹出，让读者在弹出历史记录中快速向后/向前浏览（例如，将当前弹出窗口与之前阅读的几个弹出窗口进行比较）。

或者，我们可以只嵌套弹出窗口而不是使用平面列表，并且浏览历史记录部分变成树列表。
- **复制粘贴/突出显示**：我们还可以轻松记录用户在阅读页面时*突出显示*的所有文本。

     每个文本只是成为列表中的另一个条目，并且它会得到一个反向弹出窗口（到它之前的第一个锚点/ID，因为带有 ID 的链接的普遍性意味着附近应该始终有一个有用的 ID）。

这可以帮助强制突出显示或选择文本的用户重建他们的阅读历史记录，然后他们可以手动复制全部内容或通过打印页面等“导出”。
- **本地存储**？可能不会。所有这些都是客户端的，不涉及任何第三方或服务器，并且默认情况下，当页面重新加载或关闭时消失。

    我们“可以”将其存储在本地存储客户端中，并在每次读者返回时简单地附加到它，但考虑到本地存储的严格大小限制和一般短暂性，以及渲染它的负担日益增加，以及实现的复杂性，以及我怀疑大量读者是否会从中受益，我认为这不是一个好主意。

所以我们可以想象一个浏览历史记录部分，例如

> **浏览历史记录**
>
> 1.《论鲸类毛皮在时装中的运用》：
>
> ...
> 2.脚注15 ↑
> 3.‘可变宽度字体节省下载带宽，尤其是CJK’

在实现方面，这并不太复杂，因为它重用了弹出和嵌入机制。
然而，截至 2025 年 4 月，我们尚未这样做，因为浏览历史记录仍然是一个复杂的功能，较小的功能/错误修复具有更高的优先级。

# 预计阅读时间和字数

在博客上越来越常见的是包含“预计阅读时间：_n_分钟”（通常以“极简主义”的名义省略更重要的功能）。
由于 Gwern.net 的文本内容非常多，并且强调阅读，而且它缺乏标准的书籍可供性，例如卷中文本的物理页面，我们是否需要它作为替代品？

不。

经过进一步研究后，我彻底否定了这一点。
我认为阅读时间估计在没有错误的情况下会产生误导，并且对于[消失的滚动条](https://artemis.sh/2023/10/12/scrollbars.html)的实际问题来说，这是一个糟糕的解决方案。

几乎每个实现都采取简单化的观点，即可以通过[计算字数](https://en.wikipedia.org/wiki/Word_count)，然后除以某个平均 WPM 阅读率来估计阅读时间。
但这是一个毫无意义的估计：

- 页面是非线性超文本；脚注、折叠、嵌入和兔子洞式阅读打破了任何固定字数或线性阅读的假设

- 读者出于不同的原因阅读页面的不同部分
    - 读者甚至可能不在他们正在阅读的页面上，因为他们是通过弹出窗口阅读的
- 个别 WPM 因读者、主题复杂性、词汇量和设备（例如屏幕尺寸）而异
- 分析显示，很少有读者真正在一次会话中从头到尾读完。

    例如，我的 Google Analytics 计时显示，坐下来从头到尾阅读一页的情况几乎永远不会发生：页面完成率 <10%。
    许多页面的预计阅读时间为数小时，并且我避免页面少于 1,000 字（即*所有*页面在 200WPM 下的阅读时间 >5 分钟）；但分析一致表明，平均阅读时间为 [接近 3 分钟](/doc/traffic/2023-01-02-2023-07-01-gwern-gwern.net-analytics.pdf "Average Time On Page (site-wide average): 00:02m:55s”）（即 <600 个单词）。

    因此，我们估计的字数或阅读速度与“实际”字数或阅读速度关系不大，而我们估计的阅读时间甚至更少。

    即使阅读第一段，也可能比任何“估计”更能让读者更好地了解他们实际花在阅读一页上的时间。

您可以尝试稍微调整这些问题：尝试使用实际的[可读性公式](https://en.wikipedia.org/wiki/Readability#Readability_formulas)，如 Flesch-Kincaid；而不是类似于 `wc --words` 的简单字数统计；或者使用 JS 分析来报告一些经验平均页面停留时间，也许......
但即使是复杂的计时器，除了现有的滚动条和目录可供性之外，也没有任何其他功能。

我还没有看到一个看起来真正有用的实现，或者任何实现都是有用的证据。
它们是货物崇拜拟物化，这是由 Medium 等网站发起的趋势（在这一点上应该被视为反对它们是一个好主意的有力证据）。
它们对于像官僚机构这样的机构来说是有意义的，在官僚机构中，完成特定表格的预计时间*可以*进行有意义的测量，并且了解它对于减少文书工作的负担很有用；或者对于像出版商这样的人，他们可能按字付费给文案编辑或索引员，并且每个字必须花费一定数量的墨水和纸张。
它们在某些地方可能有意义......但在任何博客文章上都没有意义！

我更愿意专注于让读者控制时间的真正解决方案，例如前面讨论的[浏览历史](#browsing-history)想法，以便稍后排队提醒，或者实现我们自己的滚动条（因为浏览器和操作系统似乎一心要逐步淘汰它们，以便在某个时候可以完全删除它们）。

## 序数字数统计

字数统计有意义的一个地方是在博客文章之外，用来描述其他地方的页面。
例如，一个人可能有一长串博客文章，读者可以从粗略的大小估计中受益，例如《Greater Wrong》：

![Greater Wrong 的屏幕截图（“野兽派”主题）：元数据中包含一个简单的估计阅读时间，例如“4 分钟阅读”或“15 分钟阅读”，以帮助读者决定是否打开提交。](/doc/cs/css/2025-04-26-greaterwrong-homepage-brutalisttheme.png)

虽然这些估计是高度错误的（即使就相对时间要求而言，这些估计也不是“正确的”），但它们总比没有好，并且有助于区分短的废话、长的努力帖子、样板通知等。

我认为这在 Gwern.net 上也相关：当链接另一篇文章时，链接图标有助于表明它是一篇文章，但它并不能告诉读者太多有关大小的信息——它是一个大页面之一，还是一篇相对精简的 1--2,000 字文章？
弹出窗口可以帮助回答这个问题，但需要一些思考或交互，但更有用的方法是以某种方式指示大小。

我们不想包含实际的单词或时间计数，因为这些都是虚假的并且很难紧凑地内联呈现。
但我们“可以”提供一些“相对”大小的指标：我们不太关心一篇文章的绝对长度，而是它相对于所有其他文章的长度：“它是大、中还是小？”

这种相对的“序数”数据可以用各种线条或[哈维球](https://en.wikipedia.org/wiki/Harvey_balls)圆或填充几何形状来表示。
在对顺序“进度指示器”时钟状元数据图标（看起来像 Twitter 如何指示 280 个字符限制已用完多少）进行一些修改后，我们想出了一个漂亮的“环绕”圆圈，它允许以微小的字母大小的形状显示任何 0--100% 的数据，直观的视觉精度可能为 ±5%。
目前，它们[在每篇文章的元数据](/doc/cs/css/2025-02-21-gwern-gwernnet-ordinalprogressindicators-metadataheaderexample.png) 中用于表示其他类型的序数数据，例如页面的完整性，并在折叠中用于指示[有多少内容是可见的](/doc/cs/js/2025-01-10-gwern-gwernnet-ordinalprogressindicatorsoncollapses.png)。

我们可以进一步使用它们，计算每个页面的字数，然后按字数计算直方图，并将它们的“相对位置”视为序数图标：最长的页面（无论可能有数十万个字）获得 100％ 和一个完整的圆圈；最短的页面（可能只有几十个字）被分配为 0% 和一个空圆圈；其他所有页面都会出现在其他地方，例如 24% 或 78% 等。
这避免了像“15.8 分钟阅读时间”这样的虚假精度，同时以紧凑的符号形式传达了潜在的信息（“这是一个异常大的页面”）。

如果我们愿意，我们可以将它们四舍五入到四分位数，所以它看起来大致如下：

- 空○=最短的25%论文
- 四分之一 ◔ = 25–50%
- 一半 ◑ = 50–75%
- 四分之三◕ = 75–100%

我们不一定会替换现有的“𝔊”后缀链接图标作为论文链接，但也许会将其替换为悬停和弹出窗口中的序号指示符。

# 诗块引用/代码块

[**参见主要文章。 **](/poetry-html "‘Poetry HTML Typesetting’, Gwern 2026"){.backlink-not .redirect-from-id .include-annotation}

<!--

# 全站阅读器模式

Twitter 民意调查 2025-08-16--2025-08-23（也在 /r/gwern 上发布广告）：

> Gwernnet“阅读器模式”用户：您通常在站点范围内还是每个页面上使用阅读器模式？ （您是在特定时间打开它来阅读特定页面，还是只是在打开它的情况下进行一般浏览？）\[_n_ = 154 票\]
>
>
> #.全站范围：7.8% \[_n_ = 12\]
>
> - \[即。 28% 的阅读器模式用户\]
> #.每页：20.1% \[_n_ = 31\]
>
> - \[即。 72% 的阅读器模式用户\]
> #.我从不使用阅读器模式：41.6% \[_n_ = 64\]
> #.不适用/其他/查看结果：30.5% \[_n_ = 47\]

1 条评论支持站点范围的阅读器模式，其理由是“站点范围内，因为不断打开和关闭很烦人”，但没有回复我的评论，询问这是否意味着每页默认设置会更好。
-->
