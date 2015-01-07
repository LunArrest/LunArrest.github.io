---
layout: post
title: YAML 语法学习笔记
---

## 简介

_[YAML](http://yaml.org "YAML"): YAML Ain't Markup Language_

_[YAML](http://yaml.org "YAML"): YAML不是标记语言_

__由于兼容性问题，不同语言间的数据流转建议不要用YAML.__


## 命名

 * YAML是"YAML Ain't a Markup Language"（YAML不是一种置标语言）的递归缩写。
 * 在开发的这种语言时，YAML 的意思其实是："Yet Another Markup Language"（仍是一种标记语言）。

## 设计目标

 1. YAML 易于人读和理解
 2. YAML 数据可以在编程语言间移植
 3. YAML 与一些灵活的语言的源生数据结构匹配
 4. YAML 有一个固定模型来支持通用的工具
 5. YAML supports one-pass processing（暂时不能准确理解）
 6. YAML 表现力强，而且容易扩充
 7. YAML 易于实现和使用 

## YAML的适用范围
由于实现简单，解析成本很低，YAML特别适合在脚本语言中使用。列一下现有的语言实现：Ruby，Java，Perl，Python，PHP，OCaml，JavaScript。除了Java，其他都是脚本语言.

YAML比较适合做序列化。因为它是宿主语言数据类型直转的。

YAML做配置文件也不错。比如Ruby on Rails的配置就选用的YAML。对ROR而言，这很自然，也很省事.

由于兼容性问题，不同语言间的数据流转建议现在不要用YAML. 

## YAML存在的意义

无论多么完美的事物，都需要有对立面，有说“NO”的声音。XML也不例外。当然，站在主流的对立面，需要勇气和智慧。

YAML和XML不同，没有自己的数据类型的定义，而是使用实现语言的数据类型。这一点，有可能是出奇制胜的地方，也可能是一个败笔。如果兼容性保证的不好的话，YAML数据在不同语言间流转会有问题。如果兼容性好的话，YAML就会成为不同语言间数据流通的桥梁。建议yaml.org设立兼容认证机制，每个语言的实现必须通过认证。

假如兼容性没问题的话，YAML就太完美了。轻巧，敏捷，高效，简便，通用。这才是理想中的数据模型。当然就现在而言，这还只是个理想。

## 参考资料
 <http://www.ibm.com/developerworks/cn/xml/x-cn-yamlintro/>