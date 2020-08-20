---
title: '[Swift]Textfield 터치시 키보드내리기, 리턴시 커서이동(resignFirstResponder())'
date: 2020-08-09 16:10:42
category: "ios"
tags:
- Swift
- UITextfield
- resignFirstResponder()
thumbnail: 
---



### delegate = slef선언
```swift
idTextField.delegate = self
pwTextField.delegate = self
```

### UITextFieldDelegate

```swift
extension ViewController: UITextFieldDelegate {
  //1.리턴시 다음 텍필로 커서 이동 ~ 이후 종료와 로그인 액션으로 접근
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == idTextField {
      pwTextField.becomeFirstResponder()
    } else if textField == pwTextField {
      loginButtonAction()
      pwTextField.resignFirstResponder()
    }
    return true
  }
  //2. 화면터치시 키보드 종료
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.pwTextField.resignFirstResponder()
    self.idTextField.resignFirstResponder()
      }

}
```
### 1. textFieldShouldReturn은 리턴시 수행할 메서드를 정의합니다. 

![](/image/doyou1.gif)


1-1. textField가 idTextField일 경우 pwTextField.becomeFirstResponder()을 호출합니다. 
1-2. textField가 pwTextField일 경우 pwTextField.resignFirstResponder()을 호출합니다. resignFirstResponder는 텍스트필드의 현재상태를 포기했다는 요청을 리시버에게 알려주고, 키보드가 자동으로 내려가게 합니다. 
1-3. loginButtonAction()을 호출하여, 로그인 버튼에 접근합니다. 


[참고 : resignFirstResponder()](https://developer.apple.com/documentation/uikit/uiresponder/1621097-resignfirstresponder)


화면전환 소스를 넣거나해두 됨.. 



### 2. touchesBegan 메서드를 통해 resignFirstResponder()호출하여 텍스트필드에 대한 현재상태 종료함. 


![](/image/doyou2.gif)



