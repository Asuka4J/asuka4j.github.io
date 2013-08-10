---
layout: post
title: "数据有结构（一）二叉树"
description: ""
category: tech
tags: [算法]
---
{% include JB/setup %}
<center><img src="http://pic.yupoo.com/asuka4j/CKmn5K0g/medish.jpg"/></center>
二叉树应该算是‘树’这类数据结构中最为基础的一种。二叉树规定了每个节点最多只能有两个子节点，一般称为左子节点和右子节点（或左孩子和右孩子），并且这两个节点有左右顺序之分，次序不能任意颠倒。如果子节点下边还挂了子节点，可以称它为“子树”。本篇主要讲述二叉树相关的基础算法，正好最近在学习Python，代码就都使用Python表示了。  

先定义二叉树节点的数据结构：一个二叉树节点主要包含其左右子节点的引用，和自身节点携带的信息。如果左右子树都为空，则认为它是一个叶子节点。  
{% highlight python %}
"""\
    二叉树节点
"""
class BinNode:
    def __init__(self, element, leftNode, rightNode):
        self.element = element
        self.leftNode = leftNode
        self.rightNode = rightNode

    def isLeaf(self):
        if (self.leftNode == None and self.rightNode == None):
            return True
        else:
            return False
{% endhighlight %}

<!-- more -->


## 1 前中后序遍历  
遍历一颗二叉树可以有前、中、后序三种方式。从代码可以看到，三种遍历方式的区别只在于获取自身节点这个语句的位置不同。有时候比较容易混淆前序和中序的顺序，前序是：”中左右“，而中序才是“左中右”。  
{% highlight python %}
""" 前序遍历：1. 获取自身节点 2. 前序遍历左子树 3. 前序遍历右子树 """
def preOrder(root):
    if root == None:
        return
    print(root.display())
    preOrder(root.leftNode)
    preOrder(root.rightNode)

""" 中序遍历：1. 中序遍历左子树 2. 获取自身节点 3. 中序遍历右子树 """
def inOrder(root):
    if root == None:
        return
    inOrder(root.leftNode)
    print(root.display())
    inOrder(root.rightNode))

""" 后序遍历：1. 后序遍历左子树 2. 后序遍历右子树 3. 获取自身节点 """
def postOrder(root):
    if root == None:
        return
    postOrder(root.leftNode)
    postOrder(root.rightNode)
    print(root.display())
{% endhighlight %}
三种遍历方式都比较简单，这里额外插播另一种非官方的遍历：如果想按树的层次，逐层往下遍历，该怎么做呢？可以借助一个二维数组来缓存逐层遍历的结果，数组的大小是 [（[ ] * 2的“深度-1”次方） * 深度]
{% highlight python %}
""" 逐层遍历 """
def levelOrder(node, level, array):
    if node == None:
        return
    array[level].append(node.element)
    level += 1
    levelOrder(node.leftNode, level, array)
    levelOrder(node.rightNode, level, array)
{% endhighlight %}
但这样打印出来的效果还不是一颗树的形状，如果想按树形打印，请见本文的最后一节“打印二叉树”。

## 2 深度计算  
树的深度取决于左右子树中层次最深的一边，当然，还要算上自己。
{% highlight python %}
"""\
    深度计算
"""
def depth(node):
    if node == None:
        return 0
    else:
        leftDepth = depth(node.leftNode)
        rightDepth = depth(node.rightNode)
        if leftDeep >= rightDeep:
            return leftDepth + 1
        else:
            return rightDepth + 1
{% endhighlight %}

类似地，如果想获取一棵树的有效节点总数目，可以这么做：
{% highlight python %}
"""\
    获取节点数目
"""
def nodeNumbers(node):
    if node == None:
        return 0
    return nodeNumbers(node.leftNode) + nodeNumbers(node.rightNode) + 1
{% endhighlight %}

## 3 获取镜像  
镜像镜像，相当于一面镜子。把二叉树中所有子树做一次左右反转，就得到这棵树的镜像了。
{% highlight python %}
"""\
    获取镜像
"""
def mirror(node):
    if node == None:
        return
    else:
        if node.isLeaf():
            return
        temp = node.leftNode
        node.leftNode = rightNode
        node.rightNode = temp
        mirror(node.leftNode)
        mirror(node.rightNode)
{% endhighlight %}

## 4 判断是否平衡  
如果二叉树的任意节点的左右子树深度相差不超过1，则认为是平衡二叉树。这里还用到了代码清单2的深度计算方法。
{% highlight python %}
def isBalance(node):
    if node == None or node.isLeaf():
        return True

    leftDepth = depth(node.leftNode)
    rightDepth = depth(node.rightNode)
    if abs(leftDepth - rightDepth) > 1:
        return False

    return isBalance(node.leftNode) and isBalance(node.rightNode)
                    
{% endhighlight %}
上述做法比较好理解，但有个缺点，它是自上而下递归判断的，每次递归都要重复计算树高。改良的做法是能在每次递归的时候累计树高，避免重复。这里通过后序遍历的方式递归，从最低端开始判断，同时通过新增的参数currentDepth记录每次递归的树高。

{% highlight python %}
"""\ 判断是否平衡 II
    node: 二叉树
    currentDepth: 当前的树高
"""
def isBalanceII(node, currentDepth):
    if node == None or node.isLeaf():
        currentDepth = 0
        return True

    lDepth = 0
    rDepth = 0 

    # 从最底层开始往上递归判断
    if isBalanceII(node.leftNode, lDepth) and isBalanceII(node.rightNode, rDepth):
        # 相差超过1就不平衡了
        if abs(lDepth - rDepth) > 1:
            return False
        # 否则按照长的那一边累计树高
        else:
            if lDepth >= rDepth:
                currentDepth = 1 + lDepth
            else:
                currentDepth = 1 + rDepth
            return True
{% endhighlight %}

## 5 子树判断  
如果可以在树A上找到和树B完全一致的结构，则认为B是A的子树。
{% highlight python %}
"""\
    子树判断
"""
def isSubTree(node, comparedNode):
    if comparedNode == None:
        return True
    elif comparedNode != None and node == None:
        return False

    """ 从A树找到B树根节点相同的节点 """
    if node.element == comparedNode.element:
        """ 如果不是叶子节点就继续比其子节点 """
        if comparedNode.isLeaf():
            return True
        else:
            return isSubTree(node.leftNode, comparedNode.leftNode) and isSubTree(node.rightNode, comparedNode.rightNode)
    else:
        return isSubTree(node.leftNode, comparedNode) or isSubTree(node.rightNode, comparedNode)

{% endhighlight %}
## 6 打印二叉树
写了好几个算法，最终总要在屏幕上显示出来吧，不然也不知道对错呢。这里先分析下树的显示效果，主要看看父节点和子节点间、左节点和右节点间的位置关系。如下图所示，节点间的关系可以归纳为：
<center><img src="http://pic.yupoo.com/asuka4j/CKmnmDZA/medish.jpg"/></center>


基于上述分析，我们需要重新设计节点的数据结构，和对应的打印算法：

{% highlight python %}
    TODO 代码调试中...
{% endhighlight %}