---
title: '[Swift]NavigationBar 생략'
date: 2020-07-20 14:49:00
category: "ios"
tags:
- Swift
- NavigationBar
thumbnail: /image/naviless.png
---


네비게이션 바 디자인 생략할 때 
자주 쓰는 코드다.

보통 히든으로 생각하는 것 같은데? 실선이 남는 듯하다.. 

이야기를 들어보면..


그런데 나는 전부터 아래코드로 써와서 ㅋㅋㅋㅋㅋㅋㅋ

다들 이 코드 보면 신박하다고 한다 ㅋㅋㅋㅋㅋㅋㅋ


```swift
func navigationBarLess(){
  //네비게이션바 디자인 생략
  navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
  navigationController?.navigationBar.shadowImage = UIImage()
  navigationController?.navigationBar.backgroundColor = UIColor.clear
}
```


navigationBar의 setBackgroundImage로는 보통 접근안하니까.. 

현업에서는 어떻게 쓰일지 잘 모르겠다. 


어쨌든,,


navigationBar는 기본 흰색이 제공되고 color역시 커스텀 가능하지만.. 
clear로 적용만 적용하면 실선이 보이게 된다. 

```swift
navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
navigationController?.navigationBar.shadowImage = UIImage()
```
이 코드가 실선을 없애고 

```swift
 navigationController?.navigationBar.backgroundColor = UIColor.clear
```
이것은 color를 투명으로 주겠다는 뜻. 


그러면 navigartionBar 영역이 해당 view의 background color를 따라가게 된다. 


![](image/naviless2.png)


이미지가 있다면 이미지를 그대로 보여준다. 스크롤해도 문제없음 !!





아래의 링크를 보면 히든으로 주는 방법 , 실선없애기, 바아이템 색면경, 타이틀 색변경에 대한 내용이 있다 . 참고해보아도 좋을 듯. 



[[dd]](https://zeddios.tistory.com/574)



아마 보통은 히든~실선없애기를 사용하거나, 애초에 통일감있게 모든 vc에대해 네비바 설정을 지정하는 방법도 있는 것 같다

달리해야할때는 fales를 줘야하는 방식으로.. 


공부해야지

