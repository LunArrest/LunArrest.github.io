---
layout: post
title: 使Jekyll实现语法高亮
description: 使用pygments 使Jekyll博客界面代码语法高亮。
tags: github pages
---

1. pip install pygments 安装python2.X的pygments（必须是python2.X）。
2. gem install pygments.rb 安装pygments.rb，如果当时搭建jekyll环境时是bundle install（source 'http://ruby.taobao.org' gem 'github-pages'），则应该已经安装完毕。
3. 配置jekyll的_config.xml。写入highlighter: pygments
4. 运行pygmentize -S default -f html > your/path/pygments.css生成代码高亮的样式表。
5. 将<link rel="stylesheet" href="/your/path/pygments.css">添加到jekyll的layout中。
6. 完毕。


#### 参考网址：  
 * <http://havee.me/internet/2013-08/support-pygments-in-jekyll.html>
 * <https://github.com/rtomayko/posix-spawn/issues/61>


#### 发现问题一
如果本地环境没有配置jekyll可用的highlighter，会导致jekyll无法预处理包含语法高亮liquid语句的，以至于无法启动本地服务器。
由于jekyll在解析语法高亮liquid时会调用python 的which命令行工具，所以如果没有配置python_path/Tools/Scripts到环境变量会报which的错误，依旧无法启动本地服务器。
如果安装的是python3.X版本的pygments也同样无法启动本地服务器，会报如下错误：  

 > C:/Ruby21-x64/lib/ruby/gems/2.1.0/gems/posix-spawn-0.3.9/lib/posix/spawn.rb:164: warning: cannot close fd before spawn  
 > python2: not found  
 >   Liquid Exception: undefined method `[]' for nil:NilClass in _posts/2015-01-07-cpp-primer-5th-memo.md  
 > jekyll 2.4.0 | Error:  undefined method `[]' for nil:NilClass   

#### 解决问题一   
 1. 安装Python2，默认环境变量为Python3  
 2. 安装Python2版本的pygments  
 3. 启动服务命令行修改为（用于优先调用Python2）：  

 > set PYTHON2_HOME=C:\Python27  
 > set PATH=%PYTHON2_HOME%\;%PYTHON2_HOME%\Scripts;%PYTHON2_HOME%\Tools\Scripts;%PATH%  
 > bundle exec jekyll serve  


#### 发现问题二
由于本地windows机器原本安装的是Python3.X版本，再安装Python2.X版本后，忘记取消对2.X注册信息的勾选，导致原机器上用Python3写的脚本无法双击执行。


#### 解决问题二
 1. 控制台执行assoc，查得与python相关的后缀名的文件关系为：  
   .py=Python.File  
   .pyc=Python.CompiledFile  
   .pyo=Python.CompiledFile  
   .pyw=Python.NoConFile  
 2. 控制台执行ftype，查得对应的执行文件为：   
   Python.CompiledFile="C:\Python27\python.exe" "%1" %*   
   Python.File="C:\Python27\python.exe" "%1" %*   
   Python.NoConFile="C:\Python27\pythonw.exe" "%1" %*   
 3. 控制台修改该执行文件路径：  
   ftype Python.CompiledFile="C:\Python34\python.exe" "%1" %*   
   ftype Python.File="C:\Python34\python.exe" "%1" %*   
   ftype Python.NoConFile="C:\Python34\pythonw.exe" "%1" %*  
 4.完毕，又可以愉快地执行Python3的脚本了。


#### 参考网址：  
 * <http://stackoverflow.com/questions/8985925/how-to-control-what-version-of-python-is-run-when-double-clicking-a-file>