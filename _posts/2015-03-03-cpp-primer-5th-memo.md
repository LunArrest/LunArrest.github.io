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

#### Logical AND and OR Operators(逻辑与/或操作符)

短路求值（short-circuit evaluation）策略:

1. &&右部分仅在其左部为true时才执行（求值）（The right side of an && is evaluated if and only if the left side is true）。
2. ||右部分尽在其左部为false时才求值（The right side of an || is evaluated if and only if the left side is false）。

#### Logical NOT Operator(逻辑非运算符)

逻辑非运算符返回其操作数真值的求反结果（The logical  NOT operator (!) returns the inverse of the truth value of its operand）。

#### The Relational Operators（关系运算符）

由于关系运算符返回bool值，所以，当连接在一起时，其结果可能会出乎意料：

{% highlight C++ %}
if (i < j < k) // true if k is greater than 1!
{% endhighlight %}

如果想达到预期的效果，需要将该表达式重写为：

{% highlight C++ %}
if (i < j && j < k)
{% endhighlight %}

#### Equality Tests and the bool Literals（等性判断以及布尔文本）

当我们要检验一个数序对象或者指针的真值时，最直接的方式是使用它的值作为判断条件：
{% highlight C++ %}
if (val) { /* ... */ } // true if val is any nonzero value
if (!val) { /* ... */ } // true if val is zero
{% endhighlight %}

但，当我们这么写的时候：
{% highlight C++ %}
if (val == true) { /* ... */ } // true only if val is equal to 1!
{% endhighlight %}
**当val不是bool值时，这个比较的结果可能并不符合我们的预期。**当val不是bool类型时，true会在==判断前被转换为val的类型：
{% highlight C++ %}
if (val == 1) { /* ... */ }
{% endhighlight %}

正如我们所见的这样，bool会被转化成另外的运算类型，false被转为0，true被转为1.

**Warning：我们应该仅当与bool类型的对象比较时使用bool文本（These literals should be used only to compare to an object of type bool）**

### 4.4. Assignment Operators（赋值运算符）

赋值运算符的左手操作数必须是一个可以被改变的左值（The left-hand operand of an assignment operator must be a modifiable lvalue）。

当赋值运算符的左右操作数类型不同时，右手操作符会被转化为左操作符的类型（If the types of the left and right operands differ, the right-hand operand is converted to the type of the left）：
{% highlight C++ %}
k = 0; // result: type int, value 0
k = 3.14159; // result: type int, value 3
{% endhighlight %}

在C++11的标准中，我们可以在赋值运算符右侧使用被大括号包裹的初始化器列表（Under the new standard, we can use a braced initializer list on the right-hand side）:

{% highlight C++ %}
k = {3.14}; // error: narrowing conversion
vector<int> vi; // initially empty
vi = {0,1,2,3,4,5,6,7,8,9}; // vi now has ten elements, values 0 through 9
{% endhighlight %}

如果左手操作数为一个内嵌类型，那么其初始化器列表中最多只能包含一个值，并且该值不会被收缩变化（If the left-hand operand is of a built-in type, the initializer list may contain at most one value, and that value must not require a narrowing conversion）。

如果是class类型，那么会发生什么取决于该类的具体细节。

如果忽略左手操作数的类型，初始化器列表可以为空，在这种情况下，编译器会生成一个值初始化的临时对象并将其赋值于左手操作数（Regardless of the type of the left-hand operand, the initializer list may be empty. In this case, the compiler generates a value-initialized temporary and assigns that value to the left-hand operand）。

#### Assignment Is Right Associative（赋值是右相关的）

{% highlight C++ %}
int ival, jval;
ival = jval = 0; // ok: each assigned 0
{% endhighlight %}

多次赋值的对象必须是同样类型的或者是可以转换为同样类型的（Each object in a multiple assignment must have the same type as its right-hand neighbor or a type to which that neighbor can be converted ）。


{% highlight C++ %}
int ival, *pval; // ival is an int; pval is a pointer to int
ival = pval = 0; // error: cannot assign the value of a pointer to an int
string s1, s2;
s1 = s2 = "OK"; // string literal "OK" converted to string
{% endhighlight %}

#### Assignment Has Low Precedence（赋值优先级低）

经常结合括号将赋值用于条件判断中（Assignments often occur in conditions. Because assignment has relatively low precedence, we usually must parenthesize the assignment for the condition to work properly）：

将：
{% highlight C++ %}
// a verbose and therefore more error-prone way to write this loop
int i = get_value(); // get the first value
while (i != 42) {
// do something ...
i = get_value(); // get remaining values
}
{% endhighlight %}

写为：
{% highlight C++ %}
int i;
// a better way to write our loop---what the condition does is now clearer
while ((i = get_value()) != 42) {
// do something ...
}
{% endhighlight %}

#### Beware of Confusing Equality and Assignment Operators（注意不要弄混等性判断和赋值操作符）

1. if (i = j)，当j为非零值时，该条件为true
2. if (i == j)，当i和j的值相等时，条件为true

#### Compound Assignment Operators（复合赋值运算符）

分为两种：数学运算操作符（arithmetic operators）和位运算操作符（bitwise operators）：

1. 数学运算操作符：+=  -=  *=  /=  %= 
2. 位运算操作符：<<=  >>=  &=  ^=  |= 

**当使用复合赋值时，左手操作数只被运算（执行）一次；而常规的赋值，该操作数会被运算（执行）两次：一次在右手边，一次在左手边。（with the exception that, when we use the compound assignment, the left-hand operand is evaluated only once. If we use an ordinary assignment, that operand is evaluated twice: once in the expression on the right-hand side and again as the operand on the left hand）**

### 4.5. Increment and Decrement Operators（自增、自减操作符）

自增、自减运算符提供了简便的给一个对象的值加1或减1的缩略记录法（The increment (++) and decrement (--) operators provide a convenient notational shorthand for adding or subtracting 1 from an object）。

这两种运算符有两种使用格式：前缀式和后缀式（There are two forms of these operators: prefix and postfix）：

1. 前缀式，增、减其操作数，并**返回已经改变的**对象做为其结果（increments (or decrements) its operand and yields the changed object as its result）。
2. 后缀式，增、减其操作数，但**返回的是改变前的原始的**对象作为其结果（increment (or decrement) the operand but yield a copy of the original,  unchanged value as its result）。

**Advice: Use Postfix Operators only When Necessary(建议：仅当必须的时候使用后缀自增、自减):**

原因很简单：前缀式不需要做一些不必要的操作（avoids unnecessary works）。它只需要增加该值，并返回增加后的结果。但是后缀式就必须要将原始的值存储起来，用以将其作为未增加/减少的值作为结果返回。如果我们不需要未增减的值，我们没有必要让编译、程序做这些事情。对于int或者pointer类型，编译器可能可以优化掉这些多余的操作，但是对于复杂的迭代器对象来说，这些额外的工作可能会占用更多的系统资源（For ints and pointers, the compiler can optimize away this extra work. For more complicated iterator types, this extra work potentially might be more costly.）。

#### Combining Dereference and Increment in a Single Expression（将解引用和自增运算符组合进一条表达式）

{% highlight C++ %}
auto pbeg = v.begin();
// print elements up to the first negative value
while (pbeg != v.end() && *beg >= 0)
cout << *pbeg++ << endl; // print the current value and advance pbeg
{% endhighlight %}

由于后缀自增运算符优先级高于解引用运算符，所以*pbeg++等价于*(pbeg++),因为pbeg++返回的是pbeg之前的值的拷贝，所以*解引用的是未增加之前的pbeg的值。

**Advice: Brevity Can Be a Virtue（简短是一种美德）：**

{% highlight C++ %}
cout << *iter++ << endl;
{% endhighlight %}

比下面的更冗长的代码要更容易并且更少出错。
{% highlight C++ %}
cout << *iter << endl;
++iter;
{% endhighlight %}

当熟悉了C++的类似的表达式后，你会发现它们更少出错（Moreover, once these expressions are familiar, you will find them less error-prone）。


#### Remember That Operands Can Be Evaluated in Any Order（请牢记，这些操作数可能以任意顺序求值）

{% highlight C++ %}
for (auto it = s.begin(); it != s.end() && !isspace(*it); ++it)
	*it = toupper(*it); // capitalize the current character
{% endhighlight %}
如此写，合法。

{% highlight C++ %}
// the behavior of the following loop is undefined!
while (beg != s.end() && !isspace(*beg))
	*beg = toupper(*beg++); // error: this assignment is undefined
{% endhighlight %}
当改为如上的while循环时，其行为是未定义的。因为“=”的左手操作数和右手操作数中都有改变beg的操作，所以行为是未定义的（both the left-hand right-hand operands to = use beg  and the right-hand operand changes beg）。

### 4.6. The Member Access Operators（成员访问操作符）

点和箭头操作符用于成员访问。点号从一个类对象中取得成员，箭头用于ptr->mem指针指向内存，同义于：(*ptr).mem。

{% highlight C++ %}
string s1 = "a string", *p = &s1;
auto n = s1.size(); // run the size member of the string s1
n = (*p).size(); // run size on the object to which p points
n = p->size(); // equivalent to (*p).size()
{% endhighlight %}

由于解引用操作符(*)的优先级低于点号（.）。所以必须要在解引用的子表达式中用括号括起来。

Exercise 4.20: Assuming that iter is a vector<string>::iterator, indicate which, if any, of the following expressions are legal. Explain the behavior of the legal expressions and why those that aren’t legal are in error.

- (a) *iter++;  可行，iter先++再解引用。
- (b) (*iter)++; 不可行，iter先解引用为string，string不包含++操作。
- (c) *iter.empty(); 不可行，先.后*，iter没有empty成员。
- (d) iter->empty(); 可行，相当于(*iter).empty，先获取vector中的string对象，后判断该对象是否为empty
- (e) ++*iter; 不可行，先*后++，string没有++操作。
- (f) iter++->empty(); 可行，先++后->

### 4.7. The Conditional Operator（条件运算符）

条件运算符（?:运算符）使我们可以在一条表达式中使用if-else逻辑（lets us embed simple if-else logic inside an expression）。

cond ? expr1 : expr2;

当条件为true，执行expr1，否者执行expr2（If the condition is true, then  expr1 is evaluated; otherwise,  expr2 is evaluated）.

#### Nesting Conditional Operations（嵌入的条件操作）

如：
{% highlight C++ %}
finalgrade = (grade > 90) ? "high pass" : (grade < 60) ? "fail" : "pass";
{% endhighlight %}

如果grade > 90，返回high pass；如果 grade <= 90，执行:后面的条件运算表达式，如果grade<60返回fail，否则pass。

**Warning（警告）**

Nested conditionals quickly become unreadable（嵌套条件运算符会使程序的可读性变差，尽量少用）. It’s a good idea to nest no more than two or three.

#### Using a Conditional Operator in an Output Expression（在输出表达式中使用条件运算符）

条件运算符的优先级相当低，一般要结合括号来使用。

{% highlight C++ %}
cout << ((grade < 60) ? "fail" : "pass"); // prints pass or fail
cout << (grade < 60) ? "fail" : "pass"; // prints 1 or 0!
cout << grade < 60 ? "fail" : "pass"; // error: compares cout to 60
{% endhighlight %}

### 4.8. The Bitwise Operators（逐位运算符、位运算符）

逐位运算符将整型操作数用作bit集合。这些运算符可以用与测试或设置单个bit（test and set individual bits）。

这些运算符同样也可以用于叫做“bitset”的可变长的、弹性尺寸的bit集合库类型。

![bitwise_operators](/images/C++Primer/bitwise_operators.png "bitwise_operators")

