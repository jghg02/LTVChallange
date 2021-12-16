//
//  AppDelegate.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import UIKit
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Google API KEY!!!
        GMSPlacesClient.provideAPIKey("API_KEY")
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navBar = UINavigationController()
        
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator.init(navBar)
        appCoordinator?.start()
        
        return true
    }



}

