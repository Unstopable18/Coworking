//
//  AppDelegate.swift
//  Cowork
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true{
            dashboardUI()
        }
        else{
            loginUI()
        }
        return true
    }
    
    func dashboardUI(){
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let navVC = UINavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
    }
    
    func loginUI(){
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navVC = UINavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

