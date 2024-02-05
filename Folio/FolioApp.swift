//
//  JaleoApp.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("Firebase launched successfully!")
    FirebaseApp.configure()
      
    // create database
    let db = Firestore.firestore()

    return true
  }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @State private var isAuthenticated: Bool = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.customDarkGray]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.customDarkGray]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.customDarkTurquoise]
        appearance.buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.customDarkTurquoise]

        UINavigationBar.appearance().tintColor = UIColor.customDarkTurquoise
    }

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
