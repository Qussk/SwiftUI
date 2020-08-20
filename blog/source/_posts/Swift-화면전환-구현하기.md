---
title: '[Swift]화면전환 구현하기'
date: 2020-05-06 16:52:03
category: "ios"
tags:
- Swift
- TextField
- Label
- Button
- 개발일기
- present
thumbnail: /image/Stert.png
---



하.. 힘들 쓰.. 뭐했다고 힘들지? 착각인가? 

어쨌든 오늘은 레이블과 화면전환을 이용해 데이터를 전달하는 용도로 만들어 보고자 한다.

먼저 첫 화면을 만든다. 



## 1. 화면구성 (프레임짜기)


1-1. 레이블2개, 버튼 1개 만들기 

```swift
import UIKit

class endViewController: UIViewController {
  
  let editButton = UIButton()
  let namelabel = UILabel()
  let emaillabel = UILabel()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    namelabel.frame = CGRect(x: 70, y: 50, width: view.frame.width - 140, height: 50)
    namelabel.backgroundColor = .black
    namelabel.textAlignment = .center
    namelabel.text = "이름"
    namelabel.textColor = .white
    namelabel.font = UIFont.systemFont(ofSize: 30)
    view.addSubview(namelabel)
    
    
    emaillabel.frame = CGRect(x: 70, y: 120, width: view.frame.width - 140, height: 50)
    emaillabel.backgroundColor = .black
    emaillabel.textAlignment = .center
    emaillabel.text = "email주소"
    emaillabel.textColor = .white
    emaillabel.font = UIFont.systemFont(ofSize: 30)
    view.addSubview(emaillabel)
    
    
    editButton.frame = CGRect(x: 70, y: 220, width: view.frame.width - 140, height: 50)
    editButton.setTitle("정보변경하기", for: .normal)
    editButton.backgroundColor = .darkGray
    view.addSubview(editButton)
    
    editButton.addTarget(self, action: #selector(editbutton(_:)), for: .touchUpInside)

  }
  
  @objc func editbutton(_ sender: UIButton) {
  }
  
```

### Lable과 Button에서 기억해야할 것

- Lable은 text고 ,  Button은 setTitle이다. 
- Lable Font size가 은근히 안외워 진다. emaillabel.font = UIFont.systemFont(ofSize: 30)
- CGrect의 ```view.frame.width```는 기기의 비율을 기준으로 하기 때문에 어떤 기기에서든 동일한 비율값으로 정의된다. (많이 사용될 것 같다.)
- 해당 변수를 전체에서 사용하고자 하면 변수를 바깥으로 뺴줘야한다. 

```swift
class endViewController: UIViewController {

let editButton = UIButton()
 let namelabel = UILabel()
 let emaillabel = UILabel()
```
  
이 외에는 다 외웠음 ㅎㅎ 
  
  
    
위의 코드로 메인화면이 완성되었다면, 아래의 화면을 확인 할 수 있을 것이다. 


![이미지](/image/Start-1.png)


이후에 할 작업은 "정보변경하기(editbutton)" 버튼을 눌렀을 때 이동할 화면을 만들어 준다. 



## 2. 전환될 화면 만들기  


버튼을 누르면 화면이 전환되는 방식으로 구현할 것이기 때문에 viewcontrollerr가 하나 더 필요하다. 
viewcontrollerr를 하나 더 만들고 1-1과 마찬가지로 프레임을 짠다.


2-1. [닫기], [저장] 버튼을 만들어준다. 

먼저 내가 구현할 화면은 present(ios13이상)타입의 화면이다. present는 화면이 아래서 위로 올라오는 방식인데, 이 경우 값전달이 안되는 게 기본값이다. (apple기본앱중 알람을 참고하면 된다.) 그냥 손으로 내려서 끌 수 있는 간편한 창같은 것인데... 화면전환으로 간편하게 값 전달을 하고싶다면 fullscreen타입으로 하면된다. 

그럼에도 굳이 present화면으로 값전달을 하고 싶은 경우라면... 그건 다음 post에 올리기로 하고.... 

나는 닫기 버튼과 저장버튼을 만들기로 정했다. 

