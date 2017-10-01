//
//  PostsTableViewController.swift
//  OutReach
//
//  Created by Louis-Philip Shahim on 2017/05/21.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase

class PostsTableViewController: UITableViewController {

    let cellId = "cellId"
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
        
    }
    @IBAction func cancelBTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchPosts(){
        
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post()
                post.setValuesForKeys(dictionary)
                self.posts.append(post)
                
                print(self.posts)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.caption
        cell.detailTextLabel?.text = "Posted by: " + post.userName!
        //cell.imageView?.image =
        
        
        DispatchQueue.main.async {
            
        
        if let postImageURL = post.imageURL{
            
            cell.imageView?.loadImagePostsFromURL(urlString: postImageURL)
            
        }}
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }

    
}

class PostCell:UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
