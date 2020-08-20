---
title: '[Swift]UISearchController ?? searchController : searchBar'
date: 2020-07-12 02:46:00
category: "ios"
tags:
- Swift
- SeachBar
thumbnail: /image/seach.png
---


## navigationBar에 UISearchBar달기


![](/image/seach1.png)


위와 같은 그림처럼 navigationBar에 searchBar를 넣는 식으로 구현하고자 한다면 아래의 코드를 참고하자. (ios11부터 생긴듯?)


### 선언
```swift
let searchBar = UISearchBar()
```

### 코드
**navigationItem.titleView = searchBar**
```swift
func navigationBar(){
  //BarItem
   navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(seachButton))
   navigationItem.rightBarButtonItem?.tintColor = .darkGray
   
   //navi in searchBar
   navigationItem.titleView = searchBar
   
 }
 @objc private func seachButton(_ sender : UIButton){
   //print("search", searchBar.text! as Any)
   
   searchBar.becomeFirstResponder()
   
   //getAdress()
 }
```
### setUI
```swift
searchBar.sizeToFit()
```

- **navigationItem.titleView = seachBar** 를 보면, navigationItem의 **titleView**에 searchBar를 넣는 것을 확인 할 수 있다.  



navigationBar에 seachBar를 고정으로 달아 놓는 경우가 많아 seachBar는 이정도만 알고 있었는데... 😹


!!


하필 아래의 그림 처럼 구현해야할 일이 닥쳤다..


![](/image/seach4.png)


ㅎㅎ...


## UISearchBarController 이용하여 navigationBar하단에 searchBar달기. (witfh: 스크롤시 사라짐)


### 선언 
**UISearchController**
```swift
let searchBarController = UISearchController(searchResultsController: nil)
```
- searchResultsController를 nil값으로 주면, UISearchController 초기화 시, searchcontroller에게 검색중인 동일한 뷰를 사용하여 결과를 표시하도록 지시한다.

### 코드
**searchController**
```swift
func navigationBar(){
       
   navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(seachButton))
   navigationItem.rightBarButtonItem?.tintColor = .darkGray
   navigationItem.title = "Cafe Spot"
   navigationItem.searchController = searchBarController
 }
 @objc private func seachButton(_ sender : UIButton){

 }
 ```
 - 위의 titleView에 올린 것과 다르게, SearchController를 직접이용하여, navigationItem에 UISearchBarController를 불러왔다. 
 - 그런데 신기한 건, rightBarButtonItem(돋보기 모양버튼)과 navigationItem.title(타이틀)을 없애도,, SearchController는 네비게이션바 아래에 달린 모습이었다.. 훔.... 몬가 씹어 삼킬줄 알았는데
 - 그리고 스크롤에 따라 SearchBar가 알아서 사라지니 참고하도록 하자. 
 - 위에는 쓰이지 않았지만, UISearchController가 활성화되어있는 동안 다른 뷰 이동시 이동한 뷰에 searchBar가 화면에 남아있지 않도록 설정도 해주자. 
 
 
 
 [[참고링크]](https://devmjun.github.io/archive/SearchController)
