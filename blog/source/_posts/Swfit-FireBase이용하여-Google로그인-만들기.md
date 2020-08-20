---
title: '[Swfit]FireBase이용하여 Google로그인 만들기'
date: 2020-08-04 04:09:11
category: "ios"
tags:
- Swift
- FireBase
- GoogleLogin
thumbnail: /image/fire.png
---


해당 앱에 

구글아이디로 로그인 할 수 있도록 구현해보자 


## 0. 사전 학습

![](/image/google3.png)

Firebase 프로젝트를 만드는 과정에서 googleServicce를 받게 되는 데, 그것을 프로젝트로 옮긴 후 REVERSED_CLIENT_ID의 주소를 복사하여 아래의 url schemes에 붙여준다. 

![](/image/google5.png)

붙인 모습. 그럼 파이어베이스를 시작해보자. 



## 1. FireBase - cocoapod에 init, install

```swift
pod init
```
1-1. cocoapod에 해당 프로젝트 경로로 간 후,  pod init 한다. 
```swift
pod 'GoogleSignIn'
```
1-2. **Podfile**가 만들어지면, Podfile을 열어서 위 코드를 추가한다. 

```swift
pod install
```
1-3. pod install로 변경사항 저장. 

(간단간단..)


## 2. AppDelegate

```swift

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupKeyWindow()
    
    return true
  }
  
  //1
  @available(iOS 9.0, *)
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
  }
  //2
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
  //3
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    // ...
    if let error = error {
      // ...
      return
    }
    
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                   accessToken: authentication.accessToken)
                                            
                                                                
   //로그아웃 호출 추가(나중에)
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
  
  func setupKeyWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    
    FirebaseApp.configure()
    
    //4
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
  }
  
}

```
2-0. Firebase와 GoogleSignIn을 import한다.
2-1. **FirebaseApp.configure()** 는 초기화를 위한 필수 적인 메소드
2-2. **GIDSignInDelegate** 만 있어도 된다.(추가하는 것 잊지 않기)
2-3. 순서대로 쭉 붙여넣기 한다. 



2-4. (주의)3부분에 아래에 **//파이어베이스로 넘겨주는 부분**의 코드도 추가해야한다.  이걸 추가 안했더니.. 로그인은 된것처럼 보이는데, 아이디(메일주소) print해봤을때 nil값이 나오더라 ;;;;;...  늦게라도 발견해서 다행..

```swift
func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
guard error == nil else {
  if let error = error {
    print("구글로그인에 실패함 \(user)")
  }
  return
}


guard let authentication = user.authentication else { return }
let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                               accessToken: authentication.accessToken)

//파이어베이스로 넘겨주는 부분
Auth.auth().signIn(with: credential) {(user, error) in
  if let error = error {
    return
  }
}

```

## 3. ViewController


```swift

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,GIDSignInDelegate {

override func viewDidLoad() {
super.viewDidLoad()

GIDSignIn.sharedInstance()?.presentingViewController = self
GIDSignIn.sharedInstance().signIn() //회원가입 신청하는 코드
}
```
3-1. viewDidLoad에 위 2줄을 추가한다. 
3-2. 회원가입 신청하는 코드는 앞으로 구현될 "구글로그인" Buttond의 Action에 옮겨적는다. ~~위에 것은 지우고~~

```swift

 //Google Login
func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
  if let error = error {
    return
  }
  guard let authentication = user.authentication else { return }
  let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                    accessToken: authentication.accessToken)
}

```
3-3. 위 코드는 GIDSignInDelegate에 대한 프로토콜


## 4.View(Button이 위치하는 곳)

여기서 선택사항이 있는데, Google이 로그인버튼 이미지를 ```GIDSignInButton```라는 이름으로 지원을 해준다. 

```swift 
let googleButton = GIDSignInButton()
```
~~그런데 직접 커스텀 하기를 추천...(안이쁨)~~

커스텀은 그냥 일반적으로 Button을 만들고 setBackgroundImage로 원하는 이미지로 로고를 주면 된다. 


```swift
import UIKit
import Firebase
import GoogleSignIn

class LoginView : UIView{
  
  //let googleButton = GIDSignInButton()
  let googleButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
    setUI()
    constrain()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func commonInit(){
    let viewXib = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)![0] as! UIView
    viewXib.frame = self.bounds
    viewXib.backgroundColor = .white
    viewXib.layer.cornerRadius = 20
    addSubview(viewXib)
    
  }
  
  func setUI(){
    
    googleButton.setBackgroundImage(UIImage(named: "dd"), for: .normal)
    googleButton.addTarget(self, action: #selector(googleLoginAction(_ :)), for: .touchUpInside)
    addSubview(googleButton)
  }
  
  
  @objc func googleLoginAction(_ sender: UIButton){
   
    GIDSignIn.sharedInstance().signIn() //회원가입 신청하는 코드
  }
  
  
  func constrain(){
    googleButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      googleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      googleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      googleButton.widthAnchor.constraint(equalToConstant: 47),
      googleButton.heightAnchor.constraint(equalToConstant: 47)
    ])
  
  }
}
```
4-1. 현재 Xib로 실험해 볼게 많아서 XiBView위에 버튼을 올린 꼴이라 헷깔릴 수도 있는데, 굳이 그것만 빼고 버튼 부분만 보시면 이해가 될거다..
4-2. ButtonAction부분으로 회원가입 신청하는 코드를 가져왔다. 



그리고 빌드해보면 아래와 같은 화면을 확인할 수 있다 !


![](/image/google0.png)




~~첫번째 화면의 버튼은 내가 비추천 했던 구글 디폴트 버튼이미지(**GIDSignInButton**)이다.... ㅎㅎ~~

보고 선택.. 





![](/image/google4.png)

엿튼, 위의 모든 과정을 마치게 되면, 

firebase에 Authentication에 '이메일/비밀번호'와 '구글'에 사용설정 됨을 확인 할 수 있다. 


firebase에 google로그인에 대한 공식가이드가 있으니 아래도 참고해보고 도움되길 바란다! 




[참고 :https://firebase.google.com/docs/auth/ios/google-signin?hl=ko#swift_5](https://firebase.google.com/docs/auth/ios/google-signin?hl=ko#swift_5)  
