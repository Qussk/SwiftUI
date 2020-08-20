---
title: '[Swift]TextField 글자수 제한하기'
date: 2020-05-21 15:33:59
category: "ios"
tags:
- TextField
- TextFieldDelegate
- 로그인화면
thumbnail: 
---

TextFieldDelegate 사용시 텍스트필드에 글자수 제한두기

아래의 코드만 붙여넣기하면 된다. 


🤷🏻‍♀️


```swift
//텍스트필드 글자수 제한
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  guard let text = textField.text else { return true }
  let newLength = text.count + string.count - range.length
  return newLength <= 16
}
```
newLength <= 16
의 16은 16자까지 제한 둔다는 뜻. 



