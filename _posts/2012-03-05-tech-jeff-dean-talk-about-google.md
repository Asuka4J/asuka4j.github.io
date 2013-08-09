---
layout: post
title: "JeffDean谈Google研发"
description: ""
category: tech
tags: [架构, 研发]
---
{% include JB/setup %}
<p>
    2010年（没错，我今天才知道..）Google的Jeff Dean曾在Stanford做了一次<a href="http://www.stanford.edu/class/ee380/Abstracts/101110.html" target="_blank">演讲</a>，主题是关于Google从1999到2010这十年间的架构发展以及其中的经验教训。整个演讲非常有料，PPT也足足有103页。在细读两遍后，这里主要摘录下其中的一些要点。（在YouTube上可以找到<a href="http://www.youtube.com/watch?v=modXC5IWTJI" target="_blank">演讲录像</a>，可能需要您先翻一下墙）
</p>
<p>
    <strong>Part I ： Evolution of various system at Google</strong>
</p>
<p>
    在十年的发展过程中，Google索引的文档数量增长了1000倍，平均查询速度提高了5倍，更新上线速度提高了5万倍，服务器规模增加了1000倍。在这期间总共做了7次重大升级（没说具体哪7次），而且都是在用户不知不觉间完成的。
</p>
<p>
    <strong>1) 97&#39; Searching Systems:</strong>
</p>
<p>
    <center><img id="3A44CCEE9E5667363B943EC921AFFB6D" src="http://m3.img.libdd.com/farm3/71/478B9B4EFCABB77AA51C6A6F0CB8B747_500_268.jpg" data-pinit="registered" /></center>
</p>
<!-- more -->
<p>
    当时还在实验室时期的搜索系统架构还比较简单，主要是将索引和网页具体内容分开部署：
</p>
<p>
    Index servers：按docid做sharding，执行query的查询并返回排好序的&lt;docid, score&gt;对列表，耗时是 O（#queries * #docs in index)。每个shard也可以有多份replicated以提升系统容量。
</p>
<p>
    doc servers：也是按docid做sharding，通过参数（docid，query）生成（网页标题，网页片段）。通过docid可以精确获取一份网页。这里的耗时是 O（#queries）
</p>
<p>
    <strong>2) 99&#39; Searching Systems:</strong>
</p>
<p>
    <center><img id="ABA4CCF063782070248753DA01A52A77" src="http://m3.img.libdd.com/farm3/176/F947263FC20FEEB7DED1E794828352B0_500_370.jpg" data-pinit="registered" /></center>
</p>
<p>
    这个版本最大的改进在于引入了缓存，并且索引和网页库形成了完善的矩阵模式。
</p>
<p>
    Cache servers ：索引和网页片段都可能被缓存，缓存的命中率大约为30~60%，这取决于索引更新频率、组合条件的流量、个性化程度等条件。增加缓存后，系统的性能得到了显著的提升，但也带来了一些问题，比如在索引更新或缓存刷新的时候会有较大的延迟。
</p>
<p>
    <strong>3) 98&#39;~99&#39; Indexing:</strong>
</p>
<p>
    在前期的网页搜索中，设计的重点和难点主要是在索引服务上。这也是最容易出问题的地方。由于Google提倡购买最廉价的设备（廉价不等于最差），这些设备的磁盘、内存经常出错，从而影响到搜索的准确度。这也对工程师们提出了更高的要求，设计的程序需要考虑到底层的各种容错机制。
</p>
<p>
    <strong>4) 00&#39; Data Center Maintain:</strong>
</p>
<p>
    Google的工程师直接参与到IDC的维护中，由于当时的服务器托管商是按照机房面积计费的，于是Google把服务器堆地严严实实，甚至需要自己增加电扇去辅助散热。期间由于很多托管商的相继倒闭，工程师还需要经常给服务器挪窝，这也练就了很多组建机房的技巧，比如按机柜安放服务器组，这样在搬迁时就可以将机柜整个抗走。
</p>
<p>
    <strong>5) 99&#39;~01&#39; Capacity Increasing:</strong>
</p>
<p>
    随着Google越来越被用户所接受，其索引数量和查询容量都在持续增长。索引的网页从50M增长到1000M，流量也维持着每月20%的增量。新增加的合作伙伴有时也会带来流量的陡增，比如00&#39;接入Yahoo!，当晚的流量就翻了一倍。
</p>
<p>
    索引服务的性能一直被列为重中之重，通常是不断地部署新服务器来扩容。直到有一天，工程师发现矩阵中所有服务器的内存总量已经足以放得下整个索引，于是乎又有了一次架构改造：
