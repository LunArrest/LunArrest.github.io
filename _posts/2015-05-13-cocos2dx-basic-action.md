---
layout: post
title: cocos2dx Action的基本使用
description: cocos2dx Action的基本使用
tags: cocos2dx
---

## 什么是Action
简单来说就是cocosdx封装好的动画

## 常用的Action

1. 移动到：MoveTo
2. 移动：MoveBy
3. 跳跃到：JumpTo
4. 跳跃：JumpBy
5. 贝塞尔：BezierBy
6. 放大到：ScaleTo
7. 放大：ScaleBy
8. 旋转到：RotateTo
9. 旋转：RotateBy
10. 闪烁：Blink
11. 色调变化到：TintTO
12. 色调变换：TintBy
13. 变淡到：FadeTo
14. 淡入：FadeIn
15. 淡出：FadeOut

## 如何使用Action

1. 通过Action类的create创建该动作
2. 通过Node的runAction来执行该Action
3. 可以通过Sequence::create创建按序执行的动作序列，最后传入的参数一定是NULL
4. 可以同过Spawn::create创建并行执行的动作集合，最后传入的参数一定是NULL
5. 可以通过Sequence以及CallFunc组合的形式，实现动画播放完毕的回调

例如：

{% highlight C++ %}
bool ActionScene::init() {
	if (!Layer::init()) {
		return false;
	}

	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();

	auto pika = Sprite::create("pika.jpg");
	auto pikaContentSize = pika->getContentSize();
	pika->setPosition(visibleSize);
	pika->setAnchorPoint(Vec2(1, 1));
	this->addChild(pika);
	auto pikaMove = MoveBy::create(2, Vec2(-250, 0));
	auto pikaScale = ScaleBy::create(2, 2);

	pika->runAction(Spawn::create(pikaMove, pikaScale, NULL));

	auto logo1 = Sprite::create("logo1.jpg");
	logo1->setScale(0.8);
	logo1->setPosition(visibleSize / 2);
	addChild(logo1);

	auto logo2 = Sprite::create("logo2.jpg");
	logo2->setScale(0.8);
	addChild(logo2);

	auto logo3 = Sprite::create("logo3.jpg");
	logo3->setAnchorPoint(Vec2(0,0));
	addChild(logo3);

	logo1->runAction(MoveTo::create(2, Vec2(visibleSize.width - 100, visibleSize.height / 2)));

	auto move1 = MoveTo::create(2, Vec2(visibleSize.width - 100, visibleSize.height - 100));
	auto move2 = MoveBy::create(2, Vec2(-200, 0));

	logo2->runAction(Sequence::create(move1, move2, NULL));

	auto move = MoveBy::create(3, Vec2(visibleSize.width / 2, 0));
	auto reverseMove = move->reverse();

	logo3->runAction(Sequence::create(Sequence::create(move, reverseMove, NULL), CallFunc::create([](){
		CCLOG("Action End!");
	}), NULL));

	return true;
}
{% endhighlight %}

## 3D特效Action

1. 抖动效果 - Shaky3D
2. 波浪效果 - Waves3D
3. 翻转效果 - FlipX3D
4. 途径效果 - Lens3D
5. 水波效果 - Ripple3D
6. 液体效果 - Liquid
7. 扭动旋转 - Twirl
8. 破碎效果 - ShatteredTiles3D
9. 瓷砖效果 - ShuffleTiles
10. 淡入淡出 - FadeOutTrTiles 等
11. 方块消失 - TurnOffTiles
12. 分行消失 - SplitRows
13. 翻页效果 - PageTurn3D

与普通Action使用几乎一样，但是调用的类对象由变为NodeGrid，例如：

{% highlight C++ %}
auto logo4 = NodeGrid::create();
auto tmp = Sprite::create("logo4.jpg");
auto size = tmp->getContentSize();
logo4->addChild(tmp);
logo4->setPosition(size.width / 2, visibleSize.height - size.height / 2);
addChild(logo4);

logo4->runAction(Shaky3D::create(10, Size(50, 50), 5, false));
{% endhighlight %}