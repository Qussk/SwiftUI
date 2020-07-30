//
//  Ex05_List.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import SwiftUI

struct Ex05_List: View {
    var body: some View {
example04
      
  }
  
  var example01: some View {
    List {
      Text("1")
      Text("2")
      Text("3")
      Text("4")
      Text("5")
      Text("6")
      Text("7")
      Text("8")
      Text("9")
      Text("10")
//      Text("11") error. 자식 뷰는 최대 10개 까지
    }
  }
  
  //서로 다른 타입들 다루기,
  var example02: some View {
    List {
      Text("List").font(.largeTitle)
      Image("ddddd")
      Circle().frame(width: 100, height: 100)
      Color(.red).frame(width: 100, height: 100)
    }
  }
  var example03: some View {
    List (0..<100){
      Text("\($0)")
  
    }
  }
  
  //헤더푸터 
  var example04: some View {
    List {
      Section(
        header: Text("헤더1"),
        footer: Text("푸터1")
      ){
        Text("1")
        Text("2")
        Text("3")
      }
      
      Section(
        header: Text("헤더2"),
        footer: HStack { Spacer(); Text("푸터1")}
      ){
        Text("섹션2")
             Text("SwiftUI")
      }
    }
    .listStyle(GroupedListStyle())
}
}

struct Ex05_List_Previews: PreviewProvider {
    static var previews: some View {
        Ex05_List()
    }
}
