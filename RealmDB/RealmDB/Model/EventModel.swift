//
//  EventModel.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 29.12.2021.
//

import Foundation
import RealmSwift

class Events : Object {
    @objc dynamic var eventName : String?
    @objc dynamic var companyName : String?
    @objc dynamic var startTime : String?
    @objc dynamic var endTime : String?
}
