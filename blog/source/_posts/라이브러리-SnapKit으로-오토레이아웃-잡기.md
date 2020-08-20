---
title: '[라이브러리]SnapKit으로 오토레이아웃 잡기'
date: 2020-07-09 17:48:46
category: "Library"
tags:
- Swift
- 라이브러리
- SnapKit
thumbnail: image/snapkit2.png
---


### SnapKit 링크
[](https://cocoapods.org/pods/SnapKit)


## SnapKit 사용

**[snapKit]**

- makeConstraints - 최초 제약설정
- updateConstraint -이미 설정한 특정 값을 다른 것으로 바꿀 때
- remakeConstraints - 기존의 연결을 모두 제거하고 완전히 새로 설정

아래 코드는 makeConstraints를 바탕으로 짰다. 

```swift
//snp - 스냅킷
func makeConstraints() {//makeConstraints오토레이아웃을 잡겠다.
    squareView.snp.makeConstraints {
    $0.centerX.equalToSuperview()
    $0.centerY.equalToSuperview().offset(40)
    $0.width.equalToSuperview().multipliedBy(0.7)
    $0.height.equalToSuperview().multipliedBy(0.4)
  }
  topView.snp.makeConstraints{
    $0.leading.trailing.top.equalToSuperview().inset(20)
  }
  bottomView.snp.makeConstraints{
    $0.top.equalTo(topView.snp.bottom)
    $0.height.equalTo(topView)
    $0.leading.bottom.trailing.equalToSuperview().inset(20)
  }
  
  topLabel.snp.makeConstraints{
    $0.edges.equalToSuperview()
  }
  bottomLabel.snp.makeConstraints{
  //  $0.width.height.equalTo(topLabel) 아래와 동일
    $0.size.equalTo(topLabel)
    $0.leading.bottom.equalToSuperview()
  }
  bottomCircleView.snp.makeConstraints{
    $0.top.equalTo(squareView.snp.bottom)
    $0.centerX.equalTo(squareView)
    $0.width.height.equalTo(squareView.snp.width).dividedBy(2)
  }
}
```

![](/image/snapkit1.png)



## SnapKit을 이용하여 로그인화면 만들기


![](/image/snapkit.png)

위 화면을 만들어보자 !!


```swift

import UIKit
import SnapKit

final class FloatingLabelViewController: UIViewController {

  let containView = UIView()
  let idTextfield = UITextField()
  let pwTextfield = UITextField()
  let loginButton = UIButton()
  let signUpButton = UIButton()
  let naverUpButton = UIButton()
  let naverLogoImage = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    setupView()
    makeConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    containView.alpha = 0
    viewAni()
  }

  func setupView(){
    
    containView.backgroundColor = .white
    view.addSubview(containView)
    
    idTextfield.backgroundColor = .white
    idTextfield.placeholder
      = "아이디를 입력해주세요."
    containView.addSubview(idTextfield)
    
    pwTextfield.backgroundColor = .white
    pwTextfield.isSecureTextEntry = true
    pwTextfield.placeholder
    = "비밀번호를 입력해주세요."
    containView.addSubview(pwTextfield)
    
    loginButton.backgroundColor = .systemGray
    loginButton.setTitle("로그인", for: .normal)
    loginButton.setTitleColor(.white, for: .normal)
    //loginButton.layer.cornerRadius = 8
    containView.addSubview(loginButton)
    
    signUpButton.backgroundColor = .systemBlue
    signUpButton.setTitle("회원가입", for: .normal)
    signUpButton.setTitleColor(.white, for: .normal)
    containView.addSubview(signUpButton)
    
    naverUpButton.backgroundColor = .systemGreen
    naverUpButton.setTitle("네이버 로그인", for: .normal)
    naverUpButton.setTitleColor(.white, for: .normal)
    containView.addSubview(naverUpButton)
    
    naverLogoImage.image = UIImage(named: "naver")
    containView.addSubview(naverLogoImage)
    
    self.containView.layer.shadowColor = UIColor.black.cgColor // 검정색 사용
    self.containView.layer.masksToBounds = false
    self.containView.layer.shadowOffset = CGSize(width: 0, height: 4) // 반경에 대해서 너무 적용이 되어서 4point 정도 내림.
    self.containView.layer.shadowRadius = 8 // 반경?
    self.containView.layer.shadowOpacity = 0.3
  }

  func makeConstraints(){
    containView.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.9)
      $0.height.equalToSuperview().multipliedBy(0.3)
    }
    
    idTextfield.snp.makeConstraints{
      $0.leading.top.equalToSuperview().inset(20)
      $0.bottom.equalTo(pwTextfield.snp.top).inset(-10)
      $0.trailing.equalToSuperview().inset(100)
      $0.height.equalTo(pwTextfield.snp.height)
    }
    loginButton.snp.makeConstraints{
      $0.leading.equalTo(idTextfield.snp.trailing).inset(-10)
      $0.top.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(signUpButton.snp.top).inset(-10)
    }
    pwTextfield.snp.makeConstraints{
      $0.top.equalTo(idTextfield.snp.bottom).inset(-8)
      $0.leading.equalToSuperview().inset(20)
      $0.bottom.equalTo(signUpButton.snp.top).inset(-10)
      $0.trailing.equalToSuperview().inset(100)
    }
    signUpButton.snp.makeConstraints{
      $0.top.equalTo(pwTextfield.snp.bottom).inset(-10)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalToSuperview().multipliedBy(0.2)
    }
    naverUpButton.snp.makeConstraints{
      $0.top.equalTo(signUpButton.snp.bottom).inset(-10)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalToSuperview().multipliedBy(0.2)
      $0.bottom.equalToSuperview().inset(20)
    }
    naverLogoImage.snp.makeConstraints{
      $0.top.bottom.equalTo(naverUpButton).inset(10)
      $0.leading.equalTo(naverUpButton.snp.leading).inset(40)
      $0.trailing.equalTo(naverUpButton.snp.trailing).inset(225)
    }
  }
  
  func viewAni(){
    UIView.animate(withDuration: 1){
      self.containView.alpha = 1
    
    }
  }
}

```

- viewDidAppear에 alpha 값을 주어 좀더 있어 보이게 했다. ㅋ

아래 링크 확인

[[동영상보기]](https://youtu.be/ML0afiexlTQ)



😸


