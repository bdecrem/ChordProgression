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

let chordList1 = [[0, "G", "V-I-IV", "D-G-C", 5140], [1, "D", "I-IV-V", "D-G-A", 1450], [2, "D", "I-V-I", "D-A-D", 1510], [3, "D", "I-V-IV", "D-A-G", 1540], [4, "G", "I-IV-V", "G-C-D", 1450], [5, "G", "I-V-IV", "G-D-C", 1540], [6, "G", "IV-I-V", "C-G-D", 4150], [7, "G", "IV-V-I", "C-D-G", 4510]]

class ViewController: UIViewController {

    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    @IBOutlet var userGuess: UITextField?
    @IBOutlet var correctIncorrect: UILabel!
   
    
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
		
    }
    
    @IBAction func submitGuess(sender: AnyObject) {
        print(i)
        print(chordList1[i][4])
        if userGuess != "" {
            let userGuessInt:Int = Int((userGuess!.text)!)!
        
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

