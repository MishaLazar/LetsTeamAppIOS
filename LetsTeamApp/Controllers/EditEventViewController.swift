//
//  EditEventViewController.swift
//  LetsTeamApp
//
//  Created by admin on 8/1/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class EditEventViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    var refEvents: DatabaseReference!

    @IBOutlet weak var btnSaveEvent: UIButton!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var dpEndDate: UIDatePicker!
    @IBOutlet weak var dpStartDate: UIDatePicker!
    @IBOutlet weak var lstEventType: UIPickerView!
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDescription: UITextView!
    
    @IBOutlet weak var switchIsActive: UISwitch!
    var viewModal:EventListViewModal = EventListViewModal.shared
    var selectedValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lstEventType.delegate = self
        self.lstEventType.dataSource = self
        
        var e1 =  EventTypes(type: "sport", id: "1", background_img_name: "bck_sport", img_name: "sport")
        var e2 =  EventTypes(type: "study", id: "2", background_img_name: "bck_study", img_name: "study")
        self.viewModal.ETypes.append( e1)
        self.viewModal.ETypes.append( e2)
        
        refEvents = Database.database().reference().child("events");     // Do any additional setup after loading the view.
        
    }

  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModal.ETypes.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModal.ETypes[row].type
    }
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedValue = self.viewModal.ETypes[lstEventType.selectedRow(inComponent: 0)].type
    }
    
    func getDateSelected(datePicker: UIDatePicker) -> String? {
        let dateFormatter = DateFormatter()
        // Now we specify the display format, e.g. "27/08/2018
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        // Now we get the date from the UIDatePicker and convert it to a string
        
        
        return dateFormatter.string(from: datePicker.date)
    }
    
    func UpdateEvent(){
        let eventId = refEvents.childByAutoId().key
        
        let event = ["id":eventId,
                     "EventName":txtEventName.text as String?,
                     "EventDesc":txtEventDescription.text as String?,
                     "EventLocation":txtLocation.text as String?,
                     "EventType":self.selectedValue as String?,
                     "EventStartDate":self.getDateSelected(datePicker: self.dpStartDate) as String?,
                     "EventEndDate":self.getDateSelected(datePicker: self.dpEndDate) as String?,
                     "CreatorId":self.viewModal.userid,
                     "Active":self.switchIsActive.isOn ? 1 : 0
            ] as [String : Any]
        
        refEvents.child(eventId).setValue(event)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 
    @IBAction func saveEvent(_ sender: Any) {
        self.UpdateEvent()
    }
}
