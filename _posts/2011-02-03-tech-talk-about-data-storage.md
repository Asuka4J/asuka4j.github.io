---
layout: post
title: "分布式数据访问概要"
description: ""
category: tech
tags: [数据, 架构]
---
{% include JB/setup %}
从09年下半年开始就一直在做支付宝的交易数据复制和存储相关的系统，经历了从刚开始连‘数据分片’是什么都不知道，到新个人版项目中搭建消费记录异步复制系统（+MySQL分片），到交易主库拆分项目中搭建消费记录查询系统，到前阵子解决大商户热点数据查询问题...虽一路摸爬滚打，但多多少少也对这类大型互联网的数据存储和访问有了一些见解吧。趁着工作空挡梳理了一些相关的知识点，仅当记录。  
<!-- more -->
PS: 点击[这里](http://pic.yupoo.com/asuka4j/Bh5dBUaA/Qh29w.jpg)可以查看原图。  
PPS: 其实有不少知识点也还一知半解，后续需要再加强实践。  
PPPS: 把图放到ATIT内网，得到最Happy的评论莫过于”这图有点儿鲁肃@lusu的风格啊“ ：）  
<center><img id="62E3958A3F03CE95FCC8EB38467A2733" src="http://m2.img.libdd.com/farm5/2012/1218/19/62E3958A3F03CE95FCC8EB38467A2733553CAA76C6D25_500_1870.jpg" data-pinit="registered" /></center>