</p>
<p>
    <strong>6) 01&#39; In-Memory Index Systems:</strong>
</p>
<p>
    <center><img id="4954FF5A3C32DEF4E07048706F0BC9C1" src="http://m1.img.libdd.com/farm3/210/EA04E46290E133131F16685EE62B09D2_500_391.jpg" data-pinit="registered" /></center>
</p>
<p>
    这个版本的架构中索引任然被划分为多个shard，每个shard中有一个节点专门负责负载均衡和调度，索引都存放在服务器的内存中。改造后系统的吞吐量大增、查询延迟骤减，但系统可用性降低了，因为单个节点是没有replicate的，单台宕机就会影响查询。
</p>
<p>
    另外，当时的Google也经常面临宕机的挑战：因为每个请求都会分派给上千台服务器处理再合并，一个请求如果能把一台服务器搞挂，就由可能搞挂全部服务器。针对这个问题，Canary Requests方案诞生了：系统接到请求后先给一台服务器发出试探请求，如果RPC处理成功，则继续下一步处理，如果RPC失败，则尝试其他服务器，如果连续失败K次，则放弃对这个请求的处理。
</p>
<p>
    <strong>7) 04&#39; QueryServingSystem:</strong>
</p>
<p>
    <center><img id="40E11546370B7B1A921387D2761A89A9" src="http://m2.img.libdd.com/farm3/5/928FCCEB26C60981C07611B594DE7805_500_372.jpg" data-pinit="registered" /></center>
</p>
<p>
    04&#39;Google已经组建了自己的IDC，机器数量也比较充足了。前端服务器被拆分成多层树状结构，叶子节点同时处理索引和网页
</p>
<p>
    。并通过repository manager的统一控制，做到了索引的增量更新，更新时不影响用户正常使用。
</p>
<p>
    在这个版本中开始抽象系统的架构概念，如repository、document、attachments、scoring functions等。
</p>
<p>
    系统能够比较容易地支持小流量实验。通过GFS等基础设施地良好支持，系统的性能也有了显著改善。
</p>
<p>
    ...
</p>
<p>
    <strong>Part II ：Techniques for building large-scale systems</strong>
</p>
<p>
    个人觉得这第二部分才是Jeff这次演讲的精华部分，都是关于large-scale systems的设计经验。当然，纸上得来终究浅，能否领悟到要点，还是得亲自实践才行。
</p>
<p>
    <strong>1) Many Internal Services:</strong>
</p>
<p>
    采用面向服务架构（<a href="http://baike.baidu.com/view/6545280.htm" target="_blank">SOA</a>），将大系统拆分成多个独立的服务。服务接口尽量简单明了，并且采用一致的契约。考虑通用契约可能会在开发阶段增加一定的工作量，但对日后服务版本升级时的测试、部署工作都会更便利。面向服务的另一个好处是开发周期的解耦，各个开发组承担相对独立的子系统维护工作，从而也便于开发组之间的跨地域合作。
</p>
<p>
    （题外话，前阵子Amazon前员工Steve Yegge也曾在<a href="http://www.mysqlops.com/2011/11/03/stevey.html" target="_blank">大篇幅的吐槽</a>中指出前CEO<a href="http://en.wikipedia.org/wiki/Jeff_Bezos" target="_blank">Jeff Bezos</a>在好几年前就提出“一切皆服务”的设计理念。可见Bezos的高瞻远瞩）
</p>
<p>
    <strong>2) Designing Efficient Systems:</strong>
</p>
<p>
    设计系统时，不应该模糊地说做到“高性能”。应该以实际情况/数据为基础，指出具体是“哪里高效”，以及“怎么做到高效”。能在构建系统之前准确地估算这些数字，也是一项不可或缺的架构能力。
</p>
<p>
    <strong>3) Numbers Everyone Should Know:</strong>
</p>
<p>
    作为系统架构师应该对于各种硬件的性能指标了然于心，以数据为基础去分析系统。
</p>
<p>
    <center><img id="87E5F92212F0A9B8429AFFD02E571804" src="http://m2.img.libdd.com/farm3/243/A1A54F51EEE5E521FA49804C33F384F3_500_284.jpg" data-pinit="registered" /></center>
</p>
<p>
    <strong>5) Back of the Envelope Calculations:</strong>
</p>
<p>
    老外比较崇尚这种信封背后的计算，即在判断一些指标时，先自己做下简单估算。比如需要估算一个含30个缩略图的result页的生成时间，Jeff是这样做的：
