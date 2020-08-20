---
title: '[Swift]주문화면 구현하기-feedback'
date: 2020-05-05 23:26:27
category: "ios"
tags:
- Swift
- feedback
- 개발일기
thumbnail: /image/firstmaincode.png
---

# 간단한 주문화면 구현하기


fastcampus에서 첫 테스트를 봤다. 시험은 전반적으로 배운 내용이었기 때문에 크게 어렵지 않았지만, 실수한 부분도 많았고, 시간부족으로 미완성한 기능도 있었다. 끝나고는 다른 사람코드로 지혜(?)도 얻고, 강사님 코드를 보고 또 반성하게 되는.. 그런 계기도 됐다. 그래서 다시 피드백 및 복습겸 올려본다. 일단 테스트 내용은 아래와 같다.

![test](/image/firstTest.png)

## [구현사항]
```
* 주문 버튼 터치 시 각 아이템에 대한 수량 증가
* 각 아이템별 주문 수량 증가에 따른 결제금액 증가
* 결제 진행 시 소지금액에서 결제금액만큼 차감 및 주문수량 초기화
* 소지금액이 결제금액보다 적은 경우 결제 불가 메시지 Alert 띄우기
* 초기화 버튼은 주문수량, 결제금액, 소지금액을 모두 초기화
* 초기화 버튼 이외에 한 번 올린 주문수량을 내리는 기능은 없음
```


## [실행예시] 

1. 짜장면 주문 버튼 클릭
- 짜장면 수량 : 1 증가
- 결제금액 : 5000원

2. 탕수육 주문 버튼 클릭
- 탕수육 수량 : 1 증가
- 결제금액 : 17000원 (5000 + 12000원)

3. 결제 버튼 클릭
- 취소, 확인 버튼을 가진 AlertController 띄우기 (메시지 - 총 결제금액은 17000원입니다.)
- 확인 버튼 클릭 시 70,000원에서 17,000원 차감해 소지금액을 53,000원으로 변경하고
각 메뉴아이템 주문 수량과 결제금액을 0으로 초기화
- 결제액이 소지금을 초과할 경우, 자동으로 결제를 취소하고
Alert을 이용해 "소지금이 부족합니다" 오류메시지 띄우기

4. 초기화 버튼 클릭
- 각 아이템 수량 및 결제금액 0원으로 초기화, 소지금 70,000원으로 초기화


## [나의 첫번째 code.레포트]


