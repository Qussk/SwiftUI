---
title: '[Swift]SF Symbols 정리'
date: 2020-08-07 13:56:59
category: "ios"
tags:
- Swift
- SFSymbols
thumbnail:
---

개발할 때 자주 사용하는 **SFSymbols** !

![](https://miro.medium.com/max/744/1*xuNseCoRcYHE4shy_arR-g.png)



이번 기회에 확실히 정리하고자 한다.


![](https://www.avanderlee.com/wp-content/uploads/2019/10/sf-symbols-scales-weights.png)

SFSymbols은 다양한 인터페이스를 지원한다. iOS13부터. 


## SF symbols 사용

```swift
 centerButton.setImage(UIImage(systemName: "camera.viewfinder"), for: .normal)
```

## Size 조절 

```swift  
 centerButton.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
```
- 스몰, 미디움, 라지가 있다. 


## Font 조절

```swift

  leftStack.firstButton.setImage(UIImage(systemName: "bubble.left.and.bubble.right.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)), for: .normal)
```
- SymbolConfiguration에서 아래의 파라미터는 본인이 선택해서 쓰면 된다. 






이것저것 찾아보다가 베타버전 다운받는 것도 있어서 아래 링크 첨부..

[SF 기호 2베타 다운로드](https://developer.apple.com/sf-symbols/)
