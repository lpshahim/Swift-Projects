//
//  GalleryCollectionViewController.swift
//  OutReach
//
//  Created by Louis-Philip Shahim on 2017/05/30.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"



class GalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var gallery = [Gallery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()

        collectionView?.backgroundColor = UIColor.white
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    
    func fetchPosts(){
        
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let gal = Gallery()
                gal.setValuesForKeys(dictionary)
                self.gallery.append(gal)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            }
            
            
        }, withCancel: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return gallery.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        let gal = gallery[indexPath.row]
        captionLabel.text = gal.caption
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    @IBAction func cancelBTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

}

/*class PhotoCell: UICollectionViewCell {
    
    var posts = [Post]()
    
    let ref = FIRDatabase.database().reference().child("posts")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getCaption(checkString: self.captionLabel)
        setupViews()
    }
    
    func getCaption(checkString : UILabel){
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                
                //checkString.text = dictionary["caption"] as? String
            }
        }, withCancel: nil)
    }
    
    let thumbNailImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "golf")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var captionLabel : UILabel = {
        let caption = UILabel()
        caption.backgroundColor = UIColor.white
        caption.translatesAutoresizingMaskIntoConstraints = false
        let post = Post()
        caption.text = post.caption
        //caption.text = "Posted by: "
        return caption
    }()
    
    let separatorView :UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        getCaption(checkString: captionLabel)
        addSubview(thumbNailImageView)
        addSubview(separatorView)
        addSubview(captionLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbNailImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbNailImageView]))
        
       addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .top , relatedBy: .equal, toItem: thumbNailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .left, relatedBy: .equal, toItem: thumbNailImageView, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .top , relatedBy: .equal, toItem: separatorView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: captionLabel, attribute: .bottom, relatedBy: .equal, toItem: separatorView, attribute: .top, multiplier: 1, constant: -8))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":separatorView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":separatorView]))

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}*/
