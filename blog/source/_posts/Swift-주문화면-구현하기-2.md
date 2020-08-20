---
title: '[Swift]주문화면 구현하기 -2'
date: 2020-05-06 15:16:40
category: "ios"
tags:
- Swift
- Alert
- 화면전환
thumbnail: /image/firstTest.png
---

# 주문화면 구현하기 -2

```
주문 버튼 터치 시 각 아이템에 대한 수량 증가(완료)
각 아이템별 주문 수량 증가에 따른 결제금액 증가(완료)
결제 진행 시 소지금액에서 결제금액만큼 차감 및 주문수량 초기화(보류중)
소지금액이 결제금액보다 적은 경우 결제 불가 메시지 Alert 띄우기
초기화 버튼은 주문수량, 결제금액, 소지금액을 모두 초기화
초기화 버튼 이외에 한 번 올린 주문수량을 내리는 기능은 없음
```

현재 1~2는 완료되었고 3은 초기화까지만 완료된 상태다. 결제금액 차감은 결제버튼을 누르면 발생하는 Aler에 따라 실행되어야 하므로 일단 보류해 놓았다. 


[[주문화면 구현하기 -2 참조하기]](https://qussk.github.io/2020/05/06/Swift-%EC%A3%BC%EB%AC%B8%ED%99%94%EB%A9%B4-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-1)


현재까지 이상이 없다면 아래의 내용을 계속 진행하자. 



## 4. AlertController 활용 

4-1. 버튼에 Alert 달기.

일단 버튼 아래에 let alertController을 살포시 얹는다.. 

```
@objc func buyButtonClicked(_ sender: UIButton) {

let alertController = UIAlertController(title: "알림",message: "결제금액은 모두\(buyPay)원 입니다.", preferredStyle: .alert)
         
  let alert1Action = UIAlertAction(title: "취소", style: .cancel) { _ in
  }
  let alert2Action = UIAlertAction(title: "확인", style: .destructive) { _ in
  }
  
    alertController.addAction(alert1Action)
    alertController.addAction(alert2Action)
            
    present(alertController, animated: true)
  }
          
}   

```


![이미지](/image/first-3.png)


- 결제하기 버튼을 누르면 "결제금액은 모두\(결제금액)원 입니다."로 메세지가 나오도록 하고, preferredStyle: 을 .alert로 지정하여 해당 alert을 가운데로 팝업되도록 한다. 
- UIAlertAction으로 "확인(destructive)", "취소(cancel)"기능을 넣는다. 


4-2. 결제하기 누른후 alert에서 "확인"을 누르면 최종적으로 결제가 진행되고, 소지금액 차감. 

이전 포스트에서 잠시 보류해 놓았던 3-2를 이곳에 구현한다. 

```swift

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
 
 ```


 - "확인"을 누르면 실행되어야 하기 때문에 "확인" UIAlertAction아래에 넣어준다.
 - 소지금액 = 소지금액 - 결제금액 
 ```self.sojiPay = self.sojiPay - self.buyPay```
 - 소지금액레이블.text역시 소지금액값으로 바뀔수 있도록 써준다.
```self.sojiCost.text! = "\(self.sojiPay)원"```


![이미지](/image/first-5.png)


그러면 확인을 누르면 결제가 정상적으로 진행이 되는 모습을 볼 수 있다. ~~결제 진행 시 소지금액에서 결제금액만큼 차감 및 주문수량 초기화~~도 모두 마쳤다. 


## 5. Alert에 조건달기 

하지만 이것으로 끝이 아니다. 

구현사항을 보면, 소지금액은 70000원으로 정해져있고, 결제금액이 소지금액을 초과할 경우 결제가 진행되지 못하도록 Alert을 차단해야한다. 이때, 조건문이 필요하고 코드는 아래와 같은 코드가 된다. 

5-1. 소지금액이 결제금액보다 적은 경우 결제 불가 메시지 Alert 띄우기


```swift

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
```

![이미지](/image/first-4.png)


- if sojiPay <= buyPay { 의 경우 아래의 Alert이 실행되도록한다. 
- 잊지 말아야하는 부분은 present(alertController, animated: true)도 꼭 달아줘야한다.. 


사실 시험때 구현은 다 해놓고 present을 실수로 안넣어서.. Alert이 작동이 안됐다.. 계속 왜 안되는 거야? 하면서 다른곳에서 이유를 찾다가 시간낭비했다... ㅠㅠ... 몬가 변수쪽이 잘못됐다고 생각했던 것..

어쨌든, 이것으로 ~~4.소지금액이 결제금액보다 적은 경우 결제 불가 메시지 Alert 띄우기~~역시 완료가 되었다. 아래의 ~~5.초기화 버튼은 주문수량, 결제금액, 소지금액을 모두 초기화~~는 3-1에서 구현이 완료되었고, 
~~6.초기화 버튼 이외에 한 번 올린 주문수량을 내리는 기능은 없음~~이것도 크게 구현하지 않는 내용이기 때문에 자동으로 클리어된 부분. 



### 셀프체크리스트를 통해 정확하게 구현됐는지 확인한다. 
```
✓ UI 구현 : 스토리보드와 코드를 이용해 정확한 UI 구현
✓ 주문하기 기능 : 특정 아이템의 수량이 1씩 증가하며, 결제금액에 반영
✓ 결제하기 기능
- 소지금에서 결제금액이 정확히 차감. 소지금은 -가 될 수 없음
- 소지금이 결제금액보다 작을때, 같을 때, 클 때 각각의 상황 모두 체크
✓ 초기화하기 기능 : 소지금, 결제금액, 주문수량의 정보가 모두 정확히 0으로 초기화
✓ AlertController 동작
- 결제 성공 : "총 결제금액은 ****원입니다.". 버튼 종류는 확인, 취소 버튼 2개
- 결제 실패 : "소지금액이 부족합니다"메시지. 버튼 종류는 확인 버튼 하나
```

이상이 없다면 이것으로 마침! :princess:



