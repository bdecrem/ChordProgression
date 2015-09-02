//
//  PracticeViewController.swift
//  ChordProgression
//
//  Created by Bart on 9/1/15.
//  Copyright © 2015 Bart Decrem. All rights reserved.
//

import UIKit
import AVFoundation

let practiceArray145 = [[1, 1], [1, 4], [2, 1], [2, 5], [2, 6]]
let practiceArray154 = [[1, 3], [1, 5], [2, 2], [2, 8], [2, 9]]
let practiceArray415 = [[1, 6]]
let practiceArray451 = [[1, 7]]

var q = 0
var practiceNumber = 0


class PracticeViewController: UIViewController {
    
   
    @IBAction func practice145(sender: AnyObject) {
    print("practice I-IV-V")
       
        let p = UInt32(practiceArray145.count)
        q = Int(arc4random_uniform(p))
        practiceNumber = (practiceArray145[q][0] * 100) + (practiceArray145[q][1])
        print(practiceNumber)
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(practiceNumber)", withExtension: "wav") {
            
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
    
    @IBAction func practice154(sender: AnyObject) {
        print("practice I-V-IV")
        
        let p = UInt32(practiceArray154.count)
        q = Int(arc4random_uniform(p))
        practiceNumber = (practiceArray154[q][0] * 100) + (practiceArray154[q][1])
        print(practiceNumber)
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(practiceNumber)", withExtension: "wav") {
            
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
    
    
    @IBAction func practice415(sender: AnyObject) {
        print("practice IV-I-V")
        
        let p = UInt32(practiceArray415.count)
        q = Int(arc4random_uniform(p))
        practiceNumber = (practiceArray415[q][0] * 100) + (practiceArray415[q][1])
        print(practiceNumber)
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(practiceNumber)", withExtension: "wav") {
            
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
    
    @IBAction func practice451(sender: AnyObject) {
    
        print("practice IV-V-I")
        
        let p = UInt32(practiceArray451.count)
        q = Int(arc4random_uniform(p))
        practiceNumber = (practiceArray451[q][0] * 100) + (practiceArray451[q][1])
        print(practiceNumber)
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(practiceNumber)", withExtension: "wav") {
            
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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

