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

一元加运算符返回一个（可能被提升的）它的操作数的拷贝。一元减运算符返回一个（可能被提升的）对其操作数的值的拷贝的求负/求反的结果（The unary minus operator returns the result of negating a (possibly promoted) copy of the value of its operand）

如：

{% highlight C++ %}
int i = 1024;
int k = -i; // k = -1024
bool b = true;
bool b2 = -b; // b2 is true!
{% endhighlight %}

**bool类型不应该用于运算。-b的结果就是个很好的需要牢记在心的例子。**
因为在绝大多数操作符和操作数中，bool类型会被提升（are promoted）为int。在此例子中，bool值为true，当提升为int时，其值为1，求负之后，该值为-1.-1被转化为bool类型并用于b2的初始化。由于初始化器是个非0值，所以初始化为bool值的true，因此，b2的值为true。

**Caution：Overflow and Other Arithmetic Exceptions（注意，溢出和其他运算异常）**

1. 一部分未定义的异常取决于数学的本性（nature of mathematics数学的基本规则），比如：除以0。
2. 一部分未定义的异常取决于计算机的本性（nature of computers），比如：溢出。当一个值的运算超过该类型能表现的范围时就会发生溢出。

整数与整数之间的除法返回整数。如果其商中包含小数部分，该部分将被截为0（Division between integers returns an integer. If the quotient contains a fractional part, it is truncated toward zero）。

%操作符，作为求余（remainder）或者取模（modulus）操作符。

在除法中，当两个操作数同符号时，其非0商为正，否则反之（otherwise）。早期版本的C++语言允许负数商向上或者向下取整，而在新标准下，它将被截断为0（总觉得不应该这么理解）（Earlier versions of the language permitted a negative quotient to be rounded up or down; the new standard requires the quotient to be rounded toward zero (i.e., truncated)）.

在C++11中(书中原话暂时附上，应为暂时不能很好的理解)：
The modulus operator is defined so that if m and n are integers and n is nonzero,
then (m/n)*n + m%n is equal to m. By implication, if m%n is nonzero, it has the same
sign as m. Earlier versions of the language permitted m%n to have the same sign as n
on implementations in which negative m/n was rounded away from zero, but such
implementations are now prohibited. Moreover, except for the obscure case where -m
overflows, (-m)/n and m/(-n) are always equal to -(m/n), m%(-n) is equal to
m%n, and (-m)%n is equal to -(m%n). More concretely：

{% highlight C++ %}
21 % 6; /* result is 3 */ 21 / 6; /* result is 3 */
21 % 7; /* result is 0 */ 21 / 7; /* result is 3 */
-21 % -8; /* result is -5 */ -21 / -8; /* result is 2 */
21 % -5; /* result is 1 */ 21 / -5; /* result is -4 */
{% endhighlight %}


### 4.3. Logical and Relational Operators（逻辑与关系运算）

1. 关系运算符搭配运算或者指针类型的操作数；逻辑运算符搭配所有可以转化为bool类型的操作数（The relational operators take operands of arithmetic or pointer type; the logical operators take operands of any type that can be converted to bool）。
2. 这些运算符返回bool类型的值（These operators all return values of type bool）。
3. 0值的运算和指针操作数为false，否则为true。
4. 这些运算符的操作数都是右值，并且返回的值为右值。

如图：

![logical_relational_operators](/images/C++Primer/logical_relational_operators.png "logical_relational_operators")

