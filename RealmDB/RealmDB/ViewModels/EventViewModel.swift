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
    var eventObject = Events()
    var nameArray = [String]()
    var companyArray = [String]()
    var startTimeArray = [String]()
    var endTimeArray = [String]()
    
    
    
    
    
    func test() -> Events {
        let result = realm.objects(Events.self)
        
        result.forEach { x in
            nameArray.append(x.eventName!)
            companyArray.append(x.companyName!)
            startTimeArray.append(x.startTime!)
            endTimeArray.append(x.endTime!)
        }
        
        #warning("event obje boş döneyir")
        
        
        
        print("********\(eventObject)")
        
        return eventObject
    }
   
}
