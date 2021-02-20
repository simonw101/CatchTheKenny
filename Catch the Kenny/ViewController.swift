//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Simon Wilson on 20/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    
    var timer = Timer()
    
    var counter = 0
    
    var kennyArray = [UIImageView]()
    
    var hideTimer = Timer()
    
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    
    @IBOutlet weak var kenny2: UIImageView!
    
    @IBOutlet weak var kenny3: UIImageView!
    
    @IBOutlet weak var kenny4: UIImageView!
    
    @IBOutlet weak var kenny5: UIImageView!
    
    @IBOutlet weak var kenny6: UIImageView!
    
    @IBOutlet weak var kenny7: UIImageView!
    
    @IBOutlet weak var kenny8: UIImageView!
    
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        
        if storedHighScore == nil{
            
            highScore = 0
            
            highScoreLabel.text = "HighScore: \(highScore)"
            
        }
        
        if let newScore = storedHighScore as? Int {
            
            highScore = newScore
            
            highScoreLabel.text = "HighScore: \(highScore)"
            
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        hideKenny()
        
        counter = 10
        
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func hideKenny() {
        
        for image in kennyArray {
            
            image.isHidden = true
            
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        
        kennyArray[random].isHidden = false
        
    }

    @objc func increaseScore() {
        
        score += 1
        
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown() {
        
        counter -= 1
        
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for image in kennyArray {
                
                image.isHidden = true
                
            }
            
            if self.score > self.highScore {
                
                self.highScore = self.score
                
                highScoreLabel.text = "HighScore: \(self.highScore)"
                
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
                
            }
            
            
            
            let alert = UIAlertController(title: "times up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                // replay function
                
                self.score = 0
                
                self.scoreLabel.text = "Score: \(self.score)"
                
                self.counter = 10
                
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            
            alert.addAction(replayButton)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}

