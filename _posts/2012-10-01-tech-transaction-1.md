---
layout: post
title: "事务（一）事务基础"
description: ""
category: tech
tags: [tx, 分布式系统]
---
{% include JB/setup %}
在面试开发工程师的时候，我很喜欢出一道关于银行间账户转账的编程题，一来是看看代码写的怎么样，二来是考察对事务的理解如何。但比较遗憾的是，能答对的人寥寥无几，其中不乏来自大型互联网公司、或者做资金相关系统的同学。这里就索性把事务相关的问题做一个梳理，做点知识沉淀。第一篇先谈谈事务的ACID四个基础属性。  
###ACID
<h2><span class="label ”>Atomic</span></h2>  
原子性，事务作为一个整体被执行，包含在其中对数据库的操作，要么全部一起执行，要么都不执行。  
eg.
<h2><span class="label label-info">Consistency</span></h2>  
一致性，事务确保数据库从一个一致状态切换到另一个一致状态，不会出现数据不一致的情况。
这里的一致状态即数据的完整性约束，比如

<h2><span class="label label-info">Isolation</span></h2>  
隔离性，当多个事务并发执行时，一个事务的执行不应该影响到其它事务。


<h2><span class="label label-info">Durability</span></h2>  
持久性，事务结束时状态是持久稳定的。


###隔离级别
<h2><span class="label label-info">Atomic</span></h2>
<h2><span class="label label-info">Atomic</span></h2>
<h2><span class="label label-info">Atomic</span></h2>
<h2><span class="label label-info">Atomic</span></h2>


###事务恢复

###广义事务
不只是数据库，泛指各种保存用户状态的资源管理器（RM），比如消息队列，KV，缓存，文件。