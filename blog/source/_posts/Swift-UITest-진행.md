---
title: '[Swift]UITest 진행'
date: 2020-08-12 16:12:49
category: "ios"
tags:
- Swift
- UITest
thumbnail:
---


나중에 다듬으기루..

## 시작하기

![](/image/uitest1.png)

하단의 **+** 버튼을 누른다. 


![](/image/uitest.png)

**UI Testing Bundle** 을 생성한다.  상단에 test로 검색하면 빠르게 찾을 수 있다. 



![](/image/uitest3.png)

**프로젝트명+Test.Swift**이 생성된다. 들어가면 테스트 할 수 있는 에딧창이 뜬다. 

넘버라인쪽에 다이아몬드모양을 누르면 해당 메소드가 실행된다. 아랫것을 누르게 되면 위에서 부터 아래로 순차적으로 실행된다. 


단축키는 cmd + U 로 자동실행 할 수 있다. 


![](/image/uitest2.png)

테스트가 성공적이면 이런 화면이 뜬다. 

아래 녹화를 누르면 tap()한 순서에 따라 코드가 자동적으로 작성된다. 




## 실행 

XCUIApplication의 경우

accessibilityIdentifier로 식별.



**UITableView**

예시)
```
let firstCell = app.tables.cells.staticTexts["WWDC보기"]
```
- 셀에 직접 접근
- .tap() 을 주면 클릭됨 

```
 if firstCell.waitForExistence(timeout: 1){//if addButton.isHittable
}
```
- 시간차 주면서 버튼으로 옮김

```
self.app.tables.cells.element(boundBy: 0).tap()
```
- 엘리먼트로 접근가능. 


### XCUIElement

- tap()
- dubleTap
- Press
- swipeUp/Down/Left/Right
- typeText

**잠자기**
```
sleep(1)
```

**비동기작업**
```
XCTAssertTrue(self.userlist.count)
```


**TextView, TextField의 경우**

```
let textView = app.textViews["textView"]
textView.tap() //텍스뷰하기전에 꼭 탭을 해야함. 필드도 마찬가지

textView.typeText("안녕하세요")//키보드올리기 귀찮을때 이렇게 써서 테스트해볼수 있다.
```
//Recording UI Test


### 주의사항

- 중복 코드가 있는 경우
- 코드가 구현되어 있지 않은 경우


### XCUIElementQuery

- staticTexts
- firstMatch
- element(boundBy:)
- waitForExistence


### Assertion Method

XCTAssertTrue(true)
XCTAssertFalse(false)
XCTAssertNil(true)
XCTAssertNotNil(true)
XCTAssertEqual(true, true)


### isHittable
- 화면이 존재하고 클릭가능한지의 여부

### exists
- 화면이 존재하는지 여부 


