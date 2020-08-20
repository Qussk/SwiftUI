---
title: '[Swift]Slider 이용예제(with: CollectionView)'
date: 2020-06-18 10:29:55
category: "ios"
tags:
- Swift
- CollectionView
- Slider
thumbnail: /image/slider.png
---



## 1. Slider 만들기


![](/image/slider5.png)


흔히 이용하는 sliderBar를 만들어보자 ! 

[[애플문서 바로가기>>]](https://developer.apple.com/documentation/uikit/uislider)


sliderBar에 대해 깊게 공부하고 싶다면 아래 링크의 애플문서를 참고하자 !





```swift
import UIKit

final class BasicCodeViewController: UIViewController {
  
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSliders()
    setupNavigationItem()
  }

  // MARK: Setup Views
  
  func setupSliders() {
    // 셀 크기 조절
    let sizeSlider = UISlider()
    sizeSlider.minimumValue = 10
    sizeSlider.maximumValue = 200
    sizeSlider.value = 50
    
    // 셀 간격 조절
    let spacingSlider = UISlider()
    spacingSlider.minimumValue = 0
    spacingSlider.maximumValue = 50
    spacingSlider.value = 10
    spacingSlider.tag = 1
    
    // 셀 외부여백 조절 
    let edgeSlider = UISlider()
    edgeSlider.minimumValue = 0
    edgeSlider.maximumValue = 50
    edgeSlider.value = 10
    edgeSlider.tag = 2
    
    let sliders = [sizeSlider, spacingSlider, edgeSlider]
    sliders.forEach {
      $0.addTarget(self, action: #selector(editLayout), for: .valueChanged)
    }
    
    //스택뷰
      let stackView = UIStackView(arrangedSubviews: sliders)
      view.addSubview(stackView)
      stackView.axis = .vertical //가로.세로
      stackView.alignment = .fill //정렬
      stackView.spacing = 10 //슬라이더간의 간격
      
      //스택뷰 오토레이아웃
      stackView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        stackView.widthAnchor.constraint(equalToConstant: 300)
      ])
      controllerStackView = stackView
 
    }
    
```
1-1.     ```let sizeSlider = UISlider()``` 로 Slider를 만들어준다. 
1-2. Slider의 minimumValue 는 최소값, maximumValue 최대값이다.
1-3. Slider의 현재값(value)을 지정해 놓을 수 있다. 
1-4. 여러개가 필요한 경우 tag로 구분해준다. 
1-5. addTarget을 해준다. 슬라이더에 따라 값 변경이 필요한 경우 .valueChanged를 이용한다. (여러개인 경우 forEach를 활용하여 코드 수를 줄이자!)
1-6. 아래 스택뷰는, slider의 위치를 stackView로 잡고, stackView의 오토레이아웃까지 잡아준 모습. 



## 2. Slider value지정 

1-5. 의 addTarget시 이용한 editLayout을 보자. 
.valueChanged값을 변경하는 것으로 지정한건데, '무엇을?'을 지정해주지 않았다. 


```swift
//에디팅 레이아웃
@objc private func editLayout(_ sender: UISlider) {
  let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

  if sender.tag == 0 { //셀크기
    let size = CGFloat(sender.value)
    layout.itemSize = CGSize(width: size, height: size)
  }else if sender.tag == 1 { //셀간격
    layout.minimumLineSpacing = CGFloat(sender.value) //value?
    layout.minimumInteritemSpacing = CGFloat(sender.value)
  }else { //외부여백
    let v = CGFloat(sender.value)
    let inset = UIEdgeInsets(top: v, left: v, bottom: v, right: v)
    layout.sectionInset = inset
  }
}
```
2-1. 먼저, Slider값에 따라 CollectionView의 layout값을 바꿔줄 것이기 때문에 layout을 불러온다. 

```let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout)```

2-2. 조건문을 이용하여, 첫번째 Slider의 경우, 두번째 Slider의 경우, 세번째 Slider의 경우, 값변경을 어떻게 줄건지 선언한다. 
2-3. tag == 0의 경우, 셀 크기를 달리하는 영역이다. 

```let size = CGFloat(sender.value)```

로 선언하고, 이 후  layout의 itemSize가 CGSize(width: size, height: size)
value값에 따라 CGSize가 유동적으로 바뀌도록 한다. 
tag == 1 은 셀의 간격, tag == 2(else로 처리)는 외부 여백을 뜻한다. 

2-4. sectionInset은 섹션 안에 여백을 얼마나 줄 것인가. 에 대한 문제. 


그러면 ? 


![](/image/slider1.png)


여기까지는 나온다. 
그런데 Slider를 조절하려하면 팅긴다. 
그리고 Cell은 어디갔지? 할 수 있는데



우리,, 애초에 Cell을 안만들어 줬자냐,,, 😅🤪 !! 



Cell 만들러 고고 ! 


## 3. Cell 만들고 layout잡기 

셀을 호다닥 만든다. 

```swift
extension BasicCodeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    cell.backgroundColor = [.red, .green, .blue, .magenta, .gray, .cyan ].randomElement()
    return cell
  }
}

```
3-1. UICollectionViewDataSource에 numberOfItemsInSection와 cellForItemAt 코드 구성. 

3-2. itemCount = 100 이다. 

3-3. Cell의 backgroundColor는 베열중 랜덤으로 실행 되도록 .randomElement 이용. 

```swift
func setupCollectionView() {
let layout = UICollectionViewFlowLayout()
  layout.itemSize = CGSize(width: 60, height: 60)   // 기본값 (50, 50)
  layout.minimumInteritemSpacing = 10  // 기본값 10
  layout.minimumLineSpacing = 20   // 기본값 10
  layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // .zero


  collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
  collectionView.backgroundColor = .systemBackground
  collectionView.dataSource = self
  collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  view.addSubview(collectionView)

  //콜렉션뷰 오토레이아웃
  collectionView.translatesAutoresizingMaskIntoConstraints.toggle()
  NSLayoutConstraint.activate([
    collectionView.topAnchor.constraint(equalTo: controllerStackView.bottomAnchor, constant: 10),
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  ])


}
```

3-4.  CollercionView는 꼭 UICollectionViewFlowLayout을 지정해줘야만 한다. 

3-5.  CollercionView의 프레임은 위에 잡은 FlowLayout을 따르도록 한다. (collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)

3-6.  CollectionView의 register와 오토레이아웃도 잊지 않고 잡아준다. 



그러면 ? ? 



![](/image/collection12.png)


이렇게 나온다 ! 


슬라이더 값을 다르게 주면 ? 


![](/image/slider4.png)

이런식으로 조절가능 ! (셀크기를 제일 줄인 모습.) 




## 4. Slider Color지정 


그리고 애플문서를 참고해보니 silder에 custom Image나 여러 animation도 추가 할 수 있는 것 같다. 

그 중 간단해 보이는 색을 지정해보도록 하자 !!



🤨


```swift
let sliders = [sizeSlider, spacingSlider, edgeSlider]
   sliders.forEach {
     //$0.minimumTrackTintColor = .brown //왼
     //$0.maximumTrackTintColor = .yellow //오
     //$0.thumbTintColor = .black //버튼
     $0.addTarget(self, action: #selector(editLayout), for: .valueChanged)
   }
   
```

4-1. slider의 addTaget을 잡아준, forEach에서 색을 추가한다. (주석 처리된 곳.)
4-2. minimumTrackTintColor 왼쪽,  maximumTrackTintColor 오른쪽 , thumbTintColor 슬라이더 버튼 색을 담당한다. 


![](/image/slider6.png)


추가된 모습.. ㅋㅋ... 


아무리 기본으로 했다지만,, 색이 너무 안예쁘다..



## 5. (Bonus) NavigationBar에  scrollDirection추가하기. 


### NavigationItem 달기.


```swift
func setupNavigationItem() {
  let changDirection = UIBarButtonItem(
    barButtonSystemItem: .reply, target: self, action: #selector(changeCollectionViewDirection(_:))
  )
  navigationItem.rightBarButtonItems = [changDirection]
}
```



### scrollDirection

UIScrollView는 스크롤 방향을 얻는 방법
scrollDirection은 스크롤 방향에 대한 문의. 


```swift
@objc private func changeCollectionViewDirection(_ sender: Any) {
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let current = layout.scrollDirection
    layout.scrollDirection = current == .horizontal ? .vertical : .horizontal
  }
}

```

- current 버튼을 누를때마다, .horizontal 인경우, .vertical로 바뀌고, vertical은 horizontal로 체인지 됨. 




![](/image/slider7.png)



horizontal 로 변경된 모습 !! 