```swift
  import UIKit

  class startViewController: UIViewController {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = .black
      
      let buttonX = UIButton()
      buttonX.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
      buttonX.setTitle("닫기", for: .normal)
      buttonX.setTitleColor(.orange, for: .normal)
      buttonX.backgroundColor = .black
      view.addSubview(buttonX)
      
      buttonX.addTarget(self, action: #selector(buttonOwn(_:)), for: .touchUpInside)
      
      
      let buttonC = UIButton()
      buttonC.frame = CGRect(x: 323, y: 0, width: 50, height: 50)
      buttonC.setTitle("저장", for: .normal)
      buttonC.backgroundColor = .black
      buttonC.setTitleColor(.orange, for: .normal)
      view.addSubview(buttonC)
      
      buttonC.addTarget(self, action: #selector(buttonTwo(_:)), for: .touchUpInside)
      
  
    @objc private func buttonOwn(_ sender: UIButton){ //닫기버튼
      dismiss(animated: true)
    }
    
    @objc func buttonTwo(_ sender: UIButton){ //저장버튼
    }
```
      
  2-2. 텍스트필드를 2개 만든다. (nameLabel과 emailLable에 전달될 nameTextfield, emailTextfield을 만든다.) 


```swift

nameTextField.frame = CGRect(x: 15, y: 250, width: view.frame.width - 30, height: 44)
nameTextField.backgroundColor = .white
nameTextField.borderStyle = .roundedRect
nameTextField.keyboardType = .emailAddress
view.addSubview(nameTextField)

  nameTextField.addTarget(self, action: #selector(textFieldN(_:)), for: .editingDidEndOnExit)


emailTextField.frame = CGRect(x: 15, y: 300, width:  view.frame.width - 30, height: 44)
  emailTextField.backgroundColor = .white
  emailTextField.borderStyle = .roundedRect
  emailTextField.keyboardType = .emailAddress
  view.addSubview(emailTextField)
  
  
  emailTextField.addTarget(self, action: #selector(textFieldE(_:)), for: .editingDidEndOnExit)
}

@objc func textFieldN(_ sender: UITextField){
 }

 @objc func textFieldE(_ sender: UITextField){
   
 }
```


### TextField에서 기억해야할 것

- borderStyle과 keyboardType을 지정해줘야한다. .으로 찍으면 종류가 많이 나온다. 
- "addTarget"에 "for: .editingDidEndOnExit" 은 키보드에서 리턴키를 눌렀을 때 닫아주는 소스다. (아래 TextField사이클 참고)

```
키보드가 뜰때 - DIdBegin
입력시 - Changed
리턴시 텍스트필드 내려감 - textfieldDidEndOnExit
리턴 이후에 뜸.(필연적으로..) PrimaryActionTriggered
종료시 - DidEnd
```

때에 따라 필요 기능이 있을 때에는 아래의 방식으로 구현하면 된다. 


```swift
 @IBAction func DidEnd(_ sender: UITextField) {
print("5. DidEnd")
   print(sender.text)
   
   //print(seder.text)할떄, 타입이 Any이면 오류남. Any -> UITextField로 바꿔줘야 print가능.

```


위 코드대로 모두 짰다면 두 번째 화면이 완성된 모습을 볼 수 있다. 


![이미지](/image/start-5.png)



이제 첫번째 화면과 두번 째 화면을 연결지을 일만 남았다. 



## 3. 화면전환하기 

첫번째 화면(endViewController)에서 "정보변경하기" 버튼을 누르면 두 번째 화면(startViewController)으로 전환되는 모션이다.  ~~ViewController 이름을 반대로 지었다ㅜ 헷깔림 주의~~


3-1.  버튼을 누르면 두번째 화면으로 이동 

버튼을 누르면 이동될 수 있도록 버튼 아래에 해당 코드를 넣는다. 
```swift
@objc func editbutton(_ sender: UIButton) {
  
  let nextVC = startViewController()
  nextVC.modalPresentationStyle = .automatic
  present(nextVC, animated: true) //아규먼트 nextVC를 넣어주고
}
```
nextVC에 startViewController()을 호출하고, 모달을 단다."nextVC.modalPresentationStyle = .automatic" 여기서 automatic은 기본값(present타입)이다. 만약 풀 스크린을 하고 싶다면 .찍고 fullScreen으로 하면된다. 아규먼트 지정까지하면, 버튼을 누를 때 두번째 화면으로 이동하는 것을 볼 수 있다. 

