---
layout: post
title: liquid 模板语言语法学习笔记
---

## 简介
[Liquid Home](https://github.com/Shopify/liquid/wiki "Liquid Home") 
[Liquid for Designers](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers "Liquid for Designers") 
[Liquid for Programmers](https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers "Liquid for Programmers") 
[参考博客](http://blog.csdn.net/dont27/article/details/38097581 "参考博客") 

Liquid is a template engine which was crafted for very specific requirements  

 * It has to have simple markup and beautiful results. Template engines which don't produce good looking results are no fun to use.  
 * It needs to be non-evaling and secure. Liquid templates are made so that users can edit them. You don't want your server running code that your users wrote.  
 * It has to be stateless. The compile and render steps have to be separate, so that the expensive parsing and compiling can be done once; later on, you can just render it by passing in a hash with local variables and objects.  
 * It needs to be able to style emails as well as HTML.  