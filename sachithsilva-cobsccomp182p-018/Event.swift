//
//  Event.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/12/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import Foundation


class Event {
    var userId:String = ""
    var eventId:String = ""
    var startDate: String = ""
    var endDate:String = ""
    var title:String = ""
    var organizer:String = ""
    var about:String = ""
    var longitude:String = ""
    var latitude:String = ""
    var venu:String = ""
    var eventType:String = "Public"
    var entrance: String = "Free"
    var goingCount: Int=0
    init (userId:String, eventId:String, startDate:String, endDate:String, title:String, organizer:String, about:String, longitude:String, latitude:String, venu:String, eventType:String, entrance:String, goingCount: Int){
        self.userId = userId
        self.eventId = eventId
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
        self.organizer = organizer
        self.about = about
        self.longitude = longitude
        self.latitude = latitude
        self.venu = venu
        self.eventType = eventType
        self.entrance = entrance
        self.goingCount = goingCount
    }
}
