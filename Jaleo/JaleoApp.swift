//
//  JaleoApp.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("Firebase launched successfully!")
    FirebaseApp.configure()

    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @State private var isAuthenticated: Bool = false

  var body: some Scene {
    WindowGroup {
        // Use RootView as the main entry point
        RootView()
            .onAppear {
                // Check authentication status
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                isAuthenticated = authUser != nil
            }
    }
  }
}
