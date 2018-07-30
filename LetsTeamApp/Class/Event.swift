//
//  Event.swift
//  LetsTeamApp
//
//  Created by admin on 7/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
class Event{
    
    var EventName:String?
    var EventType:String?
    var EventLocation:String?
    var EventDesc:String?
    var EventStartDate:Date?
    var EventEndDate:Date?
    var EventTypeImg:UIImage?
    
    
    init(EventName:String? , EventType:String? ,EventLocation:String? ,EventDesc:String? ,EventStartDate:Date?, EventEndDate:Date? ){
        self.EventName = EventName
        self.EventDesc = EventDesc
        self.EventType = EventType
        self.EventTypeImg = UIImage(named: EventType!)
        self.EventStartDate = EventStartDate
        self.EventEndDate = EventEndDate
        self.EventLocation = EventLocation
    }
    
    
}
