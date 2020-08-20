---
title: '[라이브러리]paper-onboarding'
date: 2020-07-30 20:11:37
category: "Library"
tags:
- paper-onboarding
thumbnail: image/on.png
---


## **paper-onboarding**

[https://github.com/Ramotion/paper-onboarding
](https://github.com/Ramotion/paper-onboarding
)


예쁜 온보딩 화면을 구현해주는 라이브러리다 

몬가 색깔 바뀌는 게 예뻐서 한 번 써보고 싶은 라이브러리였다! 

그런데 디자이너분들이 색을 하나로 통일하자고 해서,, 티가 안난당....(왜 썼,,.)


이왕 쓰게 된 거 포스트 !!


나는 cocoapod을 사용하지 않고 Swift Package Manager를 사용했다. 
SwiftPackageManager가 git 협업하기에도 좋고 파일 정리가 훨씬 깔끔해서
cocoapod은 지양하고 있다. 



## **1.import**

```swift
import paper-onboarding
```

## **2.선언**

```swift

//선언
let onboarding = PaperOnboarding()

override func viewDidLoad() {
  super.viewDidLoad()
      
onboarding.dataSource = self
onboarding.delegate = self
}

```


## **3.setup Onboarding**

```swift
 //MARK: - Onboarding
  func setupOnboarding(){
    view.backgroundColor = .white
    view.addSubview(onboarding)
    
    onboarding.translatesAutoresizingMaskIntoConstraints = false
    
    for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
      let constraint = NSLayoutConstraint(item: onboarding,
                                          attribute: attribute,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: attribute,
                                          multiplier: 1,
                                          constant: 0)
      view.addConstraint(constraint)
    }
  }
  
}
```

## **4. PaperOnboardingDataSource(기본값 지정)**

![](image/on1.png)

```swift

//MARK:-PaperOnboardingDataSource
extension OnboardingViewController: PaperOnboardingDataSource {
  
  func onboardingItem(at index: Int) -> OnboardingItemInfo {
    
    
    let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
    let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
    
    return [OnboardingItemInfo(informationImage: UIImage(named:"back")!,
                                 title: "확실한 분리수거",
                                 description: "폐기물 처리 가이드를 통해\n궁금했던 분리수거 방법을 알아보세요.\n잘못된 분리수거 방법을 바로 잡아요",
                                 pageIcon: UIImage(named:"on")!,
                                 color: UIColor.white,
                                 titleColor: UIColor.black,
                                 descriptionColor: UIColor.black,
                                 titleFont: titleFont,
                                 descriptionFont: descirptionFont),
              OnboardingItemInfo(informationImage: UIImage(named:"back")!,
                                 title: "집 앞에서 픽업",
                                 description: "잠들기 전, 집 문 앞에 폐기물을 놓아두고\n쓸애기 서비스를 이용해보세요.\n잠든 사이에 빠르게 수거해 갈게요.",
                                 pageIcon: UIImage(named:"on")!,
                                 color: UIColor.white,
                                 titleColor: UIColor.black,
                                 descriptionColor: UIColor.black,
                                 titleFont: titleFont,
                                 descriptionFont: descirptionFont),
              OnboardingItemInfo(informationImage: UIImage(named:"back")!,
                                 title: "새롭게 재탄생!",
                                 description: "정성껏 분리수거된 재활용 폐기물은\n종류별로 나눠져 재활용 업체에 넘어갑니다\n나의 작은 노력 하나로 깨끗한 지구를 만들어요!",
                                 pageIcon: UIImage(named:"on")!,
                                 color: UIColor.white,
                                 titleColor: UIColor.black,
                                 descriptionColor: UIColor.black,
                                 titleFont: titleFont,
                                 descriptionFont: descirptionFont)
        ][index]
    }
  func onboardingItemsCount() -> Int {
    return 3
  }
```
4-1. **onboardingItemsCount**는 딱 봐도 온보딩페이지 갯수다. 난 3개
4-2. title,description,pageIcon...등 역시 화면만 보아도 매칭이 되서 딱 알것이다. 
4-3. informationImage가 온보딩페이지의 메인 이미지라고 보면되는데, 나는 백터이미지를 넣어놓은 상태다. 왜냐면,, 이게 라이브러리라서 사이즈가 이미 정해져서 나와 변경할 수가 없당....  ~~사실 gif넣을 계획이었는데 시간이 부족해서..그냥 Image로 넣기로 한것T T..~~

디자이너가 바라는 사이즈가 안나와서 해당 카테고리에는 백터이미지를 넣고, 온보딩위에 새로운 UIImageView를 올려서 그것을 처리했다.... (왜썻..2..)



## **5. Action**


```swift
//MARK:- Action
@objc func buttonClicked(_ sender: UIButton){
  
  let adressVC = AddressViewController()
  let adressNV = UINavigationController(rootViewController: adressVC)

  adressNV.modalPresentationStyle = .fullScreen
  present(adressNV, animated: false)
  
  
}
}
```
5-1. 위 코드는 3번째 온보딩 화면에서 **시작하기** 버튼의 메서드이다.  누르면 앱의 주소입력 화면으로 넘어간당




## **6. PaperOnboardingDelegate**


```swift
//MARK:-PaperOnboardingDelegate
extension OnboardingViewController: PaperOnboardingDelegate {

   func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
      
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
      
      if index == 0 {
        if self.getButton.alpha == 1 {
          UIView.animate(withDuration: 0.1, animations: {
            self.getButton.alpha = 0
          })
        }
      }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
      if index == 0 {
        UIView.animate(withDuration: 0.1, animations: {
          self.onboardingImage.alpha = 1
          self.onboardingImage.image = UIImage(named: "on1")
        })
      }else if index == 1 {
        UIView.animate(withDuration: 0.1, animations: {
          //self.onboardingImage.alpha = 0
          self.onboardingImage.image = UIImage(named: "on2")

        })
        
      } else {
        UIView.animate(withDuration: 0.2, animations: {
          self.onboardingImage.image = UIImage(named: "on3")
          self.getButton.alpha = 1
        })
      }
    }
    
  }

```
6-1. PaperOnboardingDelegate에서 alpha을 이용해 Button은 3번째 화면에서만 보이도록 구현
6-2. 온보딩 페이지별로  onboardingImage 다르게 처리해주기 까지 하면 완성 !




### **완성모습 영상보기**

[https://youtu.be/LzJhSUQ_8i8](https://youtu.be/LzJhSUQ_8i8)



