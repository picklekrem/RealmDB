//
//  EventViewModel.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 29.12.2021.
//

import Foundation
import RealmSwift
class EventViewModel {
    
    let realm = try! Realm()
    
    func getEvents() -> [Events] {
        let result = realm.objects(Events.self)
        let events = Array(result)
        return events
    }
   
}
