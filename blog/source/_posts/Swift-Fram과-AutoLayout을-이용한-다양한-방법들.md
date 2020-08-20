---
title: '[Swift]Fram과 AutoLayout을 이용한 다양한 방법들'
date: 2020-05-21 16:08:20
category: "ios"
tags:
- Swift
- AutoLayout
- Frame
- Animate
- UIView
thumbnail: /image/autolay.png
---


## frame을 이용한 방법.

```swift
import UIKit

class greenViewController: UIViewController {
  
  let greenView = UIView()
  let touchButton = UIButton()  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //greenView
    greenView.frame = CGRect(x: 50, y: 100, width: 80, height: 80)
    greenView.backgroundColor = .green
    view.addSubview(greenView)
    
    //touchButton
    touchButton.frame = CGRect(x: 140 , y: 20, width: 100, height: 50)
    touchButton.backgroundColor = .black
    touchButton.setTitle("touch", for: .normal)
    touchButton.addTarget(self, action: #selector(touch(_:)), for: .touchUpInside)
    
    view.addSubview(touchButton)
  }
  
  //버튼 후 frame 변경 
  @objc func touch(_ sender: UIButton) {
    
    UIView.animate(withDuration: 2) {
      
      if self.greenView.layer.cornerRadius == 0 {
        self.greenView.frame = CGRect(x: 50, y: 300, width: 200, height: 200)
        self.greenView.layer.cornerRadius = 100
        
      } else {
        self.greenView.frame = CGRect(x: 50, y: 100, width: 80, height: 80)
        self.greenView.layer.cornerRadius = 0
      }
          
    }
  }
}
```
frame을 이용했다면, 오토 레이아웃을 잡을 필요는 없습니다!


## Auto Layouts 3가지 방법(Constraint. Priority,active toggle
)


## [Constraint]