```swift

import UIKit

class ViewController: UIViewController {
  
  
  var countIndex1: Int = 0 //수량1
  var countIndex2: Int = 0 //수량2
  var countIndex3: Int = 0 //수량3

  var countCost: Int = 0
  
  var 소지금 : Int = 70000
  var Backup: Int = 0 //초기화
  var count: Int = 0 //결제금액
  
  
  let buycostLable = UILabel()
  let sojecostLable = UILabel()
  
  
  
  @IBOutlet var MenuLable: UILabel!
  @IBOutlet var costLable: UILabel!
  @IBOutlet var aeLable: UILabel!
  
  
  @IBOutlet var jangLable: UILabel!
  @IBOutlet var jangcostLable: UILabel!
  @IBOutlet var jangsLable: UILabel!
  
  
  @IBOutlet var bongLable: UILabel!
  @IBOutlet var bongcostLable: UILabel!
  @IBOutlet var bongsLable: UILabel!
  
  
  @IBOutlet var tangLable: UILabel!
  @IBOutlet var tangcostLable: UILabel!
  @IBOutlet var tangsLable: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //view.frame.width
    
    let sojeLable = UILabel()
    
    sojeLable.frame = CGRect(x: 30, y: 300, width: 70, height: 30)
    sojeLable.backgroundColor = .green
    sojeLable.textAlignment = .center
    sojeLable.text = "소지금"
    sojeLable.textColor = .black
    sojeLable.font = UIFont.systemFont(ofSize: 17)
    view.addSubview(sojeLable)
    
    
    sojecostLable.frame = CGRect(x: 120, y: 300, width: 120, height: 30)
    sojecostLable.backgroundColor = .green
    sojecostLable.textAlignment = .right
    sojecostLable.text = "\(소지금)원"
    sojecostLable.textColor = .black
    sojecostLable.font = UIFont.systemFont(ofSize: 17)
    view.addSubview(sojecostLable)
    
    
    let buyLable = UILabel()
    
    buyLable.frame = CGRect(x: 30, y: 350, width: 70, height: 30)
    buyLable.backgroundColor = .orange
    buyLable.textAlignment = .center
    buyLable.text = "결제금액"
    buyLable.textColor = .black
    buyLable.font = UIFont.systemFont(ofSize: 17)
    view.addSubview(buyLable)
    
    
    buycostLable.frame = CGRect(x: 120, y: 350, width: 120, height: 30)
    buycostLable.backgroundColor = .orange
    buycostLable.textAlignment = .right
    buycostLable.text = "\(count)원"
    buycostLable.textColor = .black
    buycostLable.font = UIFont.systemFont(ofSize: 17)
    view.addSubview(buycostLable)
    
    
    let setBottun = UIButton()
    setBottun.frame = CGRect(x: 280, y: 300, width: 70, height: 30)
    setBottun.setTitle("초기화", for: .normal)
    setBottun.setTitleColor(.orange, for: .normal)
    setBottun.backgroundColor = .black
    view.addSubview(setBottun)
    
    
    setBottun.addTarget(self, action: #selector(buttonOne(_:)), for: .touchUpInside)
    //   setBottun.addTarget(self, action: #selector(buttonOne(_:)), for: .touchUpInside)
    
    
    let buyBottun = UIButton()
    buyBottun.frame = CGRect(x: 280, y: 350, width: 70, height: 30)
    buyBottun.setTitle("결제하기", for: .normal)
    buyBottun.setTitleColor(.orange, for: .normal)
    buyBottun.backgroundColor = .black
    view.addSubview(buyBottun)
    
    buyBottun.addTarget(self, action: #selector(buttonTwo(_:)), for: .touchUpInside)
  }
  
  //초기화
  @objc func buttonOne(_ sender: UIButton) {
    
    self.소지금 = 70000
    self.count = 0
    self.sojecostLable.text = "\(소지금)원"
    
    initCost()
  }
  
  private func initCost() {
    //짜장 짬뽕 탕수육 갯수 초기화
    self.countIndex1 = 0
    self.countIndex2 = 0
    self.countIndex3 = 0
    
    // 모두 더한 값도 초기화
    self.countCost = 0
    
    self.buycostLable.text = "0"
    self.jangsLable.text = "0"
    self.bongsLable.text = "0"
    self.tangsLable.text = "0"
  }
  
  //결제하기 알렛
  @objc func buttonTwo(_ sender: UIButton) {
    
    if 소지금 < countCost {
      
      let alertController = UIAlertController(title: "알림",message: "소지금액이 부족합니다", preferredStyle: .alert)
      
      
      let alert3Action = UIAlertAction(title: "확인", style: .cancel) { _ in
      }
      
      alertController.addAction(alert3Action)
      present(alertController, animated: true)
    } else {
      
      let alertController = UIAlertController(title: "알림",message: "결제금액은 모두\(buycostLable.text!)원 입니다.", preferredStyle: .alert)
      
      
      let alert1Action = UIAlertAction(title: "취소", style: .cancel) { _ in
        
      }
      let alert2Action = UIAlertAction(title: "확인", style: .destructive) { _ in
        self.소지금 = self.소지금 - self.countCost
        self.sojecostLable.text = "\(self.소지금)원"
        
        self.initCost()
      }
      
      alertController.addAction(alert1Action)
      alertController.addAction(alert2Action)
      
      present(alertController, animated: true)
    }
  }
  
  //주문1
  @IBAction func oder1Button(_ sender: Any) {
    
    countIndex1 += 1
    jangsLable?.text = "\(countIndex1)"
    
    countCost += 5000
    buycostLable.text = "\(countCost)원"
    
  }
  //주문2
  @IBAction func oder2button(_ sender: Any) {
    countIndex2 += 1
    bongsLable?.text = "\(countIndex2)"
    
    countCost += 6000
    buycostLable.text = "\(countCost)원"
    
  }
  //주문3
  @IBAction func oder3button(_ sender: Any) {
    countIndex3 += 1
    tangsLable?.text = "\(countIndex3)"
    
    countCost += 12000
    buycostLable.text = "\(countCost)원"
    
  }
  
}

```


