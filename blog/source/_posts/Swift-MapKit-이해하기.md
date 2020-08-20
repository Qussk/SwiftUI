---
title: '[Swift]MapKit 이해하기'
date: 2020-06-23 13:31:35
category: "ios"
tags:
- Swift
- MapKit
thumbnail:
---


## 0. import MapKit

```swift
import MapKit
```

![](/image/map9.png) 

0-1. 임포트를 하게되면 일단 기본적인 맵킷이 나온다. 

## 1. 권한요청 

```swift
private func checkAuthorizationStatus() {
switch CLLocationManager.authorizationStatus() {
case .notDetermined:
  locationManager.requestWhenInUseAuthorization()
case .restricted, .denied: break
case .authorizedWhenInUse:
  fallthrough
case .authorizedAlways:
  startUpdatingLocation()
@unknown default: fatalError()
}
}
```
1-1. info.plist에서 권한요청하기. (Privacy - Location When In Use Usage Description)
1-2. @컴파일러가 별도의 키워드로 인식하기 위해 필요한 것. (Attribut)


## 2. CLLocationManager

```swift
private func startUpdatingLocation() {
  let status = CLLocationManager.authorizationStatus() 
  guard status == .authorizedAlways || status == .authorizedWhenInUse,
    CLLocationManager.locationServicesEnabled()
    else { return }
  locationManager.desiredAccuracy = kCLLocationAccuracyBest
  locationManager.distanceFilter = kCLHeadingFilterNone
  locationManager.startUpdatingLocation()
}
```
2-1. **status** 사용자가 위치정보 서비스를 허용했는지 안했는지 체크
2-2. **kCLLocationAccuracyNearestTenMeters** 10미터 단위로 (기본값은 **kCLLocationAccuracyBest**) 단, 너무 짧을 경우 베터리 소진량 늘어남
2-3. **startUpdatingLocation** 실제로 update를 요청하는 값


## 3.  CLLocationManagerDelegate
 
```swift
locationManager.delegate = self
```
3-1. delegate self선언

```swift
extension MyLocationViewController: CLLocationManagerDelegate {
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
  switch status {
  case .authorizedWhenInUse, .authorizedAlways:
    print("Authorized")
  default:
    print("Unauthorized")
  }
}

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  let current = locations.last! //라스트 값을 가져옴.
  
  if (abs(current.timestamp.timeIntervalSinceNow) < 10) {
    let coordinate = current.coordinate
    
    // Span 단위는 1도
    // 경도 1도는 약 111킬로미터. 위도 1도는 위도에 따라 변함.
    // 적도 (약 111 Km) ~ 극지방 (0 Km)
    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    
    addAnnotation(location: current)
  }
}

func addAnnotation(location: CLLocation) {
   let annotation = MKPointAnnotation()
   annotation.title = "MyLocation"
   annotation.coordinate = location.coordinate
   mapView.addAnnotation(annotation)
 }
 
```
3-2. **didChangeAuthorization** 권한 확인(1.의 checkAuthorizationStatus부분.)
3-3. **didUpdateLocations**   로케이션(위치)의 정보를 받는곳
3-4. **addAnnotation**는 위치 라벨(네임) 가져오기.
3-5. **span**값 넓힐 수록 가까이됨. 뷰디드로드에 ( mapView.showsUserLocation = true)로 지정 



## 4. showsUserLocation

```swift
mapView.showsUserLocation = true
mapView.mapType = .satellite
```
4-1. 뷰디드로드에 showsUserLocation = true



## 5. 방향 추가 


```swift
  //방향모니터값 가져오기
  @IBAction func mornitoringHeading(_ sender: Any) {
    guard CLLocationManager.headingAvailable() else { return }
    locationManager.startUpdatingHeading()
  }
  
  @IBAction func stopMornitoring(_ sender: Any) {
    locationManager.stopUpdatingHeading()
  }
}
```
5-1. "방향모니터링", "방향모니터링중단" Button의 모니터 방향값 가져오기. 

```swift
//방향불러오는 함수
 func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
   print("trueHeading :", newHeading.trueHeading)  // 진북(어디에서든 북쪽 고정)
   print("magneticHeading :", newHeading.magneticHeading)  // 자북 (자기장)
 }
 ```
 5-2. didUpdateHeading 이용
 
 
 ## 6.기타
 
 
 ![](/image/map10.png) 

시뮬레이터에서 해당값을 지정하면, 달리는 모션으로 지도를 볼 수 있음. 



![](/image/map12.png) 

