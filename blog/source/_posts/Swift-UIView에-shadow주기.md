---
title: '[Swift]UIView에 shadow주기'
date: 2020-07-09 19:08:39
category: "ios"
tags:
- Swift
- UIView
- Shadow
thumbnail: /image/shadow4.png
---

shadowColor에 black을 주는 것으로 시작 ~ ! 


```swift
self.containView.layer.shadowColor = UIColor.black.cgColor // 검정색
   self.containView.layer.masksToBounds = false
   self.containView.layer.shadowOffset = CGSize(width: 0, height: 4) // 그림자 시작위치
   self.containView.layer.shadowRadius = 8 // 그림자크기(범위)
   self.containView.layer.shadowOpacity = 0.3 //그림자 불투명도 [1이 기준 - 완전 불투명]
```

- shadowPath 를 이용하면 그림자의 크기와 방향을 한꺼번에 잡을 수 있다. (베젤크기?)


```swift
view.layer.shadowPath = UIBezierPath(rest: CGRect(x: 0, y: 0, width: 10, height: view.bounds.height)).cgPath
```


- 그림자를 사용하면 자원이 많이 드는 일? 이라고 한다. 그래서 그림자를 캐시에 저장해서 재활용하는 방법도 있다.

```swift
view.layer.shouldRasterize = true
```


