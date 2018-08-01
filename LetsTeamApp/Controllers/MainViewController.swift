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

class MainViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var Listed = [Event]()
    var MyEvents = [Event]()
    var AllEvents = [Event]()
    var viewModal:EventListViewModal!
    var numberOfCells:Int = 1
    @IBOutlet weak var EventContentCollectionView: UICollectionView!
    @IBOutlet weak var segMainEvents: UISegmentedControl!
    
    @IBOutlet weak var btnCreateNewEvent: UIButton!
    
    /* test
     */
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //test
        let Myevent:Event = Event(EventName: "EventName", EventType: "sport", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil)
        let Myevent2:Event = Event(EventName: "EventName", EventType: "trip", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil)
        self.MyEvents.insert(Myevent, at: 0)
        self.MyEvents.insert(Myevent2, at: 0)
        
        let Listedevent:Event = Event(EventName: "EventName", EventType: "study", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil)
        self.Listed.insert(Listedevent,at: 0)
        
        let Allevent:Event = Event(EventName: "EventName", EventType: "trip", EventLocation: "here", EventDesc: "test test", EventStartDate: nil, EventEndDate: nil)
        self.AllEvents.insert(Allevent, at:0)
        
        self.viewModal = EventListViewModal(Events: self.MyEvents)
        // Do any additional setup after loading the view, typically from a nib.
        changeMainViewSelectedSegment(segMainEvents.selectedSegmentIndex)
        
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
            viewModal.Events = self.MyEvents
        case 1:
            //Listed
            print(2)
            viewModal.Events = self.Listed
        case 2:
            //All
            print(3)
            viewModal.Events = self.AllEvents
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
        
        let event:Event = (viewModal?.Events[indexPath.row])!
        
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
        print("you touch cell in index \(indexPath.row)")
        
    }
    @IBAction func CreateNewEvent(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "EditEventViewController") as? EditEventViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }    }
    
}
