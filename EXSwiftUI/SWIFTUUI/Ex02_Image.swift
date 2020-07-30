//
//  Ex02_Image.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct Ex02_Image: View {
  var body: some View {
    example04
  }
  
  var example01: some View {
    HStack {
      Image("ddddd")
        .resizable()
        .frame(width: 100, height: 150)
      Image("ddddd")
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 150)
      Image("ddddd")
        .resizable()
        //resizable : 사이즈를 리사이즈 할 수 있는 이미지임을 표현.
        .scaledToFill() //뷰의 크기를 벗어나더라도 비율유지.
        .frame(width: 100, height: 150)
        .clipped()
      
    }
  }
  
  
  var example02: some View {
    HStack {
      Image("ddddd")
      Image("ddddd").renderingMode(.original)
      Image("ddddd").renderingMode(.template)
      //   Image(systemName: "person").font(.largeTitle)
    }
    .foregroundColor(.red)
    
    
    //original : 이미지의 원래 색상유지
    //template : 원래 색상에 대한 정보를 제거하고 내가 원하는 특정색으로 덮어씀. (좋은 예제는 아니지만,심볼 버튼에서 주로 사용됨.)
  }
  
  
  //원하는 내용 적용하기.
  var example03: some View {
    HStack(spacing: 30) {
      Image(systemName: "book.fill")
        .imageScale(.small)
        .foregroundColor(.red)
      Image(systemName: "book.fill")
        .imageScale(.medium)
        .foregroundColor(.green)
      Image(systemName: "book.fill")
        .imageScale(.large)
        .foregroundColor(.blue)
      
    }
    .font(.largeTitle)
  }
  

  
  //someView를 이용하는 이유.
  //스위프트의 타입은 매번 변한다. 뷰 프로토콜을 따르는 어떤 뷰이기만 하면 된다는 some View를 통해 해결한다.
  
  var example04: some View {
    let myView = HStack {
      Text("Hellow, UISwift!")
      Image("ddddd")
      Text("ASDF")
        .frame(width: 100, height: 100)
      
    }
    print(type(of: myView))
    //Hstack<TupleView<(Text, Image)>>
  return myView
  }

}

    
    struct Ex02_Image_Previews: PreviewProvider {
      static var previews: some View {
        Ex02_Image()
      }
}
