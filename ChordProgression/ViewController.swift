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

var i = 0
var k = 0




let chordList1 = [[0, "G", "V-I-IV", "D-G-C", 5140], [1, "D", "I-IV-V", "D-G-A", 1450], [2, "D", "I-V-I", "D-A-D", 1510], [3, "D", "I-V-IV", "D-A-G", 1540], [4, "G", "I-IV-V", "G-C-D", 1450], [5, "G", "I-V-IV", "G-D-C", 1540], [6, "G", "IV-I-V", "C-G-D", 4150], [7, "G", "IV-V-I", "C-D-G", 4510]]

let count1 = chordList1.count
var chordList1Sequences = [String]()
var guess = String()
var option1 = String()
var option2 = String()
var option3 = String()
var option4 = String()
var userGuessed = String()



class ViewController: UIViewController {
   
    
    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    @IBOutlet var correctIncorrect: UILabel!
    
    @IBOutlet var choice1Label: UIButton!
    @IBOutlet var choice2Label: UIButton!
    @IBOutlet var choice3Label: UIButton!
    @IBOutlet var choice4Label: UIButton!
    
    
    @IBAction func playChord(sender: AnyObject) {
       
        i = Int(arc4random_uniform(8))
        k = Int(arc4random_uniform(4))

        
        print(" ======= ")
        print(i)
        
        correctIncorrect.text = ""
        key.text = ""
        progression.text = ""
        chordsPlayed.text = ""

    
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
        
        
        
        //
        //This is my logic to create a new array that is just the list of unique Chord sequences in ChordList1
        //
        for var l = 0; l < count1; l++  {
            
            chordList1Sequences.append(String(chordList1[l][2]))
            
            
        }
        print(chordList1Sequences)
        let mySet = Set<String>(chordList1Sequences)
        print(mySet)
        var chordList1UniqueSequences = Array(mySet)
        print(chordList1UniqueSequences)
        var count2 = chordList1UniqueSequences.count

        
        // That's the end of that piece of code.
        // Below is a chunk of code that removes the sequences that we played from the sequences available to show as wrong answers
        
        for var m = 0; m < count2; m++  {
            
            if chordList1UniqueSequences[m] == chordList1[i][2] {
                chordList1UniqueSequences.removeAtIndex(m)
                count2 = chordList1UniqueSequences.count
            }
            
        }
        print(chordList1UniqueSequences)
        
        // Now ChordList1UniqueSequences no longer holds the correct answer. 
        // So now we are going to pick random items from that list to throw up, and then remove them from the array so that we don't show duplicate answer options
        
        var randChord = [String]()
        
        for var n = 0; n < 3; n++ {
    
            let arrayKey = Int(arc4random_uniform(UInt32(chordList1UniqueSequences.count)))
            print(arrayKey)
            print(chordList1UniqueSequences.count)
            randChord.append(chordList1UniqueSequences[arrayKey])
            print(randChord[n])
            chordList1UniqueSequences.removeAtIndex(arrayKey)
        }
        print(randChord)
        
        // done.
        // Now we are going to throw them up on screen.
        
        
        if k == 0 {
            choice1Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option1 = "\(chordList1[i][2])"
            option2 = "\(randChord[0])"
            option3 = "\(randChord[1])"
            option4 = "\(randChord[2])"
            
            
        }
        if k == 1 {
            choice2Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option2 = "\(chordList1[i][2])"
            option1 = "\(randChord[0])"
            option3 = "\(randChord[1])"
            option4 = "\(randChord[2])"
        }
        
        if k == 2 {
            choice3Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option3 = "\(chordList1[i][2])"
            option1 = "\(randChord[0])"
            option2 = "\(randChord[1])"
            option4 = "\(randChord[2])"
        }
        
        if k == 3 {
            choice4Label.setTitle("\(chordList1[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option4 = "\(chordList1[i][2])"
            option1 = "\(randChord[0])"
            option2 = "\(randChord[1])"
            option3 = "\(randChord[2])"
        }
        
        
    }
    
   
    @IBAction func choice1(sender: AnyObject) {
        
        userGuessed = option1
        submittedGuess(userGuessed)
        
    }
    
    @IBAction func choice2(sender: AnyObject) {
        userGuessed = option2
        submittedGuess(userGuessed)
        
    }
    
    @IBAction func choice3(sender: AnyObject) {
        userGuessed = option3
        submittedGuess(userGuessed)
        
    }
    
    
    @IBAction func choice4(sender: AnyObject) {
        userGuessed = option4
        submittedGuess(userGuessed)
        
    }

    
    

  func submittedGuess(sender: AnyObject) {
        print(i)
        print(chordList1[i][4])
        if userGuessed != "" {
            
            if userGuessed == chordList1[i][2] {
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
    
        choice1Label.setTitle("", forState: UIControlState.Normal)
        choice2Label.setTitle("", forState: UIControlState.Normal)
        choice3Label.setTitle("", forState: UIControlState.Normal)
        choice4Label.setTitle("", forState: UIControlState.Normal)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

