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
import UserNotifications

var animals: [Animal] = []
//let resourcesAnimals = [APIManager.getRandonCat, APIManager.getRandonDog, APIManager.getRandonFox]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = SampleNotificationDelegate()
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)

        loadResouces()
        setupCoreData()
        registerForPushNotifications()
        
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            UNUserNotificationCenter.current().delegate = self.notificationDelegate
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories(Set([deafultCategory]))
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
  

    
    
    
    func setupCoreData(){
        //mock users
        let user1 = User(context: DataManager.getContext())
        user1.username = "palomabispo"
        user1.email = "palomabispo@alu.ufc.br"
        user1.password = "123"
//        let user2 = User(context: DataManager.getContext())
//        user2.username = "mmdisousa"
//        user2.email = "palomabispo@alu.ufc.br"
//        user2.password = "123"
//        let user3 = User(context: DataManager.getContext())
//        user3.username = "marialuiza"
//        user3.email = "palomabispo@alu.ufc.br"
//        user3.password = "123"
//        // pets for user1
        let pet1 = Pet(context: DataManager.getContext())
        pet1.followersCount = 20
        pet1.likeCount = 8
        pet1.photoCount = 6
        pet1.owner = user1
        pet1.type = "Cachorro"
        pet1.name = "Max"
        guard let image = UIImage(named: "Dog") else {return}
        pet1.photo = StoreManager.saving(image: image, withName: "\(image.hashValue)")
        
        let pet2 = Pet(context: DataManager.getContext())
        pet2.followersCount = 100
        pet2.likeCount = 200
        pet2.photoCount = 30
        pet2.owner = user1
        pet2.type = "Gato"
        pet2.name = "Margot"
        guard let imageCat = UIImage(named: "Fox") else {return}
        pet1.photo = StoreManager.saving(image: imageCat, withName: "\(imageCat.hashValue)")
//        let pet3 = Pet(context: DataManager.getContext())
//        pet3.followersCount = 5
//        pet3.likeCount = 7
//        pet3.photoCount = 2
//        pet3.owner = user1
//        pet3.type = "Gato"
//        pet3.name = "Salém"
//
//        //pets for user2
//        let pet4 = Pet(context: DataManager.getContext())
//        pet4.followersCount = 15
//        pet4.likeCount = 10
//        pet4.photoCount = 8
//        pet4.owner = user2
//        pet4.type = "Cachorro"
//        pet4.name = "Billy"
//        let pet5 = Pet(context: DataManager.getContext())
//        pet5.followersCount = 3
//        pet5.likeCount = 2
//        pet5.photoCount = 1
//        pet5.owner = user2
//        pet5.type = "Cachorro"
//        pet5.name = "Beethoven"
//        let pet6 = Pet(context: DataManager.getContext())
//        pet6.followersCount = 26
//        pet6.likeCount = 13
//        pet6.photoCount = 5
//        pet6.owner = user3
//        pet6.type = "Cachorro"
//        pet6.name = "Spike"
        
        //DataManager.saveContext()
        print("saving in core data")
        
        for _ in 0...2 {
            //dispatch.enter()
            APIManager.getRandonAnimal { (error, image) in
                if !(error == nil){
                   // print("error in saving post")
                    return
                }else{
                    let newPost = Post(context: DataManager.getContext())
                    guard let entity = DataManager.getEntity(entity: "Pet") else {return}
                    let result = DataManager.getAll(entity: entity)
                    if result.success {
                        guard let pets = result.objects as? [Pet] else {return}
                        newPost.pet = pets.randomElement()
                        guard let imagePost = image else {
                            guard let imageDefault = UIImage(named: "Fox") else{
                                newPost.photo = ""
                                return
                            }
                            newPost.photo = StoreManager.saving(image: imageDefault, withName: "\(imageDefault.hashValue)")
                            return
                        }
                        newPost.photo = StoreManager.saving(image: imagePost, withName: "\(imagePost.hashValue)")
                        print("testing")
                        DataManager.saveContext()
                    }

                }
            }
           
        }
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




