//
//  Extention+Events.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/6/22.
//

import Foundation
import CoreData

extension Events: BaseModel {
    static var all: NSFetchRequest<Events> {
        let request = Events.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    
    static var byDate: NSFetchRequest<Events> {
        let request = Events.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Events.startTime),
                                                    ascending: true)]
        return request
    }
}