앞서 말했다시피, present타입으로 하면 화면을 내려서 껐을때, 텍스트필드에 적은 데이터가 전달이 안된다. 이를 용이하게 하기 위해, 그리고  present의 화면을 버튼을 이용해서 이전화면을 돌아가기 위해, 우리는 2-1에  [닫기], [저장] 을 만들었다 !! 좀더 완성도 높은 기능을 위해 
아래를 참고하자. 



3-2. [닫기] 버튼을 누르면 이전화면, [저장]버튼을 누르면 데이터 전달. 


닫기동작 코드는 아주쉽다. dismiss만 달아주면 된다.


```swift
@objc private func buttonOwn(_ sender: UIButton){ //닫기버튼
  dismiss(animated: true)
}
```


저장버튼도 누르면 화면이 꺼질 수 있다록 dismiss을 달아준다. 다만, [저장]은 데이터를 전달해야하기 때문에 아래와 같은 코드를 더 추가한다.

```swift
@objc func buttonTwo(_ sender: UIButton){ //저장버튼

  if let vc = self.presentingViewController as? endViewController {
    vc.namelabel.text = nameTextField.text
    vc.emaillabel.text = emailTextField.text
  }
  dismiss(animated: true)
  
}
```
presentingViewController을 이용해 endViewController을 타입캐스팅 한다. 그리고 버튼을 누르면 텍스트필드의 입력값이 vc(뷰컨)의 해당 Label로 이동되도록 한다. 

```
vc.namelabel.text = nameTextField.text
vc.emaillabel.text = emailTextField.text
```

그러면 textField에 값을 입력후 [저장]을 누르면, 아래와 같이 데이터가 전달되는 것을 볼 수 있다. 




![이미지](/image/Start-3.png)




## 4.데이터 영구적으로 남기기. 


조금 아쉬운건(?) 기껏 레이블을 바꾸어 놓고 정보변경하기 창으로 가면 다시 입력값이 초기화 되어 있다는 것이다. 보안이 중요한 로그인화면에서는 유용하지만, 개인정보창이나 프로필같은 화면에서는 사용자가 본인의 입력값을 확인할 수 있도록 입력한 데이터를 영구히 보여줘야하는 경우도 있다. 

보통 데이터라면 데이터를 수집하는 방식을 선택하겠지만, 굳이 수집이 필요하지 않은 데이터라면 사용자의 화면상으로만 영구적으로 저장될 수 있도록 구현해도 좋을 것이다. 

일단은 많은 방법이 있겠지만, 그중에서도 간단하게.. 입력값이 초기화 되지않고, 사용자가 수정하지 않는 이상 보존되어있는 방식으로 구현해보자.  

*(단, 앱을 종료하면 데이터는 다시 초기화 된다. )*



앱 종료시에도 저장되는 기능은 다음 포스팅인 'UserDefaults'에서 다루기로 하고 일단은 간단하게만 !!



4-1. [정보변경하기]를 눌러도 이전값이 보존되도록 구현


뷰디드로드에 아래와 같은 고정값을 넣는다. 
```swift
if let vc = self.presentingViewController as? endViewController {
     
     self.nameTextField.text = vc.namelabel.text
     self.emailTextField.text = vc.emaillabel.text
   }
   
```

방법은 3-2와 비슷하다. 3-2처럼 레이블에 정보를 전달한 것처럼, 받은 정보를 다시 텍스트 필드로 전달하는 방식을 택하면 된다. 약간 복붙 느낌으로...ㅋ...


그래서 , 뷰디드 로드에 동일하게 "if let vc = self.presentingViewController as? endViewController {"을 불러(연결해)주고, endViewController 의 Label text를 가져와서 해당 TextField에 넣어주면 된다. 


그러면 ??


[정보변경하기] 버튼을 누르면 이전에 입력된 값을 그대로 불러오는 모습을 볼 수 있다. 



![이미지](/image/Start-2.png)



👏🏻 👏🏻. 👏🏻 👏🏻 👏🏻 

잘하고 있는 건진 모르겠다만... ㅎ


수집해야할 데이터가 아니고 화면상으로만 간단하게 보여줄 용도라면 레이블을 복사해오는 방식을 택하는 것도 나쁘지 않다..
하지만 앱을 종료하면 사라지는 현실이...
이 부분은 나중에 UserDefaults에서 따로 다루기로 !! 

(링크는 현재 준비중..)




이것으로 또 하나 끝.... 🥒


