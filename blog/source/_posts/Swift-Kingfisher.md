---
title: '[라이브러리]Kingfisher로 gif이미지 삽입'
date: 2020-07-19 19:43:30
category: "Library"
tags:
- Kingfisher
- gif
thumbnail: image/king.png
---





Kingfisher 라이브러리를 이용하여 gif이미지를 삽입해보자 ! 



### **삽입할 gif 파일**

![](/image/PET.gif)



## **1. SwiftPackageManager 에 Kingfisher불러오기** 


![](/image/king2.png)




## **2. gif파일을 프로젝트 안에 넣는다**



![](/image/king1.png)


에셋에 넣으면 안된다!! 


## **3. code**


```swift
import Kingfisher
```
3-1. 임포트 !

```swift
//MARK: -kf

override func viewDidAppear(_ animated: Bool) {
  super.viewDidAppear(true)
  
  
  self.guideimage.kf.indicatorType = .activity
  let gifs = ["https://qussk.github.io/image/PET.gif"]
  self.guideimage.kf.setImage(with: URL(string: gifs[0])!)
  
}
```
3-2. 화면 켤때마다 동작되길 원해서 viewDidAppear에 넣어준다. 




###  여러개 넣고 싶을 경우 아래의 코드를 참고한다. 

```swift

let gifs = ["https://qussk.github.io/image/PET.gif", "https://~~~~"]
self.guideimage.kf.setImage(with: URL(string: gifs[0])!)
self.guideimage.kf.setImage(with: URL(string: gifs[1])!)
```


## **완성**



[**[완성영상보기]**](https://youtu.be/QOBeANP6unI)



귀엽게 잘들어갔따.


~~만약, gif가 아닌 mp4파일을 넣게 되면 아래 처럼 된다...~~



[**[mp4영상보기]**](https://youtu.be/1_2gnypJcH0)


gif로 변환해서 넣은 이유... 

-.-;;;  매우 당황.. 









