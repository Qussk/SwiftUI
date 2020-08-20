---
title: '[Swift]Storyboard사용하지 않고 Project 사용하기'
date: 2020-06-02 20:42:22
category: "ios"
tags:
- Swift
- Xcode
- No Storyboard
thumbnail: /image/win3.png
---

이제 슬슬 스토리보드 없는 환경에 익숙해져야한다. 

스토리보드를 이용하지 않는 이유는 간단하다. 

- 보다 수월한 협업
- ios12이하는 SceneDelegate를 지원하지 않았던 환경을 참고.


스토리보드를 이용하지 않는 방법은 2가지가 있다. 

## AppDelegate만 이용하기.(ios12이하는 AppDelegate만 있다.)

이 말은 즉슨, 
취직하고 해당 회사에 AppDelegate만 있을 경우가 있다. :) 
아래를 참고하자. 


### 0. Project 만들기

### 1. Main Interface 에서 Main 지우기

![](/image/win5.png)

### 2.  info.plist 에서 Application Scene Menifest 모두 삭제.

![](/image/win4.png)


### 3. MainStoryboard 지우기 

![](/image/win.png)


### 4. SceneDelegate 지우기

![](/image/win1.png)

### 5. AppDelegate의 UISceneSession Lifecycle 지우기 

![](/image/win2.png)


### 5. AppDelegate에 window 작업하기 

![](/image/win3.png)


## SceneDelegate 이용하기 



![](/image/scene.png)


1) guard let _ (와일드카드) 표시된 곳, scene으로 바꾸기.
2) rootview 지정. (위 사진은 navigationController가 있는 모습이고, 없다면, 
winfow?.rootviewController = ViewController() 만 해주면된다. 여기서, ViewController() 는 처음 시작하고 싶은 화면(콘트롤러로)으로 지정.





