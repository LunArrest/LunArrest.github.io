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
- bind：
- byte：
- class member:
- compound type:
- const:
- const pointer:
- const reference:
- const expression:
- constexpr:
- conversion:
- data member:
- declaration:
- declarator:
- decltype:
- default initialization:
- definition:
- escape sequence:
- global scope:
- header guard:
- identifier:
- in-class initializer:
- in scope:
- initialized:
- inner scope:
- integral type:
- list initialization:
- literal:
- local scope:
- low-level const:
- member:
- nonprintable character:
- null pointer:
- nullptr:
- object:
- outer scope:
- pointer:
- pointer to const:
- preprocessor:
- preprocessor variable:
- reference:
- reference to const:
- scope:
- global:
- class:
- namespace:
- block:
- separate compilation:
- signed:
- string:
- struct:
- temporary:
- top-level const:
- type alias:
- type checking:
- type specifier:
- typedef:
- undefined:
- variable:
- void*:
- void type:
- word:
- & operator:
- * operator:
- \# define:
- \# endif:
- \# ifdef:
- \# ifndef: