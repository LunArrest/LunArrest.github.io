---
layout: post
title: markdown语法学习笔记
---

Markdown语法参考：       <http://wowubuntu.com/markdown/>

Markdown编辑器：

 1. [markdownpad] 功能强大的md编辑器
 2. [sublimetext] 功能强大的文本编辑器

## 简介

 * Markdown的目标是实现“易读易写”，成为一种适用于网络的书写语言。
 * HTML是一种发布的格式，Markdown是一种书写的格式。

## 兼容HTML

 * 不在Markdown涵盖范围内的标签，都可以直接在文档里用HTML撰写。不需要额外标注这是HTML还是Markdown。
 * 如果‘&’字符是HTML字符实体的一部分，它会保留原状，否则它会被转换成‘&amp;’。
 * 如果‘<’符号作为HTML标签的定界符，那么Markdown不会对它做任何转换，否则会被转换为‘&lt;’

### 例1 嵌套HTML
这是一个普通段落。
<table>
    <tr>
        <td>Foo</td>
        <td>*Foo</td>
    </tr>
</table>
这是另一个普通段落。

### 例2 HTML字符转换
&copy;  
AT&T  
4 < 5  

## 段落和换行
 * 一个Markdown段落是由一个或多个连续的文本组成，它的前后要有一个以上的空行。（若某一行只包含空格和制表符，则该行也会被视为空行）
 * 普通段落不该用空格或制表符来缩进。
 * 如果想要依赖Markdown插入“&lt;br/>”标签的话，在插入处先按入两个以上的空格然后回车。

### 例1 段落
行一
直接换行  
两个空格后换行

## 标题
 + Markdown支持两种标题的语法，类Setext和类atx形式。
 + 类Setext形式是用底线的形式。‘=’（最高阶标题）和‘-’（第二阶标题）。
 + 类atx形式则是在行首插入 1 到 6 个‘#’，对应到标题 1 到 6 阶。
 + 你可以选择性地「闭合」类atx样式的标题，这纯粹只是美观用的，若是觉得这样看起来比较舒适，你就可以在行尾加上‘#’，而行尾的‘#’数量也不用和开头一样（行首的井字符数量决定标题的阶数）

### 例1 setext形式标题

最高阶标题
==========

第二阶标题
----------

### 例2 atx形式标题

# h1  

## h2  

### h3  

#### h4  

##### h5  

###### h6  

## 区块引用
 - Markdown标记区块引用是使用类似 email 中用 ‘>’的引用方式，看起来像是自己先段好行，然后在每行最前面加上‘>’。

### 例1 普通区块引用
> What are GitHub Pages?  
> User, Organization, and Project Pages  
> Creating Pages with the automatic generator  
> Creating Project Pages manually  
> Using Jekyll with Pages  
> About custom domains for GitHub Pages sites  
> Setting up a custom domain with GitHub Pages  
> Tips for configuring a CNAME record with your DNS provider  
> Adding a CNAME file to your repository  
> Tips for configuring an A record with your DNS provider  
> Further reading on GitHub Pages  

### 例2 区块引用嵌套
> What are GitHub Pages?  
> User, Organization, and Project Pages  
> Creating Pages with the automatic generator  
>  
> > Creating Project Pages manually  
> > Using Jekyll with Pages  
> > About custom domains for GitHub Pages sites  
>  
> Setting up a custom domain with GitHub Pages  
>  
> > Tips for configuring a CNAME record with your DNS provider  
> > Adding a CNAME file to your repository  
>  
> Tips for configuring an A record with your DNS provider  
> Further reading on GitHub Pages  

### 例3 区块引用嵌套markdown语法
> #### 这是一个标题
> 
> + 无序行1
> + 无序行2
> 
> > 1. 有序行1
> > 2. 有序行2
> 

## 列表
 * 无序列表使用星号、加号或是减号作为列表标记。
 * 有序列表则使用数字接着一个英文句点。
 * 如果列表项目间用空行分开，在输出 HTML 时 Markdown 就会将项目内容用 ‘<p>’ 标签包起来。
 * 在句首出现‘数字-句点-空白’，要避免这样的状况，你可以在句点前面加上反斜杠。

### 例1 句首出现‘数字-句点-空白’的转义
 1. 这是第一行
 2. 1080. 这是第二行，没有转义
 3. 1099\. 这是第三行，经过转义

