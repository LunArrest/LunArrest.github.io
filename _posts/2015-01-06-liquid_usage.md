---
layout: post
title: liquid 模板语言语法学习笔记
---

## 简介

### 参考资料
[Liquid Home](https://github.com/Shopify/liquid/wiki "Liquid Home") 
[Liquid for Designers](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers "Liquid for Designers") 
[Liquid for Programmers](https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers "Liquid for Programmers") 
[参考博客1](http://blog.csdn.net/dont27/article/details/38097581 "参考博客1") 
[参考博客2](http://havee.me/internet/2013-11/jekyll-liquid-designers.html "参考博客2") 

Liquid is a template engine which was crafted for very specific requirements  

 * It has to have simple markup and beautiful results. Template engines which don't produce good looking results are no fun to use.  
 * It needs to be non-evaling and secure. Liquid templates are made so that users can edit them. You don't want your server running code that your users wrote.  
 * It has to be stateless. The compile and render steps have to be separate, so that the expensive parsing and compiling can be done once; later on, you can just render it by passing in a hash with local variables and objects.  
 * It needs to be able to style emails as well as HTML.  

## liquid标准过滤器

{% raw %}
 * date - 格式化日期
 * capitalize - 输出字符串，字符串（句子）首字母大写 e.g. 假设tb为"hello world"{{ tb|capitalize }} #=> 'Hello world'
 * downcase - 将输入字符串转为小写
 * upcase - 将输入字符串转为大写
 * first - 得到传递数组的第一个元素
 * last - 得到传递数组的最后一个元素
 * join - 将数组中的元素连成一串，中间通过某些字符分隔
 * sort - 对数组元素进行排序
 * map - 从一个给定属性中映射/收集一个数组
 * size - 返回一个数组或字符串的大小
 * escape - 对一串字符串进行编码
 * escape_once - 返回一个转义的html版本，而不影响现有的转义文本
 * strip_html - 去除一串字符串中的所有html标签
 * strip_newlines - 从字符串中去除所有换行符(\n) 
 * newline_to_br - 将所有的换行符(\n)换成html的换行标记
 * replace - 替换所有匹配内容 e.g.{{ 'forfor' | replace:'for', 'bar' }} #=> 'barbar'
 * replace_first - 替换第一个匹配内容 e.g.{{ 'forfor' | replace_first:'for', 'bar' }} #=> 'barfor'
 * remove - 移除所有匹配内容 e.g.{{ 'forbarforbar' | remove:'for'}} #=> 'barbar'
 * remove_first - 移除第一个匹配内容 e.g.{{ 'forbarforbar' | remove_first:'for'}} #=> 'barforbar'
 * truncate - 将一串字符串截断为x个字符
 * truncatewords - 将一串字符串截断为x个单词
 * prepend - 在一串字符串前面加上指定字符串，如 {{ 'bar' | prepend:'foo' }} #=> 'foobar'
 * append - 在一串字符串后面加上指定字符串，如 {{ 'foo' | append:'bar' }} #=> 'foobar'
 * minus - 减法，如 {{ 4 | minus:2 }} #=> 2
 * plus - 加法，如 {{ '1' | plus:'1' }} #=> '11', {{ 1 | plus:1 }} #=> 2
 * times - 乘法，如 {{ 5 | times:4 }} #=> 20
 * divided_by - 除法，如 {{ 10 | divided_by:2 }} #=> 5
 * split - 将一串字符串根据匹配模式分割成数组，如 {{ "a~b" | split:~ }} #=> ['a','b']
 * modulo - 取余，如 {{ 3 | modulo:2 }} #=> 1
{% endraw %}

## Tags

{% raw %}
 * assign - 将一些值赋给一个变量
 * capture - 块标记，把一些文本捕捉到一个变量中
 * case - 块标记，标准的 case 语句
 * comment - 块标记，将一块文本作为注释
 * cycle - Cycle 通常用于循环轮换值，如颜色或 DOM 类
 * for - 用于For循环
 * if - 用于if/else条件判断
 * include - 包含其他的模板
 * raw - 暂时性的禁用的标签的解析
 * unless - if 语句的简版
{% endraw %}