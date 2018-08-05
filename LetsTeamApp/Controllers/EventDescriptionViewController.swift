//
//  EventDescriptionViewController.swift
//  LetsTeamApp
//
//  Created by admin on 8/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class EventDescriptionViewController: UIViewController {

    @IBOutlet weak var EventImageView: UIImageView!
    @IBOutlet weak var EventNameLbl: UILabel!
    
    @IBOutlet weak var EventDescTxtView: UITextView!
    
    let EventTypePrefix:String = "bck_"
    var selectedEvent:Event = EventListViewModal.shared.selectedEvent!
    
    @IBOutlet weak var btnEventFavorite: UIButton!
    @IBOutlet weak var btnEventLocation: UIButton!
    @IBOutlet weak var btnChatRoom: UIButton!
    
    var EventIdSelected:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.EventDescTxtView.text = self.selectedEvent.EventDesc
        self.EventNameLbl.text = self.selectedEvent.EventName
        self.EventImageView.image = UIImage(named: EventTypePrefix + self.selectedEvent.EventType!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
