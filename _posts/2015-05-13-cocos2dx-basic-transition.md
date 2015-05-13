---
layout: post
title: cocos2dx 场景切换及特效
description: cocos2dx 场景切换及特效
tags: cocos2dx
---



## 内置的场景切换特效

1. 渐变淡化：TransitionCrossFade
2. 淡入淡出：TransitionFade
3. 角落渐变：TransitionFadeBL
4. 翻转：TransitionFlipAngular etc...
5. 跳动：TransitionJumpZoom
6. 移入：TransitionMoveInB
7. 翻页：TransitionPageTurn
8. 消失：TransitionProgressHorizontal
9. 旋转：TransitionProgressRadialCCW
10. 缩小放大：TransitionShrinkGrow
11. 滑动：TransitionSlideInB
12. 分行消失：TransitionSplitCols etc...
13. 缩放翻动：TransitionZoomFlipAngular

## 场景切换

cocos2dx的场景切换通过Director导演来执行，简单的切换就是：
{% highlight C++ %}
auto nextScene = DrawNodeScene::createScene();
Director::getInstance()->replaceScene(nextScene);
{% endhighlight %}

加入特效：
{% highlight C++ %}
auto nextScene = DrawNodeScene::createScene();
auto transition = TransitionPageTurn::create(1, nextScene, false);
Director::getInstance()->replaceScene(transition);
{% endhighlight %}