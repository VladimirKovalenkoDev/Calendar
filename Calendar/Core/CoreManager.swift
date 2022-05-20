//
//  CoreManager.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import Foundation
import CoreData

final class CoreManager {
    
    let container: NSPersistentContainer
    private let containerName: String = "Calendar"
    static let shared = CoreManager()
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading Core Data! \(error)")
            }
        }
    }
}
