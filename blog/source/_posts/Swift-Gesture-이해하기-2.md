---
title: '[Swift]Gesture 이해하기'
date: 2020-06-25 15:17:16
category: "ios"
tags: 
- Swift
- Gesture
thumbnail: /image/gestrue27.png
---


## 0. 제스처?(UITapGestureRecognizer)


0-0. UITapGestureRecognizer을 상속받아 사용할 수 있는 7가지 제스처, 

- Tap gesture recognizer
- Swipe gesture recognizer
- Pan gesture recognizer
- Pinch gesture recognizer
- Rotation gesture recognizer
- Screen gesture recognizer
- LongPress gesture recognizer


## 1. Tap제스처, Rotation제스처, Swipe제스처 연결. 


![](/image/Gesture12.png) 

제스처 아이템을 검색하여 해당되는 제스처를 @IBAction에 연결한다. 

저는 (Tap, Rotation, Swipe)을 사용했다. 

![](/image/gesture11.png)


스토리 보드상으로 보면 이런 식으로 된다. 


## 2. Tap제스처 구현(더블 클릭시 이미지 크기 4배 증가)


![](/image/gesture10.png)


```swift
import UIKit

final class GestureViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!{
 
 //0.제스처 대상 만들기(이미지뷰).
  didSet {
      imageView.layer.cornerRadius = imageView.frame.width / 2
      imageView.clipsToBounds = true
    }
  }
  
//tap1-1.
  var isQuadruple = false
  
  //더블탭 하면 이미지가 원본의 4배 크기로 <-> 원본으로
  @IBAction private func handleTapGesture(_ sender: UITapGestureRecognizer){
    guard sender.state == .ended else { return }
      
    //tap1-3.
      if !isQuadruple {
        imageView.transform = imageView.transform.scaledBy(x: 2, y: 2)
      } else {
        imageView.transform = .identity
      }
      isQuadruple = !isQuadruple
    }
```
2-1. identity는 초기화상태로 되돌리기. (다시 더블 클릭시 원래상태로 복구)  
  
  
  
  ## 3. Rotation시 회전 
  
  ![](/image/Gesture15.png)

  
  ```swift
  // MARK: Rotation
  @IBAction private func handleRotationGesture(_ sender: UIRotationGestureRecognizer){
     guard sender.state == .began || sender.state == .changed else { return }
      imageView.transform = imageView.transform.rotated(by: sender.rotation)
      sender.rotation = 0 //회전수 
    }

```

![](/image/Gesture17.png)


## 4. Swipe 방향에 따른 이미지변경

![](/image/Gesture16.png)

```swift
// MARK: Swipe
//으론쪽으로 밀면(스와이프) = cat2
//왼쪽으로 밀면(스와이프) = cat1
@IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer){
  guard sender.state == .ended else { return }
    
    if sender.direction == .left {
      imageView.image = UIImage(named: "cat1")
      sender.direction = .right
    } else {
      imageView.image = UIImage(named: "cat2")
      sender.direction = .left
    }
}
```

![](/image/gesture25.png)


## 전체코드 

```swift
//
//  GestureViewController.swift
//  GestureRecognizerExample
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class GestureViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!{
 
//tap1-1.
  didSet {
      imageView.layer.cornerRadius = imageView.frame.width / 2
      imageView.clipsToBounds = true
    }
  }
  
  
//tap1-2.
  var isQuadruple = false
  
  
  // MARK: Tap
  
  //더블탭 하면 이미지가 원본의 4배 크기로 <-> 원본으로
  @IBAction private func handleTapGesture(_ sender: UITapGestureRecognizer){
    guard sender.state == .ended else { return }
      
    //tap1-3.
      if !isQuadruple {
        imageView.transform = imageView.transform.scaledBy(x: 2, y: 2)
      } else {
        imageView.transform = .identity
      }
      isQuadruple = !isQuadruple
    }

  

 // MARK: Rotation
  @IBAction private func handleRotationGesture(_ sender: UIRotationGestureRecognizer){
     guard sender.state == .began || sender.state == .changed else { return }
      imageView.transform = imageView.transform.rotated(by: sender.rotation)
      sender.rotation = 0 //회전수
    }
  
  // MARK: Swipe
  //오른쪽 스와이프 = cat2
  //왼쪽 스와이프 = cat1
  @IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer){
    guard sender.state == .ended else { return }
      
      if sender.direction == .left {
        imageView.image = UIImage(named: "cat1")
        sender.direction = .right
      } else {
        imageView.image = UIImage(named: "cat2")
        sender.direction = .left
      }
  }

}

```


[보충링크 : (http://minsone.github.io/mac/ios/uigesturerecognizer)](http://minsone.github.io/mac/ios/uigesturerecognizer)



