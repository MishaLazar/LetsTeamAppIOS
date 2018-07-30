//
//  LoginViewController.swift
//  LetsTeamApp
//
//  Created by admin on 7/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLoginRegister: UIButton!
    @IBOutlet weak var LogoUiImageView: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var segLoginRegister: UISegmentedControl!
    
    var logoImg:UIImage = #imageLiteral(resourceName: "mainLogo")
    var refUsers: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refUsers = Database.database().reference().child("users");
        // Do any additional setup after loading the view, typically from a nib.
    changeLoginRegisterInterfaceBySelectedSegment(segLoginRegister.selectedSegmentIndex)
        LogoUiImageView.image = logoImg
    }
    
    
    @IBAction func segLoginRegisterTuched(_ sender: Any) {
    changeLoginRegisterInterfaceBySelectedSegment(segLoginRegister.selectedSegmentIndex)
    }
    func changeLoginRegisterInterfaceBySelectedSegment(_ index:Int){
        /*need to remove targets*/
        btnLoginRegister.removeTarget(nil, action: nil, for: .allEvents)
        
        switch index {
        case 0:
            txtName.isHidden = false
            btnLoginRegister.setTitle("Register", for: UIControlState())
            btnLoginRegister.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        case 1:
            txtName.isHidden = true
            btnLoginRegister.setTitle("Login", for: UIControlState())
            btnLoginRegister.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        default:
            break;
        }    }
    
    @objc func handleLogin(){
        print("login clicked")
/*
        let email: String = txtEmail.text!
        let password: String = txtPassword.text!
        refUsers.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                                //iterating through all the values
                for users in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = users.value as? [String: AnyObject]
                    let userEmail = userObject?["email"] as? String
                    let userPassword = userObject?["password"] as? String
                    
                    if userEmail == email && userPassword == password {
                        print("login ok")
                        break
                    }
                    
                }
            }
        })*/
        
        switchToMainScreen()
        
    }
    
    @objc func handleRegister(){
        let key = refUsers.childByAutoId().key
        
        let user = ["id":key,
                      "name": txtName.text! as String,
                      "email": txtEmail.text! as String,
                      "password":txtPassword.text! as String
        ]
    
        refUsers.child(key).setValue(user)
    }
    
    func switchToMainScreen() {
        let mainViewController = MainViewController()
        let new = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: mainViewController)

    }
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        self.willMove(toParentViewController: nil)
        addChildViewController(new)
        
        transition(from: self, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.removeFromParentViewController()
            new.didMove(toParentViewController: self)
           
            completion?()  //1
        }
    }
}
