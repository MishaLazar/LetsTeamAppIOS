//
//  MainViewController.swift
//  LetsTeamApp
//
//  Created by admin on 7/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
class MainViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var Listed = [Event]()
    var MyEvents = [Event]()
    var AllEvents = [Event]()
    var viewModal:EventListViewModal = EventListViewModal.shared
    var numberOfCells:Int = 1
    var refEvents: DatabaseReference!
    var refUsers: DatabaseReference!
    
    @IBOutlet weak var EventContentCollectionView: UICollectionView!
    @IBOutlet weak var segMainEvents: UISegmentedControl!
    
    @IBOutlet weak var btnCreateNewEvent: UIButton!
    
    /* test
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refEvents = Database.database().reference().child("events");
      //  refUsers = Database.database().reference().child("users").child("PUT USER ID HERE");

        //test
        /*let Myevent:Event = Event(EventName: "EventName", EventType: "sport", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil,Id:"-LJzDAtmwtgrt92cEw_Q")
        let Myevent2:Event = Event(EventName: "EventName", EventType: "trip", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil,Id:"-LJzDAtmwtgrt92cEw_Q")
        self.MyEvents.insert(Myevent, at: 0)
        self.MyEvents.insert(Myevent2, at: 0)
        
        let Listedevent:Event = Event(EventName: "EventName", EventType: "study", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil,Id:"-LJzDAtmwtgrt92cEw_Q")
        self.Listed.insert(Listedevent,at: 0)
        
        let Allevent:Event = Event(EventName: "EventName", EventType: "trip", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil,Id:"-LJzDAtmwtgrt92cEw_Q")
        self.AllEvents.insert(Allevent, at:0)*/
        //getAllEvents()
        self.viewModal.setEvents(Events: self.MyEvents)
        // Do any additional setup after loading the view, typically from a nib.
        changeMainViewSelectedSegment(segMainEvents.selectedSegmentIndex)
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllEvents()
    }
    
    @IBAction func segMainEventsSegmentSelected(_ sender: Any) {
        
        changeMainViewSelectedSegment(segMainEvents.selectedSegmentIndex)
        
    }
    func changeMainViewSelectedSegment(_ index:Int){
        
        self.viewModal.Events.removeAll()
        self.EventContentCollectionView.reloadData()
        
        
        switch index {
        case 0:
            //My
            print(1)
            //getMyEvents()
            self.viewModal.setEvents(Events: self.MyEvents)
        case 1:
            //Listed
            print(2)
            //getListedEvents()
            self.viewModal.setEvents(Events:self.Listed)
        case 2:
            //All
            print(3)
            //getAllEvents()
            self.viewModal.setEvents(Events:self.AllEvents)
        default:
            break;
        }
        self.EventContentCollectionView.reloadData()
    }
    // this is where you controll the amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal.Events.count
        
    }
    
    // this is where you controll the cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = EventContentCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell",
                                                                  for: indexPath) as! EventCollectionViewCell
        
        let event:Event = (self.viewModal.Events[indexPath.row])
        
        cell.configureCell(EventName: event.EventName!, EventTypeImg: event.EventType!)
        
        // Configure the cell
        return cell
    }
    
    // this is where you controll the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width:EventContentCollectionView.frame.size.width, height:55)
    }
    
    // this is where you controll the cell that has been touch
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModal.setSelectedEvent(event: self.viewModal.Events[indexPath.row])
        let ref = Database.database().reference().child("ListedEvents").child(self.viewModal.userid);
        var isListed:Bool = false
        ref
            .queryOrderedByKey().queryEqual(toValue: self.viewModal.selectedEvent?.Id)
            .observeSingleEvent(of: .value, with: {(snapshot) in
                
                if snapshot.childrenCount > 0 {
                    
                    for event in snapshot.children.allObjects as! [DataSnapshot] {
                        let eventObject = event.value as? [String: AnyObject]
                        isListed = (eventObject!["isListed"] as? Bool)!
                        
                        
                        
                    }
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "EventDescriptionViewController") as? EventDescriptionViewController{
                    
                    vc.EventIdSelected = self.viewModal.Events[indexPath.row].Id!
                    vc.isListed  = isListed
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            })
        
        
    }
    
    func getAllEvents(){
        self.AllEvents.removeAll()
        self.MyEvents.removeAll()
        self.Listed.removeAll()
        refEvents
            .queryOrdered(byChild: "Active")
            .queryEqual(toValue: 1)
            .observeSingleEvent(of: .value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for event in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let eventObject = event.value as? [String: AnyObject]
                    let eventName = eventObject?["EventName"] as? String
                    let eventType = eventObject?["EventType"] as? String
                    let eventLocation = eventObject?["EventLocation"] as? String
                    let eventDesc = eventObject?["EventDesc"] as? String
                    let eventStartDate = eventObject?["EventStartDate"] as? Date
                    let eventEndDate = eventObject?["EventEndDate"] as? Date
                    let eventId = eventObject?["id"] as? String
                    let eventStatus = eventObject?["Active"] as? Int
                    let eventCreatorId = eventObject?["CreatorId"] as? String

                    let NewEvent:Event = Event(EventName: eventName, EventType: eventType, EventLocation:eventLocation, EventDesc:eventDesc, EventStartDate:eventStartDate, EventEndDate: eventEndDate,Id:eventId, Active:eventStatus)
                    
                    self.AllEvents.append(NewEvent)

                    if eventCreatorId == self.viewModal.userid {
                        self.MyEvents.append(NewEvent)
                        
                    }
                    
                }
            }
        })
    }
    
   
    
    @IBAction func CreateNewEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "EditEventViewController") as? EditEventViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }    }
    
}