## 첫 번째 방식(기존) 대한 특징.

1. 나는 변수(전달할 값)를 먼저 설정한다. 

```swift
var countIndex1: Int = 0 //수량1
  var countIndex2: Int = 0 //수량2
  var countIndex3: Int = 0 //수량3

  var countCost: Int = 0
  
  var 소지금 : Int = 70000
  var Backup: Int = 0 //초기화
  var count: Int = 0 //결제금액
 ```
이런식으로 초기값을 지정하거나 타입을 지정한다. 옵셔널일 경우도 생각해서 함수에 넣는 것보다 여기에 보통 ?을 넣는다.


2. 모든(?) 아울렛을 다 연결한다. ㅋㅋㅋ

```swift
@IBOutlet var MenuLable: UILabel!
  @IBOutlet var costLable: UILabel!
  @IBOutlet var aeLable: UILabel!
  
  
  @IBOutlet var jangLable: UILabel!
  @IBOutlet var jangcostLable: UILabel!
  @IBOutlet var jangsLable: UILabel!
  
  
  @IBOutlet var bongLable: UILabel!
  @IBOutlet var bongcostLable: UILabel!
  @IBOutlet var bongsLable: UILabel!
  
  
  @IBOutlet var tangLable: UILabel!
  @IBOutlet var tangcostLable: UILabel!
  @IBOutlet var tangsLable: UILabel!
  ```

솔직히 조금 혼란스러웠다. 스토리 보드로 짤때 레이블이나 뭐 화면에 얹는 것은 다 연결해야하는 건줄 알고 이제껏 다 연결해왔었는데.. 나중에 복습하면서 굳이? 아울렛연결하지 않아도 시뮬에서 보이는 것이다.. 필요한것만 연결해도 되는 거였나,,,, 
 (그래서 이것도 정리좀 하려고 가장 무관해보이는 아울렛을 몇개 지우고 로직도 깨끗하게하고 시뮬켜봤는데 ..이상하게도 또 백지화면이여서… 당황하면서 control+z…로 다시 무마했다.)

왜 이러는지 모르겠다.. 어쨌든 이후코드에는 다 연결하지 않았는데도 화면에 다 보였다..  


3. 결제금액 레이블에 들어가는 숫자들을 ‘countCost’라는 함수안에 다 넣었다. 

```swift
//주문1
  @IBAction func oder1Button(_ sender: Any) {
    
    countIndex1 += 1
    jangsLable?.text = "\(countIndex1)"
    
    countCost += 5000
    buycostLable.text = "\(countCost)원"
    
  }
  //주문2
  @IBAction func oder2button(_ sender: Any) {
    countIndex2 += 1
    bongsLable?.text = "\(countIndex2)"
    
    countCost += 6000
    buycostLable.text = "\(countCost)원"
    
  }
  //주문3
  @IBAction func oder3button(_ sender: Any) {
    countIndex3 += 1
    tangsLable?.text = "\(countIndex3)"
    
    countCost += 12000
    buycostLable.text = "\(countCost)원"
    
  }
  ```
버튼 함수에 일일히 수량과 가격에 대한 계산을 해놓았다. 이 결과값을 ‘countCost’라는 변수에 모두 담는 방식이다.


### coment..

솔직히 코드에 맞다, 틀리다를 강요할 수는 없는 부분이다. 하지만 기존의 방식에서 벗어나 좀 더 함수를 활용해볼 수 없을까? 의문이 들기는 했다.. 
그래서 아래의 코드로 함수를 추가해 보았다. 



## [나의 두 번째 code.레포트]