</p>
<p>
    方案1：串行读，假设每个缩略图256K，即耗时= 10ms/seek + 256K read  +  30 * 256K / 30MB/s = 560ms
</p>
<p>
    方案2：并行读，耗时= 10ms/seek + 256K read / 30MB/s = 18ms
</p>
<p>
    当然，这是忽略了缓存、缩略图预处理等因素，实际情况要复杂一些。采用这种方式做系统评估是最靠谱的。
</p>
<p>
    以前双十一、双十二大促时，对系统容量的估算基本上都是直接x2、x3地往上堆机器，确实是不太科学的。为什么流量翻倍，机器就一定要翻倍？原本的集群是否已经达到容量上限？容量的瓶颈是哪个点、通过计算之后具体值是多少？简单的翻倍扩容是否有其它隐患，如导致前端负载均衡爆掉、数据库连接数爆掉等等。
</p>
<p>
    <strong>6) Know Your Basic Building Blocks:</strong>
</p>
<p>
    在设计系统之前必须对公司的基础设施了如指掌，比如核心代码库、基础数据结构、底层框架、服务等。不只停留在能使用接口的层面，还要明白其实现原理。在次基础之上才有可能设计出一个靠谱的系统。
</p>
<p>
    从另一个角度理解，公司内部是需要一套完善的KM（知识管理）体系的，如何让新入职的架构师、部门级的架构师快速、全面地了解整套架构体系，也是一个挑战。
</p>
<p>
    <strong>7) Designing &amp; Building Infrastructure:</strong>
</p>
<p>
    不要只顾及自己眼前的问题，而是同时考虑到大家都可能遇到的问题，并从这个层面着手考虑解决方案。另外也不要考虑过头，想要满足全部的需求是非常困难的，一般以能满足最大客户为标准就OK了。与其让所有人都不满意，不如满足其中一小部分。
</p>
<p>
    <strong>8) Design for Growth:</strong>
</p>
<p>
    设计是充分考虑到日后的增量，以及可能增加的需求。考虑增量的范围以5倍~50倍为佳，如果超过100倍，那就不是优化了，而是整个重写。
</p>
<p>
    Pattern: Single Master, 1000s of Workers:
</p>
<p>
    <center><img id="1C55875986FC51AD528D9ABCCD35E1B7" src="http://m3.img.libdd.com/farm3/196/90DB59EB91453A83303D53D17FF9DBC4_500_180.jpg" data-pinit="registered" /></center>
</p>
<p>
    Jeff貌似很喜欢系统中有一个master。master负责全局的控制，如负载均衡、请求分配、故障切换等，worker负责具体任务。这里的要领是，要保证master尽量少地和client接触，像具体的请求处理、大数据的传输，都是client直接调用worker，不经过master。另外，master可以做热备以增加可用性。
</p>
<p>
    Pattern：Tree Distribution of Requests
</p>
<p>
    <center><img id="67498FD8675EBA71CC7A3BF1026FA2C7" src="http://m1.img.libdd.com/farm3/48/3E42AEB2743FF317C9E10FFFEA601B30_498_180.JPEG" data-pinit="registered" /></center>
</p>
<p>
    Jeff的另一个喜好是通过树形结构分散系统压力，讲一个请求分散到N个叶子节点中处理，再汇总。但这个模式有个隐患，当叶子节点太多时，root的网卡会被撑爆、导致丢包，成为瓶颈。解决办法是设计多级root，比如下图的设计，由parent分管叶子节点：
</p>
<p>
    <center><img id="46B8B774F0FA20BAE6E8320FF4F99955" src="http://m1.img.libdd.com/farm3/76/4BEA6568944AF82A924C9487DEE5BA4C_500_210.jpg" data-pinit="registered" /></center>
</p>
<p>
    Pattern: Backup Requests to Minimize Latency
</p>
<p>
    通常将任务拆分成N多子任务（比如上千个）之后，任务总体完成的时间就变得不可控了--因为总有那么几个任务在拖后腿。应对的办法就是赛跑：给慢任务多起几个task，以最快完成的那个task为准。
</p>
<p>
    先关摘录就先到这里了，理解有误的地方请不吝指正，感谢 :）<br />
</p>
<p>
    ********************************** 延伸阅读**********************************
</p>
<p>
    1.<a href="http://www.slideshare.net/frankcai/6-dean-google" target="_blank">Handling Large Datasets at Google: Current Systems and Future Directions</a>
</p>
<p>
    2.<a href="http://www.slideshare.net/longhao/dean-keynote-ladis2009" target="_blank">Designs, Lessons and Advice from Building Large Distributed Systems</a>
</p>
<p>
    -EOF-
</p>