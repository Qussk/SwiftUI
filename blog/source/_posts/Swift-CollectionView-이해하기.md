---
title: '[Swift]CollectionView 이해하기'
date: 2020-06-16 13:54:24
category: "ios"
tags:
- Swift
- CollectionView
thumbnail: /image/collection9.png
---



### collectionView와 layout 구조

![](/image/collec.png)


### collectionView 와 TableView 차이

![](/image/collec1.png)


### Flow Layout 와 Custom Layout 

![](/image/collec2.png)



## Collectionview 이해하기 



##  0. Cell 만들기.

![](/image/collection.png)


```swift
import UIKit

final class BasicStoryboardViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  
  let parkImages = ParkManager.imageNames(of: .nationalPark)
}


//MARK: -UICollectionViewDataSource

extension BasicStoryboardViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 3
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath)
    
    if let imageView = cell.contentView.subviews.first as? UIImageView {
      imageView.image = UIImage(named: parkImages[indexPath.item % parkImages.count])
      cell.layer.cornerRadius = cell.frame.width / 2
    }
    cell.backgroundColor = .green
    return cell
  }
}
```
1) TableVikew와 동일하게 numberOfItemsInSection, cellForItemAt 이용. (TableView는 CellForRowAt이다.) 


## 1. Cell등록 (SB와 연동)


![](/image/collection7.png)
1) iteme 올리기 

![](/image/collection8.png)

1) Cell의 identified 지정 


## 2.Cell Size(Collection View Flow Layout)


![](/image/collection2.png)

1) CellSize  변경 
2) 결과 
![](/image/collection1.png)


## 3.Cell margin(CollectionView - Section Insets)


![](/image/collection3.png)

1) top, bottom, left, right 에 margin 입력
2) 결과 

![](/image/collection4.png)



## 4. CollectionView(Layout) 방향

![](/image/collection5.png)

1) Vertical 은 가로, Horizontal은 세로.
2) 결과

![](/image/collection6.png)







이해를 돕기위해 스토리보드를 사용했고, 기본적인 요소는 이정도 인 듯 하다. 

Code로 직접 CollectionView를 짜고자 한다면 아래 링크를 참고하자. 

[[--> Code로 직접 구현하기.]]()


