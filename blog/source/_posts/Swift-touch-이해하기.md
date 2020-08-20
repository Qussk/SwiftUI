---
title: '[Swift]Tuch 이해하기(touch로 이미지 끌어오기)'
date: 2020-06-25 13:18:24
category: "ios"
tags:
- Swift
- Touch
- ImageView
thumbnail: image/gesture20.png
---



## 0. 터치를 적용할 이미지뷰 준비

```swift
  @IBOutlet private weak var imageView: UIImageView!{
  didSet {
    imageView.layer.cornerRadius = imageView.bounds.width / 2
    imageView.clipsToBounds = true
  }
}
```


## 1. touch 메소드 

```swift
//터치 시작
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  //터치중
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

  }
  //터치종료
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    <#code#>
  }
  //터치취소, 시스템 인터렙션, inactive상태, 터치중인 뷰가 제거될 떄
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    <#code#>
  }
}

```

1-1. 이름만봐도 대충 느낌을 알 수 있다.. ㅋ


## 2. touch적용해보기 

```swift
 //터치 시작
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    print(touch)
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
    
    
    imageView.image = UIImage(named: "cat2")
    
  }
  //터치중
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard let touch = touches.first else { return }
    print("----touchesMoved----")
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
  }
  
  //터치종료
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard let touch = touches.first else { return }
    print("----touchesEnded----")
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
    
    imageView.image = UIImage(named: "cat2")

  }
  
  //터치취소, 시스템 인터렙션, inactive상태, 터치중인 뷰가 제거될 떄
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    guard let touch = touches.first else { return }
    print("----touchesCancelled---")
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
  }
}

```
2-1. 터치 상태에 print를 주어 확인했다. 디버깅이 위치에 따라 프린팅 된다. 


## 3. 이미지 반응 구현 (클릭, 움직임에 따라 이미지뷰 이동 - touchPoint와 toggle이용)


```swift
import UIKit

// 1. - 클릭시 이미지 변환(제스처 메서드 이용)
// 1.5 - 마우스 움직임을 따라서 이미지뷰가 함께 움직이도록 구현
// 2.- 이미지를 클릭했을 경우에만 마우스 움직임을 따라 이미지뷰가 반응하도록 구현
// 3. 다른 방법?

final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!{
  didSet {
    imageView.layer.cornerRadius = imageView.bounds.width / 2
    imageView.clipsToBounds = true
  }
}
  //2-1. 눌렀는지 안눌렀는지에 대한 정보
  var isHoldingImage = false

  // MARK:  - Touch

  //터치 시작
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    print(touch)
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
    
    //이미지뷰 원점 + 크기를 구하는 방법도 있지만 더 쉽게 제공되는 메서드 있음
       // if imageView.frame.contains(touchPoint)
    
    if imageView.frame.contains(touchPoint) {
    
      //1-1. 이미지반응 (클릭시 cat2이미지)
      imageView.image = UIImage(named: "cat2")
    
      //2-2.
      isHoldingImage = true
    }
  }
  
  //터치중
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard isHoldingImage, let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    
    if imageView.frame.contains(touchPoint) {
   
      //2-0. 이미지 이동 (이것만하면 뚝뚝 끊김)
    imageView.center = touchPoint
      //2-3. 트루일때만 동작하도록
      isHoldingImage = true
      
  }
  }
  
  //터치종료
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard isHoldingImage else { return }
   
    //2-4. 끄기 (토클로 꺼도 무관)
    isHoldingImage.toggle() //초기화로 펄스상태 만듦.
    //1-2. 종료시 다시 cat1이미지
    imageView.image = UIImage(named: "cat1")
  }
  
  //터치취소, 시스템 인터렙션, inactive상태, 터치중인 뷰가 제거될 떄
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
       guard isHoldingImage else { return }
       isHoldingImage.toggle() //2-4.
       imageView.image = UIImage(named: "cat1") //1-2.
    
  }
}

```
3-1. 이미지 이동할 수 있도록 center에 touchPoint를 준다. 
```swift
imageView.center = touchPoint
```
하지만, 이렇게만 주면 뚝뚝 끊긴다. (위 코드중 2-0 ~ 2-4 참고.)

3-1. **touchesBegan(터치시작)** 했을 때, 이미지 변경. 
```swift
imageView.image = UIImage(named: "cat2")
```
3-2. **touchesBegan(터치시작)** 했을때, 
```swift
if imageView.frame.contains(touchPoint) {
```
touchPoint 에 접근했을 때
```swift
isHoldingImage = true
```
을 주어 끊김현상 방지.





## 4. 이미지 반응 구현 (클릭, 움직임에 따라 이미지뷰 이동 - lastTouchPoint, previousLocation이용)

