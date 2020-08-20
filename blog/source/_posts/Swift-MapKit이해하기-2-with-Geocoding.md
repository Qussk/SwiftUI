---
title: '[Swift]MapKit이해하기-2(with: Geocoding)'
date: 2020-06-23 14:43:19
category: "ios"
tags:
- Swift
- MapKit
thumbnail:
---


```swift
import MapKit
```


## 1. 제스처를 이용 (gesture: UITapGestureRecognizer)

```swift
//내가 터치한 위치가 위경도 값의 어디에 해당되는지
 @IBAction func recognizeTap(gesture: UITapGestureRecognizer) {

   let touchPoint = gesture.location(in: gesture.view) //제스처.터치포인트
   let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
   let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
   
   //2.참고 
   reverseGeocode(location: location)

 ```
 
 
 ## 2. everseGeocodeLocation(위경도 값에서 주소값 가져오기)

```swift
func reverseGeocode(location: CLLocation) {
  let geocoder = CLGeocoder()

  //reverseGeocodeLocation: 위경도값에서 주소값가져오기.
  geocoder.reverseGeocodeLocation(location) { placeMark, error in
    print("\n---------- [ 위경도 -> 주소 ] ----------")
    if error != nil {
      return print(error!.localizedDescription)
    }
    
    // 국가별 주소체계에 따라 어떤 속성 값을 가질지 다름
    guard let address = placeMark?.first,
      let country = address.country, //대한민국
      let administrativeArea = address.administrativeArea, //서울특별시 (시/도)
      let locality = address.locality, //서초구, 고령군, 광명시, 용산구 (시/군/구)
      let name = address.name //방배동 2902, 신림동 1428-12 (읍/면/동)
      else { return }
    
    let addr = "\(country) \(administrativeArea) \(locality) \(name)"
    print(addr)
  }
}
```
2-1. 위경도 -> 주소로 값 가져오기(print)

```swift
func geocodeAddressString(_ addressString: String){
  print("[주소-> 위경도]")
  let geocoder = CLGeocoder()
  geocoder.geocodeAddressString(addressString) { (placeMark, error) in
    if error != nil {
    return print(error!.localizedDescription)
  }
  guard let place = placeMark?.first else { return }
  print(place.location?.coordinate)
}

}
```
2-2. 주소 -> 위경도로 값 가져오기(print)




