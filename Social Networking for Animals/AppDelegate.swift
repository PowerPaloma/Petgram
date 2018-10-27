//
//  AppDelegate.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 17/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit

var animals: [Animal] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)

        loadResouces()
        //setupCoreData()

        // Override point for customization after application launch.
        return true
    }
    
    func setupCoreData(){
        let userDefault = User(context: DataManager.getContext())
        userDefault.username = "palomabispo"
        userDefault.email = "palomabispo@alu.ufc.br"
        userDefault.password = "123"
        let pet1 = Pet(context: DataManager.getContext())
        pet1.followersCount = 20
        pet1.likeCount = 8
        pet1.photoCount = 6
        pet1.owner = userDefault
        pet1.type = "Cachorro"
        pet1.name = "Luluquinha"
        let pet2 = Pet(context: DataManager.getContext())
        pet2.followersCount = 1000
        pet2.likeCount = 1
        pet2.photoCount = 300
        pet2.owner = userDefault
        pet2.type = "Gato"
        pet2.name = "Pichano"
        let pet3 = Pet(context: DataManager.getContext())
        pet3.followersCount = 220
        pet3.likeCount = 3443
        pet3.photoCount = 12
        pet3.owner = userDefault
        pet3.type = "Coelho"
        pet3.name = "Magali"
        DataManager.saveContext()
        print("saving in core data")
    }
    
    func loadResouces(){
        let animalsResouces = ["Dog", "Cat", "Fox", "Bird"]
        for name in animalsResouces {
            var animal = Animal()
            animal.name = name
            animal.image = UIImage(named: name)
            animals.append(animal)
        }
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, options: options)
        
    
        guard let handledReturn = handled else {return false}
        return handledReturn
    }
    

    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        DataManager.saveContext()
    }

}



