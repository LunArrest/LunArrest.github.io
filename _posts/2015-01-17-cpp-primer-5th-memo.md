---
layout: post
title: 《C++ Primer Fifth Edition》 阅读及学习笔记二
description: 《C++ Primer Fifth Edition》 阅读及学习笔记二
tags: cpp
---

最基本的通用功能包括：  

 * 内建类型  
 * 变量  
 * 控制结构  
 * 函数  

C++ 是静态类型语言，类型在编译阶段就检查完毕。因此，编译器必须知道每个程序中每个名称的类型。


## Chapter 2. Variables and Basic Types（变量和基本类型）


### 2.1. Primitive Build-in Types（基本内建类型）

#### 2.1.1. Arithmetic Types（算术类型）

算术类型分为两种：整型（integral types） 以及 浮点型（floating-point types）

### 2.6. Defining Our Own Data structures（定义我们自己的数据结构）

数据结构是组织数据和使用该数据策略的一种方法。第一方式如下：

{% highlight C++ %}
struct Sales_data {
	std:: string bookNo;
	unsigned units_sold = 0;
	double revenue = 0.0;
};
{% endhighlight %}

**struct在定义结束的时候一定要跟上分号";"。**

可以通过如下方式定义这个类型的变量：

{% highlight C++ %}
struct Sales_data { /* ... */ } accum, trans, *salesptr;
// equivalent, but better way to define these objects
struct Sales_data { /* ... */ };
Sales_data accum, trans, *salesptr;
{% endhighlight %}

在C++11的新标准中，我们可以给数据成员(data member)提供一个类中的初始化器(in-class initializer)，当我们创建对象的时候，该类中初始化器将用于初始化数据成员。没有初始化器的成员被默认初始化。

#### 2.6.3 Write Our Own Head Files（实现自己的头文件）

- 我们可以在函数中定义类，这种类一般都功能有限，所以，通产类不会在函数中定义。
- 为了确保在各个文件中的类定义相同，类一般定义在头文件中。一般来讲，类存在于与之相同名字的头文件中。比如：string类定义在string头文件中。
- 头文件中通常包含在任意文件中只能定义一次的条目（例如类定义，const 和 constexpr变量）。
- 头文件通常也会用到其余头文件中的功能。
- 当头文件发生变化时，所有用到该头文件的源文件都必须进行重新编译以获得新的或者变化后的声明。

#### A Brief Introduction to the Preprocessor（预处理器的简单介绍）

最通用的让多次引用头文件安全的技术就是依赖于预处理器。C++的预处理器继承自C语言，是一个在编译前改变源文件和程序的程序。

当预处理器看到“#include”时，将指定的头文件的内容替换到该位置。

C++程序通过使用预处理器来实现头文件保护，头文件保护依赖于预处理器的变量。

预处理器的变量包含两种状态：已定义以及未定义，**预处理器变量并不遵循C++的作用域规则**，如代码：

{% highlight C++ %}
#ifndef SALES_DATA_H
#define SALES_DATA_H
#include <string>
struct Sales_data {
std::string bookNo;
unsigned units_sold = 0;
double revenue = 0.0;
};
#endif
{% endhighlight %}

### Defined Terms（术语）

