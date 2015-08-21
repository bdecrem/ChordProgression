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



let chordList1 = [["0", "G", "V-I-IV", "D-G-C"], ["1", "D", "I-IV-V", "D-G-A"], ["2", "D", "I-V-I", "D-A-D"], ["3", "D", "I-V-IV", "D-A-G"], ["4", "G", "I-IV-V", "G-C-D"], ["5", "G", "I-V-IV", "G-D-C"], ["6", "G", "IV-I-V", "C-G-D"], ["7", "G", "IV-V-I", "C-D-G"]]

class ViewController: UIViewController {

    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    
    @IBAction func playChord(sender: AnyObject) {
        
        let i = Int(arc4random_uniform(8))
    
		if let chordURL = NSBundle.mainBundle().URLForResource("\(i)", withExtension: "wav") {
			
			do {
			  
				chord = try AVAudioPlayer(contentsOfURL: chordURL)
				
				
				chord.numberOfLoops = 0
				chord.play()
				
				key.text = "Key of: \(chordList1[i][1])"
				progression.text = "Type of Progression: \(chordList1[i][2])"
				chordsPlayed.text = "Chords Played: \(chordList1[i][3])"
				
			
				
			} catch _ {
				return
			}
			
		} else {
			print("Unable to find audio file")
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

