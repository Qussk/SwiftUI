---
title: '[Swift]스토리보드에서 AutoLayout이해하기'
date: 2020-05-15 20:22:12
category: "ios"
tags:
- Swift
- AutoLayout
- UIView
thumbnail: /image/auto-1.png
---

## Laying out a user interface


애플에서 지원하는 레이아웃에 대한 접근 방식은 총 3가지가 있다. 

```
[유저 인터페이스 구성을 위한 3가지 주요 접근 방식]
Frame 기반의 프로그래밍 방식
Autoresizing masks
Auto Layout
```
첫번째 **Frame 기반의 프로그래밍 방식**은 코드를 이용한 방식이다.

(Frame 기반의 프로그래밍 방식은 다음 포스트에서 할 계획이다.)


두번째 **Autoresizing masks**은 기본적으로 제공되는 레이아웃이라고 생각하면 되는데(만약 내가 작성한 코드나 직접 Auto Layout을 사용하게될 경우에는 translatesAutoresizingMaskIntoConstraints 값을 false로 지정해야만 한다.) Autoresizing masks에 대한 자세한 이해가 필요하다면, 아래의 링크에서 확인하길 바란다. 

[https://www.thecodedself.com/autoresizing-masks/](https://www.thecodedself.com/autoresizing-masks/)


그리고 세번째인 **Auto Layout** 은 스토리보드 상에서 레이아웃을 잡는 방식이다.

오늘은 스토리보드 상에서 레이아웃을 잡을 수 있는 기능인 오토레이아웃에 대해서 알아볼 것인데, 

들어가기 전에 가장 기본이 되는 Autoresizing의 구조를 한 번 훑고 지나가자. 


## Autoresizing 기본구조

스토리보드에서 UIView를 만들면 우측 사이즈 인스펙터 탭에 Autoresizing가 보이는 것을 시각적으로 확인할 수 있다. 

![이미지](/image/auto-3.png)

대충 이런 느낌인데, 빨간색 선이 곧 View의 저 좌측 꼭지점 부분을 가리킨다고 보면 된다. (서로 매칭하면서 생각하면 쉽다.)

![이미지](/image/auto-2.png)

이런식으로.. (그림과 함께 보면 더 쉽다..)

![이미지](/image/auto-1.png)

주의할 점은 꼭 필요한 부분만 빨간색 선이 나오도록 클릭해주는 것이다...(남발하면 작동안됨.. 컴퓨터가 어디를 기준으로 줘야하는지 모르는 상태가 되어버리니까.. 기준은 명확하게 !) 

그리고 만약 

![이미지](/image/auto-4.png)


이런 식으로 오른쪽에 기준을 준 뒤, 


![이미지](image/auto-5.png)


검정색 부분의 꼭지점을 잡고 왼쪽으로 드래그하면, 빨간색 부분인 오른쪽이 고정된 채로 노란 뷰가 줄어 듦을 알 수 있다. 


이와 같이 여러 방법으로 움직여보면 Autoresizing 어떤 방식으로 작동하는지 금방 알 수 있다. 

그리고 UIView의 인스팩터 탭에서는 Autoresizing뿐만아니라, 현재 뷰의 x축,y축,width(넓이),height(높이)에 대한 정보도 볼 수 있으니 참고하자! 


이제 Autoresizing에 대해 어느 정도 훑었으니, 본격적으로 Auto Layout 으로 들어가자.


## Auto Layout 이란?


**Auto Layout** 은 뷰에 주어진 제약조건에 따라 뷰의 크기와 위치를 동적으로 계산해 배치하는 것으로, 외부 또는 내부의 변화에 동적으로 반응하여 유저 인터페이스를 구성한다.


역시 말로 하면 잘모르겠으니 직접 보도록하자. 


## Auto Layout 활용

### Auto Layout tools


![](/image/autoMain-1.png)


오토레이아웃에 접근하기 위한 tools이다. 

왼쪽부터, 
```
Update Frames : 제약조건과 맞지 않는 뷰 위치 갱신.
Align : 정렬에 관한 제약사항 설정 
Pin : 간격, 크기, 비율 등에 대한 제약 조건 설정 
Resolve Autolayout Lssues : 오토레이아웃 관련 문제 해결 
Emned In : 컨테이너 뷰 / 뷰컨트롤러 추가 
```

일단 가장 많이 접하게 되는 것은 Pin부분이다. 일단 예제를 통해 익혀보자. 

## [Auto Layout 잡기]


### 값으로 직접 Layout잡기

![](/image/auto-11.png)


1-1. UIView를 하나 만들고, Pin을 클릭후 레이아웃의 왼쪽과 위쪽 값을 지정한다. 예제로 20씩 주자. 
(참고로 Auto Layout을 잡을 때는, **Constrain to margins**에 체크를 해제하도록한다. )

그리고 ** Add 2 Constraints를 클릭하여 내용을 적용한다.

~~??적용하게 되면 빨간줄이 뜰것이다... ??~~

빨간줄은 일단 '레이아웃에 문제있음' 정도로 이해하면 될 것 같다. 값이 비어있거나, 값이 맞지 않는 경우(해당 값이 보여진다.)에 빨간줄로 표현된다. 오토 레이아웃을 잡는 다는 것은, 이 것을 파란색 줄로 바꾸는 작업 이라고 생각하면 쉽다. (노란색 줄도 놉..)

그래서 현재의 상태는 레이아웃이 비어있는 값이 존재하므로, 비어있는 값을 마저 채워 줘야한다! 아래를 보자. 

1-2. 오른쪽과 아래값 지정하기. 

![](/image/auto-12.png)

1-1과 마찬가지로 오른쪽과 아래 값을 20씩주고 add를 적용하면, view의 레이아웃이 정상적으로 잡힌 것을 볼 수 있다. (모두 파란줄!!!)

이 처럼 해당 view에 대한 값을 '완전하고도 명확하게, 지정해주어야 뷰가 어떤 상황에서든 움직이지않고, 안전한 인터페이스를 제공할 수 있게 된다. 


1-3. width와 height로 레이아웃 잡기. 

1-2처럼 모든 테두리에 값을 지정하는 방법도 있지만, 해당 view의 넓이와 높이의 값을 알고 있다면, width와 height로도 지정해 줄 수 있다. 


![](/image/auto-14.png)

이런 식으로...  width은 300, height는 500을 줬다. 


![](/image/auto-15.png)


적용된 모습.



### Add Missing Constraints으로 Layout 잡기 

다른 방법도 한가지 있는데, 위처럼 레이아웃을 일일히 지정할 필요 없이 먼저 UI를 짠 후, 그 값에 맞춰 모두 레이아웃이 잡히는 기능을 한다.
예를 들면,

![](/image/aytoadd-1.png)

2-1. 뷰를 선택후 아래 세모 모양(Resolve Autolayout Lssues)을 선택 후 'Add Missing Constraints' 클릭

그러면? 모두 정상적인 파란줄의 레이아웃으로 잘 잡히게 된다.  


2-2. 재지정?(바꾸고 싶엉!)


![](/image/aytoadd-2.png)


만약 뷰를 움직이고, 움직인 뒤의 UI로 레이아웃을 재지정 하고 싶은 경우.  다시 뷰를 선택후 아래 세모 모양(Resolve Autolayout Lssues)을 선택하면 'Update Constranit Constants' 를 확인 할 수 있다. 

현재 뷰가 이동한 자리로 레이아웃을 다시 업데이트 해준다는 뜻이다. 

클릭하면? 


![](/image/aytoadd-3.png)

지울 필요없이 자동적으로 레이아웃이 재설정 되는 모습. 


하지만, 사실? 눈대중으로 하는 것이 그렇게 명확하진 않아서? 보통 일일히 지정하는 법을 선호한다. 
(어디까지나 명확하고 정확한 UI를 위해)


### Align Tool 으로 잡기



![이미지](/image/autoMain-2.png)


Align Tool 중, 

제일 자주 사용하는 것이 아래 2개 "Horizontally in Container", "Verically in Container"인데, 이는 center값을 기준으로 둔 선의 중앙값으로 이를 배치하겠다는 뜻이 된다.  클릭해보면 손 쉽게, 중앙 값으로, 혹은 중앙값을 기준으로 변경되는 모습을 확인 할 수 있다. 



## [Auto Layout 값 수정]


아마 레이아웃을 처음 접해보았다면 뭔가 아주많이? 꼬였을 것이다.  

~~빨간줄 범벅~~

특히, 값을 변경하고 싶은데 값이 적용은 안되고,, 줄만 줄줄히 늘어나는 현상.. 


![](/image/auto-13.png) 


1-1. Pin은 어디까지나 새로 만들어지는 레이아웃에 대해서 제공되는 것이니, 값을 수정하고 싶다면 따로 우측 인스펙터 부분에서 이를 변경 해야한다. 

1-2. 변경할 레이아웃을 선택하고 Edit를 클릭하여 값을 변경하면 뷰 컨트롤러에 적용되는 모습을 확인할 수 있다. 


그리고 아예 없애거나, 지우고 싶다면?



## [Auto Layout 취소, 지우기]


![](/image/auto-16.png) 


1-1.레이아웃 선을 선택해서 키보드의 지움 버튼(<-)으로 지우거나, 우측 인스펙터 부분을 클릭 후 지움(<-)해주면 지워진다. 

~~애플의 이런 심플함은 가끔 경이롭기까지 하다...~~



1-2. 레이아웃을 모두 지우는 것도 지원한다. 

![](/image/auto-17.png) 


뷰를 선택후 아래 세모 모양(Resolve Autolayout Lssues)을 클릭하면, Clear Constraints를 확인 할 수 있다. 
누르면? 뷰에 해당하는 모든 레이아웃이 지워진다. 




## [Auto Layout Attributes]


![이미지](/image/autoMain-3.png)


레이아웃을 짤때 속성을 기억해주면 좋다. 

레이아웃의 지도와 같은 것! 



## [Anatomy of a Constraint]


![이미지](/image/autoMain-4.png)

이것도 구조를 이해하는 것이 좋다. (코드짤 때 도움) 




## [Safe Area와 View의 차이]


![이미지](/image/auto-6.png)

⬆︎ Sadfe Area는 파란색 영역에 해당한다. (기기에서의 시계, 베터리, 하위 영역을 제외한 직사각형 영역)

![이미지](/image/auto-7.png)

⬆︎ View의 영역 (기기의 모든 전체영역)


기준을 어디에 두느냐에 따라 레이아웃의 값도 달라지니 꼭 참고하여야할 부분이다. 

![이미지](/image/auto-7.png)

Pin에서도 지정할 수있도록 지원되어 있다. 


//iphone8 (20.0,0,0)
//iphineX (44,0,34,0)



## [Frame과 Auto Layout]


![이미지](/image/autoMain.png)


이미지를 살펴보면 Auto Layout이 지원되는 방식을 알 수 있다. 
Frame과 Auto Layout 모두 x,y축을 기본값으로 하지만, 왼쪽 이미지인 Frame은 좌표를 중점으로 두고 있다면, Auto Layout은 view사이의 상대적인 값에 중점을 두는 모습을 볼 수 있다. 

그래서, 레이아웃 값을 지정할때, 첫번째 뷰를 먼저 잡고, 이와 가장 근접해 있는 뷰>근접 뷰> 근접 뷰> 근접 뷰>...이런 방식으로 레이아웃을 잡아가는 게 좋다. 



### 실전 예제 [Auto Layou]

아래의 것을 오토레이 아웃을 이용하여 잡기 

![](/image/autosample.png)



1-1. 일단 view를 2개 얹고 시작. 

![](/image/autosample-1.png)

오토레이아웃을 이해했다면, 위 화면 정도는 금방 구현해낼 것이다. 하지만, 여기서 문제가 있다. 화면을 아래와 같이 돌리게 되면 ? 


![](/image/autosample-4.png)

이런 식으로 레이아웃이 깨지는 현상을 볼 수 있다. 이것도 기기의 비율에 맞춰 나올 수 있도록 하려면 ?


1-2 . Equal Width,  Equal Height 활용하기. 

![](/image/autosample-2.png)

레이아웃에 대한 비율을 맞추려면, control키를 누른채 드래그 하여 buleView에서 redView를 잇고 놓으면 위와 같은 목록이 뜬다.여기서 Equal Width,  Equal Height 을 통해 이전 뷰에 대한 비율 맞추기가 가능하다! 

그리고 클릭에서 끝나는게 아니라 우측 탭에서 "Proportional Width(Height) to view"를 확인할 수 있는 데, 꼭 Edit을 눌러서 비율을 '1'로 맞추도록한다. 1:1 비율로 해야하니깐(수치를 다르게 하면서 확인해보도록)


그러면 ?


![](/image/autosample-3.png)


가로방향으로 시뮬을 돌려도 레이아웃이 깨지지 않는 모습을 확인할 수 있다. 




### 실전 예제 [frame]


frame 방식도 위의 실전예제와 동일한 예제로 구현해보자. 


```swift
import UIKit

class safeViewController: UIViewController {

  let view1 = UIView()
  let view2 = UIView()

  //super.view.adgeAreaInsets
  
  override func viewDidLoad() {
        super.viewDidLoad()

      view1.backgroundColor = .red
      view.addSubview(view1)
  
  
       view2.backgroundColor = .blue
       view.addSubview(view2)
  
  }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("view.viewWillAppear")
  }
  
  
  override func viewWillLayoutSubviews() { //뷰의 크기가 바뀌었을때, 위치를 바꿔주는 역할. (이곳에 쓰는게 정확.
     super.viewWillLayoutSubviews()
    
    let margin: CGFloat = 20
       let padding: CGFloat = 10
       let safeLayoutInset = view.safeAreaInsets
       let horizontalInset = safeLayoutInset.left + safeLayoutInset.right
       
       let yOffset = safeLayoutInset.top + margin
       let viewWidth = (view.frame.width - padding - horizontalInset) / 2 - margin
       
       
       view1.frame = CGRect(x: safeLayoutInset.left + margin, y: yOffset, width: viewWidth, height: view.bounds.height - yOffset - (safeLayoutInset.bottom + margin))
      
       
       view2.frame = CGRect(
         origin : CGPoint(x: view1.frame.maxX + padding, y: yOffset),
         size: view1.bounds.size) //frame넣든, bounds넣든 관계없음.
       
  }
  
  override func viewSafeAreaInsetsDidChange() { //세이프에어리얼과 인셋을 바꿔주는 시점을 알려주는 역할. //safeArea(세이프 영역)
    super.viewSafeAreaInsetsDidChange()
    print(view.safeAreaInsets)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDisAppear")
  }
  
  
}
```

위 코드는 스토리보드 방식이 아닌, frame 방식을 이용하여 화면을 구현한 것이다. 
frame을 이용했다면, 레이아웃을 굳이 잡지 않아도 된다. 

다만, 사실 코드로 레이아웃을 잡는 방법은 아주 다양하고 , 
레이아웃의 순번을 통해 UI를 잡거나 하는, (프레임만으로는 표현할 수 없다.) 법을 사용해야할 수도 있다.  

그래서 frame 외, 오토레이아웃 외에도 코드로 레이아웃을 잡는 방법은 아래를 참고하자 

[링크 준비중]

(심화부분일 수 있는데 익순해지면 간단해진다.)


어쨌든 이번 포스트에서는 오토레이아웃이지만, 생각보다 손을 많이 대줘야하는?? 오토레이 아웃ㅋㅋ이지만,


완전하고 안전성있는 UI를 위한 방법이니 

꼭 참고하여 앱을 만들자 ! 

🙀

