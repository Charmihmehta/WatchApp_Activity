//
//  GameObject.swift
//  ClassActivity
//
//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved.
//

import UIKit

class GameObject: NSObject {
    // MARK: class properties
    var team:String?        // ! = this varaible will have a value
   
    var date:String?       // ? = this variable COULD be null
    
    // MARK: contructor
    convenience override init() {
        self.init(team:"Germany-China", date:"08 June 2019")
    }
    
    init(team:String, date:String) {
        self.team = team
        self.date = date
    }
    init(team:String){
         self.team = team
    }

}
