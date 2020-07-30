//
//  Ex03_Layout.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct Ex03_Layout: View {
  var body: some View {
    example04
  }
  
  
  // H, V, Z
  var example01: some View{
    ZStack {
      Rectangle()
        .fill(Color.green)
        .frame(width: 150, height: 150)
      Rectangle()
        .fill(Color.blue)
        .frame(width: 150, height: 150)
        .offset(x:40, y: 40)
      
    }
  }
  
  var example02: some View{
    VStack (spacing: 50){
      HStack (spacing: 10){
        Rectangle()
          .fill(Color.green)
          .frame(width: 150, height: 150)
        Rectangle()
          .fill(Color.blue)
          .frame(width: 150, height: 150)
        
      }
      HStack (spacing: 50){
        Rectangle()
          .fill(Color.green)
          .frame(width: 150, height: 150)
        Rectangle()
          .fill(Color.blue)
          .frame(width: 150, height: 150)
        
      }
    }
  }
  
  var example03: some View{
    HStack {
      Spacer()
        .frame(width: 200)
      Text("Spacer")
        .font(.title)
        .background(Color.yellow)
    }
    .background(Color.blue)
    
  }
  
  
  //Spacer()
  var example04: some View{
    VStack {
      Text("제목").font(.largeTitle)
      Text("부제목").foregroundColor(Color.gray)
      Spacer()   // 1/3
      Text("본문내용")
      Spacer()   //2/3
      Spacer()
      Text("각주").font(.body)
      
    }
    .font(.title)
    .frame(width: 200, height: 350)
    .padding()
    .border(Color.red, width: 2)
    //괄호 안에서 적용하는게 더 우선순위 높음. 바깥에서 하는 경우 바깥것 안먹음.
  }



}





struct Ex03_Layout_Previews: PreviewProvider {
  static var previews: some View {
    Ex03_Layout()
  }
}
