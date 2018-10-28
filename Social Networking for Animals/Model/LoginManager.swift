//
//  LoginManager.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CoreData

class LoginManager: NSObject {
    
    static func isValid(username: String, password: String)-> (success: Bool, object: NSManagedObject?){
        let predicate = NSPredicate(format: "username == %@  AND password == %@", username, password)
        let result = DataManager.executeThe(query: predicate, forEntityName: "User") as! [User]
        
        if result.isEmpty {
            return (false, nil)
        }
        let user = result.first
        let userDefaults = UserDefaults.standard
        userDefaults.set(user?.username, forKey: "userID")
        //userDefaults.synchronize()
        userDefaults.set(true, forKey: "isLogged")
        return (true, user)
        
    }
    
    static func getUserLogged() -> User? {        
        guard let username = UserDefaults.standard.string(forKey:  "userID") else {return nil}
        let predicate = NSPredicate(format: "username == %@", username)
        guard let result = DataManager.executeThe(query: predicate, forEntityName: "User") as? [User] else {return nil}
        return result.first
        
        
    }
}
