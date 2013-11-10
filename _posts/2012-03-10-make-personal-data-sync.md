---
layout: post
title: "我的家庭数据同步方案"
description: "云时代的个人存储"
category: tech
tags: [云]
---
{% include JB/setup %}
<p>
    在当下信息爆炸的时代，个人数据如何高效、可靠地存储也成了一个重要的话题（如何归类和高效检索是另外一个话题）。
</p>
<p>
    虽然随着云计算的发展和普及，现在已经有不少厂商为个人用户提供了免费、或相对廉价的云存储方案。但就目前而言，这些方案主要还是针对“单个人”的，存储空间也不是完全免费。另外把重要资料放在“别人的服务器上”，多少也有点令人不安。(这不，号称坚不可摧的Chrome浏览器昨天也<a href="http://www.36kr.com/p/89082.html" target="_blank">被黑客攻破</a>了，哪天云服务是不是也会被黑？）
</p>
<p>
    权衡之下，我还是采用本地备份的方式来搭建存储服务。主要是借助于开源的版本管理软件<a href="http://baike.baidu.com/view/183128.htm" target="_blank">SVN</a>：
</p>
<p>
   <center><img id="6C590218D93CBB875060F1E82591668E" src="http://m1.img.libdd.com/farm3/255/F607FB1AF2EF54BC75D8DE96A61305FF_500_362.jpg" data-pinit="registered" /></center>
</p>
<!-- more -->
<p style="text-align :center ;">
    （use<a href="https://www.lucidchart.com" target="_blank">Lucidchart</a> drawing）
</p>
<ul style="list-style-type :disc ;">
    <li>
        <p>
            从家里的电脑中选一台作为SVN服务器（如上图红色那台），在上面安装SVN服务端（<a href="http://www.visualsvn.com/" target="_blank">下载</a>），并根据自己的需求创建相关目录，分配权限。如果没有那么多机器，也可以直接用手头的工作的电脑做服务器，就是需要多占用一些磁盘空间而已。
        </p>
    </li>
    <li>
        <p>
            日常办公、娱乐用的笔记本就作为客户端，利用SVN客户端软件（<a href="http://tortoisesvn.net/downloads.html" target="_blank">下载</a>）向服务器获取、提交数据。
        </p>
    </li>
    <li>
        <p>
            如果条件充裕，可以腾出一些移动硬盘的空间作为SVN仓库的备份，比如定期每月一次将SVN仓库备份到移动硬盘上。没错，是备份SVN仓库！这样的好处是任何一个设备坏掉了，都可以通过其他几个设备恢复回来，保证数据不会丢。
        </p>
    </li>
</ul>
<p>
    这个方案的好处：全免费、（相对）安全、存储空间大、（局域网内）速度快。但也有一些缺点：同步数据时服务器必须是开机的（废话..），否则就不能做到随时随地提交了、SVN本身不是面向普通消费者的产品，操作起来可能会不适应。
</p>
<p>
    经过俩人几个月的试用，仓库里总共存储了上百G资料，一般也就每周做一次增量备份，每个月备份一次SVN仓库。如果您比较喜欢自己动手折腾，又能忍受上面提到的缺点的话，不妨一试：）
</p>
<p>
    <br />
</p>
<p>
    ********************************** 延伸阅读**********************************
</p>
<p>
    网盘是否靠谱：<a href="http://blog.tarwon.com/virtual-disk-game.html/" target="_blank">网盘骗局</a>
</p>
<p>
    创新的云存储：<a href="http://www.36kr.com/p/89137.html" target="_blank">挑战Dropbox，创新云存储服务Space Monkey直接把1TB硬盘摆到你家</a>
</p>
<p>
    -EOF-
</p>
