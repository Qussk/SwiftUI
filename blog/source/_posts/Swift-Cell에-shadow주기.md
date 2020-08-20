---
title: '[Swift]Cell에 shadow주기'
date: 2020-07-08 09:56:53
category: "ios"
tags:
- Swift
- Shadow
- layr
thumbnail: /image/shadow.png
---


### 간단하게 Cell에 그림자 주기 👻

```swift
private func setupView(){
  mainImageView.clipsToBounds = true
  mainTitleImage.clipsToBounds = true
  
  //쉐도우
  let shadowPath2 = UIBezierPath(rect: bounds)
  layer.masksToBounds = false
  layer.shadowColor = UIColor.black.cgColor
  layer.shadowOffset = CGSize(width: CGFloat(2.0), height: CGFloat(3.0))
  layer.shadowOpacity = 0.6
  layer.shadowRadius = 4
  layer.shadowPath = shadowPath2.cgPath
```
  


🎃🙌🏻
