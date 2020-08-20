---
title: '[Swift]UIImagePickerController 이해하기'
date: 2020-06-02 14:14:50
category: "ios"
tags:
- Swift
- ImagePicker
- UIImagePickerController 
thumbnail: /image/pikermain.png
---




## 사전작업 

### UIImagePickerController

-  ```let imagePiker = UIImagePickerController()``` 로도 쓸 수 있지만, 뷰디드로드로 하기엔 delegate =.self 선언 할 것이 한개 밖에 없을 때. lazy를 이용하여 간편하게 코드를 짤 수도 있다. 아래 코으 참고.(delegate와 UIImagePickerController선언 함께 사용하기)

```swift
import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
  
  private lazy var imagePicker: UIImagePickerController = {
  let imagePiker = UIImagePickerController()
    imagePiker.delegate = self
    return imagePiker
}()
```

## 실습 들어가기

## 1. 앨범
### 1-1. 앨범 타입 지정
- imagePicker.sourceType

```swift
//1.앨범
@IBAction private func pickImage(_ sender: Any) {
   
    imagePicker.sourceType = .photoLibrary //포토라이브러리는 앨범선택하는 화면 보여줌.
  //imagePicker.sourceType = .savedPhotosAlbum //최근에 찍은 사진 위주로 보여줌.
   present(imagePicker, animated:  true)
 }
```

![](/image/piker1.png)


### 1-2. 앨범 DidCancel 및  didFinishPickingMediaWithInfo. 

- UIImagePickerControllerDelegate 이용, 네비게이션 바 이용하는 경우, UINavigationControllerDelegate 함께 필요.
- imagePickerControllerDidCancel 와 didFinishPickingMediaWithInfo중 쓰임새에 따라 선택하여 사용. 
- dismiss는 필수인데, picker.presentingViewController?.dismiss(animated: true) 나, dismiss(animated: true)중에서 택하여 사용 


```swift
//MARK:- UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {


//닫기만 할 때는 생략가능. 창 캔슬시 기록이나 설정 필요한 경우 사용.
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//  picker.presentingViewController?.dismiss(animated: true)
//  dismiss(animated: true)


//사진이나 영상을 찍었을 때 이미지를 가져오는 함수  
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  
  let mediaType = info[.originalImage] as! NSString 
  //NSString는 objc에서 사용. 기능 많은 String "문자열"임
       

 // dismiss
 // picker.presentingViewController?.dismiss(animated: true)
    dismiss(animated: true) //위에꺼 하든 아래것 하든 둘중 하나 택 
  }
}
  
```

![](/image/piker.png)

그럼 이런 식으로 앨범 버튼을 누를 때, 사진첩에 접근함.  
Cancel 누르면 창 닫힘. 



## 2. 카메라

### 2-1. 카메라 권한 허락, 카메라 클릭시 동영상 촬영기능 포함하기. 

- 2-0. import 하기 (MobileCoreServices)

![](/image/piker2.png)


```swift

//2.카메라
@IBAction private func takePicture(_ sender: Any) {

//2-1. 카메라 사용할건지 허락
guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
imagePicker.sourceType = .camera



//2-2. 동영상 찍을 수 있도록 카메라 클릭시 photo, vidio 생김. 
  print(imagePicker.mediaTypes)
  let mediaTypes =  UIImagePickerController.availableMediaTypes(for: .camera)
  print(mediaTypes)
  
  imagePicker.mediaTypes = mediaTypes ?? []
  imagePicker.mediaTypes = ["public.image","public.moview"]
  
  //kUTTypeVideo - 비디오 (영상)
  //kUTTypeMovie - 무비 (영상 + 소리)
  
  //String대신에 키값을 대신하여 사용.
  imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]


//2-3.전면 카메라/후면카메라
  if UIImagePickerController.isFlashAvailable(for: .rear) {
    imagePicker.cameraFlashMode = .auto
  }
  
 //필수 
  present(imagePicker, animated: true)
}

```

### 2-2. info.plist에서 앱권한 설정. 

![](/image/piker4.png)

- Information Property List 에 + 를 눌러 추가후, Pirvacy - Photo Librart Additions Description 지정. 
- Value에는 사용 목적 쓰기. 


앱 실행해 보면 

![](/image/piker6.png)

디버그에 오류뜸. 


![](/image/piker5.png)

동영상 촬영시 마이크에 접근하므로 마이크도 권한 설정함. 

- Information Property List 에 Pirvacy - Microphone Usage Description 



![](/image/piker7.jpeg)


그럼 카메라 구현도 문제없이 실행된다 ! 


## 5. 화살표
(맨 우측 버튼)

###  찍은 사진 라이브러리에 접근하여 편집.

### 5-1. 토글작업.. 
```swift
//5. 화살표
 @IBAction private func toggleAllowsEditing(_ sender: Any) {
    print("\n---------- [ toggleAllowsEditing ] ----------\n")
    //5-1.
    imagePicker.allowsEditing.toggle()
  }
}
```
- 이미지나 영상을 찍었을때 가져오는 함수로 이동하여 아래코드 구현. (didFinishPickingMediaWithInfo)

