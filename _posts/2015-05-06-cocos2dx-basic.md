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