```swift
import UIKit

class addViewController: UIViewController {
  
  
  struct UI {
    static let containerHeight: CGFloat = 40
    static let displayLabelWidth: CGFloat = 140
    static let labelWidth: CGFloat = 80
  }
  
  @IBOutlet var jangCountLabel: UILabel!
  @IBOutlet var bongCountLabel: UILabel!
  @IBOutlet var tangCountLabel: UILabel!
  
  
  //짜장,짬뽕,탕수육 가격
  let jangCost = 5000
  let bongCost = 6000
  let tangCost = 12000
  
  
  //각 수량 변수 didset으로 담기
  var jangCount: Int = 0{
    didSet {
      jangCountLabel.text = "\(jangCount)"
      
      buyPay = calcPrice() //결제금액 = 현재 결제금액을 계산하는 메소드()
    }
  }
  var bongCount: Int = 0 {
    didSet {
      bongCountLabel.text = "\(bongCount)"
     buyPay = calcPrice()
    }
  }
  
  var tangCount: Int = 0 {
    didSet {
      tangCountLabel.text = "\(tangCount)"
       buyPay = calcPrice()
    }
  }
  
  //현재 결제금액을 계산하는 메소드
  func calcPrice() -> Int {
    return (jangCount * jangCost) + (bongCount * bongCost) + (tangCount * tangCost)
    
  }
  
  //소지금액 변수
  var sojiPay: Int = 70000 {
    didSet {
      sojiCost.text = "\(sojiPay)원"
    }
  }
  

  //결제금액 변수
    var buyPay: Int = 0 {
  didSet {
    buyCost.text = "\(buyPay)원"
    
    }
  }
  
  let sojiCost = UILabel()
  var buyCost = UILabel()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //소지금 Label
    let sojiLabel = UILabel()
    sojiLabel.frame = CGRect(x: 30 , y: 330, width: UI.labelWidth, height: UI.containerHeight)
    sojiLabel.textAlignment = .center
    sojiLabel.backgroundColor = .green
    sojiLabel.textColor = .black
    sojiLabel.text = "소지금"
    view.addSubview(sojiLabel)
    
   
    sojiCost.frame = CGRect(x: 120 , y: 330, width: UI.labelWidth+54, height: UI.containerHeight)
    sojiCost.textAlignment = .right
    sojiCost.backgroundColor = .green
    sojiCost.textColor = .black
    sojiCost.text = "70000원"
    view.addSubview(sojiCost)
    
    
    //결제금액 Lable
    let buyLabel = UILabel()
    buyLabel.frame = CGRect(x: 30 , y: 370, width: UI.labelWidth, height: UI.containerHeight)
    buyLabel.textAlignment = .center
    buyLabel.backgroundColor = .orange
    buyLabel.textColor = .black
    buyLabel.text = "결제금액"
    view.addSubview(buyLabel)
    

    buyCost.frame = CGRect(x: 120, y: 370, width: UI.labelWidth+54, height: UI.containerHeight)
    buyCost.textAlignment = .right
    buyCost.backgroundColor = .orange
    buyCost.textColor = .black
    buyCost.text = "0원"
    view.addSubview(buyCost)
    
    
    //초기화버튼
    let setupButton = UIButton()
    setupButton.frame = CGRect(x: 265, y: 330, width: UI.labelWidth, height: UI.containerHeight)
    setupButton.backgroundColor = .black
    setupButton.setTitleColor(.orange, for: .normal)
    setupButton.setTitle("초기화", for: .normal)
    view.addSubview(setupButton)
    
    setupButton.addTarget(self, action: #selector(setupButtonClicked), for: .touchUpInside)
    
    
    //결제하기 버튼
    let buyButton = UIButton()
    buyButton.frame = CGRect(x: 265, y: 370, width: UI.labelWidth, height: UI.containerHeight)
    buyButton.backgroundColor = .black
    buyButton.setTitle("결제하기", for: .normal)
    buyButton.setTitleColor(.orange, for: .normal)
    view.addSubview(buyButton)
    
    buyButton.addTarget(self, action: #selector(buyButtonClicked), for: .touchUpInside)
    
    
  }
  
  //초기화버튼
  @objc func setupButtonClicked(_ sender: UIButton) {
    
    jangCount = 0
    bongCount = 0
    tangCount = 0
    buyPay = 0
    sojiPay = 70000
    
  }
  
  //결제하기 버튼
  @objc func buyButtonClicked(_ sender: UIButton) {
    
    if sojiPay <= buyPay {
        
        let alertController = UIAlertController(title: "알림",message: "소지금액이 부족합니다", preferredStyle: .alert)
        
        let alert3Action = UIAlertAction(title: "확인", style: .cancel) { _ in
        }
        
        alertController.addAction(alert3Action)
        present(alertController, animated: true)
    
      } else {
           let alertController = UIAlertController(title: "알림",message: "결제금액은 모두\(buyPay)원 입니다.", preferredStyle: .alert)
           
           let alert1Action = UIAlertAction(title: "취소", style: .cancel) { _ in
             
           }
           //소지금 - 결제금액 계산
           let alert2Action = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.sojiPay = self.sojiPay - self.buyPay
            self.sojiCost.text! = "\(self.sojiPay)원"
             
           }
           
           alertController.addAction(alert1Action)
           alertController.addAction(alert2Action)
           
           present(alertController, animated: true)
         }
         
  }
  
  
  //주문 버튼 3개
  @IBAction func jangOder(_ sender: Any) {
    jangCount += 1
  }
  @IBAction func bongOder(_ sender: Any) {
    bongCount += 1
  }
  @IBAction func tangOder(_ sender: Any) {
    tangCount += 1
  }
  
}
```


