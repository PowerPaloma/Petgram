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
    
    static func isValid(email: String, password: String)-> (success: Bool, object: NSManagedObject?){
        let predicate = NSPredicate(format: "email == %@  AND password == %@", email, password)
        let result = DataManager.executeThe(query: predicate, forEntityName: "User") as! [User]
        
        if result.isEmpty {
            return (false, nil)
        }
        let user = result.first
        let userDefaults = UserDefaults.standard
        userDefaults.set(user?.objectID.uriRepresentation(), forKey: "userID")
        //userDefaults.synchronize()
        userDefaults.set(true, forKey: "isLogged")
        return (true, user)
        
    }
    
    static func getUserLogged() -> User? {
        let contex = DataManager.getContext()
        
        guard let url = UserDefaults.standard.url(forKey: "userID") else {return nil}
        guard let objetcID: NSManagedObjectID = contex.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) else {return nil}
        guard let userTemp = contex.object(with: objetcID)  as? User else {return nil}
        return userTemp
        
        
    }
}
