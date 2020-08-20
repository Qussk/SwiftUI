---
category: "Library"
title: '[라이브러리]IQkeyboardManager - 키보드에 닫기(Done)버튼 생성하기'
date: 2020-04-29 20:59:30
tags:
- 라이브러리
- IQkeyboardManager
- Keyborad
thumbnail: /image/IQKeyboardManager.png
---


# IQkeyboardManager - 키보드에 닫기(Done)버튼 생성



## why? IQkeyboardManager

앱에서 텍스트필드를 사용하려면 키보드에 대한 메소드를 구현해야하는데... 생각보다 초심자가 하기에는 어렵다. 리턴 누를때 닫히는 메소드, 화면을 눌러야 닫히는 메소드 등을 구현해야하거나, 깊게는 TextFieldDelegate까지 가야할 수도 있는데...

~~그런거 필요 없고 앱 사용에 큰 무리가 없는 정도로만? 구현하고 싶다!~~ 한다면, 

사실 키보드에 *'닫기'* 버튼 하나만 달아주면 해결되는 일이다.. 

아래를 참고하자 !



## [사용하기] 

이것을 Text Field Delegate를 사용하지 않고, 라이브러리로 간단하게 ? 해결해보고자 한다. 


### 1. 사이트가기 

[https://github.com/hackiftekhar/IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)


해당 페이지에 가면 사용법을 알려주는 동영상도 지원되고, 설명도 친절하게 되어있어 참고하면 된다. 어려우면 이 글을 쭉 참고..!


### 2. cocoapods 에 설치 

1. Installation 로 이동하여, 본인의 Swift, Xcode 버전에 맞는 것을 선택한다. 
2. Swift 5.1, 5.0, 4.2, 4.0, 3.2, 3.0 (Xcode 11) 보통 이것이라고 생각하고 아래 코드를 cocoapods Podfile에 넣는다. (이 외의 버전이라면 해당사이트에 pod으로 시작하는 다른 것을 선택!)
```swift
pod 'IQKeyboardManagerSwift'
```

### 3. 해당 프로젝트에 적용하기 

1. AppDelegate로 이동하여 import한다. 
```swift
import IQKeyboardManagerSwift
```

2. 아래의 코드를 붙여넣는다. 
```swift
IQKeyboardManager.shared.enable = true
   return true
```
어딘지 모르겠으면 3.풀화면 참조 'ㅅ'


3. 풀화면 


```swift

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

​

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//아래 코드를 이곳에 붙여넣으면 된다.  
    IQKeyboardManager.shared.enable = true
    return true

    }
```

## [완료하기]



* Keyborad 오른쪽 상단에 Done버튼이 생성된 모습

![Keyborad 오른쪽 상단에 Done버튼이 생성된 모습](image/Done.png)



참 쉽다! @_@