### 두 번째 방식에 대한 특징

1.구조체의 활용 

```swift
struct UI {
    static let containerHeight: CGFloat = 40
    static let displayLabelWidth: CGFloat = 140
    static let labelWidth: CGFloat = 80
```
struct를 이용하여 frame을 짜는데에 번거로움을 줄였다. 사실 버튼 디자인이 각각 다르기보다 깔끔한 UI를 위해 통일하는 경우가 많기 때문에 반복될만한 frame값이 있다면 UI를 미리 통일시키는 것도 나쁘지 않다. 

```swift
let sojiLabel = UILabel()
    sojiLabel.frame = CGRect(x: 30 , y: 330, width: UI.labelWidth, height: UI.containerHeight)
```
이런식으로, 코드 하나하나에 frame값을 넣어줬고, 변경할때는 다같이 또 일일히 건드려야했던 것을 UI를 통해, UI.labelWidth 이나 UI.containerHeight의 값을 복사하여 불러오면 코드를 좀더 간편하게 쓸 수 있었다.




2.didset의 활용 

didset은 값이 바뀔때 한번 실행해주는 역할을 한다. 그래서 값이 바뀔만한 것들은 모두 이런식으로 짜준다. 

```swift
//각 수량 변수 didset으로 담기
  var jangCount: Int = 0{
    didSet {
      jangCountLabel.text = "\(jangCount)"
      
      buyPay = calcPrice() //결제금액 = 현재 결제금액을 계산하는 메소드()
    }
  }
  var bongCount: Int = 0 {
    didSet {
      bongCountLabel.text = "\(bongCount)"
     buyPay = calcPrice()
    }
  }
  
  var tangCount: Int = 0 {
    didSet {
      tangCountLabel.text = "\(tangCount)"
       buyPay = calcPrice()
    }
  }
```
```swift
//소지금액 변수
  var sojiPay: Int = 70000 {
    didSet {
      sojiCost.text = "\(sojiPay)원"
    }
  }
  

  //결제금액 변수
    var buyPay: Int = 0 {
  didSet {
    buyCost.text = "\(buyPay)원"
    
    }
  }
```

첫번째 방식에서는 버튼 함수에 계산금액 값을 지정하고 수량에 따라 +(더하기)가 되서 countCost에 값을 모두 넣는 방식이고), 두번째 방식은 변수에 didset으로 계산식을 놓아 그때그때 실행한다. 1.text에 대한 변수지정, 2. 결제금액과 계산값에 대한 변수호출. 
참고로 buyPay = calcPrice()는 아래의 계산식은 아래와 같다. 
```swift
//현재 결제금액을 계산하는 메소드
  func calcPrice() -> Int {
    return (jangCount * jangCost) + (bongCount * bongCost) + (tangCount * tangCost)
    
  }
```

