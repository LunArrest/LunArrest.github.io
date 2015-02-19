---
layout: post
title: 《C++ Primer Fifth Edition》 阅读及学习笔记三
description: 《C++ Primer Fifth Edition》 阅读及学习笔记三
tags: cpp
---

## Chapter 3. Strings, Vectors, and Arrays（字符串，矢量，数组）

### 3.1. Namespace using Declaration（命名空间using声明）

- 使用库中的命名要带上库的符号，显得很冗余，幸运的是使用using声明可以更简单的使用该命名空间中的成员。
- 分离的using声明，每个要用名称都需要单独声明。
- 头文件中不应该包含using声明，因为如果这么做的话，所有使用到该头部的程序都会包含该using声明，可能会导致不想见到的命名冲突。

### 3.2. Library string Type（库字符串类型）

使用string：
{% highlight C++ %}
#include <string>
using std::string;
{% endhighlight %}

#### 3.2.1. Defining and Initiallizing strings

##### Direct and Copy Forms of Initialization（直接初始化以及拷贝初始化）

- 当我们使用等号（“=”）进行初始化时，我们让编译器通过拷贝等号右边的对象的初始化器到需要创建的对象中来拷贝初始化该对象（When we initialize a variable using =, we are asking the compiler to copy initialize the object by copying the initializer on the right-hand side into the object being created.）。
- 没有使用等号进行初始化，则为直接初始化（direct initialization）