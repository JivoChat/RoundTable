//
//  AppDelegate.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let trunk = Trunk(locale: .current)
        let module = TaskListModuleAssembly(trunk: trunk)
        
        let window = UIWindow()
        self.window = window
        
        window.rootViewController = module.view
        window.makeKeyAndVisible()
        
        return true
    }
}
