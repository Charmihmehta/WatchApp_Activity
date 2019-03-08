//
//  InterfaceController.swift
//  ClassActivity WatchKit Extension
//hghsa

//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved.hggdhsgchs jbjhkh
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController , WCSessionDelegate{
    
//
    @IBOutlet weak var messageLabel: WKInterfaceLabel!
      var session : WCSession?
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("%@", "activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        NSLog("didReceiveApplicationContext : %@", applicationContext)
        WKInterfaceDevice().play(.click)
        
        // output a debug message to the terminal
        print("Got a message!")
        messageLabel.setText(applicationContext["message"] as? String)
    }
   
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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

}
