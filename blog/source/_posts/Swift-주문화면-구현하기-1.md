---
title: '[Swift]주문화면 구현하기 -1'
date: 2020-05-06 13:39:41
category: "ios"
tags:
- Swift
- frame
- Lable
- Button
- 화면전환
thumbnail: /image/firstTest.png
---

# 주문화면 구현하기 -1


첫번째 테스트로 보았던 주문화면 구현과정을 써보고자 한다. (스토리보드 영역은 제외, )

![이미지](/image/firstTest.png)


구현사항은 아래와 같다. 

### 구현사항
```
주문 버튼 터치 시 각 아이템에 대한 수량 증가
각 아이템별 주문 수량 증가에 따른 결제금액 증가
결제 진행 시 소지금액에서 결제금액만큼 차감 및 주문수량 초기화
소지금액이 결제금액보다 적은 경우 결제 불가 메시지 Alert 띄우기
초기화 버튼은 주문수량, 결제금액, 소지금액을 모두 초기화
초기화 버튼 이외에 한 번 올린 주문수량을 내리는 기능은 없음
```
## 0. frame짜기 

구현하기 이전에 먼저 code로 프레임을 짜는 영역이 있어 프레임부터 만든다. 

0-1. 레이블 프레임을 view에 만들기
```
//소지금 Label
 let sojiLabel = UILabel()
 sojiLabel.frame = CGRect(x: 30 , y: 330, width: UI.labelWidth, height: UI.containerHeight)
 sojiLabel.textAlignment = .center
 sojiLabel.backgroundColor = .green
 sojiLabel.textColor = .black
 sojiLabel.text = "소지금"
 view.addSubview(sojiLabel)
 
 
 let sojiCost = UILabel()
 sojiCost.frame = CGRect(x: 120 , y: 330, width: UI.labelWidth+54, height: UI.containerHeight)
 sojiCost.textAlignment = .right
 sojiCost.backgroundColor = .green
 sojiCost.textColor = .black
 sojiCost.text = "70000원"
 view.addSubview(sojiCost)
```
"sojiLabel.frame"의 width: UI.labelWidth 부분은 구조체를 따로 만들어 해당값을 복사하는 방식으로 만들었다. 

```swift
struct UI {
  static let containerHeight: CGFloat = 40
  static let displayLabelWidth: CGFloat = 140
  static let labelWidth: CGFloat = 80
}
```
0-2. 위와 동일한 방법으로 버튼도 만든다. 

```swift
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
```
다른 점이 있다면, 레이블은 addTaget이 필요없지만, Button은 필요하다(textField도 동일). Lable은 타겟해서 딱히 할게 없기 때문이다.. 버튼 타입은 .touchUpInside로 해준다. (버튼을 눌렀을때 동작) 


![이미지](/image/first-1.png)

그럼 이정도는 나온다. 



## 1. 변수만들기 

1-1. 변수가 필요한 Label은 아웃렛으로 연결한다. 
```swift
@IBOutlet var jangCountLabel: UILabel!
@IBOutlet var bongCountLabel: UILabel!
@IBOutlet var tangCountLabel: UILabel!
```
1-2. 초기값이 필요한 변수를 파악하고, 초기값을 넣는다. 
```swift
//짜장,짬뽕,탕수육 가격
let jangCost = 5000
let bongCost = 6000
let tangCost = 12000
```

1-3. 값이 바뀔만한 변수는 didset으로 설정한다. 

```siwft
//각 수량 변수 didset으로 담기
var jangCount: Int = 0{
  didSet {
    jangCountLabel.text = "\(jangCount)"
      }
}
var bongCount: Int = 0 {
  didSet {
    bongCountLabel.text = "\(bongCount)"
  }
}

var tangCount: Int = 0 {
  didSet {
    tangCountLabel.text = "\(tangCount)"
  }
}
```
- 주문 버튼 터치 시 레이블에 대한 수량 증가가 필요하므로, "jangCountLabel.text"값이 "\(jangCount)"로 바뀌게 한다. 

```
(참고)
jangCount: 짜장면 수량
bongCount: 짬뽕 수량
tangCount: 탕수육 수량 
jangCountLabel.text: 짜장면 수량 레이블.text
bongCountLabel.text: 짬뽕 수량 레이블.text
tangCountLabel.text: 탕수육 수량 레이블.text 
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
*소지금액(sojePay)*과 *결제금액(buyPay)*에 대한 변수도 지정한다.
소지금액은 70000원의 초기값으로 설정하고, 결제금액은 메뉴의 수량에 따라 변동하므로.


1-4. 주문버튼을 누르면 수량이 증가하도록 만든다. 

```swift
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
버튼을 누르고 증가한 카운트가 레이블에 적용될 수 있도록. 그럼 ~~1.주문 버튼 터치 시 각 아이템에 대한 수량 증가~~는 이걸로 완료됐다. 


## 2. 계산메소드 만들기. 

각 아이템별 주문 수량 증가에 따른 결제금액 증가가 필요하다. 

2-1. 수량에 따라 짜장면+짬뽕+탕수육의 가격을 모두 더해줄 함수 필요.
```swift
//현재 결제금액을 계산하는 메소드
func calcPrice() -> Int {
  return (jangCount * jangCost) + (bongCount * bongCost) + (tangCount * tangCost)
  
}
```
"calcPrice()"는 (짜장면 x 수량) + (짬뽕 x 수량) + (탕수육 x 수량)
이것은 *결제금액*레이블에 에 담겨야할 값이기도 하다. 또, 이 함수가 어느 메뉴의 수량이 올라갈 때마다 계산될 수 있도록 이전에(1-3) 써놓은 변수의 didset에 넣어준다. 그러면 다음과 같이 입력된다.  
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
수량이 증가할 때마다, 결제금액(buyPay)이 현재 결제금액(calcPrice())을 계산하는 메소드를 호출한다.
그러면 ~~2.각 아이템별 주문 수량 증가에 따른 결제금액 증가~~는 완료되었다.


![이미지](/image/first-2.png)

## 3. 전달값 초기화와 결제금액 차감 구현

결제 진행 시 소지금액에서 결제금액만큼 차감 및 주문수량 초기화가 필요하다. 

3-1.먼저 초기화부터 보자면, 초기화버튼을 눌렀을 때, 실행될 수 있도록 초기화Button아래에 변수를 재지정해준다. 

```swift
@objc func setupButtonClicked(_ sender: UIButton) {
  
  jangCount = 0 //수량
  bongCount = 0 //수량
  tangCount = 0 //수량
  buyPay = 0  //결제금액
  sojiPay = 70000 //소지금액
}
```
초기화버튼을 누르면 수량과, 결제금액, 소지금액 모두 초기값으로 진행되는 코드. 


3-2. 소지금 - 결제금액 계산(차감되는 것)

소지금은 70000원으로 고정되어있지만 결제금액은 수량에 따라 변동되는 값이고, 최종적으로 *결제*를 하게 되면 소지금에서 결제금액이 빠져나가야 하는 방식이다. 

그러면, 
```소지금 = 소지금 - 결제금액```

일텐데, 결제금액 차감부분은 alert에서  해당기능을 넣어야 하는 사항이기 때문에,  뒤의 포스프의 alert 부분을  참고하자. alert 먼저 만든후 확인/취소에 따라 결제금액이 차감되어야하기 때문. 








