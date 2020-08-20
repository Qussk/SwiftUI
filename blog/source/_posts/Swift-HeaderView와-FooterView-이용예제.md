---
title: '[Swift]HeaderView와 FooterView 이용예제'
date: 2020-06-20 18:17:38
category: "ios"
tags:
- Swift
- HeaderView
- FooterView
- CollectionView
thumbnail: /image/header.png
---



오늘은 해더뷰와 푸터뷰 이용예제에 대해 알아보자 ! 


구현사항 
```
 [ 문제 ]
 셀 크기 = (80, 80) / 아이템과 라인 간격 = 4 / 인셋 = (25, 5, 25, 5)
 헤더 높이 50, 푸터 높이 3
```

CollectionView와, 레이아웃 잡는 것, CollectionCell 크기 inset값 등은 생략 !

맨 아래 전체코드로 확인하기 ! 

# HeaderView적용 (with:CollectionView)

## 1. SectionHeaderView class만들기

```swift
import UIKit


final class SectionHeaderView: UICollectionReusableView {
  static let identifier = "SectionHeaderView"
  private let titleLabel = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  
  private func setupView() {
    titleLabel.textColor = .darkText
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
  
  
  // MARK: Configure
  
  func configure(title: String) {
    titleLabel.text = title
  }
}

```
1-1. 일단, 헤더뷰든 푸터뷰든 UICollectionReusableView를 만들어야한다. 헤더뷰에 대한 swift파일을 하나 만들어 class만들기. 
```
class SectionHeaderView: UICollectionReusableView {
```
 
1-2. 헤더뷰의 identifier이름과, 헤더뷰에 들어갈 titleLable을 선언. 
```swift
static let identifier = "SectionHeaderView"
 private let titleLabel = UILabel()
 ```
 1-3.  override init 부분은 titleLable의 frame에 대한 함수호출.
 ```swift
 override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
```


## 2. layout 

HeaderView 에 대한 설정은 끝났고, 메인 viewController로 돌아와, 
컬렉션뷰 레이아웃 잡는 위치(레이아웃을 리턴하는 곳. return layout )에 해더뷰의 레이아웃도 함께 지정해준다. 헤더뷰는 어쨌든 컬렉션뷰 위에 놓는 거니까.. 


2-1 헤더뷰 레이아웃 

```swift
layout.headerReferenceSize = CGSize(width: 50, height: 50)
```

2-2. 스크롤중 해당 해더뷰의 섹션값과 가까워질 때, 헤더뷰가 투명해지는 옵션 ! 

```swift
layout.sectionHeadersPinToVisibleBounds = true
```

2-3. 리턴 
```swift 
return layout
```


## 3. register 지정 

3-1. collectionView의 register를 지정했던 곳 아래에 register을 지정해준다. 

```swift

collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

```
3-2. 첫번째, 해더뷰의 이름을 줄러준다. SectionHeaderView.self(1-2부분 참고.) 두번째, UICollectionView.elementKindSectionHeader, (UICollectionView에 elementKindSectionHeader을 둔다는 뜻. 아래 5-1부분 참고.) 세번째, withReuseIdentifier: SectionHeaderView.identifier. identifier 이름 넣기. 


## 4. numberOfSections 지정. 

4-1. 알다시피, 우리는 collectionView 위에 헤더뷰를 놓는 거니까, UICollectionViewDataSource 부분에 numberOfSections(섹션 갯수)함수를 불러 지정. 
(collectionView의 numberOfItemsInSection과 다르다 !!!!😡 )

```swift

// MARK: - UICollectionViewDataSource

extension SupplementaryViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    sections.count
  }
  
```

4-2.  sections.count는 아래의 데이터 부분을 참고하자. 


![](/image/header3.png)


대충 이해가 가죠??



## 5. header을 리턴.. 

**집중!** 

5-1. UICollectionReusableView를 리턴하는 함수가 있다! 

**viewForSupplementaryElementOfKind**

헤더뷰와 푸터뷰를 리턴할 때 모두 사용.


```swift
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

  let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
  
  header.configure(title: "sections:\(indexPath.section + 1)")
  
  return header
  ```

5-2. cellforrowitem에서 하는 것처럼 비슷하게 타입캐스팅 해주면 된다. ofKind는 kind 넣어주고, withReuseIdentifier는 해더뷰의 Identifier이름. 
5-3.  header.configure(title: "sections:\(indexPath.section + 1)")은 indexPath.section만 할경우 섹션 0 부터 시작하므로, 1부터 시작하기 위해 +1해줬다. 


그러면. ? 해더뷰에 대한 **할일**은 모두 했으니 빌드해보자.,,


![](/image/header1.png) 짠... 

아래로 내리면...? 

![](/image/header2.png)  

2-2 에서 적용했던 layout.sectionHeadersPinToVisibleBounds = true 으로 투명해지는 모습까지 확인할 수 있다. 🤤


해더 뷰를 끝냈으니, 빨간색 점선의 FooterView도 적용해 보자! 



# FooterView적용 (with:CollectionView)

사실, 과정은 headerview와 거의 동일하다 ㅋㅋ 

위를 참고하며 보기 !


## Class SectionFooterView


```swift

import UIKit


class SectionFoorterView: UICollectionReusableView {
 
  static let identifire = "SectionFoorterView"
  let foorterLable = UILabel()
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   setupView()
 
  }
 
  func setupView() {
    
    foorterLable.backgroundColor = .systemGray
    foorterLable.textColor = .black
    foorterLable.textAlignment = .right
   // foorterLable.font = UIFont.boldSystemFont(ofSize: 17)
    addSubview(foorterLable)
    
    
    
    foorterLable.translatesAutoresizingMaskIntoConstraints = false
    foorterLable.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    foorterLable.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    foorterLable.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    foorterLable.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    
    
  }
  func configure(title: String) {
    foorterLable.text = title
  }
  
  
}


```


