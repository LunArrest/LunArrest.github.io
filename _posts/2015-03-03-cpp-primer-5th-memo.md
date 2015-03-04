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

#### 4.1.3 Order of Evaluation(求值顺序、执行顺序)

优先级指定了操作数是如何组合的，但是并没有明确说明操作数的求值顺序。在大多数情况下，这种顺序是很大程度上未指明的（In most cases, the order is largely unspecified.）。

比如：

{% highlight C++ %}
int i = f1() * f2();
{% endhighlight %}

我们知道在乘法之前，f1和f2一定会被调用，但是我们无从知道究竟是f1还是f2先被调用（we have no way of knowing whether f1 will be called before f2 or vice versa）。

对于那些没有指定求值顺序的操作符，当在一个表达式中改变同一个对象时，会发生错误。这样做的表达式的行为是未定义的。如：

{% highlight C++ %}
int i = 0;
cout << i << " " << ++i << endl; // undefined
{% endhighlight %}

输出操作符并不保证它的操作数是如何被运算的，编译器可能先运算++i也有可能先运算i，因此该段程序的行为是未定义的。

Advice: Managing Compound Expressions（关于管理复合表达式的建议）：

1. 当你不确定（优先级）时，使用括号来强制让程序的逻辑变成你想要的样子（When in doubt, parenthesize expressions to force the grouping that the logic of your program requires）。
2. 如果你需要改变一个操作数的值，不要在同一个表达式中再使用该操作数（If you change the value of an operand, don’t use that operand elsewhere in the same expresion）。

### 4.2. Arithmetic Operators(算术操作符、运算符)

一元算术运算符的优先级高于乘/除运算符，乘/除运算符优先级高于二元加/减运算符。这些运算符都是左结合的（left associative），意味着，当优先级相同时从左到右组织（group left to right）。如图所示：

![arithmetic_operators](/images/C++Primer/arithmetic_operators.png "arithmetic_operators")

由这些运算符及操作数返回结果为右值。