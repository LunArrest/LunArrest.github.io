---
layout: post
title: github pages 学习使用笔记
description: 使用Github pages 以及jekyll搭建个人页面。
tags: github pages
---
1. 访问<http://rubyinstaller.org/downloads>，下载windows环境的rubyinstaller，勾选添加到环境变量，安装。ruby安装完毕。
2. gem source -a <http://ruby.taobao.org/> 增加淘宝的ruby源
3. gem install bundler，bundler安装完毕
4. 访问<http://rubyinstaller.org/downloads>，下载Development Kit，解压到‘解压目录’，并配置环境变量
5. cmd，cd ‘解压目录’
6. ruby dk.rb init
7. 修改目录中的config.yml，配置ruby的安装目录‘- C:/Ruby21-x64’
8. ruby dk.rb review验证是否正常工作
9. 使用Devkit的msys.bat执行gem install jekyll（应该还要增加淘宝的ruby源），jekyll安装完毕。
10. 在github-page本地仓库创建Gemfile文件，填写内容：source 'http://ruby.taobao.org' gem 'github-pages'
11. 在github-page本地仓库目录，命令行中执行bundle install，完成安装步骤。
12. 命令行中执行bundle exec jekyll serve运行jekyll服务，通过访问http://localhost:4000查看页面
13. 使用bundle update命令来确保jekyll为最新
14. 可以通过在根目录创建一个名称为‘.nojekyll’的文件来关闭github page的jekyll。