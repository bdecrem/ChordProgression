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


class ViewController: UIViewController {

    @IBAction func playChord(sender: AnyObject) {
    
        let chordURL:NSURL = NSBundle.mainBundle().URLForResource("1", withExtension: "wav")!
        
        do {
          
            chord = try AVAudioPlayer(contentsOfURL: chordURL)
            
            
            chord.numberOfLoops = 1
            chord.prepareToPlay()
            chord.play()

            
            
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

