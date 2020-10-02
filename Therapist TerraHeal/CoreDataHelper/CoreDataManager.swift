//
//  CoreData+AppDelegate.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 27/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    //2.
    private init() {} // Prevent clients from creating another instance.
    //3
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PersonData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    //4
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func create(username: String, password : String) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(username, forKeyPath: "username")
        person.setValue(password, forKeyPath: "password")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update(username: String, password : String) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "username = %@", username)
        do {
            let personFound = try managedContext.fetch(fetchRequest)
            if personFound.count > 0 {
                let person = personFound[0]
                person.setValue(username, forKeyPath: "username")
                person.setValue(password, forKeyPath: "password")
                do {
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func delete(username: String) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "username = %@", username)
        do {
            let personFound = try managedContext.fetch(fetchRequest)
            if personFound.count > 0 {
                let person = personFound[0]
                managedContext.delete(person)
                do {
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchPersons() -> [Person] {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            
            if  let people = try managedContext.fetch(fetchRequest) as? [Person]
            {
                return people
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    
    func retrive(username: String) -> Person? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = NSPredicate.init(format: "username = %@", username)
        do {
            let personFound = try managedContext.fetch(fetchRequest)
            if personFound.count > 0 {
                return personFound[0] as? Person
            } else {
                return nil
            }
        } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func fetchPersonsForTable() -> [PersonData] {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            
            if  let people = try managedContext.fetch(fetchRequest) as? [Person]
            {
                var peopleArray: [PersonData] = []
                for data in people {
                    let personData: PersonData = PersonData.init(username: data.username ?? "", password: data.password ?? "", isSelected: false)
                    peopleArray.append(personData)
                    
                }
                return peopleArray
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}