```swift

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
   
   let mediaType = info[.mediaType] as! NSString
   //NSString: objc에서 사용. 기능 많은String
   
   if UTTypeEqual(mediaType, kUTTypeImage) { //사진

     let originalImage = info[.originalImage] as! UIImage
     //5-2. 편집을 할 때만 있는거기 때문에 ?사용
     let editedImage = info[.editedImage] as? UIImage
     //5-3. 최종이미지
     let selectedImage = editedImage ?? originalImage
     //5-4.originalImage을 selectedImage로 변경.
     imageView.image = selectedImage/*originalImage*/
     
     print(info)
```

![](/image/piker9.jpeg)

이런식으로 사진 편집 가능하게 됨.. 하지만 저장하면 멈춤... 


### 5-2.info.plist에서 앱권한 설정. 

![](/image/piker7.png)

- Information Property List 에 Privacy - Photo Library AddUsage Descriptrion을 추가하고 Value에 목적을 쓴다. 



(참고로 Key에 Control + 마우스 좌측 누르면 "Raw Keys & Values"로 원래 이름? 값을 볼 수 있다. 
체크해서, NSPhotoLibraryAddUsageDescriptrion )



![](/image/piker13.jpeg)

그럼 앱처음 켤때 이런 메세지 확인가능해짐. 




## 3. 딜레이 촬영 

###  앱 실행되자마자 촬영되게 끔~ 시간차 이용하여 촬영되도록 설정 

```swift
//3.딜레이촬영
@IBAction private func takePictureWithDelay(_ sender: Any) {
  
  
  guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
  imagePicker.sourceType = .camera
  imagePicker.mediaTypes = [kUTTypeImage as String]
  
  present(imagePicker, animated: true) {
    // present(imagePicker, animated: true, completion: )//completion : 프레젠트가 끝날 때 코드
    
    //화면 띄우자마자 촬영
    // self.imagePicker.takePicture()
    
    //2초뒤 촬영
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.imagePicker.takePicture()
    }
  }
}
```

![](/image/piker11.jpeg)


빌드하고 촬영해보면 이런 식으로 나온다.


## 4. 동영상 촬영

### 4-1. 촬영 기능 설정. 

```swift 
//4.동영상 촬영
@IBAction private func recordingVideo(_ sender: Any) {
  
  guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
  imagePicker.sourceType = .camera
  //앨범에 사진 안나오고 동영상만나옴.//[kUTTypeImage,kUTTypeMovie as String] 이렇게 해야 이미지도 뜸 //그런데 왜인지 아래로 해두 된다..
  imagePicker.mediaTypes = [kUTTypeMovie as String]
  // imagePicker.mediaTypes = ["public.movie"]
  
  imagePicker.cameraCaptureMode = .video // 처음시작을 video로 하고 싶은 경우
  //imagePicker.cameraCaptureMode = .photo //처름시작을  photo로 하고 싶은 경우
  
  
  //front전면 카메라 ,rear후면 카메라
  imagePicker.cameraDevice = .rear
  
  present(imagePicker, animated: true)
  
  //imagePicker.startvideoCapture()
  //  imagePicker.stopVideoCapture()
  
  imagePicker.videoMaximumDuration = 10 //초단위, 기본 10분. - 동영상 타이머 설정가능.
  imagePicker.videoQuality = .typeHigh //고화질 - 화질변경 가능.
}
```

### 4-2. 영상 불러오는 함수 추가. (조건문 활용)

```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
   
   let mediaType = info[.mediaType] as! NSString
   
   if UTTypeEqual(mediaType, kUTTypeImage) { //사진
     let originalImage = info[.originalImage] as! UIImage
     let editedImage = info[.editedImage] as? UIImage
     let selectedImage = editedImage ?? originalImage
     imageView.image = selectedImage
     
     print(info)
     
     //카메라로 찍은 경우만 저장
     if picker.sourceType == .camera {
       UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
     }
     }else if UTTypeEqual(mediaType, kUTTypeMovie) { //영상
     if let mediaPath = (info[.mediaURL] as? NSURL)?.path,
       UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath) {
       UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)
     }
   }
       //picker.presentingViewController?.dismiss(animated: true)
       dismiss(animated: true) //위에꺼 하든 아래것 하든 상관 없음
     }
   }
   
```

동영상 버튼 누르게 되면 

![](/image/piker12.jpeg)


된다. 





### [전체코드]

