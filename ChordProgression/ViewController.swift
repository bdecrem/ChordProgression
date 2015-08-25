//
//  ViewController.swift
//  ChordProgression
//
//  Created by Bart Decrem on 8/18/15.
//  Copyright © 2015 Bart Decrem. All rights reserved.
//

import UIKit
import AVFoundation

var chord = AVAudioPlayer()
let i = Int(arc4random_uniform(8))
let j = Int(arc4random_uniform(8))
let k = Int(arc4random_uniform(4))


let chordList1 = [[0, "G", "V-I-IV", "D-G-C", 5140], [1, "D", "I-IV-V", "D-G-A", 1450], [2, "D", "I-V-I", "D-A-D", 1510], [3, "D", "I-V-IV", "D-A-G", 1540], [4, "G", "I-IV-V", "G-C-D", 1450], [5, "G", "I-V-IV", "G-D-C", 1540], [6, "G", "IV-I-V", "C-G-D", 4150], [7, "G", "IV-V-I", "C-D-G", 4510]]

class ViewController: UIViewController {
    
    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    @IBOutlet var userGuess: UITextField!
    @IBOutlet var correctIncorrect: UILabel!
    
    @IBOutlet var choice1Label: UIButton!
    @IBOutlet var choice2Label: UIButton!
    @IBOutlet var choice3Label: UIButton!
    @IBOutlet var choice4Label: UIButton!
    
    
    @IBAction func choice1(sender: AnyObject) {
    }
    
    @IBAction func choice2(sender: AnyObject) {
    }
    
    @IBAction func choice3(sender: AnyObject) {
    }
    
    
    @IBAction func choice4(sender: AnyObject) {
    }
    
    @IBAction func playChord(sender: AnyObject) {
        print(i)
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(i)", withExtension: "wav") {
            
            do {
                
                chord = try AVAudioPlayer(contentsOfURL: chordURL)
                
                
                chord.numberOfLoops = 0
                chord.play()
                
                
                
                
            } catch _ {
                return
            }
            
        } else {
            print("Unable to find audio file")
        }
        
        choice1Label.setTitle("Hi", forState: UIControlState.Normal)
        choice2Label.setTitle("Ho", forState: UIControlState.Normal)
        choice3Label.setTitle("Ha", forState: UIControlState.Normal)
        choice4Label.setTitle("He", forState: UIControlState.Normal)
        
        if k == 0 {
            choice1Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)
  
        }
        if k == 1 {
            choice2Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)

        }
        if k == 2 {
            choice3Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)

        }
        if k == 3 {
            choice4Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)

        }
        
        
    }
    
    @IBAction func submitGuess(sender: AnyObject) {
        print(i)
        print(chordList1[i][4])
        if userGuess.text != "" {
            let userGuessInt = Int(userGuess.text!)
            
            if userGuessInt == chordList1[i][4] {
                correctIncorrect.text = "Correct!"
            } else {
                correctIncorrect.text = ":("
            }
            
            key.text = "Key of: \(chordList1[i][1])"
            progression.text = "Type of Progression: \(chordList1[i][2])"
            chordsPlayed.text = "Chords Played: \(chordList1[i][3])"
            
        } else {
            correctIncorrect.text = "Please enter a guess"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

