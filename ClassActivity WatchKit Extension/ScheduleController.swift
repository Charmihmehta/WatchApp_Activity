//
//  ScheduleController.swift
//  ClassActivity WatchKit Extension
//
//  Created by Charmi Mehta on 2019-03-09.
//  Copyright © 2019 Charmi Mehta. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

struct listGame{
    var list:String
    var date: String
    var flag: Bool
}

class ScheduleController: WKInterfaceController, WCSessionDelegate {
   
    
    
     var session : WCSession!
    var interFace : InterfaceController!
    var data : [[String: String]] = []
    
     var dataSub : [[String : String]] = [] // old data
    
    
    @IBOutlet weak var demoLabel: WKInterfaceLabel!
    //var listgame : [listGame] = []
    
    @IBOutlet weak var gameTable: WKInterfaceTable!
    
   // var game : [GameObject] = []
    
    //MARK: Session function
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
          NSLog("%@", "activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
       // print("######zero----")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
       // print("Message receive")
        
        dataSub = data
         data = message["demoKey"] as! [[String : String]]
        interFace.data = data
        var index = 0
        self.gameTable.setNumberOfRows(data.count, withRowType: "row1")
        for game in data {
            let row = self.gameTable.rowController(at: index) as! ScheduleCellController
            // row.countryFlag.setImage(UIImage(named:country.image!))
            print("inside")
            row.flag1.setImage(UIImage(named: game["image1"]!))
           // print("--------------\(game["image1"]!)")
            row.flag2.setImage(UIImage(named: game["image2"]!))
            row.teamLabel.setText(game["Team"])
            row.dateLabel.setText(game["Date"] )
            index = index + 1
        
        }
        
        for newData in data{
            for oldData in dataSub{
                
//                print("Data For old: \(oldData["Team"]!), Flag: \(oldData["Flag"]!) -> new: \(newData["Team"]!), Flag: \(newData["Flag"]!)")
                
                if(oldData["Team"] == newData["Team"]){
                    if(oldData["Flag"] != newData["Flag"]){
                        
                        print("you have \(newData["Flag"] == "1" ? "Subscribed" : "Unsubscribed") \(oldData["Team"]!)")
                    }
                }
            }
            
        }
    }
    
    

    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
//        if(WCSession.isSupported()){
            session = WCSession.default
        //session?.delegate = self
            session.delegate = self
            session.activate()
        
       // interFace = InterfaceController()
        
      
        
    }
    override func awake(withContext context: Any?) {
         interFace = context as! InterfaceController
        
        
        var data : [[String : String]] = []
        data = interFace.data
       // print(data)
        var index = 0
        self.gameTable.setNumberOfRows(data.count, withRowType: "row1")
        for game in data {
            let row = self.gameTable.rowController(at: index) as! ScheduleCellController
            row.flag1.setImage(UIImage(named: game["image1"]!))
            // print("--------------\(game["image1"]!)")
            row.flag2.setImage(UIImage(named: game["image2"]!))
            row.teamLabel.setText(game["Team"] )
            row.dateLabel.setText(game["Date"] )
            index = index + 1
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