```swift
import MobileCoreServices
import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  
//  let picker = UIImagePickerController()
  
  private lazy var imagePicker: UIImagePickerController = {
    let imagePiker = UIImagePickerController()
    imagePiker.delegate = self
    return imagePiker
  }()
  
  
  // MARK: Action
  
  //1.앨범
  @IBAction private func pickImage(_ sender: Any) {
    print("\n---------- [ pickImage ] ----------\n")
    
    imagePicker.sourceType = .photoLibrary //포토라이브러리는 앨범선택하는 화면 보여줌.
    //. imagePicker.sourceType = .savedPhotosAlbum //최근에 찍은 사진 위주로 보여줌.
    //   imagePicker.mediaTypes = [kUTTypeMovie]
    present(imagePicker, animated:  true)
    
  }
  
  //2.카메라
  @IBAction private func takePicture(_ sender: Any) {
    print("\n---------- [ takePicture ] ----------\n")
    
    //카메라 사용할건지 허락
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
    imagePicker.sourceType = .camera
    
    //동영상 찍을 수 있도록 생김.
    print(imagePicker.mediaTypes)
    let mediaTypes =  UIImagePickerController.availableMediaTypes(for: .camera)
    print(mediaTypes)
    
    imagePicker.mediaTypes = mediaTypes ?? []
    imagePicker.mediaTypes = ["public.image","public.moview"]
    
    //kUTTypeVideo - 비디오 (영상)
    //kUTTypeMovie - 무비 (영상 + 소리)
    
    //String대신에 키값을 대신하여 사용.
    imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
    
    //2-1.전면 카메라/후면카메라
    if UIImagePickerController.isFlashAvailable(for: .rear) {
      imagePicker.cameraFlashMode = .auto
    }
    
    
    present(imagePicker, animated: true)
    
  }
  
  
  //3.딜레이촬영
  @IBAction private func takePictureWithDelay(_ sender: Any) {
    
    
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
    imagePicker.sourceType = .camera
    imagePicker.mediaTypes = [kUTTypeImage as String]
    
    present(imagePicker, animated: true) {
      // present(imagePicker, animated: true, completion: )//completion : 프레젠트가 끝날 때 코드
      
      //화면 띄우자마자 촬영
      // self.imagePicker.takePicture()
      
      //2초뒤 촬영
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.imagePicker.takePicture()
      }
      print("\n---------- [ takePictureWithDelay ] ----------\n")
    }
  }
  
  //4.동영상 촬영
  @IBAction private func recordingVideo(_ sender: Any) {
    print("\n---------- [ recordingVideo ] ----------\n")
    
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
    imagePicker.sourceType = .camera
    //앨범에 사진 안나오고 동영상만나옴.//[kUTTypeImage,kUTTypeMovie as String] 이렇게 해야 이미지도 뜸
    imagePicker.mediaTypes = [kUTTypeMovie as String]
    // imagePicker.mediaTypes = ["public.movie"]
    
    imagePicker.cameraCaptureMode = .video // 처음시작을 video로 하고 싶은 경우
    //   imagePicker.cameraCaptureMode = .photo //처름시작을  photo로 하고 싶은 경우
    
    
    //front전면 카메라 ,rear후면 카메라
    imagePicker.cameraDevice = .rear
    
    present(imagePicker, animated: true)
    
    //imagePicker.startvideoCapture()
    //  imagePicker.stopVideoCapture()
    
    imagePicker.videoMaximumDuration = 10 //초단위, 기본 10분
    imagePicker.videoQuality = .typeHigh //고화질
  }
  
  //5.화살표
  @IBAction private func toggleAllowsEditing(_ sender: Any) {
    print("\n---------- [ toggleAllowsEditing ] ----------\n")
    //2-2.
    imagePicker.allowsEditing.toggle()
  }
}

//MARK:- UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  //네비게이션안에 생성되어있으므로, 네비컨트롤러딜리게이트도 필요.
  //imagePickerControllerDidCancel : 의 경우 dismiss직접구현 필요함.
  //imagePickerControllerDidCancel를 하지 않으면 아주 잘닫힘.. 구현 필요없는 경우엔 생략
  
  //  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
  //    picker.presentingViewController?.dismiss(animated: true)
  //  //dismiss(animated: true)
  //닫기만할때는 굳이 구현 필요없으나, 캔슬시 기록이나 설정 필요한 경우 사용.
  
  //이미지나 영상을 찍었을때 가져오는 함수
  //didFinishPickingMediaWithInfo: 어떤 것을 픽했는지 알려주는.//피킹한것을 끝냈다.
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    
    let mediaType = info[.mediaType] as! NSString
    //NSString: objc에서 사용. 기능 많은String
    
    if UTTypeEqual(mediaType, kUTTypeImage) { //사진

      let originalImage = info[.originalImage] as! UIImage
      //2-3. 편집을 할 때만 있는거기 때문에 ?사용
      let editedImage = info[.editedImage] as? UIImage
      //2-4. 최종이미지
      let selectedImage = editedImage ?? originalImage
      //2-5.originalImage을 selectedImage로 변경.
      imageView.image = selectedImage/*originalImage*/
      
      print(info)
      
      //카메라로 찍은 경우만 저장
      if picker.sourceType == .camera {
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
      }
      }else if UTTypeEqual(mediaType, kUTTypeMovie) { //영상
      if let mediaPath = (info[.mediaURL] as? NSURL)?.path,
        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)
      }
    }
        //picker.presentingViewController?.dismiss(animated: true)
        dismiss(animated: true) //위에꺼 하든 아래것 하든 상관 없음
        
      }
      
    }
    
``` 


