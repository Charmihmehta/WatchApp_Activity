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
    
   @IBOutlet weak var messageLabel: WKInterfaceLabel!
    @IBOutlet weak var WatchTable: WKInterfaceTable!
    
    
    var session : WCSession?
     var MessageData = NSMutableDictionary()
    var tableData = [String]()
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("%@", "activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
        //load()
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        NSLog("didReceiveApplicationContext : %@", applicationContext)
        WKInterfaceDevice().play(.click)
        
        // output a debug message to the terminal
        print("Got a message!")
        messageLabel.setText(applicationContext["message"] as? String)
        DispatchQueue.main.async { () -> Void in

            if let retrievedArray1 = applicationContext["Array"] as? [String] {
                self.tableData = retrievedArray1
                print(self.tableData)
            }
            for (index, thName) in self.tableData.enumerated() {
                let row2 = self.WatchTable.rowController(at: index) as! MenuItemController
//                let texxt = row2.placeLabel.setText(thName)
//                print("Inside ??.. \(texxt)")
            }
        }
    }
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if WCSession.isSupported()
        {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
    }
//    func load(){
//        
//        func session(session: WCSession, didRecieveApplicationContext applicationContext: [String : Any]) {
//            
//            DispatchQueue.main.async() { () -> Void in
//                if let retreivedArray = applicationContext["Array"] as? [String] {
//                    self.tableData = retreivedArray
//                    print(self.tableData)
//                }
//            }
//        }
//    }
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
