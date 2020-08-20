---
title: '[Swift]Json파일 가져오기(with: decoder)'
date: 2020-07-12 02:45:28
category: "ios"
tags:
- Swift
- JSON
- Bundle
- Path
thumbnail: image/json.png
---

## JSON란?

- name: Value의 형태의 쌍을 이루는 콜렉션 타입(Dictionary)
- XML에 비해 기능이 적고 구조가 단순하여 파싱이 쉽고 빠르다.
- 적은 용량으로 저장가능
- 사람뿐 아니라, 기계가 분석하고 생성하는 것도 용이
- contents type --> application/json
- 기본 인코딩 UTF-8


[JSON 깊게 이해하기](https://github.com/Qussk/Swift-5/blob/master/JSON.md)




## JSON 실제


![](/image/json1.png)


위의 json 형식 파일을 데이터로 불러오는 경우. 


### 1.구조체 만들기
```swift

import UIKit

struct Cafe: Decodable {
  let title: String
  let description: String
  let location: Location
  let isFavorite: Bool

struct Location: Decodable {
  let address: String
  let lat: Double
  let lng: Double
  }
}
```
- Key이름과 실제 사용할 Key이름이 다를 경우, CodingKey를 사용(enum:열거형) 하지만, 현재 key값이 동일하므로 Decode만 해줘도 된답. 

### 2. 데이타 불러주기(해당 ViewController로 이동)

**Bundle이용하여 리소스 가져오기**
```swift
let path = Bundle.main.path(forResorce: "CafeList", ofType: "json")
```
- 리소스 : "CafeList", 데이터 타입 : "json" 

**URL이용**
```swift
lazy var url = URL(fileURLWithPath: path!)
```
- 새로만든 NSURL객체를 지정된 경로를 가진 파일 URL(let path)로 초기화하고 반환. (파일에서 바로 가져오므로 utf-8이용안함)

**Data try!**
```swift
lazy var data = try! Data(contentsOf: url)
```

**구조체 담을 변수선언 (타입: [Cafe], 값:빈배열)**
```swift
var cageData : [Cafe] = []
```

### 3.JSON가져오기

**JSONDecoder**
```swift
override func viewDidLoad() {
super.viewDidLoad()

   if let json = try? JSONDecoder().decode([Cafe].self, from: data) {
     print(json)
     //제이슨을 배열에 담아주기
    cafeData.append(contentsOf: json)
     
   }
 }
```
- data로부터, [Cafe].self(배열) decode하기
- 데이터 못 가져온 경우,  do ~cashe 이용하여 print(error)로 애러사항 확인 가능.
- 성공했다면 아래와 같은 값이 디버깅에 확인됨 
![](image/json3.png)




### 4. 데이터 불러오기(셋팅?)


**CollectionViewCell**
```swift
func configureCell(data: Cafe) {
  
  let title = data.title
  let description = data.description
  
  cafeImageView.image = UIImage(named: title)
  cafeTitle.text = title
  cafeComent.text = description
}
```
- data는 cafe라는 (타입/값)을 가진 Key임

**CollectionViewDataSource**
```swift
cell.configureCell(data: cafeData[indexPath.item])
```
- cellForItemAt에 CollectionViewCell에서 만들어준 configureCell 값 붙이기.



## 결과




![](/image/json2.png)





