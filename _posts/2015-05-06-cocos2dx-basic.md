---
layout: post
title: cocos2dx 引擎基础概念
description: cocos2dx 引擎基础概念
tags: cocos2dx
---

## 综述

### Cocos2dx API风格

#### 一、对象构造

##### 两阶段构造器

由于C++的构造器本身并不返回能够用作逻辑判断的bool值，所以语言级别的构造和逻辑级别的构造（逻辑层面的初始化）需要分开，也就有了官方文档中说明的**两阶段构造器**：

1. 第一阶段是运行C++类构造器。在C++类的默认构造器中，成员变量须设定为默认值。但我们不应在默认构造器中编写任何逻辑。
2. 第二阶段是调用MyClass::init()函数

例如：

{% highlight C++ %}
MyClass::MyClass()  // c++ class constructor
:_data(NULL)      // set all member variables to default values
,_flag(false)
,_count(0)
{
    memset(_array, 0, sizeof(_array));   // only set default values here, but not logics
}

bool MyClass::initWithFilename(const std::string& filename)
{
    // just take loading texture as a sample, this behaviour can fail if the image file doesn't  exist. 
    bool bReturnValue = loadTextureIntoMemory(filename);  
    return bReturnValue;
}
{% endhighlight %}

##### 静态create()函数

在Cocos2d-x引擎中，我们已对这一两阶段构造器进行包装，并在静态函数create()中自动释放引用计数。除了单例模式，每一个cocos2d类都有自己的static CCClass* CCClass::create(...)方法。**极力推荐这一方法**。即create包含：

1. 两阶段构造器
2. 调用autorelease()自动释放引用计数

例如：
{% highlight C++ %}
Layout* Layout::create()
{
    Layout* layout = new (std::nothrow) Layout();
    if (layout && layout->init())
    {
        layout->autorelease();
        return layout;
    }
    CC_SAFE_DELETE(layout);
    return nullptr;
}
{% endhighlight %}

by the way，自动释放引用计数有点类似Android中的智能指针，Object-C中的内存管理机制，简单来说就是通过Ref，PoolManager，AutoreleasePool搭建的一套基于引用计数的半自动的内存管理机制。代码节选如下：

{% highlight C++ %}
Ref* Ref::autorelease()
{
    PoolManager::getInstance()->getCurrentPool()->addObject(this);
    return this;
}

class CC_DLL PoolManager
{
public:

    CC_DEPRECATED_ATTRIBUTE static PoolManager* sharedPoolManager() { return getInstance(); }
    static PoolManager* getInstance();
    
    CC_DEPRECATED_ATTRIBUTE static void purgePoolManager() { destroyInstance(); }
    static void destroyInstance();
    
    /**
     * Get current auto release pool, there is at least one auto release pool that created by engine.
     * You can create your own auto release pool at demand, which will be put into auto releae pool stack.
     */
    AutoreleasePool *getCurrentPool() const;

    bool isObjectInPools(Ref* obj) const;


    friend class AutoreleasePool;
    
private:
    PoolManager();
    ~PoolManager();
    
    void push(AutoreleasePool *pool);
    void pop();
    
    static PoolManager* s_singleInstance;
    
    std::vector<AutoreleasePool*> _releasePoolStack;
};

class CC_DLL AutoreleasePool
{
public:
    /**
     * @warning Don't create an autorelease pool in heap, create it in stack.
     * @js NA
     * @lua NA
     */
    AutoreleasePool();
    
    /**
     * Create an autorelease pool with specific name. This name is useful for debugging.
     * @warning Don't create an autorelease pool in heap, create it in stack.
     * @js NA
     * @lua NA
     *
     * @param name The name of created autorelease pool.
     */
    AutoreleasePool(const std::string &name);
    
    /**
     * @js NA
     * @lua NA
     */
    ~AutoreleasePool();

    /**
     * Add a given object to this autorelease pool.
     *
     * The same object may be added several times to an autorelease pool. When the
     * pool is destructed, the object's `Ref::release()` method will be called
     * the same times as it was added.
     *
     * @param object    The object to be added into the autorelease pool.
     * @js NA
     * @lua NA
     */
    void addObject(Ref *object);

    /**
     * Clear the autorelease pool.
     *
     * It will invoke each element's `release()` function.
     *
     * @js NA
     * @lua NA
     */
    void clear();
    
#if defined(COCOS2D_DEBUG) && (COCOS2D_DEBUG > 0)
    /**
     * Whether the autorelease pool is doing `clear` operation.
     *
     * @return True if autorelase pool is clearning, false if not.
     *
     * @js NA
     * @lua NA
     */
    bool isClearing() const { return _isClearing; };
#endif
    
    /**
     * Checks whether the autorelease pool contains the specified object.
     *
     * @param object The object to be checked.
     * @return True if the autorelease pool contains the object, false if not
     * @js NA
     * @lua NA
     */
    bool contains(Ref* object) const;

