---
title: '[Swift]Custom Tabbar'
date: 2020-08-07 15:56:35
category: "ios"
tags:
- Swift
- Tabbar
thumbnail:
---



UITabbarController에 구애받지 않고 ViewController로 Tabbar 만들기!



참고한 사이트 : 
- [https://milyo-codingstories.tistory.com/m/11](https://milyo-codingstories.tistory.com/m/11)
- [https://dvpzeekke.tistory.com/69](https://dvpzeekke.tistory.com/69)

첫번째 방법은 vc에 tabbar를 만들고 스택뷰를 이용하여 버튼 -> 화면 이동의 방식이고,

두번째 방법은 vc에 collectionView올려서 셀 클릭 -> 화면 이동 의 방식인 거 같은데

난 첫번째 방법을 사용했다. ㅎㅎ ~~공유해주시는 분들 언제나 감사합니다~~



## 1. BaseView 

*베이스가 되는 UIView만들기*


```swift
import UIKit

class BaseView: UIView {
    
    let titleLabel: UILabel = {
        return UILabel()
    }()
    
    /// TitleLabel의 AutoLayout 설정
    func makeTitleLableConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        makeTitleLableConstraint()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

```
- 일단 UIView하나가 필요하다. 화면을 담당하는 녀석. 가운데에 콘트롤러마다 "Lable"이 들어가고, 화면마다 lable의 text가 다른데, 
어쨌든 그러한 점을 보면 BaseView를 타입캐스팅 해서 여러개의 콘트롤러들이 본인들 View에 상속을 받는 방식이다. 

아래를 보면 조금 이해가 된다. 


## 2. firstView ~ ... 

*TabbarItem에 해당될 vc만들기*


```swift
import UIKit

class SNSViewController: UIViewController {

  
      override func loadView() {
             view = BaseView()

             guard let ownView = view as? BaseView else {
                 return
             }
       
             ownView.titleLabel.text = "First View"
         }
      
    }
    
```
- 탭바아이템 3개짜리를 만든다면, 위와 같은 VC이 3개 필요하다. 
- 나는 [chatVC, snsVC, mywriteVC ] 총 3개로 했다. 
- 해당 vc에서의 view는 BaseView가 되고, 이것의 이름 정의는 ownView가 된다. 


## 3. TabbarView 

*TabbatView 디자인하기* 

```swift
import UIKit

class CustomTabbarView: UIView {
  
  var buttonSize: CGFloat = 60
  var buttonBackImageSize: CGFloat = 0
  
  let contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .white
    return contentView
  }()
  
  //탭바 아이템
  let customTabBar: UITabBar = {
    let customTabBar = UITabBar()
    customTabBar.backgroundImage = UIImage()
    customTabBar.shadowImage = UIImage()
    // customTabBar.barTintColor = UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1)
    // customTabBar.alpha = 0.5
    return customTabBar
  }()
  
  let leftStack: ButtonStack = {
    return ButtonStack()
  }()
  
  let centerButtonBackImage: UIImageView = {
    return UIImageView()
  }()
  
  let centerButton: UIButton = {
    return UIButton()
  }()
  
  
  func makeContentViewConstraint() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
      contentView.widthAnchor.constraint(equalTo: widthAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
  
  func makeCustomTabBarConstraint() {
    customTabBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      customTabBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      customTabBar.centerXAnchor.constraint(equalTo: centerXAnchor),
      //   customTabBar.heightAnchor.constraint(equalToConstant: 44),
      customTabBar.widthAnchor.constraint(equalTo: widthAnchor),
    ])
    
  }
  
  
  func makeStackConstraint(targetStack: UIView) {
    targetStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      targetStack.heightAnchor.constraint(equalTo: customTabBar.heightAnchor),
      targetStack.widthAnchor.constraint(equalTo: customTabBar.widthAnchor,multiplier: 1),
      targetStack.centerYAnchor.constraint(equalTo: customTabBar.centerYAnchor)
    ])
  }
  
  func makeLeftStackConstraint() {
    leftStack.leadingAnchor.constraint(equalTo: customTabBar.leadingAnchor,constant: 16).isActive = true
  }
  
  //버튼 back이미지
  func makeCenterButtonBackImageConstraint() {
    centerButtonBackImage.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      centerButtonBackImage.trailingAnchor.constraint(equalTo: customTabBar.trailingAnchor, constant: -16),
      centerButtonBackImage.widthAnchor.constraint(equalToConstant: buttonBackImageSize),
      centerButtonBackImage.heightAnchor.constraint(equalTo: centerButtonBackImage.widthAnchor),
      centerButtonBackImage.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: -(buttonBackImageSize/2))
      
    ])
  }
  
  func makeCenterButtonConstraint() {
    centerButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      centerButton.centerXAnchor.constraint(equalTo: centerButtonBackImage.centerXAnchor),
      centerButton.centerYAnchor.constraint(equalTo: centerButtonBackImage.centerYAnchor),
      centerButton.widthAnchor.constraint(equalToConstant: buttonSize),
      centerButton.heightAnchor.constraint(equalTo: centerButton.widthAnchor),
      centerButton.topAnchor.constraint(equalTo: customTabBar.topAnchor, constant: -(buttonSize/2))
      
    ])
  }
  
  func makeView() {
    addSubview(contentView)
    addSubview(customTabBar)
    addSubview(leftStack)
    addSubview(centerButtonBackImage)
    addSubview(centerButton)
  }
  
  func makeItemConstraints() {
    makeContentViewConstraint()
    makeCustomTabBarConstraint()
    makeStackConstraint(targetStack: leftStack)
    makeLeftStackConstraint()
    makeCenterButtonBackImageConstraint()
    makeCenterButtonConstraint()
  }
  
  func makeCircleBackButtonImage() {
    centerButtonBackImage.backgroundColor = UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1.0)
    centerButtonBackImage.layer.cornerRadius = buttonBackImageSize / 2
  }
  
  func makeCircleBackButton() {
    
    centerButton.backgroundColor = .clear//UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1.0)
    centerButton.setImage(UIImage(systemName: "camera.viewfinder", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)), for: .normal)
    
    centerButton.tintColor = UIColor.lightGray
    centerButton.layer.cornerRadius = buttonSize / 2
  }
  
  func makeLabelTitle() {
    
    [leftStack.firstButton,leftStack.secondButton, leftStack.threeButton].forEach{
      $0.backgroundColor = .clear
      $0.backgroundColor = UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1)
      $0.tintColor = UIColor.white
      //  $0.alpha = 0.5
      $0.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    }
    //symbols 디자인
    leftStack.firstButton.setImage(UIImage(systemName: "bubble.left.and.bubble.right.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)), for: .normal)
    
    leftStack.secondButton.setImage(UIImage(systemName: "timer",withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)), for: .normal)
    
    leftStack.threeButton.setImage(UIImage(systemName: "person",withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)), for: .normal)
    
    leftStack.vecLable.text = ""
    leftStack.vecLable.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
    leftStack.vecLable.backgroundColor = UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1)
    // leftStack.vecLable.alpha = 0.5
  }
  
  func linkTagNumber() {
    leftStack.firstButton.tag = 0
    leftStack.secondButton.tag = 1
    leftStack.threeButton.tag = 2
    leftStack.vecLable.tag = 3
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    buttonBackImageSize = buttonSize + 10
    makeView()
    makeItemConstraints()
    makeLabelTitle()
    makeCircleBackButtonImage()
    makeCircleBackButton()
    linkTagNumber()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class ButtonStack: UIView {
  
  let buttonStackView: UIStackView = {
    let buttonStackView = UIStackView()
    buttonStackView.axis = .horizontal
    buttonStackView.distribution = .fillEqually
    return buttonStackView
  }()
  
  let firstButton: UIButton = {
    return UIButton()
  }()
  
  let secondButton: UIButton = {
    return UIButton()
  }()
  let threeButton: UIButton = {
    return UIButton()
  }()
  let vecLable: UILabel = {
    return UILabel()
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(buttonStackView)
    
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      buttonStackView.widthAnchor.constraint(equalTo: widthAnchor),
      buttonStackView.heightAnchor.constraint(equalTo: heightAnchor),
      buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
    
    buttonStackView.addArrangedSubview(firstButton)
    buttonStackView.addArrangedSubview(secondButton)
    buttonStackView.addArrangedSubview(threeButton)
    buttonStackView.addArrangedSubview(vecLable)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}

```
- TabbarView에 대한 정보. 레이아웃, 디자인, addsubView, 모두 이쪽에서 해주면 된다. 
- 카메라 버튼이 하나 있는 데, 그건 그냥 버튼일 뿐이고, 마치 탭바에 있는 것처럼 레이아웃을 잡아주면 되는 방식이다. 
- vecLable는 스택뷰의 tag=3에 대한 정보인데, 거의 Nil이라고보면 된다. 이 위에 카메라 버튼 이 와야하는 부분이고,,, 스택뷰 비율 예쁘게 맞춰야해서.. 버튼 추가보다 레이블을 추가하여 맞췄다. 


### **Tabbar 실선 없애기?**


여기서 좀 헤맸는데, 

![](/image/tabbar1.png)

일단 미리보여주자면, 위 코드로 작성되면 이렇게 나온다. (아직 탭바 콘트롤러 작성적이기 때문에 안보이실 것..)

아, 저 위에 검정 실선 너무 거슬려 해서 없애려한게 이 것의 발단.. 


![](/image/tabbar2.png)


```swift
customTabBar.backgroundImage = UIImage()
customTabBar.shadowImage = UIImage()
// customTabBar.barTintColor = UIColor(red: 251/255, green: 252/255, blue:157/255, alpha:1)
```

navigationvar생략도 약간 비슷한 방식으로 없애서, tabbar에 적용해보았더니 되었다 ㅋㅋ 그런데??
옆에 애들이 날아갔다... 왜지?,, ㅡㅡ;;;;


다시 부랴부랴 색을 채우려고 코드 이것저것 적용해보고... 결국 알파값을 0.5 씩 낮춰봤는데.... 


![](image/tabbar3.png)


아........ 탭바 위에 스택뷰 backgroundColor 때문에 동일하게 알파 0.5 씩 줬음에도,, 탭바 부분은 0.5+0.5 가 겹쳐져 더 진하게 보인다.
(틴트 컬러나 백그라운드 컬러에서 알파를 낮추는게 아니라, 탭바.알파 = 0.5 로 직접 적용해야함. 주석 보면 알 수 있음!!)


그렇다면 ? 

![](image/tabbar4.png)


일단, 실선을 없애려면

**backgroundImage** 와 **shadowImage** 를 줘야하는게 맞다. 


그러면 tabbar에 대한 이미지 처리가 **완전히** 없어진 것이기 때문에,
스택뷰의 backgroundColor로 tabbar의 색을 대신해 주는 것이다.
그래서 노란 영역은 탭바가 아닌 스택뷰의 영역인 것...!!!!!!!


그래서 위에 vecLabel을 추가한 것이다.. 간격 맞추려고.. vacLable에 프레임도 주고 배경색도 동일하게 준 것 !! 


![](image/tabbar5.png)


눈이 아파서 일단 이 정도로 마무리.... 

디자인은 아직 나온게 아니니까..

~~이거하면서 느꼈다. 나 디자인 개못하구나..🐶~~

이제 마지막이다.


## Custom Tabbar

```swift

import UIKit

class CustomTabbar: UIViewController {
    
    var chatVC: ChatlistViewController?
    var snsVC: SNSViewController?
    var mywriteVC: MyWriteHistoryViewController?
    var vcList = [UIViewController]()
    var prevIndex: Int?
    
    @objc func linkAction(_ sender: UIButton) {
        checkView()
        prevIndex = sender.tag
        moveView(sender.tag)
    }
    
    /// 새로운 뷰를 만들기 전에 기본의 뷰가 있으면 그 뷰를 제거한다.
    func checkView() {
        
        guard let prevSelectedIndex = prevIndex else {
            return
        }

        vcList[prevSelectedIndex].willMove(toParent: nil)
        vcList[prevSelectedIndex].view.removeFromSuperview()
        vcList[prevSelectedIndex].removeFromParent()
        
    }
    
    /// 새로운 뷰로 이동한다.
    func moveView(_ index: Int) {
        
        guard let targetView = view as? CustomTabbarView else {
            return
        }
       
        addChild(vcList[index])
        targetView.contentView.addSubview(vcList[index].view)
        vcList[index].view.frame = targetView.contentView.bounds
        vcList[index].didMove(toParent: self)
        
    }
    
    @objc func moveWriteView() {

        let vc = CameraViewController()
        present(vc,animated: true)
    }
    
    ///각 탭바의 아이템들을 액션에 연결한다.
    func linkTargetAction() {
        
        guard let targetView = view as? CustomTabbarView else {
            return
        }
        
        targetView.leftStack.firstButton.addTarget(self, action: #selector(linkAction), for: .touchUpInside)
        targetView.leftStack.secondButton.addTarget(self, action: #selector(linkAction), for: .touchUpInside)
        targetView.leftStack.threeButton.addTarget(self, action: #selector(linkAction), for: .touchUpInside)
    
        targetView.centerButton.addTarget(self, action: #selector(moveWriteView), for: .touchUpInside)
        
    }
    
    func makeViewList() {
        
        guard let views = [chatVC, snsVC, mywriteVC] as? [UIViewController] else {
            return
        }
        
        vcList = views
    }
    
  //탭바뷰
    override func loadView() {
        view = CustomTabbarView()
    }
    
    override func viewDidLoad() {
        
        chatVC = ChatlistViewController()
        snsVC = SNSViewController()
        mywriteVC = MyWriteHistoryViewController()
        
        makeViewList()
        linkTargetAction()
    }
    
    /// 뷰가 로딩이 다 되고 난 뒤 기본 뷰를 셋팅한다.
    override func viewDidAppear(_ animated: Bool) {
        
        if prevIndex == nil {
            prevIndex = 0
            moveView(0)
        }
        
    }
    

}
```

- 드디어 탭바컨트롤러!! 읽으면 대충 감은 온다.. ㅎㅎ

(이 부분은 포스팅 맨 위에 작성된 첫번째 방법 참고 링크를 보면 좀 더 이해가 쉽다.!!)

[링크!](https://milyo-codingstories.tistory.com/m/11)


일단 이정도로 글을 마치고, 

시간이 남으면 스크롤시 사라지는 것, tabbar아이템 클릭시의 애니매이션을 추가할 계획이다.










