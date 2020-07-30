//
//  Ex04_Button.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct Ex04_Button: View {
  var body: some View {
    example02
  }
  
  var example01: some View {
    HStack(spacing: 20) {
      Button("Button") {
        print("Button 1")
      }
      Button(action: {print("Button 2")}) {
        Text("Button")
          .padding()
          .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
        //strokeBorder안에 색을 채우지 않고 테두리만
        
      }
      Button(action: {print("Button 3")}) {
        Circle()
          .stroke(lineWidth: 2)
          .frame(width: 80, height: 80)
          .overlay(Text("Button"))
      }   //overlay 뷰 위에 얹는 것.
        .accentColor(.green)
      
    }
  }
  
  
  var example02: some View {
    
    HStack(spacing: 20) {
      Button(action: {print("Button 1")}) {
        Image("ddddd")
          .resizable()
          .renderingMode(.original)
          .frame(width: 120, height: 120)
        
      }
      
      Button(action: {print("Button 2")}) {
        Image(systemName: "play.circle")
          .resizable()
          .imageScale(.large)
          .font(.largeTitle)
      }
      .accentColor(.green)
    }
  }
}

struct Ex04_Button_Previews: PreviewProvider {
  static var previews: some View {
    Ex04_Button()
  }
}
