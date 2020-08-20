---
title: '[라이브러리]SideMenu사용하기'
date: 2020-05-12 21:45:50
category: "Library"
tags:
- 라이브러리
- SideMenu
thumbnail: /image/sideMenu-2.png
---



앱에서 자주 사용되는 '사이드메뉴 바' 가 있다. 


일명 '햄버거메뉴'라고도 한다. 


코드로 직접구현해도 되겠지만, 쉽게 라이브러리를 통해 구현도 가능하니 방법을 알아보자. 



##  1. 설치하기 

1-1. 사이트 이동하기. 

아래 링크를 클릭하여 해당 사이트로 이동. 

[[https://github.com/jonkykong/SideMenu]](https://github.com/jonkykong/SideMenu)

![이미지](/image/sideMenu-2.png) 


1-2. 터미널에 cocoapods install하기

- 설치
```
$ sudo gem install cocoapods
```
- 해당 경로로 가서 cocoapods init ~ install
```
pod init
```
```
pod install
```


1-3. 버전에 맞춰 Podfile 설치 

최신버전 

```
pod 'SideMenu'
```


(만약 swift 버전이 이전 버전일 경우 사이트의 Installation 부분 참조하여 설치!)



## 2. 사용하기 

2-1. 사이드메뉴로 할 컬트롤러의 class 이름을 "SideMenuNavigationController"로 지정한다.

(podfile에 SideMenu라이브러리가 정상적으로 설치가 되었다면, 아래 이미지의 해당 메뉴를 확인 할 수 있을 것이다. )


![이미지](/image/sideMenu.png)


2-2.  해당 부분의 on은 왼쪽으로, off는 오른쪽 팝업이라는 의미다. 이렇게 선택해서 사용하면 된다. 


![이미지](/image/sideMenu-1.png)

적용된 모습. png 

😺

잘모르겠다면, 글쓴이가 직접 쓴 사용방법이 있으니, 해당 사이트의 Usage 구간을 참고하도록 하자.  



