---
title: '[Swift]Xib이용예제(sb: customUI)'
date: 2020-07-25 15:18:31
category: "ios"
tags:
- Swift
- UIView
- CustomUI
thumbnail: /image/xib11.png
---


Xib로 customa UIView를 구현하는 방식. 

첫 발단은 기술면접 보면서 customUI만들어본적 있냐고 했을 때,

아, MVC 패턴 말하는 거냐고?? 물어봤는데, 정색하면서 아니라고 해서 공부시작.. 

Xib/Nib 의 존재를 알게 되었고 적용해봄. 

~~결론은 내가생각 했던 커스텀~~ 이 아니라, 그냥 스토리보드 상에서 사용하는 UIView~~였음....

ㅡㅡ,, 

그래서 좀 실망한 부분.. 



## 1. UIView

먼저, customView가 될, UIView를 하나 만든다. 
시험삼아 레이블 1개,버튼 1개가 있는 커스텀 뷰를 만들 것이다. 


```swift
import UIKit

class MyView: UIView {

  let myLable = UILabel()
  let mybutton = UIButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
    setUI()
    constrain()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func commonInit(){
    
    let viewXib = Bundle.main.loadNibNamed("MyView", owner: self, options: nil)![0] as! UIView
    viewXib.frame = self.bounds
    viewXib.backgroundColor = .white
    viewXib.layer.cornerRadius = 20
    addSubview(viewXib)
  }
  
  
  func setUI(){
    myLable.text = "dd"
    addSubview(myLable)
    
    mybutton.setTitle("버튼", for: .normal)
    mybutton.setTitleColor(.red, for: .normal)
    addSubview(mybutton)
    
  }
  
  func constrain(){
    
    [myLable,mybutton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
     }
    
    NSLayoutConstraint.activate([
      myLable.centerXAnchor.constraint(equalTo: centerXAnchor),
      myLable.centerYAnchor.constraint(equalTo: centerYAnchor),
  
      mybutton.topAnchor.constraint(equalTo: myLable.bottomAnchor),
      mybutton.centerXAnchor.constraint(equalTo: centerXAnchor),

    ])
  }
}
```
1-1.  override init과 required init?은 일반 MVC와 동일하다. 
1-2. 습관처럼 view.addsubview~~ 쓰려고 했는데 이미 view라서 view쓰면 오류난다. addsubView으로 그냥으로 처리.. 
1-3.  다른점은 commonInit 부분인데,  commonInit함수가 UIview불러오는 함수다. 
1-4. **loadNibNamed** 이 해당 xib파일의 클래스 이름을 가져와준다. Bundle.main으로?.. "MyView"는 xib클래스 이름!




xib 이 뭐야 !!😡 라고 묻는 다면 아래를 보시라. 

~~늦어서 미안..~~




## 2. xib만들기 



![](/image/xib.png)


2-1. cmd + n 으로 새로만들기 진행후 아래 View를 선택



![](/image/xib1.png)



스토리보드 비스무리한 게 나올텐데 우리는 코드로 하자구, , ,


2-2. class이름만 지정하도록 한다. 


(스토리 보드로 할거라면, 위의 코드에 레이블과 버튼을 모두 @IBOulet처리 하면된다. 그리고 스토리 보드에 꾸미면 됨... 이건 다른 블로그에도 많으니까......)


그런데 파일에 직접 들어가서 class이름을 하나하나 부여하는 것도 번거로운것 같은데.. 아마 다른 방법이 있긴 할 것같은데.. 
다음에 더 알아보기로.. 
(지금은 궁금증해소가 먼저,,)


~~알아본 결과: 그냥 애초에 스토리보드용이라서 그러는 거 같다 ㅋㅋㅋ 그런거 없음~~


![](/image/xib3.png)


2-3. 파일명도 customView와 동일하게 지정해줬다면 끝! (혼돈이 오지 않게)



**commonInit** 함수에 viewXib 가 customView가 된다. 
viewXib.backgroundColor = .white 로 지정하여 구분! 




## 3.ViewController 

제작한 customView(MyUIView.swift)를  ViewController에 가져오기.  
```swift
import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let customView = MyView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    view.backgroundColor = .yellow
    self.view.addSubview(customView)
  }
}

```
3-1. customView의 크기는 ViewController에서 한답


일단 이정도로 해주면 ? 



![](/image/xib4.png)


vc위에 해당 frame 값으로 customView가 위치한 모습을 볼 수 있다.  스냅챗처럼 커스텀뷰인거 티내려고 cornerRadius = 20을 줬던건데..
생각해보니 일반 view에 cornerRadius가 안먹었었나 !? ㅡㅡ 문득 생각이 들어 
vc에도 cornerRadius을 줘봤다..


결과는,,,? 


![](/image/xib5.png)



아,.... 원래 되는거구나 그냥 일반 view에서도.. 

((((배신감))))....... 난 뭘한거지... 🤔


현재 수치 ㅋ.. 구분하기 쉽게.. 

```
view.laye.cornerRadius = 10
viewXib.layer.cornerRadius = 20
```

아니 그럼 내가 믿었던 건 뭐지 ㅠㅠ....

근데 스냅챗은 뒤에가 검정색인데 ? ..!! 


ㅎㅎ....


SceneDelegate가서 window 색을 black으로 바꾸어 보았다... 

```
window?.backgroundColor = .black
```



결과는 .. ? ? ? 


![](/image/xib6.png)



앗... 뭔가 원했던 그림이랑 비슷하게 나왔다 ㅋㅋ.....


이제야 궁금증이 해소된..



하..  근데 면접자분 피셜,,, 현역에서도 customUI를 제대로 다루는 사람을 본적이 없다고 하셨따... (네이버10년 배민 2년경력이신..)


흠.. 


좀 더 연구해보기로.. 

일단 더 주어진 생각은 


버튼에 액션도 달기

아, 액션도 그냥 달면된다.. 특별할거 없다. 



Xib는 그냥 이걸로 끝인거 같다 활용가능성이 별루 없습,,,,



흐윽.. 😱.... 😔 ;;

