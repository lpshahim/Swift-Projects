//
//  ViewController.swift
//  WorkoutTimer
//
//  Created by Louis-Philip Shahim on 2017/04/13.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var setTimeText: UITextField!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setText: UITextField!
    @IBOutlet weak var restText: UITextField!
    
    var player : AVAudioPlayer?
    
    var myTimer = Timer()
    var myRestTimer = Timer()
    var counter = -1
    var sets = ""
    var setCounter = 0
    var rest = -1
    var totalTime = 0
    var totalRest = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clockView = ClockView(frame: view.frame)
        clockView.backgroundColor = UIColor.clear
        clockView.setTimer(value: 10)
        clockView.startClockTimer()
        view.addSubview(clockView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startBTapped(_ sender: Any) {
        counter = Int(setTimeText.text!)!
        rest = Int(restText.text!)!
        
        totalTime = counter
        totalRest = rest
        
        startTimer()
        
        sets = setText.text!
        
        enabled()
        
        displaySets()
        
    }
    
    func reset(){
        counter = -1
        sets = ""
        setCounter = 0
        rest = -1
        totalTime = 0
        totalRest = 0
    }
    
    func enabled(){
        setTimeText.text = ""
        setTimeText.isEnabled = false
        setText.text = ""
        setText.isEnabled = false
        restText.text = ""
        restText.isEnabled = false
    }
    
    func disabled(){
        setTimeText.text = ""
        setTimeText.isEnabled = true
        setText.text = ""
        setText.isEnabled = true
        restText.text = ""
        restText.isEnabled = true
        
        setLabel.text = "WELL DONE!"
    }
    
    func startTimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (ViewController.counterTimer), userInfo: nil, repeats: true)
    }
    
    func startRest(){
        myRestTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (ViewController.resting), userInfo: nil, repeats: true)
        player?.stop()
    }
    
    
    func stopTimer(){
        myTimer.invalidate()
        
    }
    
    func stopRest(){
        myRestTimer.invalidate()
    }
    
    func counterTimer(){
        
        
        if (counter == 0){
            print("TIMES UP!")
            counter = totalTime
            stopTimer()
            startRest()
            setLabel.text = "REST"
        }else{
            
            counter -= 1
            playSound()
            timerText.text = "\(counter)"
        }
        
    }
    
    func displaySets(){
        
        
        let check = Int(sets)! + 1
        
        setCounter += 1
        
        if (check == setCounter){
            print("Workout complete")
            player?.stop()
            stopTimer()
            stopRest()
            timerText.text = ":-)"
            disabled()
            reset()
        }else{
            setLabel.text = "Set: " + "\(setCounter) of "  + sets
        }
    }
    
    func resting(){
        
        if (rest == 0){
            print("rest done!")
            rest = totalRest
            stopRest()
            startTimer()
            displaySets()
        }else{
            setTimeText.text = ""
            
            rest -= 1
            
            timerText.text = "\(rest)"
        }
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "clock-ticking-2", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //************ Clock view ********************************
    
    class ClockView: UIView {
        
        private var shapeLayer = CAShapeLayer()
        private var countDownTimer = Timer()
        private var timerValue = 900
        private var label = UILabel()
        
        override init (frame : CGRect) {
            super.init(frame : frame)
            
            self.createLabel()
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("This class does not support NSCoding")
        }
        
       private func addCircle() {
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: 160,y: 240), radius: CGFloat(100), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2*M_PI-M_PI_2), clockwise: true)
            
            self.shapeLayer.path = circlePath.cgPath
            self.shapeLayer.fillColor = UIColor.clear.cgColor
            self.shapeLayer.strokeColor = UIColor.red.cgColor
            self.shapeLayer.lineWidth = 1.0
            
            self.layer.addSublayer(self.shapeLayer)
        }
        
        private func createLabel() {
            self.label = UILabel(frame: CGRect(x: 72, y: 220, width: 200, height: 40))
            
            self.label.font = UIFont(name: self.label.font.fontName, size: 40)
            self.label.textColor = UIColor.red
            
            self.addSubview(self.label)
        }
        
         private func startAnimation() {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            //animation.duration = Double(self.timerValue)
            animation.duration = Double(self.timerValue)
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            
            self.shapeLayer.add(animation, forKey: "ani")
        }
        
        private func updateLabel(value: Int) {
            self.setLabelText(value: self.timeFormatted(totalSeconds: value))
            self.addCircle()
        }
        
        private func setLabelText(value: String) {
            self.label.text = value
        }
        
        private func timeFormatted(totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            let hours: Int = totalSeconds / 3600
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        // Needs @objc to be able to call private function in NSTimer.
        @objc private func countdown(dt: Timer) {
            self.timerValue -= 1
            if self.timerValue < 0 {
                self.countDownTimer.invalidate()
            }
            else {
                self.setLabelText(value: self.timeFormatted(totalSeconds: self.timerValue))
            }
        }
        
        func setTimer(value: Int) {
            self.timerValue = value
            self.updateLabel(value: value)
        }
        
        func startClockTimer() {
            //self.countDownTimer.invalidate()
            //self.countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("countdown:")), userInfo: nil, repeats: true)
            self.startAnimation()
            self.addCircle()
            
        }
        
    }
    
    //************ Clock view ********************************
    
    

}

