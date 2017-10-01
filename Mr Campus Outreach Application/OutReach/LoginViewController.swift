//
//  ViewController.swift
//  OutReach
//
//  Created by Louis-Philip Shahim on 2017/04/20.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var loginRegisterButton: SpringButton!
    @IBOutlet weak var loginUsernameTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginView: SpringView!
    
    @IBOutlet weak var registerNameTextField: UITextField!
    
    @IBOutlet weak var registerUsernameTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerView: SpringView!
    
    let mainVC = MainViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        handleLoginRegister()
        
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func moveButton(check : Int){
        if check == 0{
            loginRegisterButton.frame.origin = CGPoint(x: 42, y: 315)
            loginView.isHidden = false
            registerView.isHidden = true
            loginRegisterButton.setTitle("Login", for: .normal)
        }else{
            loginRegisterButton.frame.origin = CGPoint(x: 42, y: 349)
            loginView.isHidden = true
            registerView.isHidden = false
            loginRegisterButton.setTitle("Register", for: .normal)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moveButton(check: 0)
    }
    
    @IBAction func loginRegisterBTapped(_ sender: Any) {
        //doSomething()
        loginRegisterButton.animation = "pop"
        loginRegisterButton.duration = 1.0
        loginRegisterButton.animate()
        handleLoginRegister()
    }
    
    func doSomething(){
        _ = animation(toAnimate: "loginView", chosenAnimation: "flash")
    }
    
    func animation(toAnimate : String, chosenAnimation: String) -> String{
        let stringAnimate = "\(toAnimate).animation" + "= \"\(chosenAnimation)\""
        let duration = "\(toAnimate).duration = 1.0"
        let animateFunction = "\(toAnimate).animate()"
        
        
        return (stringAnimate + "\n" + duration + "\n" + animateFunction)
    }
    
    func handleRegister(){
        guard let name = registerNameTextField.text, let email = registerUsernameTextField.text, let password = registerPasswordTextField.text else{
            
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if (error != nil){
                print(error!)
                self.registerView.animation = "shake"
                self.registerView.duration = 1.0
                self.registerView.animate()
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://mr-campus.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            
            let values = ["name" : name, "email" : email]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if (err != nil){
                    print(err!)
                    return
                }
                print("Successfully saved to db")
                
                self.handleMainNav()
            })
            
        })
        
    }
    
    func handleLogin() {
        guard let email = loginUsernameTextField.text, let password = loginPasswordTextField.text else{
            return
        }
        
        if email == "" || password == "" {
            loginRegisterButton.animation = "pop"
            loginRegisterButton.duration = 1.0
            loginRegisterButton.animate()
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            
            if err != nil{
                print(err!)
                self.loginView.animation = "shake"
                self.loginView.duration = 1.0
                self.loginView.animate()
                return
            }
            
            print("Successfully logged in")
            
            self.handleMainNav()
            
            
            
        })
    }
    
    func handleMainNav(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func handleLoginRegister(){
            if( segmentControl.selectedSegmentIndex == 0){
                handleLogin()
                
            }else{
                handleRegister()
                
            }
        
        
    }
    
    @IBAction func segmentControlBTapped(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            moveButton(check: 0)
        }else{
            moveButton(check: 1)
        }
        
        
        
        
    }
    



}

