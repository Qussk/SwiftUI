//
//  Ex01_Text.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct Ex01_Text: View {
  var body: some View {
    //2.someView를반환하는 연산프로퍼티라서 그냥 여기다가 갖다 씀
    example05
  }
  
  //error = Compiling failed: extra tokens at the end of #sourceLocation directive
  
  
  var example01: some View {
    
    //1.swiftUI는 대 부분의 retrun이 생략되어 있음(보통 View를 표현할때는 생략)
    
    Text("Hello, SwiftUI")
      //  .font(.headline)
      .fontWeight(.light)
      .foregroundColor(Color.purple)
      // .font(.system(size: 40, weight: .light))
      .font(.custom("AppleGothic", size: 40))
      .blur(radius: 3.0)
    
    // cmd+shif+L
    
  }
  
  
  // (텍스트간의 합성 용의)
  var example02: some View {
    Text("Hello").font(.headline)
      .foregroundColor(.blue)
      .italic()
      +
      Text("SwiftUI").font(.largeTitle)
        .foregroundColor(.green)
        .baselineOffset(8)
    
  }
  var example03: some View {
    
    Text("Hellow, Qussk")
      .font(.title)
      .kerning(5)
      .underline(true, color: .orange)
      .strikethrough(true, color: .blue)
  }
  
  
  //수식어 적용시 순서 주의.
  var example04: some View {
    Text("Qussk")
      .font(.largeTitle) //Text
      .bold() //Text
      .background(Color.yellow)
    //View
    
    
    //    Text("Qussk")
    //        .font(.largeTitle) //View - 알아서 속성이 바뀜.
    //        .background(Color.yellow) //Veiw
    //        .bold() => text가 가진 속성 //Text
    //       -background가 가진 속성은 View~ 반환타입도 View이기 때문에 bold()를 쓸수 없음.
  }
  
  
  //내용은 같은데 순서가 다르다. why?
  var example05: some View {
    VStack(spacing: 20) {
      //spacing: 뷰간의 간격
      Text("🐰🦊🐻🐼").font(.largeTitle)
        .padding()
        .background(Color.yellow)
      //뷰의 크기만큼 배경색을 주느냐,
      
      Text("🐶🐱🐭🐹").font(.largeTitle)
        .background(Color.green)
        //백그라운드 색을 주고, 뷰 크기를 결정하느냐
        .padding()
      
    }
  }
}
/*
 기본적으로 가운데 정렬함.
 
 */

//이것 때문에 Preview가 나올 수 있음.
//struct Ex01_Text_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      Ex01_Text()
//        .previewLayout(.sizeThatFits)
//      //.previewLayout(.fixed(width: 300, height: 200))
//
//      Ex01_Text()
//        .preferredColorScheme(.dark)
//        .previewDisplayName("iPhon 11")
//        .previewDevice(PreviewDevice(rewValue: "iPhon 11"))
//
//      Ex01_Text()
//        .preferredColorScheme(.dark)
//        .previewDisplayName("iPhon 8")
//        .previewDevice(PreviewDevice(rewValue: "iPhon 8"))
//
//    }
//  }
//}

//}
struct Ex01_Text_Previews2: PreviewProvider {
  static var previews: some View {
    Ex01_Text()
    .preferredColorScheme(.light)
  }
}
