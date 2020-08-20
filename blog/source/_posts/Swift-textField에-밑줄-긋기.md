---
title: '[Swift]TextField에 밑줄 긋기'
date: 2020-05-21 14:58:14
category: "ios"
tags:
- TextField
- TextFieldDelegate
- 로그인화면
thumbnail: /image/line.png
---


오늘은 텍스트 필드에 밑줄을 긋는 법을 알아보고자 합니다!

스토리 보드에서 지원하는 텍스트필드 디자인은 총 4가지가 있는데 이곳에는 TextField의 underLine은 제외 되어 있으니 이는 코드로 직접 구현해내는 방법 밖엔 없습니다. 


😉


아래의 코드를 참고하여 붙여넣어줍니다. 


```swift
override func viewDidLayoutSubviews() {
passwordUnderline()
}

//텍스트필드 밑줄
func passwordUnderline() {
  passwordTextfield.borderStyle = .none
  let border = CALayer()
border.frame = CGRect(x: 0, y: passwordTextfield.frame.size.height-1, width: passwordTextfield.frame.width, height: 1)
     border.backgroundColor = UIColor.gray.cgColor
     passwordTextfield.layer.addSublayer((border))


  emailTextfield.borderStyle = .none
  let border1 = CALayer()
  border1.frame = CGRect(x: 0, y: emailTextfield.frame.size.height-1, width: emailTextfield.frame.width, height: 1)
         border1.backgroundColor = UIColor.gray.cgColor
         emailTextfield.layer.addSublayer((border1))
  }
```  
  
  
해당 코드를 viewWillAppear에서 사용하여도 관계없지만, 만약 코드로 오토레이아웃을 잡았다면 

```viewDidLayoutSubviews```

이곳에서 오버라이딩하여 사용해야합니다. 

이에 대한 내용은 아래 링크를 참고 !

[[https://g-y-e-o-m.tistory.com/64]](https://g-y-e-o-m.tistory.com/64)




혹시 안되는 분들은 TextFieldDelegate를 했는지 확인!

1. class에 UITextFieldDelegate부르기.

```swift
class ViewController: UIViewController,UITextFieldDelegate {
```
2. viewDidLoad에 해당 textField를 self로 지정

```swift
emailTextfield.delegate = self
passwordTextfield.delegate = self
```


완성된 모습 확인
![](/image/line.png)




👏🏻👏🏻👏🏻
