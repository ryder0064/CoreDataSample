//
//  PersonListViewModel.swift
//  CoreDataSample
//
//  Created by 陳耀奇 on 2021/8/9.
//

import Foundation
import CoreData

class PersonListViewModel: ObservableObject {
    var name: String = ""
    var height: String = ""
    var weight: String = ""

    @Published var persons: [PersonViewModel] = []
    
    func getAllPersons() {
        persons = CoreDataManager.shared.getAllPersons().map(PersonViewModel.init)
    }
    
    func delete(_ person: PersonViewModel) {
        
        let existingPerson = CoreDataManager.shared.getPersonById(id: person.id)
        if let existingPerson = existingPerson {
            CoreDataManager.shared.deletePerson(person: existingPerson)
        }
    }
    
    func save() {
        
        let person = PersonItem(context: CoreDataManager.shared.viewContext)
        person.name = name
        person.height = (height as NSString).floatValue
        person.weight = (weight as NSString).floatValue

        CoreDataManager.shared.save()
    }
    
}

struct PersonViewModel {
    
    let personItem: PersonItem
    
    var id: NSManagedObjectID {
        return personItem.objectID
    }
    
    var name: String {
        return personItem.name ?? ""
    }
    
    var height: Float {
        return personItem.height
    }
    
    var weight: Float {
        return personItem.weight
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