通常来说，如果一个操作数是一个“小整数”，那么它的值会被扩充到一个更大的整数类型。该操作数可能是有符号的也可能是无符号的。如果该操作数是有符号的并且它的值为负数，那么它的“符号位”保存着一个与机器有关的数值来标志其符号，此外，通过左移改变了一个数的符号位，这种行为是未定义的（If the operand is signed and its value is negative, then the way that the “sign bit” is handled in a number of the bitwise operations is machine dependent. Moreover, doing a left shift that changes the value of the sign bit is undefined.）。

**Warning（警告）：**
**由于我们没法保证符号位是怎么处理的，我们强烈建议，仅用无符号数作为逐位运算符的操作数（Because there are no guarantees for how the sign bit is handled, we strongly recommend using unsigned types with the bitwise operators.）。**

Bitwise Shift Operators（移位运算符）

左移运算符（<<）将在右侧插入0bit.

右移运算符（>>）的行为取决于其左操作数的类型：
1. 如果该操作数是无符号类型，则将在其左侧插入0值bit（If that operand is unsigned, then the operator inserts 0-valued bits on the left）。
1. 如果该操作数是一个有符号类型，则其行为由实现定义（由硬件环境，编译器的实现方式决定），既可能插入符号位的复制，也可能插入0值bit（if it is a signed type, the result is implementation defined—either copies of the sign bit or 0-valued bits are inserted on the left）。

Bitwise NOT Operator（按位非运算符）

按位非运算符将一个操作数的值按位取反，如果是1则变成0，如果是0则变成1（The bitwise  NOT operator (the ~ operator) generates a new value with the bits of its operand inverted. Each 1 bit is set to 0; each 0 bit is set to 1）.

Bitwise  AND ,  OR , and  XOR Operators（按位与、或、异或运算符）

按位与运算符（&），如果两个操作数的某一位都值为1则返回位值1，否则返回0.
按位或运算符（|），如果两个操作数的某一位的值有一个为1则返回1，否则返回0.
按位异或运算符（^），如果两个操作数的某一位的值有且仅有一个为1则返回1，否则返回0.

Using Bitwise Operators（使用位运算符）

略

Shift Operators (aka IO Operators) Are Left Associative（位移运算符，又叫做输入输出运算符，是左相关的）

注意以下例子：

{% highlight C++ %}
cout << 42 + 10; // ok: + has higher precedence, so the sum is printed
cout << (10 < 42); // ok: parentheses force intended grouping; prints 1
cout << 10 < 42; // error: attempt to compare cout to 42!
{% endhighlight %}

### 4.9. The sizeof Operator (sizeof运算符)

sizeof运算符返回一个类型名称或者表达式的以字节为单位的尺寸大小，右相关。（The sizeof operator returns the size, in bytes, of an expression or a type name. The operator is right associative.）。

sizeof返回的结果是一个size_t类型的常量表达式（The result of sizeof is a constant expression of type size_t）。

sizeof运算符有两种书写格式：

1. sizeof (type)
2. sizeof expr，当使用这种格式时，sizeof返回的是给定表达式的返回结果的类型的大小，并且不同寻常的是，sizeof并不对其操作数进行运算。

例如：
{% highlight C++ %}
Sales_data data, *p;
sizeof(Sales_data); // size required to hold an object of type Sales_data
sizeof data; // size of data's type, i.e., sizeof(Sales_data)
sizeof p; // size of a pointer
sizeof *p; // size of the type to which p points, i.e., sizeof(Sales_data)
sizeof data.revenue; // size of the type of Sales_data's revenue member
sizeof Sales_data::revenue; // alternative way to get the size of revenue（在C++11标准下）
{% endhighlight %}

在C++11标准下：

The result of applying sizeof depends in part on the type involved(sizeof的结果取决于其涉及的类型):

