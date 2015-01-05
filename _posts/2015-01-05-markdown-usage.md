---
layout: default
title: markdown语法学习笔记
---

Markdown语法参考：       [http://wowubuntu.com/markdown/][markdown]

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


[markdown]: http://wowubuntu.com/markdown/