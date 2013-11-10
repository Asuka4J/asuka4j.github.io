---
layout: post
title: "数据有结构（二）二叉查找树"
description: ""
category: tech
tags: [算法]
---
{% include JB/setup %}
我们知道，一般有两种结构可以用在做数据索引：哈希和树，两者在查找功能上最显著的一个区别是，哈希只支持恒等查询，而树支持范围查询。二叉查找树（BinarySearchTree or BinarySortTree or BST）就是一个为范围查询设计的树，它是满足如下性质的二叉树或空树：  
1. 如果左子树非空，则左子树节点的值都小于根节点  
2. 如果右子树非空，则右子树节点的值都大于根节点  
3. 左右子树也是一颗二叉查找树  

先定义BST的节点数据结构，其实和上一篇的二叉树结构基本相同，只是增加了一个频率字段，具体请见后续说明。
{% highlight python %}
"""\
    BST节点
"""
class BSTNode:

    def __init__(self, element, leftNode, rightNode):
        self.element = element
        self.leftNode = leftNode
        self.rightNode = rightNode
        self.freq = 0

    """ 频率递增 """
    def freqUp(self):
        self.freq += 1
  
    """ 频率递减 """
    def freqDown(self):
        if self.freq > 0:
            self.freq -= 1
{% endhighlight %}

<!-- more -->
## 1 插入节点
往BST插入节点的算法遵循上述的3点性质。需要注意的是，现实中可能会碰到节点已经存在的情况，所以这里给节点增加一个频率属性，碰到重复节点时就递增该字段。删除时也类似，当频率属性大于零时，就先递减，而不是直接删除。

{% highlight python %}
"""\
    插入节点
    node: the BST
    element: new BST node
"""
def insert(node, element):
    # 如果是空树，直接初始化根节点 
    if node == None:
        return BSTNode(element, None, None)
    else:
        # 等于当前节点，累计频率
        if node.element == element:
            node.freqUp()
            return node

        # 小于当前节点，插入到左子树 
        elif node.element > element:
            node.leftNode = insert(node.leftNode, element)
            return node

        # 大于当前节点，插入到右子树 
        else:
            node.rightNode = insert(node.rightNode, element)
            return node
{% endhighlight %}

## 2 删除节点
删除操作应该算是BST中最复杂的操作了，因为删除一个节点的时候，要考虑挂在它下边的左右子树怎么重新排列。这里有几种情况：  
1. 没有左右子节点，最简单，直接删除就好了  
2. 只有一个左或右节点，直接拿这个节点替代当前节点  
3. 存在左右子节点，这里需要拿右节点替代当前节点。另外，如果右节点也是有子节点怎么办呢？一个比较简单的方式是，直接拿右子树的最小节点来替代当前删除的节点，这样删除节点之后仍然是一颗BST。画个图就比较直观了：
<center><img src="http://pic.yupoo.com/asuka4j/CKmy1GTf/medish.jpg"></center>

{% highlight python %}
"""\
    删除节点
    node: the BST
    element: node to delete
"""
def delete(node, element):
    if node == None:
        return

    if node.element > element:
        delete(node.leftNode, element)
    if node.element < element:
        delete(node.rightNode, element)

    if node.element == element:
        if node.freq > 0:
            node.freqDown()
        else:
            # 对于存在双子节点的情况，就拿右子树的最小节点来替代当前节点
            if node.leftNode != None and node.rightNode != None:
                minNode = getMin(node)
                minNode.leftNode = node.leftNode
                minNode.rightNode = node.rightNode
                delete(node, minNode.element)
                node = minNode
            elif node.leftNode != None and node.rightNode == None:
                node = node.leftNode
            elif node.leftNode == None and node.rightNode != None:
                node = node.rightNode
            else:
                node = None

"""\
    获取BST子树中的最小元素
"""
def getMin(node):
    if node.leftNode == None:
        return node
    return getMin(node.leftNode)
{% endhighlight %}

## 3 查找节点
辛辛苦苦构建这颗树，就是用来做范围查询的。目前我们构建的BST已经支持从min到max的范围查询，按照中序遍历可以将结果以升序的方式输出，这样也省去了重排序的步骤。  
{% highlight python %}
"""\ 
    按范围搜索 
    node: BST
    min: min value
    max: max value
    result: search result
"""
def searchII(node, min, max, result):
    if node == None or min > max:
        return
    # 只要当前元素小于MIN就继续遍历左子树
    if node.element > min:
        searchII(node.leftNode, min, max, result)
    # 满足条件就添加
    if node.element >= min and node.element <= max:
        result.append(node.element)
    # 只要当前元素小于MIN或不超过MAX就继续遍历右子树
    if node.element < min or node.element <= max:
        searchII(node.rightNode, min, max, result)
{% endhighlight %}

## 4 树的退化
很完美是不？噢不，可能你也发现了，其实BST是一个静态的结构，树的形状完全依赖于录入元素的顺序。在一些极端情况会导致树长歪，比如我们依次录入的元素是：0、1、2、3、...1000，生成的BST就退换成一条链表了。这就提现不出二叉检索的优越性了。有什么改良的办法吗？当然有了，既然是为了让BST一直保持平衡，那就在插入和删除节点的时候做控制，保证每次修改之后BST一直处于平衡状态。请见下一篇[平衡二叉树](http://jiaqing.me/)
