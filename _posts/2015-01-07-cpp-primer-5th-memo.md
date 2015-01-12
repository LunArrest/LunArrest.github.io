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