//
//  MainViewController.swift
//  OutReach
//
//  Created by Louis-Philip Shahim on 2017/05/19.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: SpringImageView!
    @IBOutlet weak var captionTextField: SpringTextField!
    
    @IBOutlet weak var postButton: SpringButton!
    var imagePicker : UIImagePickerController!
    
    var username : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        imageView.animation = "easeInOut"
        imageView.duration = 1.0
        imageView.animate()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        if uid == nil{
            handleLogout()
        }else{
            print(uid!)
            
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject]{
                self.username = dictionary["name"] as? String
                self.navigationItem.title = self.username
                }
            }, withCancel: nil)
        }
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageToBeUploaded)))
        imageView.isUserInteractionEnabled = true
    }
    @IBAction func postBTapped(_ sender: Any) {
        handleUploadImageToStorage()
    }
    
    func reset(){
        captionTextField.text = ""
        imageView.image = UIImage(named : "MMK.png")
        
        postButton.animation = "slideUp"
        postButton.duration = 1.0
        postButton.animate()
        
        captionTextField.animation = "slideUp"
        captionTextField.duration = 1.0
        captionTextField.animate()
        
        
        
        
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func handleUploadImageToStorage(){
        let myUID = FIRAuth.auth()?.currentUser?.uid
        let imageCaption = captionTextField.text
        let imageName = NSUUID().uuidString
        
        
        let storageRef = FIRStorage.storage().reference().child("image_posts").child("\(imageName).png")
        
        let uploadData = UIImagePNGRepresentation(self.imageView.image!)
        
        storageRef.put(uploadData!, metadata: nil) { (metadata, error) in
            
            if error != nil{
                print(error!)
                return
            }
            
            if let postImageURL = metadata?.downloadURL()?.absoluteString{
                let myValues = ["uid" : myUID,"caption" : imageCaption, "imageURL" : postImageURL, "userName" : self.username] as [String : AnyObject]
                
                self.addImagePostToStorage(uid: myUID!, values: myValues)
            }
        }
        
        let when =  DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            self.reset()
            
        }
        
    }
    
    
    func addImagePostToStorage(uid : String, values : [String : AnyObject]){
        
                let ref = FIRDatabase.database().reference(fromURL: "https://mr-campus.firebaseio.com/")
                let usersReference = ref.child("posts").childByAutoId()
        
                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if (err != nil){
                        print(err!)
                        return
                    }
                    print("Successfully saved to db")
                })
    }
    
    func handleImageToBeUploaded(){
        print("You have tapped")
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        

        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutBTapped(_ sender: Any) {
            handleLogout()
    }
    
    func handleLogout(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }

}

