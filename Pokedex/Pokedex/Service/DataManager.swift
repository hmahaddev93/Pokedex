//
//  DataManager.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/13/21.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    static let shared: DataManager = DataManager()
    private var managedContext: NSManagedObjectContext? = nil
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func storePokemons(pokemons: [Pokemon]) {
        guard let managedContext = self.managedContext else {
            return
        }
        let itemsInfo = NSEntityDescription.insertNewObject(forEntityName: "ItemsInfo", into: managedContext) as! ItemsInfo
        let pokemonArray:[String: [Pokemon]] = ["allPokemons": pokemons]
        let jsonData = try! JSONEncoder().encode(pokemonArray)
        itemsInfo.values = jsonData
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchLocalData() -> [ItemsInfo] {
        let fetchRequest = NSFetchRequest<ItemsInfo>(entityName: "ItemsInfo")
        
        guard let managedContext = self.managedContext else {
            return []
        }
        
        do{
            let myProjects = try managedContext.fetch(fetchRequest)
            return myProjects
        } catch let fetchErr{
            print("Failed to fetch companiess: ", fetchErr)
            return []
        }
    }
}