    /**
     * Dump the objects that are put into the autorelease pool. It is used for debugging.
     *
     * The result will look like:
     * Object pointer address     object id     reference count
     *
     * @js NA
     * @lua NA
     */
    void dump();
    
private:
    /**
     * The underlying array of object managed by the pool.
     *
     * Although Array retains the object once when an object is added, proper
     * Ref::release() is called outside the array to make sure that the pool
     * does not affect the managed object's reference count. So an object can
     * be destructed properly by calling Ref::release() even if the object
     * is in the pool.
     */
    std::vector<Ref*> _managedObjectArray;
    std::string _name;
    
#if defined(COCOS2D_DEBUG) && (COCOS2D_DEBUG > 0)
    /**
     *  The flag for checking whether the pool is doing `clear` operation.
     */
    bool _isClearing;
#endif
};
{% endhighlight %}

#### 二、函数命名

##### doSomething()

没啥好说的，主流的函数命名方式，动词 + 名词的方式命名一个函数。表明干什么。如：getTexture()

##### doWithResource()

表明通过什么（借助什么、用什么）干什么。如：initWithTexture(CCTexture*)

##### onEventCallback()

on开头表示是一个回调函数。如：void onEnter()

##### getInstance()

单例模式，没啥特别的。在v3.0之前，单例类的构造方式是CocosClass::sharedCocosClass()，比如TextureCache::sharedTextureCache()。顺带一提，shared是Object-C中的单例代码风格。

#### 三、属性

因为在C++ 和 C++11中没有"property" （“属性”）这个概念，所以我们在Cocos2d-x引擎中使用了许多getter和setters。因为Object-C中有“属性”这个概念（貌似C#等语言中也有“属性”的这个概念)，此处就通过类似Java Bean/VO的实现方式增加getter 和 setter：

1. setProperty() 如setPosition()
2. getProperty() 如果获取的属性并非bool类型的话，用get，否则用is。如getVisibleSize()
3. isProperty() 如：isDirty()

### Cocos2dx架构和目录结构

#### Cocos2dx架构

如图：
![cocos2d-x-architecture](/images/Cocos2dx/cocos2d-x-architecture.jpg "cocos2d-x-architecture")

暂未研究过其代码架构，但从图示上看，目前Cocos2dx主要在各个平台的基础上抽象了，视图，音频，物理引擎，脚本四大部分的功能。

### Cocos2dx目录结构

官方文档给出的目录结构如下（但就目测而言，3.6版本与之几乎完全不一样）：

1. CocosDenshion	音频支持。注意：Android平台中背景音乐和短音效所使用的系统API不同。
2. cocos2dx	Cocos2d-x框架的主目录。
3. document	你可以下载doxygen文档系统，利用该系统打开本文档文件夹内的doxygen.config文件，然后再生成离线API文档。
4. extensions	如果需要更多图形用户界面的控制功能、网络访问、CocosBuilder支持甚至2.5D功能，你可以使用using namespace cocos2d::extension。
5. external	包括box2d及Chipmunk库。
6. licenses	cocos2d依赖很多其他开源项目。所有授权许可文件都在这个目录。
7. samples	重要！这是你该开始用到的文件。从Cpp/HelloCpp开始学习，你会在TestCpp中发现所有类的用法。lua和js样本也在这个目录。
8. scripting	我知道你不喜欢C++，写起来太复杂。没问题，我们有Lua和Javascript。Scripting文件夹包括来自火狐的lua官方引擎和SpiderMonkey引擎。
9. template	该目录包括在不同集成开发环境及不同平台中创建Cocos2d-x新项目的模板。这里汇集了数量庞大覆盖各种开发环境和平台的模板！
10. tools	包括将C++绑定至lua及javascript的脚本文件。
11. CHANGELOG	作者修订记录文档。
12. cocos2d-win32.vc2010.sln	配套Visual Studio 2010打开。注意：VS 2008自Cocos2d-x v2.0版本以来就不再支持。
13. cocos2d-win32.vc2012.sln	配套Visual Studio 2012打开。
14. create-android-project.bat	在Windows平台运行。具体用法请参考如何用脚本创建Android项目。
15. create-android-project.sh	在Linux或OS X平台运行。具体用法请参考如何用脚本创建Android项目。
16. install-templates-msvc.bat	执行该文件安装后，你可以在Visual Studio中创建空的Cocos2d-x项目。
17. install-templates-xcode.sh	执行该文件安装后，你可以在Xcode中创建空的Cocos2d-x项目。

总而言之，包括了cocos2dx引擎的核心框架目录，用到的第三方开源项目/引擎/库的目录，样例目录，母版目录，工具目录，控制台命令相关工具目录，证书目录等等。

