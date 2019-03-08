//
//  ViewController.swift
//  ClassActivity
//
//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved.
//

import UIKit
import WatchConnectivity

struct listGame{
    var list:String
    var date: String
    var flag: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,WCSessionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var subscribeBtn: UIButton!
    var wcSession : WCSession!
    
    var listgame = [listGame(list: "Germany-China", date: "08 June 2019", flag: true) , listGame(list: "Spain-South Africa", date: "08 June 2019", flag: true), listGame(list: "Norway-Nigeria" , date: "08 June 2019", flag: true), listGame(list: "Austraila-Italy", date: "09 June 2019", flag: true), listGame(list: "Brazil-Jamaica" , date: "0 June 2019", flag: true), listGame(list: "England-Scotland", date: "09 June 2019", flag: true)]
  
//    let list = ["Germany-China" ,"Spain-South Africa","Norway-Nigeria" , "Austraila-Italy" , "Brazil-Jamaica" , "England-Scotland"]
//    let date = ["08 June 2019" , "08 June 2019" , "08 June 2019" , "09 June 2019", "09 June 2019", "09 June 2019"]
    
    
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listgame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
      // var cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell") as! TableViewCell
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell") as! TableViewCell
//        }
        cell.textLabel?.text = listgame[indexPath.row].list
        cell.detailTextLabel?.text = listgame[indexPath.row].date
        if(listgame[indexPath.row].flag == true){
            cell.subscribeBtn.setTitle("Subscribe", for: .normal)
        }
        else{
            cell.subscribeBtn.setTitle("Unsubscribe", for: .normal)
        }
    
        cell.subscribeBtn.tag = indexPath.row
        cell.subscribeBtn.addTarget(self, action: "BtnAction:", for: .allEvents)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    @IBAction func BtnAction(_ sender: UIButton){
        print("You have clicked subscribe to the notification")
        let no = sender.tag
        
        listgame[no].flag = listgame[no].flag == true ? false : true
        tableView.reloadData()
        print(no)
        
    }

    @IBAction func btnClick(_ sender: Any) {
       if(subscribeBtn.titleLabel?.text == "Subscribe")
       {
         print("You have subscribe to the notification")
          NSLog("%@", "button 1")
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
        NSLog("%@", "button 2")
            subscribeBtn.setTitle("Subscribe", for: .normal)
       
        }
    }
    


}

