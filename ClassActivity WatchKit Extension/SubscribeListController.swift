//
//  SubscribeListController.swift
//  ClassActivity WatchKit Extension
//
//  Created by Charmi Mehta on 2019-03-09.
//  Copyright © 2019 Charmi Mehta. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

class SubscribeListController: WKInterfaceController, WCSessionDelegate {

    
    var session : WCSession!
    var subList : [[String:String]] = []
    var interFace : InterfaceController!
    var data : [[String : String]] = [] // old data
     var dataSub : [[String : String]] = [] // old data
    
    
 
    //var listgame : [listGame] = []
    
    @IBOutlet weak var gameListTable: WKInterfaceTable!
    
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
        subList = []
        for game in data{
            if(game["Flag"] == "1"){
                subList.append(game)
            }
        }
        
        
        var index = 0
        if(subList.count == 0){
            self.gameListTable.setNumberOfRows(1, withRowType: "subscribeRow")
            let row = self.gameListTable.rowController(at: index) as! SubscribeCellController
            row.teamLable.setText("NO GAMES ")
            row.datelabel.setText("")
            
        }else{
            self.gameListTable.setNumberOfRows(subList.count, withRowType: "subscribeRow")
            for game in subList {
                
                let row = self.gameListTable.rowController(at: index) as! SubscribeCellController
                row.flag1.setImage(UIImage(named: game["image1"]!))
              //  print("--------------\(game["image1"]!)")
                row.flag2.setImage(UIImage(named: game["image2"]!))
                row.teamLable.setText(game["Team"] )
                row.datelabel.setText(game["Date"] )
                index = index + 1
            }
            
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
    }
    
    
    
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //        if(WCSession.isSupported()){
        session = WCSession.default
        //session?.delegate = self
        session.delegate = self
        session.activate()
        
    
        
        
    }
    override func awake(withContext context: Any?) {
        interFace = context as! InterfaceController
        
        var data :  [[String : String]] = []
        data = interFace.data
//        subList = []
        for game in data{
            if(game["Flag"] == "1"){
                subList.append(game)
            }
        }
        
        
        
        var index = 0
       
        
        if(subList.count == 0){
             self.gameListTable.setNumberOfRows(1, withRowType: "subscribeRow")
            let row = self.gameListTable.rowController(at: index) as! SubscribeCellController
            row.teamLable.setText("NO GAMES ")
            row.datelabel.setText("")
            
        }else{
         self.gameListTable.setNumberOfRows(subList.count, withRowType: "subscribeRow")
        for game in subList {
            
            let row = self.gameListTable.rowController(at: index) as! SubscribeCellController
            row.flag1.setImage(UIImage(named: game["image1"]!))
            // print("--------------\(game["image1"]!)")
            row.flag2.setImage(UIImage(named: game["image2"]!))
            row.teamLable.setText(game["Team"] )
            row.datelabel.setText(game["Date"] )
            index = index + 1
        }
        
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
      //  pushController(withName: "MainInterface", context: subList)
        
    }

}
