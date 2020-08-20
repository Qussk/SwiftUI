---
title: '[Swift]CollectionViewCell에 애니메이션 주기(CAAnimation)'
date: 2020-07-08 09:07:48
category: "ios"
tags:
- Swift
- UICollectionView
- CAAnimation
thumbnail: /image/acani.png
---

Cell에는 애니메이션 못주나?

라는 생각하나로..

CollectionViewCell에 animation을 주는 방법을 찾다가, 

레이어 상태 간의 애니메이션 전환을 주는 CATransition을 발견했다! 

🥺

바로 구현 고고 

### AnimationUtility.swift

```swift

import UIKit

class AnimationUtility: UIViewController, CAAnimationDelegate {
  
  static let kSlideAnimationDuration: CFTimeInterval = 0.5
  
  static func viewSlideInFromRight(toLeft views: UIView) {
    var transition: CATransition? = nil
    transition = CATransition.init()
    transition?.duration = kSlideAnimationDuration
    transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition?.type = CATransitionType.push
    transition?.subtype = CATransitionSubtype.fromRight
    //transition?.delegate = (self as! CAAnimationDelegate)
    views.layer.add(transition!, forKey: nil)
  }
  
  static func viewSlideInFromLeft(toRight views: UIView) {
    var transition: CATransition? = nil
    transition = CATransition.init()
    transition?.duration = kSlideAnimationDuration
    transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition?.type = CATransitionType.push
    transition?.subtype = CATransitionSubtype.fromLeft
 //   transition?.delegate = (self as! CAAnimationDelegate)
    views.layer.add(transition!, forKey: nil)
  }
  
  static func viewSlideInFromTop(toBottom views: UIView) {
    var transition: CATransition? = nil
    transition = CATransition.init()
    transition?.duration = kSlideAnimationDuration
    transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition?.type = CATransitionType.push
    transition?.subtype = CATransitionSubtype.fromBottom
//transition?.delegate = (self as! CAAnimationDelegate)
    views.layer.add(transition!, forKey: nil)
  }
  
  static func viewSlideInFromBottom(toTop views: UIView) {
    var transition: CATransition? = nil
    transition = CATransition.init()
    transition?.duration = kSlideAnimationDuration
    transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition?.type = CATransitionType.push
    transition?.subtype = CATransitionSubtype.fromTop
  //  transition?.delegate = (self as! CAAnimationDelegate)
    views.layer.add(transition!, forKey: nil)
  }
}

```
- CATransition : 레이어 상태 간 애니메이션 전환을 제공하는 객체. 기본 전환은 크로스 페이드이지만 사전 정의 된 전환 세트와 다른 효과를 지정할 수 있다.
- CAMediaTimingFunction : 애니메이션의 간격의 타이밍 기능. 곡선으로 정의하는 함수의 한 세그먼트를 나타낸다. 이 함수는 범위 [0,1]과 출력 시간에 매핑 [0,1].
- easeInEaseOut :  애니메이션이 느리게 시작하고 지속 시간 동안 가속 된 다음 완료하기 전에 다시 느리게함 (아래 그림 참고)
- subtype은 어디로부터? 올지 설정하는 것 같다. (아니면 기존 레이아웃 위치?)


![](/image/easeInEaseOut.png)



### cellForItemAt에 animate 코드추가

```swift
// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MainCollectionViewCell
    
    if !cell.isAnimated {
      
      UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
        
        if indexPath.row % 2 == 0 {
          AnimationUtility.viewSlideInFromLeft(toRight: cell)
        }
        else {
          AnimationUtility.viewSlideInFromRight(toLeft: cell)
        }
        
      }, completion: { (done) in
        cell.isAnimated = true
      })
    }
    
    cell.backgroundColor = .clear
    cell.mainImageView.image = UIImage(named: images[indexPath.item])
    cell.mainTitleImage.image = UIImage(named: "cardShadow")
    cell.titlteLable.text = titleData[indexPath.item]
    
    return cell
  }
}
```

코드는 stackoverflow를 참고 했다! 

옛날 코드라서 바뀐 게 좀 있었지만 문제 없는 정도였다!... 

[참고링크 - stackoverflow](https://stackoverflow.com/questions/49387620/animate-collection-view-cells)


### 완성된 모습 


4가지 게임이 보이는 메인화면에 적용! 

[[영상보기]](https://www.youtube.com/watch?v=f2uHaIQeQYw&lc=UgzvZkYN3GBFMesltn94AaABAg)





