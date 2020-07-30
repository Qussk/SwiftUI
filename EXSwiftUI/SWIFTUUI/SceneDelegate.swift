//
//  SceneDelegate.swift
//  SWIFTUUI
//
//  Created by Qussk_MAC on 2020/07/30.
//  Copyright © 2020 Qussk_MAC. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    let contentView = ContentView()

  
    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
      
  
        self.window = window
        window.makeKeyAndVisible()
    }
  }

}

//UIHostingController: UIViewController상속받고 있으므로 UIViewController로 생각.(UIViewController objc언어이긴함. 그래서,) swiftUI랑 UIKit에서만든 View랑 호환할 수 있도록 변환해주는 UIHostingController

//