두번째가 훨씬 친절한 느낌이 드는 것 같기도하다. 애초에 didset으로 놓으니, 예상치못하게 기능을 바꾸어야하는 순간이 올때, 첫번째처럼 했더라면 해당 함수를 찾아 긴긴 코드를 읽어야 했겠지만.. 두번째는 일일히 찾지 않고 didset을 보면 확실히 알기 때문이다. 장기적으로 좋은 것 같다. 역시 공유하려면 '나만아는 코드’(여기서 벗어나야 한다..ㅜㅜ)보단 지도가 될 수 있는'객관적인 코드’가 중요하니까.

   
3. viewDidLoad 간소화

사실 다루고 싶은 부분이었는데, 하지를 못했다,, ~~방법은 아는데..~~아무래도 다음 포스트에서 해야할 듯하다.. 



### coment..

요즘 수업을 듣고, 공부하면서 가장 힘든 부분은 독학해왔던 기존방식을 버리고 새로운 방식을 습득해야하는 것에 있다. 강사님의 코드는 어렵고. 옆친구는 어쩐지 나와 다른방식으로 풀고 있고, 나는 어쩐지 너무 단순하게 코드를 짜는 것 같아. 스트레스가 좀 쌓인다. 이 부분에 대해서 억울한 면이 있지만, 이게 아마추어와 프로의 차이라고 말한다면 할말은 없어진다. 프로의 길을 가기위해 기존의 방식을 내려 놓아야한다면 놓아야지. 그것은 변함없는 사실일 테니까.. 

아래에는 강사님 코드를 붙여놓았다. 어렵지만, 코드를 보았을 때, 참 합리적이라는 생각이 들었다. 아직은 공부하는 단계니까 문법에 좀 더 익숙해지면, 나도 합리적으로 코드를 짤 수 있겠지… 강사님의 코드가 눈에 익숙해지도록 복습 또, 복습하고 더욱 노력해야겠다.. 


 
## 답지code.(강사님 코드)

