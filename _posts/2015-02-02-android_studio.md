---
layout: post
title: Android新亲儿子IDE ---- Android Studio
description: Android Studio官网介绍相关
tags: IDE
---

## 简介 ##

就我经历过的Android官方开发工具： 独立的eclipse adt插件到整合在一起的Android Development Tool，再到现在正式推出的Android Studio。可能再往前推会有Ant Maven之类的开发阶段，可惜的是我并没有经历过那个时代。遥想当年Android Studio 0.0.1beta版刚推出的时候还有点小激动呢，但是使用起来各种那啥，bug也是略多，公司电脑配置还卡...真是留下了深刻印象。

有点跑题了，话说回来，原本占稳Android官网Tools第一条的Android Development Tool已经被Android Studio彻底地取代。集成版的eclipse + adt插件也无法在官网找到下载链接，仅剩下一个孤零零的adt插件下载。从种种迹象表明，Android官方已经将IDE的重心转移到了Android Studio，ADT可能会被慢慢地磨灭在岁月之中。所以呢，身为一只机智的程序猿，当然也是要适当地学习一下Android Studio的使用。

Android Studio是基于[IntelliJ IDEA](https://www.jetbrains.com/idea/ "intellij")的官方Android应用开发IDE。

Android Studio提供了如下功能：  

 * Flexible Gradle-based build system
 * Build variants and multiple apk file generation
 * Code templates to help you build common app features
 * Rich layout editor with support for drag and drop theme editing
 * Lint tools to catch performance, usability, version compatibility, and other problems
 * ProGuard and app-signing capabilities
 * Built-in support for Google Cloud Platform, making it easy to integrate Google Cloud Messaging and App Engine
 * And much more

总结一下，就是：

 1. 更好的构建系统 -- gradle（Ant的XML脚本语法确实略反人类）
 2. 可以支持生成多个不同的apk包（看来写好的Ant脚本在不久的将来要吃灰了）
 3. 代码模板（嗯，聊胜于无）
 4. Lint工具（嗯，同理）
 5. 混淆工具 -- ProGuard 和 apk签名能力（必备功能吧）
 6. 内嵌的Google云平台（...）
 7. 以及其他更多的，未来加入的功能

## 项目及文件结构（Project and File Structure） ##

### Android Project View ###

与Eclipse类似，在项目视图中可以看到项目相关的文件列表，以及用于快速访问源文件。而且可以更好地帮助开发者使用基于Gradle的构建系统。

Android Project View：

 * Groups the build files for all modules at the top level of the project hierarchy（将所有模块相关的构建文件整合进项目层级的顶层）.
 * Shows the most important source directories at the top level of the module hierarchy（在顶层显示重要源文件目录）.
 * Groups all the manifest files for each module（整合每个模块的所有清单文件）.
 * Shows resource files from all Gradle source sets（显示所有Gradle源集合的资源文件）.
 * Groups resource files for different locales, orientations, and screen types in a single group per resource type（将不同路径，方向，屏幕类型的资源文件整合在每一个不同的资源类型中）.

Android项目视图在Gradle Scripts的第一级展示所有的构建文件。每个项目模块以文件夹形式出现在项目视图的第一层级，并包含了以下三种元素：

 * java/ - Source files for the module（源文件）.
 * manifests/ - Manifest files for the module（清单文件）.
 * res/ - Resource files for the module（资源文件）.

### New Project and Directory Structure ###

Android Studio的文件结构与Eclipse的不同。Android Studio的每个Project（项目）可以包含一个或多个application modules（应用模块）。每个应用模块的文件夹包含了该模块的完整的源代码文件集合，包括：src/main目录、src/androidTest目录、资源文件、build file以及Android manifest。

**个人理解：Eclipse中的Workspace类似于Android Studio的Project，Eclipse中的Project类似Android Studio中的Application Module。**

可以通过ALT + INSERT快捷键创建文件（windows 和 linux），COMMAND + N（MAC）。

## Android Build System ##

### 安卓构建系统 ###

Android Studio的构建系统将原本Eclipse的ANT替换为了Gradle，可以通过Android Studio集成的菜单界面或者使用独立的命令行来运行该构建系统。可以用于：

 * Customize, configure, and extend the build process（定制，配置，继承构建操作）.
 * Create multiple APKs for your app with different features using the same project and modules（用同一个项目创建包含不同功能的多种apk）.
 * Reuse code and resources across source sets（重用资源和代码）.

这种构建系统的灵活性可以让你在不必更改源代码的前提下达成上述目标。

### Application ID for Package Identification ###

在Android构建系统中，applicationId 属性用于唯一标记需要发布的应用包，在build.gradle文件中设置。

    apply plugin: 'com.android.application'

    android {
        compileSdkVersion 19
        buildToolsVersion "19.1"

    defaultConfig {
        applicationId "com.example.my.app"
        minSdkVersion 15
        targetSdkVersion 19
        versionCode 1
        versionName "1.0"
    }
    ...

applicationId只在build.gradle文件中设置，而不是在AndroidManifest.xml中。

构建系统允许你在构建多个不同的包的时候标记不同的产品偏好和构建类型。当指定了产品偏好的时候，该构建类型的applicationId将会添加该后缀。

	productFlavors {
        pro {
            applicationId = "com.example.my.pkg.pro"
        }
        free {
            applicationId = "com.example.my.pkg.free"
        }
    }

    buildTypes {
        debug {
            applicationIdSuffix ".debug"
        }
    }
    ....
   
包名（package name）仍需在清单文件中指定。用于关联R类和处理相关的Activity和Service。

	package="com.example.app">

## 调试与执行（Debug and Performance） ##

### Android Virtual Device (AVD) Manager（安卓虚拟设备管理器） ###

跟Eclipse ADT相差不多，略

### Memory Monitor（内存监视器） ###

如标题，略

### New Lint inspections ###

Lint做一些新的检查工作以确保：

- Cipher.getInstance() is used with safe values
- In custom Views, the associated declare-styleable for the custom view uses the same base name as the class name.
- Security check for fragment injection.
- Where ever property assignment no longer works as expected.
- Gradle plugin version is compatible with the SDK.
- Right to left validation
- Required API version
- many others

在Android Studio中，你可以为指定的构建作业执行Lint，或者为全部的构建作业执行Lint。可以在build.gradle文件中添加Lint选项（lintOptions）属性。

    android {
        lintOptions {
           // set to true to turn off analysis progress reporting by lint
           quiet true
           // if true, stop the gradle build if errors are found
           abortOnError false
           // if true, only report errors
           ignoreWarnings true

### Dynamic layout preview（动态布局预览） ###

直观来看，与ADT的差别就是在于可以在同一个屏幕中编辑布局XML，以及预览该布局。

### Log messages（日志信息） ###

跟ADT相似，略

## Installation, Setup, and Update Management（安装设置以及升级管理） ##

嗯，无非是click click，略过

## 其余亮点 ##

### Translation Editor（翻译编辑器，预览版） ###

多语言化的插件工具，估计就算正式上线，由于种种原因也很难用的了。

### Editor support for the latest Android APIs ###

嗯，必须的

### Easy access to Android code samples on GitHub ###

可以跟GitHub更好的交互，如导入Sample，搜索开源项目等。

## 自我小结 ##

从整体来看，Android/Google的发力方向是客户端-->客户端联合云服务-->云服务，相信在未来，从开发到调试到发布到使用都会是在云端完成。
