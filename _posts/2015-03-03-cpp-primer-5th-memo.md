---
layout: post
title: 《C++ Primer Fifth Edition》 阅读及学习笔记四
description: 《C++ Primer Fifth Edition》 阅读及学习笔记四
tags: cpp
---

## Chapter 4. Expressions（表达式）


- 表达式一般由一个或者多个操作数组成，并且在evaluated（求值、执行？）的时候生成（yield返回）一个结果。
- 最简单的表达式的格式是只有单个变量或者文本。
- 复杂的表达式的格式包含一个操作符以及一个或者多个操作数。  


### 4.1. Fundamentals（基础）

#### 4.1.1 Basic Concepts（基础章节）

有一元运算符和二元运算符（There are both  unary operators and  binary operators）：

1. 一元运算符作用于一个操作数，比如取地址“&”和解引用“*”
2. 二元运算符作用于两个操作数，比如等于“==”和乘法“*”

##### Grouping Operators and Operands（组织操作符和操作数）

理解包含多个运算符的表达式需要理解运算符的优先级（precedence）以及关联性（associativity），并且有可能与操作数的求值顺序（may depend on the  order of evaluation of the operands）有关。

##### Operand Conversions（操作数转化）

在执行表达式的时候，操作数经常会从一种类型转化成另外一种类型。

##### Overloaded Operators（操作符重载）

C++语言已经定义了应用于内建类型时的操作符的含义，但是我们可以自定义作用于class类型的绝大多数的操作符的含义。但是操作符的操作数数量、优先级和关联性无法被改变（the number of operands and the precedence and the associativity of the operator cannot be changed）。

##### Lvalues and Rvalues（左值及右值）

左值可以在赋值符号“=”左边，而右值不行。

粗略来讲（Roughly speaking），当我们将一个对象用作一个右值的时候，我们使用的是该对象的内容；当我们讲一个对象用作一个左值的时候，我们使用的是该对象的身份（即在内存中的位置）。

目前已经用过的调用左值（invoke lvalues）的操作符包含：

1. 赋值“=”，需要一个非常量的左值作为左操作数，并返回该做操作数作为一个左值。
2. 取地址“&”，需要一个左值操作数，并返回一个指向该操作数的指针作为右值。
3. 内建的解引用“*”以及下标操作和迭代器的解引用及string、vector的下标操作都会返回一个左值。
4. 内建的及迭代器的自增自减操作符“++”、“--”需要一个左值操作数，并返回一个左值。

当使用decltype时也存在左值和右值的差别：当decltype中的表达式生成的是一个左值时，其结果是一个引用。

##### Precedence and Associativity(优先级及关联性)

包含两个或以上的操作符的表达式称为“复合表达式”（compound expression）。优先级与关联性是用于判断这些操作数是如何组织在一起的。程序员可以通过使用括号来改变这些规则以强制形成一种参数组织格式。


1. 高优先级的操作数和操作符结合的比低优先级的操作数和操作符更紧密（Operands of operators with higher precedence group more tightly than operands of operators at lower precedence）。
2. 关联性决定如何组织相同优先级的操作数（Associativity determines how to group operands with the same precedence.）。

> 例如：
> 
> 1. 因为优先级的存在，3+4*5得23，而非35；
> 2. 因为关联性的存在，20-15-3得2，而非8.

##### Parentheses Override Precedence and Associativity(括号重载优先级和关联性)

包含括号的表达式在执行时把各个由括号括住的字表达式当作一个整体，并遵循基本的优先级规则（Parenthesized expressions are evaluated by treating each parenthesized subexpression as a unit and otherwise applying the normal precedence rules）。

##### When Precendence and Associativity Matter（何时与优先级、关联性有关）

例如：


{% highlight C++ %}
int ia[] = {0,2,4,6,8}; // array with five elements of type int
int last = *(ia + 4); // initializes last to 8, the value of ia [4]
last = *ia + 4; // last = 4, equivalent to ia [0] + 4
{% endhighlight %}


{% highlight C++ %}
cin >> v1 >> v2; // read into v1 and then into v2
{% endhighlight %}

