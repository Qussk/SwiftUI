---
title: '[Swift]TextField 키보드에 가려짐 문제해결'
date: 2020-05-19 10:56:51
category: "ios"
tags:
- Swift
- TextField
- keyboard
- 로그인화면
thumbnail: /image/login.png
---




## 문제직면 


![](/image/login-1.png)

텍스트필드를 이용하다보면 위와 같은 문제에 자주 직면하게 될 것이다. 텍스트 필드를 키보드 높이보다 위에 두면 문제는 간단히 해결되겠지만, 
~~나도 남들처럼 예쁘게 UI자고 싶은데.. (왜 나만안돼 나만.. ㅠㅠ)~~ 
이라면 아래를 참고하자. 

우린 아름다운 UI를 포기할 수 없으니까!!


1-1. 뷰 만들기. 

텍스트 필드를 하나하나 올리는 방법도 있겠지만, 
필자는 view로 좀더 손쉽게 올려보고자 한다.



![](/image/login-2.png)

올려야할 영역을 모두 view에 넣는다. 좌측 목록을 활용하면, view가 상위목록으로, 이 외에 것들은 모두 view의 하위목록으로 쉽게 옮길 수 있다. 


그리고 view 아울렛 연결로 마무리. 


1-2. 키보드에 따라 뷰 올렸다 내리기. (NotificationCenter addObserver)

1) 일단 옵저버를 등록해줘야하는데, 화면이 켜졌을 때 이를 적용해야하기 때문에,
뷰디드로드에 놓거나, viewWillAppear에 넣어야한다. 

필자는 viewWillAppear에 넣는 방법을 택했다. 그리고 viewWillAppear가 지저분해지는 것을 막고자  함수를 이용하여 더 깔끔하게 처리했다.  (그리고 viewWillAppear는 반드시 override를 해줄것.) 

```swift
override func viewWillAppear(_ animated: Bool) {
  addKeyboardNotification()
}

//옵저버 등록 
private func addKeyboardNotification() {
 NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow(_:)),name: UIResponder.keyboardWillShowNotification,object: nil)
 NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(_:)),name: UIResponder.keyboardWillHideNotification,object: nil)
   }
```
2)keyboardWillShowNotification,keyboardWillHideNotification는 고정갑싱다.
3) #selector해준 값은 keyboardWillShow, keyboardWillHide이고 키보드를 올리고 내리는 함수이다.

```swift
//1-2. 올리기, 내리기.
@objc private func keyboardWillShow(_ notification: Notification) {
  loginView.frame.origin.y = 250 }

@objc private func keyboardWillHide(_ notification: Notification) {
   loginView.frame.origin.y = 450    }

```

위의 수치는 본인의 UI에 맞춰 조절할 수 있다 (꼭 정수가 아닌, -값이 될 수도 있다.)


그래서 이 수치에 맞춰서 하게되면 ? 



![](/image/login-3.png)


설정해준 값에 맞춰 view가 올라가는 모습을 확인할 수 있다. 

구분을 쉽게하기 위해 view의 백그라운드를 노란색으로 줬다. 


이해를 돕기위한 영상 참고 

[[https://www.youtube.com/watch?v=--belgLUl0U&lc=UgxTbtgIjq8c8tcAPLZ4AaABAg]](https://www.youtube.com/watch?v=--belgLUl0U&lc=UgxTbtgIjq8c8tcAPLZ4AaABAg)




🎃

