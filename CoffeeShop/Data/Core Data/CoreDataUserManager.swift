//
//  CoreDataManager.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 02.04.2024.
//

import CoreData
import UIKit

public final class CoreDataUserManager: NSObject {
    public static let shared = CoreDataUserManager()
    override private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createUser(name: String, email: String, password: String){
        guard let userEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else {
            return
        }
        let user = User(entity: userEntityDescription, insertInto: context)
        user.id = UUID()
        user.name = name
        user.email = email
        user.password = password
        user.addressName = ""
        user.lat = 1000
        user.lon = 1000
        user.flat = -1
        
        appDelegate.saveContext()
    }
    
    public func fetchUser(with email: String) -> User?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let user = try? context.fetch(fetchRequest) as? [User]
            return user?.first
        }
    }
    
    public func updateUserAdress(with email: String,
                                 adress: String, lat: Double,
                                 lon: Double, flat: Int16){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            guard let users = try? context.fetch(fetchRequest) as? [User],
                  let user = users.first else { return }
            user.addressName = adress
            user.lat = lat
            user.lon = lon
            user.flat = flat
        }
        
        appDelegate.saveContext()
    }
}
