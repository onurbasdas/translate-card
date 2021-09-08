//
//  AppDelegate.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import AMTabView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AMTabView.settings.tabColor = UIColor(named: "label")!
        AMTabView.settings.ballColor = .black
        AMTabView.settings.animationDuration = 1
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

