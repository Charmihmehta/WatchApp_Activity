//
//  InterfaceController.swift
//  ClassActivity WatchKit Extension
//hghsadf

//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved.hggdhsgchs jbjhkh
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController , WCSessionDelegate{
    

    
    
    var session : WCSession?
    var data : [[String : String]] = [] // Updated data
    var dataSub : [[String : String]] = [] // old data

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("%@", "activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
        //load()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        dataSub = data
        if(message["demoKey"] != nil)
        {
            data = message["demoKey"] as! [[String : String]]
            print(data)
        
       // var subList  = [[String:String]]()
       
        
        //let demoData = ["Kaik": subList]
        }
        
        for newData in data{
            for oldData in dataSub{
                if(oldData["Team"] == newData["Team"]){
                    if(oldData["Flag"] != newData["Flag"]){
                        
                        print("you have \(newData["Flag"] == "1" ? "Subscribed" : "Unsubscribed") \(oldData["Team"]!)")
                    }
                }
            }
            
        }
//        if(message["Kaik"] != nil){
//
//            dataSub = message["Kaik"] as! [[String : String]]
//
//        }
        
    }
    
    override func awake(withContext context: Any?) {
        
        if(context != nil){
        
         data = context as! [[String : String]]
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
     
        session = WCSession.default
        session?.delegate = self
        session?.activate()
        

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func btnSchedule() {
        //print("button clicked  \(data)")
       self.pushController(withName: "scheduleController", context: self)
    }
    
    @IBAction func btnSubscribe() {
       
       // print("button clicked  \(data)")
        
        self.pushController(withName: "subscribeController", context: self)
    }
}
