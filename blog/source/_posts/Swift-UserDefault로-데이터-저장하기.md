---
title: '[Swift]UserDefault로 데이터 저장하기'
date: 2020-05-13 17:31:10
category: "ios"
tags:
- UserDefault
- Swift
- 화면전환
- ImageView
- TextField
- TextFieldDelegate
thumbnail: /image/UserDefault-1.png
---


## UserDefault 이해하기 


쉽게 말하면, 앱상의 작은 저장공간이라고 생각하면 된다.
앱을 종료하여도, 사용자의 데이터가 다시 리셋되지 않도록 기억해주는 장치. 

예제로 쉽게 이해해보도록 하자!  



## UserDefault 활용하기


![이미지](/image/UserDefault-1.png)


### 구현 목표

```
1. 스위치를 On으로 하면 강아지사진, Off는 고양이사진. (Bool을 활용하면된다.)
2. 레이블도 스위치에 따라 함께 변경. "Dog" : "Cat"
3. 텍스트필드는 save버튼 누른 다음의 뷰화면(프로필 화면)에 name으로 변경될 것.
4. 사진(이미지),레이블(Dog/Cat),텍스트필드(data) 모두 마찬가지.
5. 변경내용을 모두 제자리로 돌리는 Setup버튼 구현. 
```


## 1. UI짜기, 구조설정

1-1. @IBOutlet 및 @IBAction 연결. 

```swift
@IBOutlet var animalPhoto: UIImageView! //imageSwich
@IBOutlet var animalLable: UILabel! //Dog
@IBOutlet var animalSwitch: UISwitch!  //스위치 아울렛
@IBOutlet var animalTextField: UITextField! //텍스트필드(name) 

//스위치 액션
 @IBAction func isSwitch(_ sender: UISwitch) {
 }
 
//저장버튼
  @IBAction func saveButton(_ button : UIButton) {
  
//셋업버튼
  @IBAction func setButton(_ button: UIButton) {
  }
  
```
IBOutlet과 IBAction을 구분하여 연결지어 준다. 

이때, Switch는 아울렛과 액션 모두 연결해야한다. (아울렛일때와 액션일때의 기능 분리.)


1-2. Key 값 설정.

```
struct Key {
  static let photo = "imageSwich"
  static let photoLable = "Dog"
  static let name = "name"
  static let isOn = "inOn"
}
```
데이터를 불러오기 쉽게 Key값으로 변수를 설정한다. 


## 2. UserDefault 선언과 Switch값 설정하기.

2-1. userDefaults를 상수로 지정. 

```
let userDefaults = UserDefaults.standard
```
userDefaults를 쓰기위해 UserDefaults.standard의 고정값이 필요하다. 자주 쓰기 위해 상수로 선언하여 활용한다. 

2-2. Switch 설정하기.

먼저, viewDidLoad에 스위치에 대한 상시값(isOn)을 넣는다. 

```swift
let isOn = userDefaults.bool(forKey: Key.photo)
configureData(isOn: isOn)
```

1) 스위치는 on/off 딱 두 타입 뿐이므로, true/false로 구분되기 때문에 userDefaults중에서도 Bool타입으로 지정한다. (userDefaults를 지정할때 해당하는 것에 맞는 타입으로 꼭 선택해야한다.)
2) forKey는 Key값을 활용하여 넣는다. 
3) 위의 configureData는 Switch가 on상태일 때의 값을 지정한 함수이름이다. (아래 코드 참고)

```swift
func configureData(isOn: Bool) {
let animal = isOn ? "dog" : "cat"
animalPhoto.image = UIImage(named: animal)
animalLable.text = animal 
}
```
4) 해당 스위치의 액션버튼에 userDefaults.set 적용하기

```swift
@IBAction func isSwitch(_ sender: UISwitch) {
   
   configureData(isOn: sender.isOn)
   userDefaults.set(sender.isOn, forKey: Key.photo)
 }
```
set은 저장할때 사용한다. 


## 3. UserDefault 적용.

3-1. 저장하기 버튼에 UserDefault 적용. 

