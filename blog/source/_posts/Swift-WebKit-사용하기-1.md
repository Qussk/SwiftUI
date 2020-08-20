---
title: '[Swift}WebKit 사용하기'
date: 2020-06-07 14:18:36
category: "ios"
tags:
- Swift
- Webkit
- WKWebView
thumbnail: /image/webview1.png
---


## 사용예제

###  1. Webkit 임포트, url 지정

```
import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
```

- let myURL = URL(string:"불러올 페이지 url주소") 
- myRequest는 myURL를 URLRequest로 변경한다.
- 웹뷰 로드.


일단 나는 요즘 1일1깡을 하기 위해 깡을 불러와봤다. 


![](/image/webview.png)



혹시 안되시는 분들은 권한설정도 확인해보자 (아래의 것이 수행되어야 웹킷을 사용할 수 있다.)



### 2. 권한설정 


![](/image/webview2.png)

- 2-1. Webkit framework가져오기 (패키지 가져오는 것이라 생각 .h로 구성되어있음)


![](/image/webview3.png)

- 2-2. 사용자 인터넷연결 허용하기(info.plist에 들어가 권한설정.) 
- Information Property List 에 (+)추가하여 "App Transport Security Settings" 항목 만든후 아래 하위 목록으로 "Allow Arbitrary Loads" 생성 - Value는 대문자 "YES"로 지정 




### 이 후 

- webkit을 불러오는 건 쉬운데, 그것으로 끝나는게 아니라, 이게 시작이다 ㅋㅋ.
- 무슨말이냐 하면, 결국 webview를 사용자가 편리하게 이요하기 위해선, back버튼이라던가, 새로고침, 뷰크기설정등, 다양한 인터페이스를 제공하려면,  WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler등을 통해 결국 조작을 해줘야한다는 것이다.
(이에 대한 내용은, [Swift}WebKit 사용하기-2'에 다뤄볼 생각이다. )




 여기서 내가 원하는 것은 

- 깡 자동재생
- 재생시 풀화면 중단 
- 유튜브처럼 내리는 제스처 이용시 영상이 작은뷰로 생성되면서 아래로 내려감.
- 플로팅 버튼 생성(버튼 누르면 my캘린더에 +1깡씩 )


### 나의 현재코드 

```swift
import UIKit
import WebKit

class WebViewController: UIViewController {

  
  
  var webView: WKWebView!
  
  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    view = webView
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    
    loadUrl()
  }
  
  
  func loadUrl() {
    let myURL = URL(string:"https://m.youtube.com/watch?v=xqFvYsy4wE4")
    let myRequest = URLRequest(url: myURL!)
    
    webView.configuration.allowsInlineMediaPlayback = true
  //  webView.allowsInlineMediaPlayback = YES
    webView.load(myRequest)
   }
  
  }
  ````

어제 밤을 새서 오늘 낮인데도 졸리다..
