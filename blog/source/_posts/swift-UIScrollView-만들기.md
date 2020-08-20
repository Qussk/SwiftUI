---
title: '[swift]UIScrollView 만들기'
date: 2020-07-20 16:12:35
category: "ios"
tags:
- Swift
- UIScrollView
thumbnail: image/scroll.png
---


앱을 이용하면서 자주접하는 scrollview를 공부해보자.


scrollview가 까다로운게, 부모뷰가 자식뷰의 크기를 따라가는 속성이라 자식뷰의 프레임과 통일성이 굉장히 중요해진다. 

이것을 frame으로 잡는 방법이 있고 autolay 아웃으로 잡는 방법이 있는데

2가지 다 알아보는 걸로 ㅋㅋ

# [frame 이용]


### ~~주의점~~ 

![](/image/scroll1.png)

- red -> ScrollView
- whigt -> ImageView 

보기에 잘나온 것 같지만, 부모뷰(ScrollView)가 자식뷰(imageView)보다 더 큰 경우라서, 위처럼 구현되면 자식뷰들이 부모뷰의 영역(redView)만큼 자유자재로 움직일 수 있게 된다.

애초에 그게 구현목표였다면 상관 없겠지만..
스크롤뷰에서는 보통 고정되도록 구현하니까.. 



![](/image/scroll4.png)


이런식으로 풀화면 채워야한다. 
그리고 총 3개의 그림을 크롤 하도록.. 


## 1.선언 

```swift
lazy var scrollView = UIScrollView()
var scrollFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
let images = ["naver","instagram","naver"] //이미지이름
```

## 2.frame잡기 

```swift 
scrollView.contentSize = CGSize(width: 375 * 3, height: scrollView.frame.height)
   scrollView.delegate = self
   scrollView.isPagingEnabled = true
  // scrollView.backgroundColor = .red
   view.addSubview(scrollView)

```

2-1.  **scrollView.contentSize**는 width가 275인 이미지가 3개 들어간다는 의미로 * 3을 해주었다. height는 scrollView에 맞춤. 
2-1. **isPagingEnabled**는 스크롤 할때 페이지값으로 프레임이 정확하게 이동하는 것


## 3. ScrollView에 들어갈 이미지의 size지정. 

```swift
//MARK:-ScrollView

func setScrollView(){
  //
  for index in images.indices {
    scrollFrame.origin.x = view.frame.width * CGFloat(index)
    scrollFrame.size = scrollView.frame.size
    
    
    let descriptionImage = UIImageView()
    descriptionImage.image = UIImage(named: images[index])
    descriptionImage.frame = CGRect(x: scrollFrame.origin.x, y: 0, width: 375, height: 430)
    scrollView.addSubview(descriptionImage)
  }
}
```
3-1. **images.indices** 이미지를 순차적으로 넣는다.
3-2. image의 사이즈  

```swift
descriptionImage.frame = CGRect(x: scrollFrame.origin.x, y: 0, width: 375, height: 430)
```


그러면 이미지가 scrollView의 크기와 맞게 잘 돌아가는 화면을 확인 할 수 있다. 


스크롤 방향은 콜렉션뷰처럼 호라이즌, 버티컬로 지정해주는 게 아니라, 
scrollview가 지정범위를 주고, 자식뷰의 크기에 따라서 스크롤 해주는 개념이다.
그래서 자식뷰가 width를 늘리면서 가는지, height를 늘리면서 가는지에 따라 결정된다. 


fram이 정확한 값을 부여하기 쉬워서 오토레이아웃보다는 안정성 면에서 좋은 것 같지만, 나는 오토레이아웃 쟁이이니까. 

그리고, 위/아래로 스크롤 되는 것이 오토레이아웃이 더 쉬울것 같아서 아래의 방법처럼 해보았다. 

~~(사실 삽질 엄청 많이함.)~~



# [autoLayout 이용]


구현해야할 사항은 아래와 같다. 


![](image/scroll6.png)


컨텐츠 크기에 맞춰 아래로 스크롤 하기! 