```swift
@IBAction func saveButton(_ button : UIButton) {
    let animal = animalSwitch.isOn ? "dog" : "cat"
    
    let userDefaults = UserDefaults.standard
    //    userDefaults.set(animalLable.text, forKey: Key.photoLable) //아래의 photo와 중복되므로 생략해도됨. 
    userDefaults.set(animal, forKey: Key.photo)
    userDefaults.set(animalSwitch.isOn, forKey: Key.isOn)
    userDefaults.set(animalTextField.text, forKey: Key.name)
```

1) IBAtion타입을 Any?에서 button으로 바꿔준다. (_ button : UIButton) 
2) animalSwitch.isOn ? "dog" : "cat"을 적용할 수 있는 변수 animal 선언. (func configureData 에서 써준건 해당 함수에서만 쓸 수 있으니까.. 재선언)  
3) 값에 맞게 모두 set을 적용한다. 
이미지  = animal, (Key.photo) / 스위치 = animalSwitch.isOn(Key.isOn)/ 텍스트필드 = animalTextField.text(Key.name)


3-2.  셋업 버튼에 UserDefault 적용. 
 
 ```swift
 //셋업버튼
 @IBAction func setButton(_ button: UIButton) {
   
   let userDefaults = UserDefaults.standard
   
   let animal = animalSwitch.isOn ? "dog" : "cat"

   let isPhoto = userDefaults.bool(forKey: Key.photo)
   let isanimalSwitch = userDefaults.bool(forKey: Key.isOn)
   let isPhotoLable = userDefaults.bool(forKey: Key.photoLable)
   let isAnimalTextfield = (userDefaults.object(forKey: Key.name) as? Data) ?? Data()
   
   animalPhoto.image = UIImage(named: animal)
   animalSwitch.setOn(isanimalSwitch, animated: true)
   animalTextField.text = "\(Key.name)"

 }
 ```
 
 1) 셋업버튼에 대한 새로운 이름의 상수로 선언후 (Save한 값으로 되돌릴 수 있는 작업) 값 선언.
 2) 타입을 지정할 수 없는 경우 object 선언하여 타입캐스팅이용함. (아래 참고)
 
 ```
 let isAnimalTextfield = (userDefaults.object(forKey: Key.name) as? Data) ?? Data()
```

위를 늘려쓰면 아래와 같은 느낌. (예시임,,)

```swift
let ob = userDefaults.object(forKey: Key.today)
let tempDate = ob as? Date
let tempTodat = tempDate ?? Date()
```

