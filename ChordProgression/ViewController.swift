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
var feedbackYouPickedLoop = AVAudioPlayer()

var i = 0
var k = 0
var gameCompleted = true
var levelPassed = true // to evaluate if user allowed to move onto next level


let chordList1 = [[0, "G", "V-I-IV", "D-G-C", 5140], [1, "D", "I-IV-V", "D-G-A", 1450], [2, "D", "I-V-I", "D-A-D", 1510], [3, "D", "I-V-IV", "D-A-G", 1540], [4, "G", "I-IV-V", "G-C-D", 1450], [5, "G", "I-V-IV", "G-D-C", 1540], [6, "G", "IV-I-V", "C-G-D", 4150], [7, "G", "IV-V-I", "C-D-G", 4510]]

let chordList2 = [[0, "A", "I-IV-I-V-IV", "A—D-A-E-D"], [1, "A", "I-IV-V", "Ahi-D-E (powerchord)"], [2, "A", "I-V-IV", "A—E-D"], [3, "A", "I-V-IV-I-V", "A-E-D-A-E"], [4, "A", "I-V-IV-V", "A-E-D-E"], [5, "C", "I-IV-V", "C-Fhi-G"], [6, "C", "I-IV-V", "C-F-G"], [7, "C", "I-IV-V", "Chi—F-G (powerchord)"], [8, "C", "I-V-IV", "Chi-G-F"], [9, "C", "I-V-IV", "C-G-F"], [10, "D", "I-IV-V", "D-G-A (powerchord)"], [11, "D", "I-IV-V", "Dhi-G-A"], [12, "D", "I-V-IV-IV", "D-A-G-G"], [13, "D", "I-V-IV", "D-A-G"], [14, "D", "I-V-I-IV", "Dhi-A-Dhi-G"], [15, "E", "I-IV-I-V-IV", "E-A-E-B-A (powerchord)"], [16, "E", "I-IV-V-IV", "E-A-B-A"], [17, "E", "I-V-IV", "E-B-A"], [18, "E", "I-V-IV", "Ehi-B-A (powerchord)"], [19, "G", "I-IV-V", "G-C-D"], [20, "G", "I-IV-V", "G-C-D (powerchord)"], [21, "G", "I-IV-V", "Ghi-C-D"], [22, "G", "I-V-IV", "G-D-C"], [23, "G", "I-V-IV-V", "G-D-C-D"]]

let count1 = chordList1.count
var chordListXSequences = [String]()
var guess = String()
var option1 = String()
var option2 = String()
var option3 = String()
var option4 = String()
var userGuessed = String()
var points = Int()
var plays = Int()
var feedbackYouPickedSampleLoopNumber = Int()
var level = 0  // we will increment this upon Level Up
var loopsAtEachLevel:[Int] = [8, 24]
var songFileCounterAtEachLevel:[Int] = [100, 200]
var wavNumber = 100
var chordListX = chordList1 // we will increment this upon level up



// other variables we're using: M, N, O





class ViewController: UIViewController {
   
    
    @IBOutlet var key: UILabel!
    @IBOutlet var progression: UILabel!
    @IBOutlet var chordsPlayed: UILabel!
    @IBOutlet var correctIncorrect: UILabel!
    
    @IBOutlet var choice1Label: UIButton!
    @IBOutlet var choice2Label: UIButton!
    @IBOutlet var choice3Label: UIButton!
    @IBOutlet var choice4Label: UIButton!
    @IBOutlet var score: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var feedbackLoopWas: UIButton!
    @IBOutlet var feedbackYouPicked: UIButton!
    @IBOutlet var feedbackSoundsLike: UIButton!
    @IBOutlet var levelWinLoseMessage: UILabel!
    @IBOutlet var endOfLevelButtonLabel: UIButton!
    
    
    //
    // THE MAIN LOOP STARTS HERE //
    //
    
   

    
    
