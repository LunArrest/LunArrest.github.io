---
layout: post
title: 《C++ Primer Fifth Edition》 阅读及学习笔记
description: 《C++ Primer Fifth Edition》 阅读及学习笔记
tags: cpp
---

## 前言

In 2011, the C++ standards committee issued a major revision to the ISO C++ standard.（2011年，C++标准协会发布了一个重大的ISO C++标准）
This revised standard is latest step in C++’s evolution and continues the emphasis on programmer efficiency.（这次的标准改进是C++进化史上的最新一步，进一步强调的程序员的效率）
The primary goals of the new standard are to（新标准的主要目标是）：

 * Make the language more uniform and easier to teach and to learn（使C++语言更统一并且更易于教学）  
 * Make the standard libraries easier, safer, and more efficient to use（使C++标准库能更简单、安全并且高效的使用）  
 * Make it easier to write efficient abstractions and libraries（使C++语言能更容易地实现抽象结构以及编写库）

## 为何读这本书？

现代的C++可以理解为由以下三部分组成：  

 1. C语言的超集的低级语言(low-level language)部分  
 2. 允许我们定义自己的类型以及组织大规模程序和系统的更高级语言功能（More advanced language features）  
 3. 标准库，提供了有用的数据结构和算法  

## 关于编译器
C++ Primer第五版这本书在编写的时候（2012年7月），常用的编译器是4.7.0版本的GNU编译器。只有一小部分特性当时还没实现，包括：构造器继承（inheriting constructors）、成员函数的引用限定符（reference qualifiers for member functions）以及正则表达式库（the regular-expression library）。

## Chapter 1. Getting Started（搞起来）

### 1.1. Writing a Simple C++ Program（写一个简单的C++程序）

 * 每个C++程序都包含一个或者多个函数（*functions*），其中的一个必须叫做*main*。
 * 一个函数定义包含四个元素：一个返回值类型（*a return type*），一个函数名称（*a function name*），一个被括号括住的可为空的参数列表（a possibly empty *parameter list* enclosed in *parentheses*），以及一个函数体（*function body*）
 * 函数体是一块由左大括号开始，右大括号截止的语句块（the function body, is a block of statements
starting with an *open curly brace* and ending with a *close curly*）
 * 分号标志着大部分C++语句的截止（*Semicolons* mark the end of most statements in C++.）

### 1.2. A First Look at Input/Output（初窥输入输出）

 * C++包含大量的标准库用于提供IO功能，而并非定义相关的输入输出语句。
 * iostream 定义了四种IO对象：  

 	1. 标注输入流：istream类型的对象cin（standard input）  
 	2. 标准输出流：ostream类型的对象cout（standard output）  
 	3. cerr以及clog，通常将cerr当作标准错误流（standard error）用于警告和错误信息（warning and error messages），clog用于程序运行时的普通信息（general information）。  


{% highlight C++ %}
#include <iostream>
int main()
{
	std::cout << "Enter two numbers:" << std::endl;
	int v1 = 0, v2 = 0;
	std::cin >> v1 >> v2;
	std::cout << "The sum of " << v1 << " and " << v2
	<< " is " << v1 + v2 << std::endl;
	return 0;
}
{% endhighlight %}

 * \#include <iostream> 告诉编译器我们想要使用iostream库。用尖括号（angle brackets）括住的部分为头部（header）  
 * \#include 必须单独写一行  
 * 头文件名称必须与 \#include 在同一行  

字符串（string literal）

#### Warning
 * 程序猿通常在调试过程中增加打印语句，类似这样的语句需要总是刷新流（flush the stream），否则，当程序挂掉（crash）的时候，输出内容可能依旧存在于缓冲区（buffer）中，会导致对程序挂掉原因的错误推测（inferences）


#### 标准库的命名空间
 * std::cout和std::endl的前缀std::表明（indicates）名称cout以及endl是定义在命名空间（namespace）std中的。
 * 命名空间能让我们避免（avoid）不经意地（inadvertent）定义和使用了与库中相同的命名（name）导致的冲突（collisions）。

### 1.3. A Word about Comments（一言以蔽C++注释）  
 * C++有两种注释：单行注释和多行注释（single-line and paired）。  
 * 单行注释以双斜线（a double slash）开始，以换行符（newline）截止。  
 * 多行注释由一对分隔符包裹（/\* 以及 \*/），由C语言继承而来。  
 * 多行注释中不能嵌套多行注释（Comment Pairs Do Not Nest）  

### 1.4. Flow of Control（控制流程）  

#### 1.4.1. The while Statement（while语法）  
 * while语句在给出的条件（a given condition）为true时循环地执行（repeatedly executes）代码片段（a section of code）  

复合赋值运算符（compound assignment operator），如 += 运算符。  
前缀自增运算符（prefix increment operator），如 ++val 运算符。  
赋值运算符（assignment operator），如 =   


#### 1.4.1.The for Statement（for语法）  

 * 每条for语句都包含两部分：语句头和语句体（a header and a body）。语句头决定了语句体多久执行一次（controls how often the body is executed）；  
 * 语句头包含三部分：初始化语句（an init-statement），条件（a condition），以及一条表达式（an expression）。  
 * 初始化语句中定义的变量只存在于该for循环中（The variable val exists only inside the for），for循环结束后不能再使用该变量。  
 * 初始化语句只在进入for循环时执行一次（The init-statement is executed only once, on entry to the for）。  
 * 条件语句每循环完一次判断一次（The condition is tested each time through the loop），循环会一直进行直至条件判断失败（The loop continues until the condition fails）。  
 * 表达式在每次for语句体执行完后执行一次。

{% highlight C++ %}
#include <iostream>
int main()
{
	int sum = 0;
	// sum values from 1 through 10 inclusive
	for (int val = 1; val <= 10; ++val)
	sum += val; // equivalent to sum = sum + val
	std::cout << "Sum of 1 to 10 inclusive is "
	<< sum << std::endl;
	return 0;
}
{% endhighlight %}

#### 1.4.3. Reading an Unknown Number of Inputs（从输入中读取未知数字）   

{% highlight C++ %}
#include <iostream>
int main()
{
	int sum = 0, value = 0;
	// read until end-of-file, calculating a running total of all values read
	while (std::cin >> value)
	sum += value; // equivalent to sum = sum + value
	std::cout << "Sum is: " << sum << std::endl;
	return 0;
}
{% endhighlight %}

while (std::cin >> value) 如果流有效（在流没有遇到错误的时候），即判定成功（true）。当我们输入一个EOF（end-of-file）或者非法的输入（输入的并非整数）时，输入流将失效。一个处于失效状态的输入流将导致条件判断为false。


### 如何从键盘中输入EOF：
 * Windows 下 为Ctrl + z 之后 回车键   
 * Unix系统下 通常为Ctrl + d   


#### 1.4.4. The if Statement（if 语句）

