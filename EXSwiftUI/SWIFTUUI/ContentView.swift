//
//  ContentView.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct ContentView: View { //UIView가 아닌, view
  var body: some View {
    Ex02_Image()
    
    //2.    List(0..<100){
    //      Text("\($0)")
    //    }
    //1.  Text("Hello, World!")
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      //다크모드 여부
      .preferredColorScheme(.dark)
  }
}


// ContentView?
