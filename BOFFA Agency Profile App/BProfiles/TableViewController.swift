//
//  RightSideViewController.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/28.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct postStruct {
    let title : String!
    let message: String!
}

class TableViewController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tblView: UITableView!
    
    var posts = [postStruct]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

       let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Posts").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let title = snapshot.value!["Title"] as! String
            let message = snapshot.value!["Message"] as! String
            
            self.posts.insert(postStruct(title: title, message: message), at: 0)
            
            self.tableView.reloadData()
            
            
            
        })
        
        
        
        
        
        post()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func post(){
        
        let title = "Title"
        let message = "Message"
        
        let post : [String : AnyObject] = ["Title" : title as AnyObject , "Message" : message as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Posts").childByAutoId().setValue(post)
    
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection:Int) -> Int {
        
        return posts.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let nameLabel = cell?.viewWithTag(1) as! UILabel
        nameLabel.text = posts[(indexPath as NSIndexPath).row].title

        let categoryLabel = cell?.viewWithTag(2) as! UILabel
        categoryLabel.text = posts[(indexPath as NSIndexPath).row].message
        
        return cell!
        
        
        
    }
    
    
    
    

}