```swift
import UIKit


final class ViewController: UIViewController {
  
  struct UI {
    static let containerHeight: CGFloat = 40
    static let displayLabelWidth: CGFloat = 140
    static let labelWidth: CGFloat = 80
  }
  
  // MARK: IBOutlets
  
  @IBOutlet weak var 짜장면amountLabel: UILabel!
  @IBOutlet weak var 짬뽕amountLabel: UILabel!
  @IBOutlet weak var 탕수육amountLabel: UILabel!
  
  // MARK: Properties
  
  enum MenuItem: Int {
    case 짜장면, 짬뽕, 탕수육
  }
  var 주문수량dict: [MenuItem: Int] = [
    MenuItem.짜장면: 0,
    MenuItem.짬뽕: 0,
    MenuItem.탕수육: 0
  ]
  let menuItemCostArr = [5_000, 6_000, 12_000]
  
  let 소지금displayLabel = UILabel()
  var 소지금 = 70_000 {
    didSet { 소지금displayLabel.text = "\(소지금)원" }
  }
  
  let 결제금액displayLabel = UILabel()
  var 결제금액 = 0 {
    didSet { 결제금액displayLabel.text = "\(결제금액)원" }
  }
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAdditionalViews()
    initializeData()
  }
  
  
  // MARK: Setup Views
  
  func setupAdditionalViews() {
    setup소지금views()
    setup결제금액views()
  }
  
  func setup소지금views() {
    
    // 컨테이너
    let 소지금containerView = UIView()
    소지금containerView.frame = CGRect(
      x: 20, y: 350, width: view.frame.width - 40, height: UI.containerHeight
    )
    view.addSubview(소지금containerView)
    
    
    // 콘텐츠
    let 소지금label = UILabel()
    소지금label.frame = CGRect(
      x: 0, y: 0, width: UI.labelWidth, height: UI.containerHeight
    )
    소지금label.text = "소지금"
    소지금label.textAlignment = .center
    소지금label.backgroundColor = .green
    소지금label.font = UIFont.preferredFont(forTextStyle: .title3)
    소지금containerView.addSubview(소지금label)
    
    소지금displayLabel.frame = CGRect(
      x: 소지금label.frame.maxX + 10, y: 0,
      width: UI.displayLabelWidth, height: UI.containerHeight
    )
    소지금displayLabel.backgroundColor = .green
    소지금displayLabel.textAlignment = .right
    소지금displayLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    소지금containerView.addSubview(소지금displayLabel)
    
    let 초기화button = UIButton()
    초기화button.frame = CGRect(
      x: 소지금displayLabel.frame.maxX + 20, y: 0,
      width: UI.labelWidth, height: UI.containerHeight
    )
    초기화button.backgroundColor = .black
    초기화button.setTitle("초기화", for: .normal)
    초기화button.setTitleColor(.white, for: .normal)
    초기화button.addTarget(self, action: #selector(initializeData), for: .touchUpInside)
    소지금containerView.addSubview(초기화button)
  }
  
  
  func setup결제금액views() {
    let 소지금maxYOffset = 소지금displayLabel.superview!.frame.maxY
    
    // 컨테이너
    
    let 결제금액containerView = UIView()
    결제금액containerView.frame = CGRect(
      x: 20, y: 소지금maxYOffset + 10,
      width: view.frame.width - 40, height: UI.containerHeight
    )
    view.addSubview(결제금액containerView)
    
    // 콘텐츠
    
    let 결제금액label = UILabel()
    결제금액label.frame = CGRect(
      x: 0, y: 0, width: UI.labelWidth, height: UI.containerHeight
    )
    결제금액label.text = "결제금액"
    결제금액label.textAlignment = .center
    결제금액label.backgroundColor = .orange
    결제금액label.font = UIFont.preferredFont(forTextStyle: .title3)
    결제금액containerView.addSubview(결제금액label)
    
    결제금액displayLabel.frame = CGRect(
      x: 결제금액label.frame.maxX + 10, y: 0,
      width: UI.displayLabelWidth, height: UI.containerHeight
    )
    결제금액displayLabel.textAlignment = .right
    결제금액displayLabel.backgroundColor = .orange
    결제금액displayLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    결제금액containerView.addSubview(결제금액displayLabel)
    
    let 결제button = UIButton()
    결제button.frame = CGRect(
      x: 결제금액displayLabel.frame.maxX + 20, y: 0,
      width: UI.labelWidth, height: UI.containerHeight
    )
    결제button.backgroundColor = .black
    결제button.setTitle("결제", for: .normal)
    결제button.setTitleColor(.white, for: .normal)
    결제button.addTarget(self, action: #selector(didTapPaymentButton(_:)), for: .touchUpInside)
    결제금액containerView.addSubview(결제button)
  }
  
  
  
  // MARK: - Action
  
  // 주문
  @IBAction func didTapOrderButton(_ sender: UIButton) {
    guard let item = MenuItem(rawValue: sender.tag),
      let amount = 주문수량dict[item]
      else { return }
    결제금액 += menuItemCostArr[sender.tag]
    주문수량dict[item] = amount + 1
    
    let labels = [짜장면amountLabel, 짬뽕amountLabel, 탕수육amountLabel]
    labels[sender.tag]?.text = "\(amount + 1)"
  }
  
  
  // 결제
  @objc func didTapPaymentButton(_ sender: UIButton) {
    if 소지금 >= 결제금액 {
      showAlert(
        title: "결제하기",
        message: "총 결제금액은 \(결제금액)원입니다.",
        actions: [
          UIAlertAction(title: "확인", style: .default) { _ in
            let temp = self.소지금 - self.결제금액
            self.initializeData()
            self.소지금 = temp
          },
          UIAlertAction(title: "취소", style: .cancel)
        ]
      )
    } else {
      showAlert(
        title: "소지금이 부족합니다",
        actions: [UIAlertAction(title: "확인", style: .default)]
      )
    }
  }
  
  // Alert
  func showAlert(title: String, message: String? = nil, actions: [UIAlertAction]) {
    let alertController = UIAlertController(
      title: title, message: message, preferredStyle: .alert
    )
    for action in actions {
      alertController.addAction(action)
    }
    present(alertController, animated: true)
  }
  
  
  // 초기화
  @objc func initializeData() {
    소지금 = 70_000
    결제금액 = 0
    짜장면amountLabel.text = "0"
    짬뽕amountLabel.text = "0"
    탕수육amountLabel.text = "0"
    for key in 주문수량dict.keys {
      주문수량dict[key] = 0
    }
  }
}

```