```swift
import UIKit

// 1. - 클릭시 이미지 변환(제스처 메서드 이용)
// 1.5 - 마우스 움직임을 따라서 이미지뷰가 함께 움직이도록 구현
// 2.- 이미지를 클릭했을 경우에만 마우스 움직임을 따라 이미지뷰가 반응하도록 구현
// 3. 다른 방법?

final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!{
  didSet {
    imageView.layer.cornerRadius = imageView.bounds.width / 2
    imageView.clipsToBounds = true
  }
}
  //2-1. 눌렀는지 안눌렀는지에 대한 정보
  var isHoldingImage = false
  //3-1. 라스트 터치포인트 기억시키기
  var lastTouchPoint = CGPoint.zero
  
  
  // MARK:  - Touch

  //터치 시작
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    print(touch)
    
    let touchPoint = touch.location(in: touch.view) //정확하게 어디(터치포인트)를 터치했는지.
    print(touchPoint)
    
    //이미지뷰 원점 + 크기를 구하는 방법도 있지만 더 쉽게 제공되는 메서드 있음
       // if imageView.frame.contains(touchPoint)
    
    if imageView.frame.contains(touchPoint) {
    
      //1-1. 이미지반응 (클릭시 cat2이미지)
      imageView.image = UIImage(named: "cat2")
    
      //2-2.
      isHoldingImage = true
      
      //3-2.
      lastTouchPoint = touchPoint

    }
  }
  
  //터치중
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard isHoldingImage, let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    
      
      //3-3.
      // currenTouchPoint = 100 (움직인위치)
      // lastTouchPoint = 150 (시작위치)
      // 100 - 150 = -50 (이동거리)
      
      
     //방법1.3-3. lastTouchPoint이용
    //x의 이동거리, y의 이동거리를 센터x랑 센터y에게 더해준 것.
    //    imageView.center.x = imageView.center.x + (touchPoint.x - lastTouchPoint.x)
    //    imageView.center.y = imageView.center.y + (touchPoint.y - lastTouchPoint.y)
    //    lastTouchPoint = touchPoint
      //lastTouchPoint처음위치부터 계산됨.
      
     
    //방법2.3-3.previousLocation이용 (lastTouchPoint와 비슷)
      touch.previousLocation: 직전의 터치포인트를 기억했다가 알려주는것.
      let prevTouchPoint = touch.previousLocation(in: touch.view)
      imageView.center.x = imageView.center.x + (touchPoint.x - prevTouchPoint.x)
      imageView.center.y = imageView.center.y + (touchPoint.y - prevTouchPoint.y)
 
      //점에서 점으로 이동했을때, 센터x랑,y한테 그 이동거리만큼 움직여라
  
    }
  
  
  //터치종료
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard isHoldingImage else { return }
   
    //2-4. 끄기 (토클로 꺼도 무관)
    isHoldingImage.toggle() //초기화로 펄스상태 만듦.
    //1-2. 종료시 다시 cat1이미지
    imageView.image = UIImage(named: "cat1")

    
  }
  
  //터치취소, 시스템 인터렙션, inactive상태, 터치중인 뷰가 제거될 떄
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
       guard isHoldingImage else { return }
       isHoldingImage.toggle() //2-4.
       imageView.image = UIImage(named: "cat1") //1-2.
    
  }
}
```
4-1. 둘의 차이가 있다면, lastTouchPoint는 개발자가 저장한 값, previousLocation는 프레임워크에서 지원하는 값.
4-2. 3의 방법보다 lastTouchPoint와 previousLocation를 이용하는게 훨씬 깔끔? 할 것 같다는 개인적인 생각. 




## 5. shack 모션달기(Bonus) 
```swift
// MARK: Motion
  
  override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionBegan(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat2")
    }
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionEnded(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }

  override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionCancelled(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }
}

```


## 전체코드

```swift
//
//  TouchViewController.swift
//  GestureRecognizerExample
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit


final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.frame.width / 2
      imageView.clipsToBounds = true
    }
  }
  var isHoldingImage = false
  var lastTouchPoint = CGPoint.zero
  

  // MARK: Touch
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    
    if imageView.frame.contains(touchPoint) {
      imageView.image = UIImage(named: "cat2")
      isHoldingImage = true
      lastTouchPoint = touchPoint
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard isHoldingImage, let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    
//    imageView.center.x = imageView.center.x + (touchPoint.x - lastTouchPoint.x)
//    imageView.center.y = imageView.center.y + (touchPoint.y - lastTouchPoint.y)
//    lastTouchPoint = touchPoint
    
    let prevTouchPoint = touch.previousLocation(in: touch.view)
    imageView.center.x = imageView.center.x + (touchPoint.x - prevTouchPoint.x)
    imageView.center.y = imageView.center.y + (touchPoint.y - prevTouchPoint.y)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard isHoldingImage else { return }
    isHoldingImage.toggle()
    imageView.image = UIImage(named: "cat1")
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    guard isHoldingImage else { return }
    isHoldingImage.toggle()
    imageView.image = UIImage(named: "cat1")
  }


  // MARK: Motion
  
  override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionBegan(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat2")
    }
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionEnded(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }

  override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionCancelled(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }
}

```
