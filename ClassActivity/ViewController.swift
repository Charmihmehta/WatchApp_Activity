//
//  ViewController.swift
//  ClassActivity
//
//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved. jkjk
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,WCSessionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var subscribeBtn: UIButton!
    var wcSession : WCSession!
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
    }
    
    let list = ["Germany-China" ,"Spain-South Africa","Norway-Nigeria" , "Austraila-Italy" , "Brazil-Jamaica" , "England-Scotland"]
    let date = ["08 June 2019" , "08 June 2019" , "08 June 2019" , "09 June 2019", "09 June 2019", "09 June 2019"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = list[indexPath.row]
        cell.detailTextLabel?.text = date[indexPath.row]
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    

    @IBAction func btnClick(_ sender: Any) {
       if(subscribeBtn.titleLabel?.text == "Subscribe")
       {
         print("You have subscribe to the notification")
            subscribeBtn.setTitle("UnSubscribe", for: .normal)
        
        let message = ["message" : "message sent"]
        do {
            try wcSession.updateApplicationContext(message)
        } catch {
            print("Something went wrong")
        }
       
        }
       else if (subscribeBtn.titleLabel?.text == "UnSubscribe"){
          print("You have Not subcribe to the notification")
            subscribeBtn.setTitle("Subscribe", for: .normal)
       
        }
    }
    


}

