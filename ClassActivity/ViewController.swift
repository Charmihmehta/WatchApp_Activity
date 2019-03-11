//
//  ViewController.swift
//  ClassActivity
//
//  Created by Charmi Mehta on 2019-03-07.
//  Copyright © 2019 Charmi Mehta. All rights reserved.
//

import UIKit
import WatchConnectivity

//struct listGame{
//    var list:String
//    var date: String
//    var flag: Bool
//}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    var wcSession : WCSession!
    
    var listGame : [[String : String]] = []
    
   
    //let dic1  = NSMutableDictionary()
  //  var listgame = [listGame(list: "Germany-China", date: "08 June 2019", flag: true) , listGame(list: "Spain-South Africa", date: "08 June 2019", flag: true), listGame(list: "Norway-Nigeria" , date: "08 June 2019", flag: true), listGame(list: "Austraila-Italy", date: "09 June 2019", flag: true), listGame(list: "Brazil-Jamaica" , date: "0 June 2019", flag: true), listGame(list: "England-Scotland", date: "09 June 2019", flag: true)]
    
    
    
    
   
    // MARK: - WCSessionDelegate
    


    


    
    override func viewDidAppear(_ animated: Bool) {
        
        listGame = [["Team" : "Germany-China", "Date" : "08 June 2019" , "Flag" : "0", "image1" : "brazil" , "image2" : "china"], ["Team" : "Spain-South Africa", "Date" : "08 June 2019" , "Flag" : "0", "image1" : "spain" , "image2" : "south-africa"], ["Team" : "Norway-Nigeria", "Date" : "08 June 2019" , "Flag" : "0", "image1" : "norway" , "image2" : "nigeria"] , ["Team" :"Austraila-Italy", "Date" : "09 June 2019" , "Flag" : "0" ,"image1" : "australia" , "image2" : "flag"],  ["Team" : "Brazil-Jamaica", "Date" : "09 June 2019" , "Flag" : "0" ,"image1" : "brazil" , "image2" : "jamaica"], ["Team" : "England-Scotland", "Date" : "09 June 2019" , "Flag" : "0", "image1" : "england" , "image2" : "scotland"]]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // createGameObjects()
        let demoData = ["demoKey" : listGame]
        wcSession.sendMessage(demoData, replyHandler: nil) { (err) in
            print(err.localizedDescription)
        }
        var subList  = [[String:String]]()
        for game in listGame{
            if(game["Flag"] == "1"){
                subList.append(game)
            }
        }
        
//        let demoData1 = ["Kaik": subList]
//        wcSession.sendMessage(demoData1, replyHandler: nil) { (err) in
//            print(err.localizedDescription)
//        }
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
     
        
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        
        

        
        //MARK: Game object function
        
      
        //MARK: Table view delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
        

    }
    
    //MARK: Table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
  
        cell.textLabel?.text = listGame[indexPath.row]["Team"] 
        cell.detailTextLabel?.text = listGame[indexPath.row]["Date"]
        if(listGame[indexPath.row]["Flag"]  == "1"){
            cell.subscribeBtn.setTitle("Unsubscribe", for: .normal)
        }
        else{
            cell.subscribeBtn.setTitle("Subscribe", for: .normal)
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
        
        listGame[no]["Flag"]  = listGame[no]["Flag"] == "1" ? "0" : "1"
        
        
       let demoData = ["demoKey" : listGame]
        
        wcSession.sendMessage(demoData, replyHandler: nil) { (err) in
            print(err.localizedDescription)
        }
        print(no)
//        var alert = UIAlertController(title: "Warning", message: "Aler for Send data\(demoData)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
//        present(alert, animated: true)
        tableView.reloadData()
        
    }


}

