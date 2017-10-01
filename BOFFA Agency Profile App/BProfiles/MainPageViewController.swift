//
//  MainPageViewController.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/28.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase
import pop
import FirebaseDatabase

class MainPageViewController: UIViewController {
    
    //connections
    @IBOutlet weak var viewBtn: CustomButton!
    @IBOutlet weak var nextBtn: CustomButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    var rootRef = FIRDatabase.database().reference()
    
    var ref: FIRDatabaseReference!
    
    var currentCard: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
       
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutBTapped(_ sender: AnyObject) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("Signed out")
            //Navigate to protected page
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            let logInPage:ViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            let logInPageNav = UINavigationController(rootViewController:logInPage)
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = logInPageNav
            
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }
    
    //next button pressed
    @IBAction func nextBTapped(_ sender: AnyObject) {
        showNextCard()
        artistLabel.text = currentCard.currentArtist
    }
    
    
    //card functions
    func createCardFromNib() -> Card? {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            } as! ((POPAnimation?, Bool) -> Void))
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if viewBtn.isHidden {
                viewBtn.isHidden = false
                nextBtn.setTitle("YES", for: UIControlState())
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
            } as! ((POPAnimation?, Bool) -> Void))
            
        }
        
        
    }
    
    @IBAction func viewBTapped(_ sender: AnyObject) {
        writeData()
        //removeData()
        //viewData()
    }
    
    
    //retrieve data from firebase
    func writeData(){
        let text = "Artist"
        let viewArtist = currentCard.currentArtist
        let userData = ["text": text, "view": viewArtist]
        self.rootRef.childByAutoId().setValue(userData)
    }
    
    func removeData(){
        self.rootRef.removeValue()
    }
    
    func viewData(){
        print("\(self.rootRef.childByAutoId().queryOrdered(byChild: "Facebook"))")
    }
    
    
    

}