    @IBAction func playChord(sender: AnyObject) {
       
        if (gameCompleted == true) {
            let o = UInt32(loopsAtEachLevel[level]) // pick a random number among the loops for a given level
            i = Int(arc4random_uniform(o)) // i will be a random number from 0 to 7 at Level 2
            k = Int(arc4random_uniform(4)) // k decides where we will show the correct number on the list of answer options
            wavNumber = songFileCounterAtEachLevel[level] + i // this is how we pick the right wav file
            print("new game")
            print(wavNumber)
            gameCompleted = false
        }
        
        print(" ======= ")
        print(i)
        
        correctIncorrect.text = ""
        key.text = ""
        progression.text = ""
        chordsPlayed.text = ""
        feedbackLoopWas.setTitle("", forState: UIControlState.Normal)
        feedbackYouPicked.setTitle("", forState: UIControlState.Normal)
        feedbackSoundsLike.setTitle("", forState: UIControlState.Normal)
        
        
        // play the chord 
        
        if let chordURL = NSBundle.mainBundle().URLForResource("\(wavNumber)", withExtension: "wav") {
            
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
        //This is my logic to create a new array that is just the list of unique Chord sequences in ChordListX
        //
        
        for var l = 0; l < loopsAtEachLevel[level]; l++  {
            
            chordListXSequences.append(String(chordListX[l][2]))
            
            
        }
        let mySet = Set<String>(chordListXSequences)
        var chordListXUniqueSequences = Array(mySet)
        var count2 = chordListXUniqueSequences.count  // count2 is the number of unique chord sequences for this level

        
        // That's the end of that piece of code.
        // Below is a chunk of code that removes the sequences that we played from the sequences available to show as wrong answers
        
        for var m = 0; m < count2; m++  {
            
            if chordListXUniqueSequences[m] == chordListX[i][2] {
                chordListXUniqueSequences.removeAtIndex(m)
                count2 = chordListXUniqueSequences.count
            }
            
        }
        
        // Now ChordListXUniqueSequences no longer holds the correct answer.
        // So now we are going to pick random items from that list to throw up, and then remove them from the array so that we don't show duplicate answer options
        
        var randChord = [String]()
        
        for var n = 0; n < 3; n++ {
    
            let arrayKey = Int(arc4random_uniform(UInt32(chordListXUniqueSequences.count)))
            print(arrayKey)
            print(chordListXUniqueSequences.count)
            randChord.append(chordListXUniqueSequences[arrayKey])
            print(randChord[n])
            chordListXUniqueSequences.removeAtIndex(arrayKey)
        }
        print(randChord)
        
        // done.
        // Now we are going to throw them up on screen.
        
        
        if k == 0 {
            choice1Label.setTitle("\(chordListX[i][2])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option1 = "\(chordListX[i][2])"
            option2 = "\(randChord[0])"
            option3 = "\(randChord[1])"
            option4 = "\(randChord[2])"
            
            
        }
        if k == 1 {
            choice2Label.setTitle("\(chordListX[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option2 = "\(chordListX[i][2])"
            option1 = "\(randChord[0])"
            option3 = "\(randChord[1])"
            option4 = "\(randChord[2])"
        }
        
        if k == 2 {
            choice3Label.setTitle("\(chordListX[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice4Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option3 = "\(chordListX[i][2])"
            option1 = "\(randChord[0])"
            option2 = "\(randChord[1])"
            option4 = "\(randChord[2])"
        }
        
        if k == 3 {
            choice4Label.setTitle("\(chordListX[i][2])", forState: UIControlState.Normal)
            choice1Label.setTitle("\(randChord[0])", forState: UIControlState.Normal)
            choice2Label.setTitle("\(randChord[1])", forState: UIControlState.Normal)
            choice3Label.setTitle("\(randChord[2])", forState: UIControlState.Normal)
            option4 = "\(chordListX[i][2])"
            option1 = "\(randChord[0])"
            option2 = "\(randChord[1])"
            option3 = "\(randChord[2])"
        }
        
        // and turn the PLAY button into a PLAY AGAIN button
        
        if (gameCompleted == true) {
            playButton.setTitle("Play Chords", forState: UIControlState.Normal)
        } else {
            playButton.setTitle("Repeat", forState: UIControlState.Normal)
        }
        
        
        
    }
    
    
    //
    // THE MAIN LOOP ENDS HERE
    //
    
   
    
    // we record which answer the user picked 
    
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
    
    
    
    
    // three feedback buttons
    
    @IBAction func playLoopWas(sender: AnyObject) {
        chord.play()
    }
    
    @IBAction func playYouPicked(sender: AnyObject) {
        print(feedbackYouPickedSampleLoopNumber)
        if let chordURL = NSBundle.mainBundle().URLForResource("\(feedbackYouPickedSampleLoopNumber)", withExtension: "wav") {
            
            do {
                
                feedbackYouPickedLoop = try AVAudioPlayer(contentsOfURL: chordURL)
                feedbackYouPickedLoop.numberOfLoops = 0
                feedbackYouPickedLoop.play()
                
            } catch _ {
                return
            }
            
        } else {
            print("Unable to find audio file")
        }
    }
    
    //  we're not using playSoundsLike (for now at least)
    @IBAction func playSoundsLike(sender: AnyObject) {
    }
    
    // end of three feedback buttons
    
    // the end of level NEXT ACTION button
    
    @IBAction func endOfLevelButton(sender: AnyObject) {
        
        if levelPassed == false {
            print("try level \(level + 1) again")
            newGame("new game")
            
        } else {
            print("time to play level \(level + 2)")
            newGame("next level")
        }
        
    }
    

    
// Cleanup things and let user start a new game
    
    func newGame(sender: AnyObject) {
        correctIncorrect.text = ""
        key.text = ""
        progression.text = ""
        chordsPlayed.text = ""
        gameCompleted = true
        playButton.setTitle("Play Chords", forState: UIControlState.Normal)
        levelWinLoseMessage.text = ""
        endOfLevelButtonLabel.setTitle("", forState: UIControlState.Normal)
        feedbackLoopWas.setTitle("", forState: UIControlState.Normal)
        feedbackYouPicked.setTitle("", forState: UIControlState.Normal)
        points = 0
        plays = 0
        score.text = "\(points) | \(plays)"
    }

// end of the newGame code
    
    
// Evaluate the user's guess and give feedback, increment the score etc
    

  func submittedGuess(sender: AnyObject) {
        if userGuessed != "" {
            
            if userGuessed == chordListX[i][2] {
                correctIncorrect.text = "Correct!"
                points++
                plays++
                
            } else {
                correctIncorrect.text = ":("
                plays++
                
                
                feedbackLoopWas.setTitle("The loop was: \(chordListX[i][2])", forState: UIControlState.Normal)
                
                //looking for the first loop in the set that is of the type the user guessed
                
                for var n = 0; n < chordListX.count; n++  {
                    
                    if chordListX[n][2] == userGuessed {
                        feedbackYouPickedSampleLoopNumber = n
                        n = chordListX.count
                    }
                    
                }
                
                

                feedbackYouPicked.setTitle("Sample of the progression you chose: \(userGuessed)", forState: UIControlState.Normal)
                
                // we're not using feedbackSoundsLike for now at least - sitting around for future use
                feedbackSoundsLike.setTitle("", forState: UIControlState.Normal)

                
            }
            score.text = "\(points) | \(plays)"
            
            key.text = "Key of: \(chordListX[i][1])"
            progression.text = "Type of Progression: \(chordListX[i][2])"
            chordsPlayed.text = "Chords Played: \(chordListX[i][3])"
            gameCompleted = true
            playButton.setTitle("Play Chords", forState: UIControlState.Normal)

            
        } else {
            correctIncorrect.text = "Please pick a guess"
        }
    
        // hide the answer options since the user has made their guess
        choice1Label.setTitle("", forState: UIControlState.Normal)
        choice2Label.setTitle("", forState: UIControlState.Normal)
        choice3Label.setTitle("", forState: UIControlState.Normal)
        choice4Label.setTitle("", forState: UIControlState.Normal)
    
    
    
    // evaluate if the level is over, respond accordingly
    if plays == 3 {
        print("3 games played")
        if points > 1 {
            levelWinLoseMessage.text = "Congrats! You passed level \(level + 1)"
            if (level == 1) {
                endOfLevelButtonLabel.setTitle("You've completed the game!", forState: UIControlState.Normal)
            } else {
            endOfLevelButtonLabel.setTitle("Play Level \(level + 2)", forState: UIControlState.Normal)
            levelPassed = true
            level++
            chordListXSequences.removeAll()
            
            if (level == 1) {
                chordListX = chordList2
                }
            }
            
        } else {
            levelWinLoseMessage.text = "Bummer. You didn't pass level 1"
            endOfLevelButtonLabel.setTitle("Try Again", forState: UIControlState.Normal)
            levelPassed = false
        }
    
    }
 
    
    }
    // end of Evaluate The User's guess
 
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

