//
//  EventListViewModal.swift
//  LetsTeamApp
//
//  Created by admin on 7/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class EventListViewModal {
    
    static let shared = EventListViewModal()
    
    var selectedEvent:Event?
    var Events = [Event]()
    
    /*init(Events:[Event]){
        self.Events = Events
    }*/
    
    
    func setEvents(Events:[Event]){
        self.Events = Events
    }
    
    func setSelectedEvent(event:Event){
        self.selectedEvent = event
    }
    func removeSelectedEvent(){
        self.selectedEvent = nil
    }
    
}