3) 데이터에 해당하는 값 매칭. (고정값임((외우자))

 - image는 UIimage
 - Switch는 setOn
 - Textfield는 text
 - (해당없지만)Date는 setDate
 
 

 ![이미지](/image/UserDefault-2.png)
 
 그러면 일단 여기까지는 완성이 된다. 
 
 
 (이미지가 안뜬다면, Assets.xcassets에 image를 추가하였는지 확인!...  파일이름은 강아지: dog, 고양이: cat)
 
 
 
 Save도 정상적으로 되나 확인해볼까? 하는데, 키보드가 안내려가는 상황 발생! 
 
 ( cm + k 하면 내려가지만 언제나 앱이라는 가정하에 진행해야하니까...!!!)
 
 
 
 ## 4. Textfield Delegate
 
 
 이번에는 딜리게이트를 이용하여 키보드에 대한 설정을 바꿔보도록 한다. 
 
 딜리게이트는,
 
 '(너가 기본적으로 제공해주는 것보다)내가 알아서 설정해서 쓸게,,!' 라는 걸 선언하는 것이다. 
 
 4-1. Delegate 선언
 
 ```swift
 class animalDefaultViewController: UIViewController, UITextFieldDelegate {
 ```
 클래스에 UITextFieldDelegate를 추가한다. 
 
 
 4-2. 셀프 선언
 
 ```swift
 override func viewDidLoad() {
 super.viewDidLoad()
 
 animalTextField.delegate = self
```
딜리게이트 설정이 필요한 해당 텍스트필드(animalTextField)와 delegate를 불러와 self를 viewDidLoad에 선언한다. 
 
 
 4-2. return 시 키보드 닫음 설정. 
 
 ```swift

 //리턴시 키보드 닫음
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
   textField.resignFirstResponder()
   return true
 }
 
 ```
 크게 구현할 내용은 없고, 키보드에 [Return]을 누르게 되면 키보드가 닫힐 수 있도록 설정한다. 


그러면... 



![이미지](/image/UserDefault-3.png)


텍스트필드를 입력하고 리턴을 누르면 키보드가 내려간다 !!

이제 이것저것 설정하고 Save 버튼을 누르면? ...!

화면이 넘어가지 않는다... 

😸


## 5.화면전환


이미 스토리보드로 시작한거.. segue로 화면전환을 할까? 하다가 역시 깔끔한게 좋아서 코드로 화면전환을 해보자 !!

원래 코드로 시작하면, 끝까지 코드로만 하고,
스토리보드로 시작하면, 끝까지 스코리보드로만 하는 게 정석인 듯 싶지만... 

겸하는 것도 어찌됐든 가능하다. 

일단, Save버튼을 누른후 화면이 전환이 되는 구성이기 때문에 Save버튼으로 이동한다. 

5-1. 화면전환 메서드 

```swift

animalTextField.text ?? ""
let story = UIStoryboard(name: "Main", bundle: nil)
guard let vc = story.instantiateViewController(identifier:  "animalViewController") as? animalViewController else {return}

//값전달
vc.profileName = "\(animalTextField.text!)"
vc.animalName = "\(animalLable.text!)"
vc.profileImage = UIImage(named: animal)!

//화면전환 스타일  
vc.modalPresentationStyle = .fullScreen
present(vc, animated: true)
```

1) let story = UIStoryboard(name: "Main", bundle: nil) 스토리 보드를 가져온다. "Main"은 거의 고정값이므로 외운다.(맨앞에 M은 대문자 필수!)
2) vc에 스토리보드의 instantiateViewController을 불러온 후, identifier이름을 붙여넣는다. (identifier:  "animalViewController"). animalViewController은 두 번째 뷰컨 이름(목적지뷰)이다. 
3) as? animalViewController else {return} 역시 같은 이름으로 붙여넣는다. (identifier 이름은 보통 뷰컨트롤러의 이름과 동일하게 짓는다.)
4) vc.에 화면전환시 값이 전달될 곳으로 매칭한다. 두번째 뷰에는 이미지-이미지, 텍스트필드 - 레이블1, 레이블 - 레이블2 로 총 3가지만 받아오면 된다. (이미지의 경우 UIImage(named:  )!의 형식임을 외우자.)
5) vc.modalPresentationStyle = .fullScreen로 프리젠트 스타일을 설정하고, present(vc, animated: true)를 불러온다. (필수)


그러면 ? 

화면은 전환이 되나, 데이터가 이동되지 않은 모습을 볼 수 있다 

Why? 

전달된 값을 받는 작업을 수행하지 않았기 때문에... 


5-2. 값 받기

일단, 두 번째 뷰 컨트롤러(animalViewController)로 이동한다. 

이건 초간단하니 간단하게. 

1) 아울렛 연결 

```swift
@IBOutlet var profilePhoto: UIImageView!
@IBOutlet var profileLable: UILabel!
@IBOutlet var profileNameLable: UILabel!
```

2) 변수 만들기 

```swift
var profileName = ""
  var animalName = ""
  var profileImage = UIImage()
```

3) viewDidLoad에 값 설정. 

```swift
profileNameLable.text = profileName
   profileLable.text = animalName
   profilePhoto.image = profileImage
```
두번째 화면으로 넘어갔을 때 바로 값을 불러와야하기때문에 viewDidLoad에 값을 설정한다.   
이 부분은. 5-1 의 4)부분을 참고하여 매칭하면 된다. 


그러고 빌드를 하면? 


![이미지](/image/UserDefault-4.png)


이런 식으로 모두 값을 받아오는 모습을 볼 수 있다.

사진 아래에 [<<정보변경하기]라는 버튼을 달아줬다. 이전화면으로 돌아가는 게 없어서 불편해서.. 


4) 화면 닫힘. (이전 화면으로) 

