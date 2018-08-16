//
//  UTils.swift
//  LetsTeamApp
//
//  Created by admin on 8/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class Utills {
    
    
    
    static let shared = Utills()
    
    
    func dateToString(date:Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy hh:mm:ss"
       
        
        return  df.string(from: date)
        
    }
}