- sizeof char or an expression of type char is guaranteed to be 1（sizeof char 返回1）.
- sizeof a reference type returns the size of an object of the referenced type（sizeof 引用时，返回该引用对应的对象的类型的大小）.
- sizeof a pointer returns the size needed hold a pointer（sizeof 指针时返回指针类型的大小）.
- sizeof a dereferenced pointer returns the size of an object of the type to which the pointer points; the pointer need not be valid（sizeof 解引用的指针时，返回该指针所指的对象的类型的大小，指针不必合法）.
- sizeof an array is the size of the entire array. It is equivalent to taking the sizeof the element type times the number of elements in the array. Note that sizeof does not convert the array to a pointer（sizeof 一个数组，相当于sizeof整个数组的每个元素的总大小，而不会把它当作一个指针来运算）.
- sizeof a string or a vector returns only the size of the fixed part of these types; it does not return the size used by the object’s elements（sizeof 一个string或者vector只会返回其固定部分的类型的大小，而不会返回由其元素使用的大小）.

由于sizeof 数组，返回的是整个数组元素的总大小，因此我们可以通过数组大小除以元素大小的方式判断其元素的个数（Because sizeof returns the size of the entire array, we can determine the number of elements in an array by dividing the array size by the element size）。

如：
{% highlight C++ %}
// sizeof(ia)/sizeof(*ia) returns the number of elements in ia
constexpr size_t sz = sizeof(ia)/sizeof(*ia);
int arr2[sz]; // ok sizeof returns a constant expression 
{% endhighlight %}

由于sizeof 返回的是一个常量表达式，所以我们可以用其结果来指定数组的维度。

### 4.10. Comma Operator（逗号运算符）

逗号运算符带两个操作数，以从左到右的顺序进行运算（The comma operator takes two operands, which it evaluates from left to right）。 

逗号运算符的左表达式计算后的结果将被丢掉，其结果为其右表达式的值，如果右操作数是个左值，那么它的结果就是个左值（The left-hand expression is evaluated and its result is discarded. The result of a comma expression is the value of its right-hand expression. The result is an lvalue if the right-hand operand is an lvalue）。

### 4.11. Type Conversions（类型转换）

如果两种类型中存在一种转换，那么就称这两个类型是相关的（Two types are related if there is a conversion between them）。

#### 4.11.1. The Arithmetic Conversions（算术转换）

#### 4.11.2. Other Implicit Conversions（其余隐式转换）

#### 4.11.3. Explicit Conversions（显式转换）

转换有如下格式：

cast-name<type>(expression);

cast-name为static_cast, dynamic_cast, const_cast和reinterpret_cast其中之一。

##### static_cast

- static_cast经常用于大的算术类型给小的算术类型赋值。
- static_cast用于做编译器不会自动进行的转换。

例如：

{% highlight C++ %}
// cast used to force floating-point division
double slope = static_cast<double>(j) / i;

void* p = &d; // ok: address of any nonconst object can be stored in a void*
// ok: converts void* back to the original pointer type
double *dp = static_cast<double*>(p);
{% endhighlight %}


##### const_cast

- const_cast只能用于改变其操作数的低级const（A const_cast changes only a low-level const in its operand）
- const_cast将const对象转换为为const对象，就是所说的“casts away the const”
- 如果对象起初并非const，那我们使用const_cast则是合法的，否则是未定义。

{% highlight C++ %}
const char *cp;
// error: static_cast can't cast away const
char *q = static_cast<char*>(cp);
static_cast<string>(cp); // ok: converts string literal to string
const_cast<string>(cp); // error: const_cast only changes constness
{% endhighlight %}


##### reinterpret_cast


**Warning**

A reinterpret_cast is inherently machine dependent. Safely using
reinterpret_cast requires completely understanding the types involved
as well as the details of how the compiler implements the cast.
（reinterpret_cast原理取决于机器，安全地使用reinterpret_cast需要我们完全理解编译器进行类型转化的细节）

##### Old-Style Casts


{% highlight C++ %}
type (expr); // function-style cast notation
(type) expr; // C-language-style cast notation
{% endhighlight %}


#### 4.12. Operator Precedence Table(运算符优先级列表)

![operators_precedence1](/images/C++Primer/operators_precedence1.png "operators_precedence1")

![operators_precedence2](/images/C++Primer/operators_precedence2.png "operators_precedence2")