(ImageView와 함께 설명!)


## 1. 선언 

```siwft
let scrollView = UIScrollView()
let detailimageView = UIImageView()
```

## 2. UI 

```swift
scrollView.backgroundColor = .white
view.addSubview(scrollView)

detailimageView.clipsToBounds = true
detailimageView.image = UIImage(named: "dc1")
scrollView.addSubview(detailimageView)

```


## 3. Constrain

- translatesAutoresizingMaskIntoConstraints
```swift
[scrollView,detailimageView].forEach{
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
```
- NSLayoutConstraint
```swift
NSLayoutConstraint.activate([

scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -90),
scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

detailimageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
detailimageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
detailimageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
detailimageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
detailimageView.heightAnchor.constraint(equalToConstant: 480),

```
3-1. scrollView.topAnchor를 constant : -90으로 잡은 이유는 **    view.safeAreaLayoutGuide** 가 아니라 View의 범위로 하고 싶어 설정한거고, topAnchor를 (equalTo: view.topAnchor)로만 잡게 되면 top부분이 고정되어 스크롤이 안된당... 그래서 고정을 주면 안되기 때문에, 임의의 값인 -90으로만 살짝 잡은것.. 

3-2. scrollView의 레이아웃의 기본값을 view에 맞춰줬다면, 이제 자식뷰인 detailimageView설정이 중요해진다. top은 scrollView를 따라가고, 사실 widthAnchor가 애매한 부분인데(기기마다 크기 다르니까..), **(UIScreen.main.bounds.width)**로 아예 view가 아닌 스크린 값으로 잡아버린다. 
3-3. heightAnchor를 잡은이유는 이미지의 값이 고정값이고, 그 위로 Lable이 가득한 뷰를 이어나가야하기 때문..


그러면 가장 중요한. 유동값인 bottomAnchor는 어떻게 잡아야할까? 

방법은 간단하다. 

구현 이미지를 보면, 스크롤 뷰 맨 마지막에 올 컨텐츠는 "브랜드 더보기 >" 버튼이다. 

```swift

    viewsButton.topAnchor.constraint(equalTo: comentLable3.bottomAnchor, constant: 40),
    viewsButton.widthAnchor.constraint(equalToConstant: 150),
    viewsButton.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -23),
    viewsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
  ])
  
```
3-4. 이런식으로 스크롤 마지막에올 viewsButton의 레이아웃을 **scrollView.bottomAnchor**으로 잡으면 된다.
3-4. detailView는 UIView고 그림 상의 흰영역부분 !(브랜드 설명?)



![](/image/scroll5.png)

요 흰부분 !!!!!!


```siwft
detailView.topAnchor.constraint(equalTo: detailimageView.bottomAnchor, constant: -39),
     detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
     detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
     detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
     detailView.heightAnchor.constraint(equalToConstant: 830),
```


이해를 돕기위해 detailView의 코드 올린다. 



이해해보니 참 쉽다!!! 





# ScrollView 지정 장소에서 멈추기


위의 방법처럼 스크롤 범위를 해당 뷰의 heightAnchor로 조절가능하지만, 
화면을 끝까지 당기는 경우 빈 화면이 조금 끌어당겨진다. 
이것이 싫고 그냥 딱 원하는 만큼만 스크롤이 되었으면 좋겠다! 싶으면 아래를 이용하자 


## 1.self 선언
```swift
scrollView.delegate = self
```

## 2. extension(UIScrollViewDelegate)
```swift
extension DetaileDescriotionViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 450 {
      scrollView.contentOffset.y = 450
    }
    print(scrollView.contentOffset.y)
 }
}
```
2-1. scrollView.contentOffset.y > 450  값이 450 이상이면, 
scrollView.contentOffset.y = 450을 450으로 지정하겠다는 뜻이다. 
2-2. **print(scrollView.contentOffset.y)** 는 스크롤 되었을 때, contentOffset의 y좌표를 알려준다. 그 값에 따라 적당한 값으로 설정 가능!!


