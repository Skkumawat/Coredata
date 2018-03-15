//
//  CoreDataManager.swift
//  Punch
//
//  Created by EndiveSoftware on 08/12/17.
//  Copyright © 2017 Sharvan Kumawat. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let appdelgate = (UIApplication.shared.delegate as! AppDelegate)
    static let context = appdelgate.persistentContainer.viewContext
    
    class func saveUserData(userData: UserModel) {
        let user = User(context: context)
        
        user.user_id = Int16(userData.user_id)
        user.name = userData.name
        user.email = userData.email
        user.phone = userData.phone
        appdelgate.saveContext()
    }
    
    class func deleteAllUserData(entityName: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(fetchRequest)
        
        for object in result! {
            context.delete(object as! NSManagedObject)
        }
    }
    
    class func deleteUser(user: UserModel) {
        if let userData = getUsersByUserId(user_id: user.user_id) {
            context.delete(userData)
        }
    }
    
    class func UpdateUser(user: UserModel) {
        if let userData = getUsersByUserId(user_id: user.user_id) {
            userData.setValue(user.name, forKey: "name")
            userData.setValue(user.email, forKey: "email")
            userData.setValue(user.phone, forKey: "phone")
            
            appdelgate.saveContext()
        }
        
    }
    
    
    class func getUsersByUserId(user_id: Int)-> NSManagedObject?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "user_id == %d", user_id)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               return data
            }
        } catch {
            
            print("Failed")
        }
        return nil
    }
    
    
    class func getUsers()-> [UserModel]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        var users = [UserModel]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let user = UserModel()
                user.user_id = data.value(forKey: "user_id") as! Int
                user.name =   data.value(forKey: "name") as! String
                user.email =   data.value(forKey: "email") as! String
                user.phone =   data.value(forKey: "phone") as! String
                users.append(user)
            }
            
        } catch {
            
            print("Failed")
        }
        return users
    }
    
    
    class func getUsersWithNSManagedObject()-> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        var users = [NSManagedObject]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                users.append(data)
            }
            
        } catch {
            
            print("Failed")
        }
        return users
    }
    
}
