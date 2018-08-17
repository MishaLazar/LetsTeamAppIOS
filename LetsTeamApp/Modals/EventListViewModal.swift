//
//  EventListViewModal.swift
//  LetsTeamApp
//
//  Created by admin on 7/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
//import Firebase
//import FirebaseDatabase

class EventListViewModal {
    
    static let shared = EventListViewModal()
    var userid = "-LIflQXsRuLYHN63v7Hn"
    var userName = "MorAndMisha"
    var selectedEvent:Event?
    var Events = [Event]()
    var ETypes = [EventTypes]()
//    private var dbRef = Database.database().reference()
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
    
    func refreshEventsData(){
       
    }
    
    func refreshLookUpData(){
        
    }
    
    
}
