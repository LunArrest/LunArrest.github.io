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

### Defined Terms（术语）

- begin: 开始，string 和 vector 的成员函数，用于返回指向第一个元素的迭代器。同时也是C++11标准中用于返回指向数组第一元素的的指针的独立函数。
- buffer overflow: 缓冲区溢出，当我们使用string、vector或者array的越界下标时导致的严重bug（Serious programming bug that results when we use an index
that is out-of-range for a container, such as a string, vector, or an array）。
- C-style strings: C语言风格的字符串，‘\0’结尾的字符数组（Null-terminated character array）。String文本(string literal)就是C风格的字符串（出于兼容考虑），C语言风格的字符串本身就容易出错（C-style strings are inherently error-prone）。
- class template: 类模板，一个可以创建特定类型的模板、蓝图（A blueprint from which specific clas types can be created）。
- compiler extension: 编译器扩充功能，个别编译器独有的特性。依赖于编译器扩充功能的的程序很难在编译器间移植。 
- container: 容器，一种用于存储一系列给定类型对象的对象的那种类型（A type whose objects hold a collection of objects of a given type.）。
- copy initialization: 拷贝初始化，使用“=”符号进行初始化的初始化格式。新创建的对象是一给出的初始化器的一份拷贝。
- difference_type: vector和string中定义的用于保存两个迭代器之间的距离的有符号算术类型（A signed integral type defined by vector and string that
can hold the distance between any two iterators.）。 
- direct initialization: 直接初始化，不包含“=”符号的初始化格式。
- empty: 空，string和vector的成员函数，返回bool类型的值，当为true时size为0，size不为0时返回false。
- end: 结尾，string和vector的成员函数，用于返回刚好过尾的迭代器。同时也是用于返回指向数组最后一个元素后面的那个指针的独立函数（Member of string and vector that returns an off-the-end iterator. Also,
freestanding library function that takes an array and returns a pointer one past
the last element in the array）。
- getline: string头中定义的函数，从输入流istream中读一行字符串。换行符被读取但不保存。
- index: 索引，用于通过下标迭代器从string，vector，array中检索值。
- instantiation: 实例化，编译器生成指定的模板类或者函数的操作（Compiler process that generates a specific template class or
function.）。
- iterator: 迭代器，一种用于访问和遍历容器中元素的类型（A type used to access and navigate among the elements of a container）。
- iterator arithmetic: 迭代器运算，
- null-terminated string: “\0”结尾的字符数组。
- off-the-end iterator: 刚好过容器末尾的，指向一个不存在的元素的迭代器（The iterator returned by end that refers to a nonexistent
element one past the end of a container）。
- pointer arithmetic: 指针运算。
- ptrdiff_t: 在cstddef头文件中定义的与机器相关的存储范围足够大的用于保存数组中两个指针之间的差的一种有符号算术类型（Machine-dependent signed integral type defined in the cstddef
header that is large enough to hold the difference between two pointers into the
largest possible array）。
- push_back: vector的成员函数，用于向vector后端添加元素。
- range for: 范围for循环。用于循环访问指定集合的值的控制语句（Control statement that iterates through a specified collection of values）。
- size: string和vector的成员函数，返回size_type类型的元素个数。
- size_t: 在cstddef头文件中定义的与及其相关的存储范围足够大的用于保存数组长度的类型。
- size_type: string和vector中定义的名字。用于存储string或者vector的大小。库中定义了的size_type的都为无符号类型。
- string: 代表着字符序列的库类型（Library type that represents a sequence of characters）。
- using declarations: 使用声明，使命名空间的某个名称可以被直接使用。如：using namespace::name
- value initialization: 值初始化，用于初始化一个有大小的但是没有元素初始化器的容器。元素被初始化为一个编译器生成值的拷贝。
- vector: 矢量，用于保存指定类型的元素集的库类型。
- [] operator: 下标操作符，（Subscript operator. obj[i] yields the element at position i from
the container object obj. Indices count from zero—the first element is element 0
and the last is the element indexed by obj.size() - 1. Subscript returns an
object. If p is a pointer and n an integer, p[n] is a synonym for *(p+n)）下标返回的是对象。
- -> operator: 箭头操作符，包含解引用和点操作符，a->b等同于(*a).b
- << operator: 输出操作符，The string library type defines an output operator. The string
operator prints the characters in a string
- \>\> operator: 输入操作符，The string library type defines an input operator. The string
operator reads whitespace-delimited chunks of characters, storing what is read
into the right-hand (string) operand.
- ! operator: 逻辑非操作符，返回作为bool值的操作数的反（ogical  NOT operator. Returns the inverse of the bool value of its
operand. Result is true if operand is false and vice versa）。
- && operator: 逻辑与操作符，当左右两边的操作数都是true时，返回true，仅当左操作符为true时才判断右操作符（Logical  AND operator. Result is true if both operands are true.
The right-hand operand is evaluated  only if the left-hand operand is true）。
- || operator: 逻辑或操作符，当左右量表的操作符有一个为true时，则返回true，仅当左操作符为false时才判断右操作符（Logical  OR operator. Yields true if either operand is true. The right-
hand operand is evaluated  only if the left-hand operand is false）。