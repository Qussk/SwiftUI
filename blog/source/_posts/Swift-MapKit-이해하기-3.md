---
title: '[Swift]MapKit 이해하기-3'
date: 2020-06-23 14:58:36
category: "ios"
tags:
- Swift
- MapKit
thumbnail:
---


```swift
import MapKit
```

## 1. CLLocationCoordinate2DMake

```swift
override func viewDidAppear(_ animated: Bool) {
   super.viewDidAppear(animated)
   // 시청 위치
      let center = CLLocationCoordinate2DMake(37.566308, 126.977948)
      setRegion(coordinate: center)
 }
```
1-1. app켜질때 시청위치 기본값으로 가져옴. 

## 2. 위치 핀 사용하여 추가. (MKPointAnnotation)

```swift
//내가 원하는 위경도값 가져옴.
 private func setRegion(coordinate: CLLocationCoordinate2D) {
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
```
2-1. 내가 원하는 위경도값 가져오기.

```swift
//위치추가
@IBAction private func addAnnotation(_ sender: Any) {
  let cityHall = MKPointAnnotation()
     cityHall.title = "시청"
     cityHall.subtitle = "서울특별시"
     cityHall.coordinate = CLLocationCoordinate2DMake(37.566308, 126.977948)
     mapView.addAnnotation(cityHall)
     
     let namsan = MKPointAnnotation()
     namsan.title = "남산"
     namsan.coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
     mapView.addAnnotation(namsan)

     let gimpoAirport = MKPointAnnotation()
     gimpoAirport.title = "김포공항"
     gimpoAirport.coordinate = CLLocationCoordinate2DMake(37.559670, 126.794320)
     mapView.addAnnotation(gimpoAirport)
     
     let gangnam = MKPointAnnotation()
     gangnam.title = "강남역"
     gangnam.coordinate = CLLocationCoordinate2DMake(37.498149, 127.027623)
     mapView.addAnnotation(gangnam)
   }
```
2-2. "핀추가" 눌렀을 때, 해당 위,경도에 대한 위치에 핀 꽂기


![](/image/map15.png)

## 3. 랜덤 핀으로 이동

```swift
@IBAction private func moveToRandomPin(_ sender: Any) {
   guard mapView.annotations.count > 0 else { return }
      let random = Int.random(in: 0..<mapView.annotations.count) //0 이상이면
      let annotation = mapView.annotations[random] //랜덤값 가져오기.
      setRegion(coordinate: annotation.coordinate) //그 위치로 이동하도록
 }
 ```
 3-1. 0개 이상이면, 랜덤으로 핀으로 위치 이동하기 
 
 
 ## 4. 핀 제거하기 
 
 ```swift
 @IBAction private func removeAnnotation(_ sender: Any) {
    mapView.removeAnnotations(mapView.annotations)
  }
```
4-1. removeAnnotations 이용

## 5. 카메라로 보기 

```swift
 @IBAction private func setupCamera(_ sender: Any) {
   let camera = MKMapCamera()
      let coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
      camera.centerCoordinate = coordinate
      camera.centerCoordinateDistance = 200  // 고도      
      camera.pitch = 70.0  // 카메라 각도 (0일 때 수직으로 내려다보는 형태)
      camera.heading = 0   // 카메라 방향 
      mapView.setCamera(camera, animated: true)
 }
```

5-1. centerCoordinateDistance 고도는 **m단위**임
5-2. **camera.heading** 카메라 방향 0 ~ 360 (맵을 바라보는 방향)

![](/image/map16.png)


