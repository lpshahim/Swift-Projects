//
//  MainViewController.swift
//  LPass
//
//  Created by Louis-Philip Shahim on 2017/04/10.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var mySocialCopy = [String]()
var mySocialPass = [String]()
var myIndex = 0
var passCell = Passwords()
var saveId = ""

var fireArray = [Passwords]()

var idArray = [String]()



var passwords = [
    "Facebook" : "12406458lpshahim",
    "Instagram": "1240lpshahim",
    "Twitter": "12406458lpshahim",
    "Udemy": "1240lp",
    "Google": "12406458LpShahim",
    "Xbox" : "1240Lpshahim",
    "iCloud" : "1240Lpshahim"]

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //firebase
    let rootRef = FIRDatabase.database().reference()
    
    //firebase array
    //var fireArray = [Passwords]()
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.register(PasswordCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.reloadData()
        
        //fetch for table
        fetchForTable()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //print(viewData())
        
        //mySocialCopy = Array(passwords.keys)
        //mySocialPass = Array(passwords.values)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return mySocialCopy.count
        return fireArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.cyan
        cell.detailTextLabel?.textColor = UIColor.white
        passCell = fireArray[indexPath.row]
        cell.textLabel?.text = passCell.socialName
        cell.detailTextLabel?.text = passCell.socialPass
        //cell.textLabel?.text = mySocialCopy[indexPath.row]
        
        
        return cell
        
    }
    
    class PasswordCell : UITableViewCell{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        print(myIndex)
        performSegue(withIdentifier: "segue", sender: self)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            _ = rootRef.child("Passwords").observe(.value, with: { (snapshot) in
                
                if snapshot.exists(){
                    
                    for item in snapshot.children{
                        
                        guard let itemSnapshot = item as? FIRDataSnapshot else {break}
                        let id = itemSnapshot.key
                        
                        idArray.append(id)
                    }
                    print(indexPath.row)
                    for i in 0...idArray.count{
                        if i == indexPath.row {
                            print("DELETE")
                        print(idArray[i])
                            let delPath = idArray[i]
                            let ref = FIRDatabase.database().reference().child("Passwords").child(delPath)
                            ref.removeValue()
                        }
                    }
                }
            })
            
            fireArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        addSocialInfo()
        
    }
    @IBAction func logoutBTapped(_ sender: Any) {
        
        handleLogout()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    func addSocialInfo(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Social Media", message: "Enter the platform name", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textFieldName) in
            textFieldName.text = ""
            
        }
        alert.addTextField { (textFieldPass) in
            textFieldPass.text = ""
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textFieldName = alert?.textFields![0] // Force unwrapping because we know it exists.
            let textFieldPass = alert?.textFields![1]
            
            if (textFieldName?.text != "" && textFieldPass?.text != ""){
                self.writeData(text: (textFieldName?.text)!, password: (textFieldPass?.text)!)
            }else{
                print("Enter fields")
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
 
    
    func writeData(text: String, password: String){
        
        let userData = ["socialName": text, "socialPass": password] as [String : Any]
        
        self.rootRef.child("Passwords").childByAutoId().setValue(userData)
        tableView.reloadData()
    }
    
    func handleLogout(){
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("Signed out")
            
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }
    
    func fetchForTable(){
        FIRDatabase.database().reference().child("Passwords").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let pass = Passwords()
                //pass.setValuesForKeys(dictionary)
                pass.socialName = dictionary["socialName"] as? String
                pass.socialPass = dictionary["socialPass"] as? String
                
                fireArray.append(pass)
                
                //mySocialCopy = Array(dictionary.keys)
                //mySocialPass = Array(dictionary.values) as! [String]
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            } else{print("Dictionary is not string of anyobject")}
            
            
        }, withCancel: nil)
    }
    
    

}