```swift
@IBAction func editButton(_ sender: Any) {
  
  dismiss(animated: true) {
  }
}

```
@IBAction 으로 이은후 dismiss만 해주면 끝. 




끝 !! 


앱을 종료하여도, 가장 마지막으로 값으로 Save한 시점에 계속 저장되어있는 모습을 볼 수 있다. 

그리고 setUp버튼은 Save한 값과 다르게 설정하다가 setUp을 누르면 Save한 값으로 돌아가는 용도이다. 

직접해서 확인해보면 될 듯.. ㅎㅎ 

이것으로 마무리 한다! 


👐🏻 👾 👐🏻


### [전체코드 ]

전체 코드를 보며 흐름을 참고하자! 

- 첫번 째 뷰컨(animalDefaultViewController)


```swift
import UIKit

class animalDefaultViewController: UIViewController, UITextFieldDelegate {
  
  
  struct Key {
    static let photo = "imageSwich"
    static let photoLable = "Dog"
    static let name = "name"
    static let isOn = "inOn"
  }
  
  @IBOutlet var animalPhoto: UIImageView! //imageSwich
  @IBOutlet var animalLable: UILabel! //Dog
  @IBOutlet var animalSwitch: UISwitch!  //스위치 아울렛
  @IBOutlet var animalTextField: UITextField!
  
  
  let userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animalTextField.delegate = self
    
    let isOn = userDefaults.bool(forKey: Key.photo)
    configureData(isOn: isOn)

  }
  
  
  @IBAction func isSwitch(_ sender: UISwitch) {
    
    let userDefaults = UserDefaults.standard
    configureData(isOn: sender.isOn)
    userDefaults.set(sender.isOn, forKey: Key.photo)
    
  }
  
  func configureData(isOn: Bool) {
    let animal = isOn ? "dog" : "cat"
    animalPhoto.image = UIImage(named: animal)
    animalLable.text = animal
  }
  
  //저장버튼
  @IBAction func saveButton(_ button : UIButton) {
    let animal = animalSwitch.isOn ? "dog" : "cat"
    
    let userDefaults = UserDefaults.standard
//    userDefaults.set(animalLable.text, forKey: Key.photoLable)
    userDefaults.set(animal, forKey: Key.photo)
    userDefaults.set(animalSwitch.isOn, forKey: Key.isOn)
    userDefaults.set(animalTextField.text, forKey: Key.name)
 
    animalTextField.text ?? ""
    let story = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = story.instantiateViewController(identifier:  "animalViewController") as? animalViewController else {return}
    
    vc.profileName = "\(animalTextField.text!)"
    vc.animalName = "\(animalLable.text!)"
    vc.profileImage = UIImage(named: animal)!

      
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }
  
  //리턴시 키보드 닫음
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  //셋업버튼
  @IBAction func setButton(_ button: UIButton) {
    
    let userDefaults = UserDefaults.standard
    
    let animal = animalSwitch.isOn ? "dog" : "cat"

    let isPhoto = userDefaults.bool(forKey: Key.photo)
    let isanimalSwitch = userDefaults.bool(forKey: Key.isOn)
    let isPhotoLable = userDefaults.bool(forKey: Key.photoLable)
    let isAnimalTextfield = (userDefaults.object(forKey: Key.name) as? Data) ?? Data()
    
    animalPhoto.image = UIImage(named: animal)
    animalSwitch.setOn(isanimalSwitch, animated: true)
    animalTextField.text = "\(Key.name)"

  }

  
}

```

- 두 번째 뷰컨(animalViewController)

```swift
import UIKit

class animalViewController: UIViewController {

  
   var profileName = ""
   var animalName = ""
   var profileImage = UIImage()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

    profileNameLable.text = profileName
    profileLable.text = animalName
    profilePhoto.image = profileImage
      
      
    }
    
  
  @IBOutlet var profilePhoto: UIImageView!
  @IBOutlet var profileLable: UILabel!
  @IBOutlet var profileNameLable: UILabel!


  @IBAction func editButton(_ sender: Any) {
    
    dismiss(animated: true) {
    }
  }

  
}

```