## 代码区块
 * 缩进4个空格或是一个制表符酒可以建立代码区块。
 * 后续每一行的一阶缩进（4 个空格或是 1 个制表符），都会被移除。
 * 一个代码区块会一直持续到没有缩进的那一行（或是文件结尾）。

### 例1 代码区块
下面是一段代码：  

	public class Test {
		private int test = 0;
	}

## 分隔线
 * 在一行中用三个以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。
 * 可以在星号或是减号中间插入空格。

### 例1 各种分隔符

******
* * *
------
- - -

## 链接
 * Markdown 支持两种形式的链接语法： 行内式和参考式两种形式。
 * 要建立一个行内式的链接，只要在方块括号后面紧接着圆括号并插入网址链接即可，如果你还想要加上链接的 title 文字，只要在网址后面，用双引号把 title 文字包起来即可。
 * 如果你是要链接到同样主机的资源，你可以使用相对路径
 * 参考式的链接是在链接文字的括号后面再接上另一个方括号，而在第二个方括号里面要填入用以辨识链接的标记，在文件的任意处，你可以把这个标记的链接内容定义出来。
 * 链接内容定义的形式为：

   1. 方括号（前面可以选择性地加上至多三个空格来缩进），里面输入链接文字
   2. 接着一个冒号
   3. 接着一个以上的空格或制表符
   4. 接着链接的网址
   5. 选择性地接着 title 内容，可以用单引号、双引号或是括弧包着

 * 链接网址也可以用尖括号包起来。
 * 链接辨别标签可以有字母、数字、空白和标点符号，但是并不区分大小写。
 * 隐式链接标记功能让你可以省略指定链接标记，这种情形下，链接标记会视为等同于链接文字，要用隐式链接标记只要在链接文字后面加上一个空的方括号。

### 例1 行内式链接

[这是一个行内式链接](http://www.baidu.com/ "baidu")

### 例2 参考式链接

[这是一个参考式链接][baidu]

### 例3 隐式链接

[baidu][]


## 强调
 * Markdown 使用星号（*）和底线（_）作为标记强调字词的符号，被 * 或 _ 包围的字词会被转成用 <em> 标签包围，用两个 * 或 _ 包起来的话，则会被转成 <strong>
 * 强调也可以直接插在文字中间
 * 如果你的 * 和 _ 两边都有空白的话，它们就只会被当成普通的符号
 * 如果要在文字前后直接插入普通的星号或底线

### 例1 强调标记
文本1  
*文本2*  
_文本3_  
**文本4**  
__文本5__  
部分*强调*  
部分\*强调\*  

## 代码
 * 如果要标记一小段行内代码，你可以用反引号把它包起来（`）
 * 如果要在代码区段内插入反引号，你可以用多个反引号来开启和结束代码区段
 * 在代码区段内，& 和尖括号都会被自动地转成 HTML 实体，这使得插入 HTML 原始码变得很容易

### 例1 代码
打印 `print(hello world)`  
`` 反引号` ``  

## 图片
 * Markdown使用一种和链接很相似的语法来标记图片，包括行内式和参考式。
 * 详细叙述如下: 
   1. 一个惊叹号 !
   2. 接着一个方括号，里面放上图片的替代文字
   3. 接着一个普通括号，里面放上图片的网址，最后还可以用引号包住并加上 选择性的 'title' 文字。

### 例1 行内式图片
![图片1](/images/minertocat.png "title1")

### 例2 参考式图片
![图片1][minertocat]

## 自动链接
 * Markdown 支持以比较简短的自动链接形式来处理网址和电子邮件信箱，只要是用尖括号包起来， Markdown 就会自动把它转成链接。

### 例1 自动链接
 <https://github.com/>

## 反斜杠
 * Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号
 * Markdown 支持以下这些符号前面加上反斜杠来帮助插入普通的符号：
   1. \\   反斜线
   2. \`   反引号
   3. \*   星号
   4. \_   底线
   5. \{\}  花括号
   6. \[\]  方括号
   7. \(\)  括弧
   8. \#   井字号
   9. \+   加号
   10. \-   减号
   11. \.   英文句点
   12. \!   惊叹号


[minertocat]: /images/minertocat.png "title2"

[baidu]: <http://www.baidu.com/> "baidu"

[markdown]: http://wowubuntu.com/markdown/

[markdownpad]: http://markdownpad.com/ "markdownpad"

[sublimetext]: http://www.sublimetext.com/ "sublimetext"