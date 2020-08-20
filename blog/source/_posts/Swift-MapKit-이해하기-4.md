---
title: '[Swift]MapKit 이해하기-4(with: MKOverlayRenderer)'
date: 2020-06-23 15:36:44
category: "ios"
tags:
- Swift
- MapKit
thumbnail:
---

```swift
import MapKit
```
맵킷 가져오기 


## 1. '원'그림으로 반경 추가하기.(MKCircle)

```swift
@IBAction func addCircle(_ sender: Any) {
  let center = mapView.centerCoordinate
     // 44000m = 44km
     let circle = MKCircle(center: center, radius: 44000)
     mapView.addOverlay(circle)
}
```
1-1.  원 = center 화면 중앙,  radius: 44000은 44km값.


![](/image/map17.png)


## 2. '별그림'으로 반경 추가하기.(MKPolyline)
```swift
@IBAction func addStar(_ sender: Any) {
  //별 컬러 및 굵기 지정
  let center = mapView.centerCoordinate
     
     var point1 = center; point1.latitude += 0.4
     var point2 = center; point2.longitude += 0.32;   point2.latitude -= 0.30
     var point3 = center; point3.longitude -= 0.45;  point3.latitude += 0.15
     var point4 = center; point4.longitude += 0.45;  point4.latitude += 0.15
     var point5 = center; point5.longitude -= 0.32;   point5.latitude -= 0.30
     
     let points: [CLLocationCoordinate2D] = [point1, point2, point3, point4, point5, point1] //2-1.
     let polyline = MKPolyline(coordinates: points, count: points.count)//2-2
    
    mapView.addOverlay(polyline)
}
```
2-1. 마지막 배열 왜 point1을 넣었을까?  point1로 돌아와야하기 때문.
```swift
 let points: [CLLocationCoordinate2D] = [point1, point2, point3, point4, point5, point1]
 ```
2-2. points: 특정 점들의 count: 카운트만큼.


![](/image/map18.png)



## 3. MKMapViewDelegate(MKCircle,polyline)

```swift
// MARK: - MKMapViewDelegate

extension RendererOverlayViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if let circle = overlay as? MKCircle { //MKCircle일때 작성.
      let renderer = MKCircleRenderer(circle: circle)
      renderer.strokeColor = UIColor.blue
      renderer.lineWidth = 2
      return renderer
    }
    if let polyline = overlay as? MKPolyline { //아니면, MKPolyline을 반환
      let renderer = MKPolylineRenderer(polyline: polyline)
      renderer.lineWidth = 2
      renderer.strokeColor = .red
      return renderer
    }
    return MKOverlayRenderer(overlay: overlay)
  }
}
```
3-1. MKCircled일때 작성, MKCircled이 아니면, MKPolyline을 반환.


## 4. overlays 지우기

```swift
@IBAction private func removeOverlays(_ sender: Any) {
  mapView.removeOverlays(mapView.overlays)
}
```

![](/image/map19.png)




추가로, 아래에 확대하면 별이 커진 것처럼 
제스처로 화면을 최대한 작게하면 별이 작아진다 !!!!


![](/image/map20.png)





