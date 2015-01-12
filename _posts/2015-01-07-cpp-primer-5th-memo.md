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

### 1.1. Writing a Simple C++ Program

 * 每个C++程序都包含一个或者多个函数（*functions*），其中的一个必须叫做*main*。
 * 一个函数定义包含四个元素：一个返回值类型（*a return type*），一个函数名称（*a function name*），一个被括号括住的可为空的参数列表（a possibly empty *parameter list* enclosed in *parentheses*），以及一个函数体（*function body*）
 * 函数体是一块由左大括号开始，右大括号截止的语句块（the function body, is a block of statements
starting with an *open curly brace* and ending with a *close curly*）
 * 分号标志着大部分C++语句的截止（*Semicolons* mark the end of most statements in C++.）

### 1.2. A First Look at Input/Output

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


