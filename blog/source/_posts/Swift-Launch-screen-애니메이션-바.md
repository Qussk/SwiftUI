---
title: '[Swift]Launch screen 애니메이션 바(CAGradientLayer)'
date: 2020-07-08 10:12:03
category: "ios"
tags:
- Swift
- Launch Screen
- animation
- CAGradientLayer
thumbnail: /image/grad.png
---


프로젝트중 LaunchScreen이 필요 했는데, 

스토리보드로 해야할 것 처럼 생겼고,,

swift 파일 만들어서 @IBOulet연결 해도 코드가 적용안되는 모습이고,, 

알아보니, 

Xcode에서 지원하는 LaunchScreen을 쓰기보다 보통  ViewController을 이용하여 LaunchScreen을 직접 만들어 쓴다고 한다! 

🤔

그래서 vc를 만들고 

animation을 주면 좋을 것 같아 찾아 보았다! 


[[참고한 사이트 - 왕복바]](https://m.blog.naver.com/hjloveu012/221586596920)

위 사이트에서는 왕복으로 왔다갔다하는 바지만, 

나는 로딩이 되는 것처럼 보이기 위해 한 방향으로만 가도록 고쳤다 ㅎㅎ ! 


### HorizontalMarqueeView.swift 

```swift
import UIKit

class HorizontalMarqueeView: UIView {
  
  var barView: UIView!
  var backgroundGradientLayer: CAGradientLayer!
  
  var grdientDelay: CFTimeInterval = 0.7
  var grdientDuration: CFTimeInterval = 0.3
  var moveDelay: TimeInterval = 0.3
  var moveDuration: TimeInterval = 1
  
  public func initBar() {
    self.clipsToBounds = true
    self.backgroundColor = UIColor.clear
    
    let barW = self.frame.size.width / 2
    let barH = self.frame.size.height
    
    barView = UIView.init(frame: CGRect.init(x: self.frame.size.width, y: 0, width: barW, height: barH))
    barView.backgroundColor = UIColor.clear
    self.addSubview(barView)
    
    backgroundGradientLayer = CAGradientLayer()
    backgroundGradientLayer.frame = barView.bounds
    backgroundGradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
    backgroundGradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.5)
    //166, 177, 225
    backgroundGradientLayer.colors = [UIColor(red: 166/255, green: 177/255, blue: 225/255, alpha: 1).cgColor, UIColor.clear.cgColor]
    backgroundGradientLayer.locations = [1.0, 1.0]
    barView.layer.addSublayer(backgroundGradientLayer)
    
    moveBarToLeft()
    
  }
  
  private func moveBarToLeft() {
  // 1.reset
    barView.frame = CGRect.init(x: self.frame.size.width, y: 0, width: barView.frame.size.width, height: barView.frame.size.height)
    backgroundGradientLayer.colors = [UIColor(red: 166/255, green: 177/255, blue: 225/255, alpha: 1).cgColor, UIColor.clear.cgColor]
    backgroundGradientLayer.locations = [1.0, 1.0]
    
    
    // 2.anim gradient
    let gradientChangeLocation = CABasicAnimation(keyPath: "locations")
    gradientChangeLocation.beginTime = CACurrentMediaTime() + grdientDelay
    gradientChangeLocation.duration = grdientDuration
    gradientChangeLocation.toValue = [-1.0, 1.0]
    gradientChangeLocation.fillMode = CAMediaTimingFillMode.forwards
    gradientChangeLocation.isRemovedOnCompletion = false
    
    self.backgroundGradientLayer.add(gradientChangeLocation, forKey: "locationsChange")
    
    // 3. anim move
    UIView.animate(withDuration: moveDuration, delay: moveDelay, options: UIView.AnimationOptions.curveLinear, animations: {
      
      self.barView.frame = CGRect.init(x: -self.barView.frame.size.width, y: 0, width: self.barView.frame.size.width, height: self.barView.frame.size.height)
      
    }) { (isFinish) in
      
      self.moveBarToLeft()
      
    }
  }

}
```
**1. reset**
- 바 뷰 부분에 **CAGradientLayer**를 이용하였다. background color위에 color gradient를 그려서 layer의 shape을 채우는 layer라고 생각하면 될 듯.
- startPoint와 endPoint 는 view위에 그려질 그라데이션의 시작과 끝점.
- **backgroundGradientLayer** 은 그라데이션의 비율. 기본적으로 [1,0]이 1:1 모습.
**2. anim gradient**
-  anim gradient의 부분은 CABasicAnimation을 이용하여 그라데이션 주는 부분. 
- gradientChangeLocation의 시작 시간(beginTime)은 CACurrentMediaTime(현재 절대 시간을 초 단위로 반환) + grdientDelay이다. let grdientDelay = 0.7
- coloer는 커스텀 하여 사용
**3. anim move**
- 일반적인 animation을 사용


CAGradientLayer에 대한 자세한 내용은 아래의 블로그를 참고하면 된다! 

(매우 쉽게 설명 되어있음!)

[CAGradientLayer 참고 - Zedd 블로그](https://zeddios.tistory.com/948)



### Launch Screen VC에 HorizontalMarqueeView코드 넣어 주기.

```swift
import UIKit

class ViewController: UIViewController {
  
  var marqueeView: HorizontalMarqueeView!
  
  let timerArr : [IndexPath] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    
    marqueeView = HorizontalMarqueeView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width/10, y: 400, width: UIScreen.main.bounds.size.width/1.2, height: 5))
    self.view.addSubview(marqueeView)

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

        let startVC = StartViewController()
        startVC.delegate = self
        startVC.modalPresentationStyle = .fullScreen
        self.present(startVC, animated: true)

   }
    marqueeView.initBar()
    setupLaunchImage()
  
  }
  func setupLaunchImage(){
    
    let launchImage = UIImageView()
    launchImage.image = UIImage(named: "Dadam4")
    
    view.addSubview(launchImage)
    
    launchImage.translatesAutoresizingMaskIntoConstraints = false
    
    launchImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width/2.8).isActive = true
    launchImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/3).isActive = true
    launchImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width/3)).isActive = true
    launchImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.width/0.7)).isActive = true

  }

}

extension ViewController: StartViewControllerDelegate {
  func handleDismiss() {
    let MainVC = MainViewController()
  //  let navi = UINavigationController(rootViewController: MainVC)
    MainVC.modalPresentationStyle = .fullScreen
    self.present(MainVC, animated: false)
  }
  
}
```
-  **DispatchQueue.main.asyncAfter(deadline: .now() + 3) {** 을 이용하여, 해당 Launch화면이 main으로부터 3초뒤에 종료되도록 하였다. 



### 완성된 모습 

[[영상보기]](https://www.youtube.com/watch?v=f2uHaIQeQYw&lc=UgzvZkYN3GBFMesltn94AaABAg)