- address：地址，一byte在内存可寻的数字
- alias declaration：别名声明，C++11标准中通过using name = type的语法来声明类型的别名，对应从前的typedef
- arithmetic types：算术类型，代表boolen值，字符，整数和浮点数的内建类型
- array：数组，包含了一系列可通过索引访问的无名对象的数据结构
- auto：C++11标准中的，通过变量初始化器推断类型的说明符
- base type：类型说明符，可以被const修饰，声明语句的开头部分。
- bind：将一个名称与一个已给出的条目相关连，以至于我们可以使用该名称来使用那个潜在的条目。例如，引用就是一个与对象绑定的名称。
- byte：内存的最小单位，在大部分机器上是8位。
- class member: 类的一部分。
- compound type: 依据其他的类型定义的类型。
- const: 类型修饰符，用于定义对象不能被改变。const对象必须被初始化，因为没有任何方式可以在其定义后被赋值。
- const pointer: 常量指针，指针本身是常量，不可变。
- const reference: 口语化的“常量对象的引用”
- const expression: 常量表达式，可在编译阶段解读的表达式
- constexpr: 在C++11标准中，可以通过constexpr让编译器在编译过程中校验声明语句是否为常量表达式，代表了常量表达式的变量。
- conversion: 转换，类型转换，从一个类型变成另一个类型。C++语言定义的转换在内建类型中。
- data member: 组成对象的数据元素。
- declaration: 声明语句（我是这么理解的...），断言变量、函数、或者在别处定义类型的存在（ Asserts the existence of a variable, function, or type defined
elsewhere）。声明让程序知晓某个名称（A declaration makes a name known to the program）。名称在定义或者声明前不能被使用。
- declarator: 说明符，声明语句的一部分，包含了一个被定义的名称以及类型修饰符（可有可无）。
- decltype: C++11标准中，通过某个变量或者表达式来推断类型。
- default initialization: 对象在没有别显式地指定时的初始化操作（How objects are initialized when no explicit initializer is given）。类类型（class type）对象如何初始化取决于该类。全局范围内的内建类型对象会被初始化为0；在局部范围内的未初始化对象的值未定义。
- definition: 定义，为指定类型的变量分配存储空间（可以同时包含初始化该变量）。
- escape sequence: 转义（逃脱）序列。Alternative mechanism for representing characters, particularly
for those without printable representations. An escape sequence is a backslash
followed by a character, three or fewer octal digits, or an x followed by a
hexadecimal number.
- global scope: 在其他所有范围外的范围。
- header guard: 利用预处理器变量实现的防止头文件被引用了不止一次。
- identifier: 标识符，一系列的字符用于标注一个名字。标识符是区分大小写的（Sequence of characters that make up a name. Identifiers are case-sensitive）。
- in-class initializer: 类内初始化器。作为类数据成员声明的一部分。必须紧跟等号“=”出现或者被包含在大括号内。
- in scope: 在作用域中。名称在该范围是可以见的。
- initialized: 初始化，在定义一个变量的同时给出他的初始值。变量通常都需要初始化。
- inner scope: 内部作用域，在别的作用域范围中的作用域。
- integral type: 整型（相对于浮点类型，包含在算术类型中），包括字符型和布尔（boolean）类型
- list initialization: C++11标准中，将多个初始化器用大括号包包围而组织起来的初始化语句（Form of initialization that uses curly braces to enclose one or more initializers）。
- literal: 文本。类似于一个数字，一个字符，一个字符串，值不会被改变。不知道怎么翻译，知道是什么意思。（A value such as a number, a character, or a string of characters. The value cannot be changed. Literal characters are enclosed in single quotes, literal strings in double quotes）
- local scope: 局部作用域，口语化的“块作用域”的同义词
- low-level const: 相对于top-level，这种常量可以理解为是与类型绑定，并且不可忽略的（A const that is not top-level. Such consts are integral to the type and are never ignored），比如：某个指针本身不是常量，但是其指向的对象被理解为是常量。
- member: 成员，类的一部分（part of a class）
- nonprintable character: 不可打印字符，就是看不见、没有任何视觉实体，但是却又有实际意义的字符。比如控制字符，退格，换行等等。
- null pointer: 空指针，一个值为0的指针，合法，但是不指向任何对象。
- nullptr: C++11标准中的，代表着空指针的文本常量。
- object: 对象，一块具有类型的内存（A region of memory that has a type）。变量是一个拥有名称的对象（ A variable is an object that has a name）。
- outer scope: 外部作用域，相对于 inner scope，包含内部作用域的作用域就被称之为外部作用域。
- pointer: 指针，一个保存着另外一个对象的地址的对象，可以为对象的尾部，也可以是0（the address one past the end of an object, or zero）。
- pointer to const: 这个保存着常量对象（看起来是）的地址的指针。不可以通过该指针来改变该对象。
- preprocessor: 预处理器，在C++程序编译阶段运行的一部分程序。
- preprocessor variable: 预处理器变量，受预处理器管理，在C++程序编译前将该变量的值替换为内容。
- reference: 引用，对象的别名（An alias for another object）。
- reference to const: 常量的引用，不能通过该引用（别名）来改变该对象的值。
- scope: 作用域，名字具有意义的范围（The portion of a program in which names have meaning），C++中包含如下几种。
    - global: 全局作用域，全局可用
    - class: 类作用域，在类中
    - namespace: 命名空间作用域，在该命名空间中可用
    - block: 块作用域，在该块中可用
- separate compilation: 分别编译，将一个程序分割成多个原文件的能力。
- signed: 有符号的，可以为负，正，0.
- string: 字符串，库类型。（library type representing variable-length sequences of characters）
- struct: 结构体，用于定义类的关键字。
- temporary: 临时（对象），编译器通过解析表达式时创建的无名对象，A temporary exists until the end of the largest expression that encloses the expression for which it was created
- top-level const: 相对于low-level const，该对象本身不能修改。
- type alias: 类型别名，某个类型的同意词。
- type checking: 类型确认，用于描述编译器在校验对象与所给类型是否相同的术语（Term used to describe the process by which the compiler verifies that the way objects of a given type are used is consistent with the definition of that type）。
- type specifier: 类型说明符，就是类型的名字，如：int
- typedef: 用于定义类型的别名
- undefined: 未定义，语言本身没有给出特定含义的用法。
- variable: 未初始化，变量在定义的时候没有给出初始值。
- void*: 可以指向任意非空类型对象的指针类型，不能被解引用。
- void type: 空类型，心里上标明：不包含任意操作，不包含任意值。不能定义任何void类型的变量。
- word: 字，机器进行整数类型运算时的自然单位，一般在一个32位的机器上，一个字的大小是4个byte。
- & operator: 取地址预算符，返回对象的地址
- * operator: 解引用运算符，将一个指针解析成它所指的对象。
- \# define: 预处理指令，用于定义一个预处理器变量
- \# endif: 预处理指令，与# ifdef和# ifndef组成条件判断
- \# ifdef: 预处理指令，判断所给的预处理器变量变量是否已被定义
- \# ifndef: 预处理指令，判断所给的预处理器变量是否未被定义