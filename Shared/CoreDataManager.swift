//
//  CoreDataManager.swift
//  CoreDataSample
//
//  Created by 陳耀奇 on 2021/8/7.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getPersonById(id: NSManagedObjectID) -> PersonItem? {
        
        do {
            return try viewContext.existingObject(with: id) as? PersonItem
        } catch {
            return nil
        }
        
    }
    
    func deletePerson(person: PersonItem) {
        
        viewContext.delete(person)
        save()
        
    }
    
    func getAllPersons() -> [PersonItem] {
        
        let request: NSFetchRequest<PersonItem> = PersonItem.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Persons")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}
