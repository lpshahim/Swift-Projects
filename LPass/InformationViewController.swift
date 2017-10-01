//
//  InformationViewController.swift
//  LPass
//
//  Created by Louis-Philip Shahim on 2017/04/11.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import FirebaseDatabase



class InformationViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var socialText: UITextField!
    @IBOutlet weak var charLengthText: UITextField!
    @IBOutlet weak var newPassText: UITextField!
    
    let rootRef = FIRDatabase.database().reference()
    
    var updateArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let passCell = fireArray[myIndex]
        //self.navigationItem.title = mySocialCopy[myIndex]
        //passwordText.text = mySocialPass[myIndex]
        passwordText.text = passCell.socialPass
        nameText.text = "Louis-Philip"
        //socialText.text = mySocialCopy[myIndex]
        socialText.text = passCell.socialName
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changeBTapped(_ sender: Any) {
        
    }

    @IBAction func generateBTapped(_ sender: Any) {
        let chosenLen = Int(charLengthText.text!)
        let check = chosenLen! % 3
        if (check != 0){
            charLengthText.text = "Choose a length divisible by 3"
        }else{
            newPassText.text = createNewPass(name: nameText.text!, social: socialText.text!, size: chosenLen!)
        }
        
        
        
        //let chosenLen = charLengthText.text
        //newPassText.text = randomString(length: Int(chosenLen!)!)
        
        //createNewPass(name: nameText.text!, social: socialText.text!, number: charLengthText.text!, size: 10)

    }
    
    @IBAction func saveBTapped(_ sender: Any) {
        //passCell.socialName = socialText.text
        //passCell.socialPass = newPassText.text
        
        _ = rootRef.child("Passwords").observe(.value, with: { (snapshot) in
            
            if snapshot.exists(){
                
                for item in snapshot.children{
                    
                    guard let itemSnapshot = item as? FIRDataSnapshot else {break}
                    let id = itemSnapshot.key
                    
                    self.updateArr.append(id)
                }
                print(myIndex)
                for i in 0...self.updateArr.count{
                    if i == myIndex {
                        print("UPDATE")
                        print(self.updateArr[i])
                        let updatePath = self.updateArr[i]
                        let ref = FIRDatabase.database().reference().child("Passwords").child(updatePath)
                        ref.setValue(["socialName" : self.socialText.text, "socialPass" : self.newPassText.text])
                        //ref.removeValue()
                    }
                }
            }
        })
        
        
        
        //createPass(length: 10)
        
        //createNewPass(name: nameText.text!, social: socialText.text!, number: charLengthText.text!, size: 10)
        
        
    }
    
    //random generator
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
    
    func createRandomNameChars(text : String) -> String{
        var nameCharArr = [Character]()
        var randName = ""
        
        for nameChar in (text.characters) {
            let rand1 = Int(arc4random_uniform(UInt32(nameCharArr.count)))
            nameCharArr.append(nameChar)
            //check += String(nameChar)
            randName += String(nameCharArr[rand1])
        }
        
        return randName
    }
    
    func createRandomSocialChars(text : String) -> String{
        
        var socialCharArr = [Character]()
        
        var randSocial = ""
        
        for socialChar in (text.characters){
            let rand2 = Int(arc4random_uniform(UInt32(socialCharArr.count)))
            socialCharArr.append(socialChar)
            randSocial += String(socialCharArr[rand2])
        }
        
        return randSocial
        
    }
    
    func createRandomNumbers() -> String{
        
        var randNum = ""
        
        for _ in 0..<20 {
            let rand = Int(arc4random_uniform(UInt32(10)))
            randNum += String(rand)
        }
        
        return randNum
    }
    
    func createNewPass(name : String, social : String, size : Int) -> String{
        
        let n = createRandomNameChars(text: name) + createRandomNameChars(text: name)
        let s = createRandomSocialChars(text: social) + createRandomSocialChars(text: social)
        let num = createRandomNumbers()
        
        var newP = ""
        
        var count = 0
        
        while count < size {
            
            let index1 = n.characters.index(n.startIndex, offsetBy: count)
            
            let index2 = s.characters.index(s.startIndex, offsetBy: count)
            
            let index3 = num.characters.index(num.startIndex, offsetBy: count)
            
            let nextChar1 = n[index1]
            let nextChar2 = s[index2]
            let nextChar3 = num[index3]
            
            
            newP += "\(nextChar1)\(nextChar2)\(nextChar3)"
            count = newP.characters.count
            
        }
        print(newP)
        return newP
    }
    
    

}
