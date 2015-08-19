//
//  ViewController.swift
//  ChordProgression
//
//  Created by Bart Decrem on 8/18/15.
//  Copyright © 2015 Bart Decrem. All rights reserved.
//

import UIKit
import AVFoundation



var chord:AVAudioPlayer = AVAudioPlayer()



let chordList1 = [ [1, "D", "I-IV-V", "D-G-A"], [2, "D", "I-V-I", "D-A-D"], [3, "D", "I-V-IV", "D-A-G"], [4, "G", "I-IV-V", "G-C-D"], [5, "G", "I-V-IV", "G-D-C"], [6, "G", "IV-I-V", "C-G-D"], [7, "G", "IV-V-I", "C-D-G"], [8, "G", "V-I-IV", "D-G-C"]]

class ViewController: UIViewController {

    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    
    @IBAction func playChord(sender: AnyObject) {
        
        let i = Int(arc4random_uniform(7))
        let j = i + 1
    
        let chordURL:NSURL = NSBundle.mainBundle().URLForResource("\(j)", withExtension: "wav")!
        
        do {
          
            chord = try AVAudioPlayer(contentsOfURL: chordURL)
            
            
            chord.numberOfLoops = 0
            chord.prepareToPlay()
            chord.play()
            
            key.text = "\(chordList1[i])"
            progression.text = " "
            chordsPlayed.text = " "
            

            
            
        } catch _ {
            return
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

