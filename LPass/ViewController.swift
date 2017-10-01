//
//  ViewController.swift
//  LPass
//
//  Created by Louis-Philip Shahim on 2017/04/10.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ranPass = randomString(length: 10)
        
        print(ranPass)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }

    @IBAction func btnLogin(_ sender: Any) {
        
        let uName = username.text
        let pass = password.text
        
        /*if(uName == "lpshahim" && pass == "1240LpSh@him")
        {
            print("LOGGED IN")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.present(vc, animated: true, completion: nil)
        }else
        {
            print("Incorrect!")
        }*/
        
        FIRAuth.auth()?.signIn(withEmail: uName!, password: pass!, completion: {
            user, error in
            
            if (error != nil){
                print(error ?? "LOGIN FAILED")
                
            }else{
                
                //Navigate to protected page
                let _:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                print("user logged in")
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewControllerStory") as! MainViewController
                self.present(vc, animated: true, completion: nil)
                
                
                
            }
        })

        
        
    }

}

