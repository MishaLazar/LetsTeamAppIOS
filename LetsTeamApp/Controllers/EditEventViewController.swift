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
class EditEventViewController: UIViewController {
    var refEvents: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        refEvents = Database.database().reference().child("events");     // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveNewEvent(){
        let key = refEvents.childByAutoId().key
        
        /*let user = ["id":key,
                    "name": txtEventName.text! as String,
                    "email": txtEventDesc.text! as String,
                    "password":txtPassword.text! as String
        ]*/
        
        //refEvents.child(key).setValue(user)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
