//
//  RunRoutineViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit
import AVFoundation

class RunRoutineViewController: UIViewController {
    
    // MARK: Variables
    var routine: Routine!
    var routineResults: RoutineResults!
    
    var isRunning = false
    
    let startColor = UIColor(red:0.20, green:0.65, blue:0.37, alpha:1.0)
    let pauseColor = UIColor(red:0.53, green:0.54, blue:0.51, alpha:1.0)
    
    // timers
    var currentActionTimer: NSTimer!
    var totalElapsedTimer: NSTimer!
    
    var currentActionTimerCounter: Int!
    var totalElapsedTimerCounter = 0
    
    var currentActionIndex = 0
    var isOverTimeForAction = false
    
    // MARK: Outlets
    @IBOutlet var currentActionLabel: UILabel!
    @IBOutlet var nextActionLabel: UILabel!
    
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    
    @IBOutlet var nextActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = routine.name
        changeToNewAction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        routineResults.totalTime = totalElapsedTimerCounter
        
        // stop the timers
        if currentActionTimer != nil {
            currentActionTimer.invalidate()
        }
        if totalElapsedTimer != nil {
            totalElapsedTimer.invalidate()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "FinishRoutineSegue":
                let finishController = segue.destinationViewController as! RoutineResultsViewController
                finishController.routineResults = routineResults
            default:
                break
            }
        }
    }

    // MARK: Actions
    
    @IBAction func toggleStartFinish(sender: UIButton) {
        if isRunning {
            isRunning = false
            
            sender.setTitleColor(startColor, forState: .Normal)
            sender.setTitle("Resume", forState: .Normal)
            
            // Stop the timers
            stopTimers()
        }
        else {
            isRunning = true
            
            sender.setTitleColor(pauseColor, forState: .Normal)
            sender.setTitle("Pause", forState: .Normal)
            
            // start the timers up
            startTimers()
        }
    }
    
    @IBAction func moveToNextTask(sender: UIButton) {
        changeToNewAction()
    }

    func changeToNewAction() {
        if currentActionIndex < routine.actions.count {
            isOverTimeForAction = false
            currentTimeLabel.textColor = UIColor.blackColor()
            
            let action = routine.actions[currentActionIndex]
            
            // Update action timer
            currentActionTimerCounter = action.timeInMinutes * 60
            currentActionTimer = NSTimer.init(timeInterval: 1, target: self, selector: #selector(actionTimerTick), userInfo: nil, repeats: true)
            
            updateTimers()
            
            // Update current action label
            currentActionLabel.text = "\(action.name)"
            
            // Try to update next action label
            if currentActionIndex < routine.actions.count - 1 {
                let nextAction = routine.actions[currentActionIndex+1]
                nextActionLabel.text = "Next task: \(nextAction.name)"
            }
            else {
                nextActionLabel.text = "No tasks left!"
                nextActionButton.setTitle("You're done!", forState: .Normal)
            }

            currentActionIndex += 1
        }
    }
    
    @IBAction func finishRoutine(sender: UIButton) {
        // stop the timers
        if currentActionTimer != nil {
            currentActionTimer.invalidate()
        }
        if totalElapsedTimer != nil {
            totalElapsedTimer.invalidate()
        }
    }
    
    func elapsedTimerTick() {
        totalElapsedTimerCounter += 1
        updateTimers()
        
        print("Total elapsed timer ticking... \(totalElapsedTimerCounter)")
        
    }
    
    func actionTimerTick() {
        // as long as the user is on time...
        if !isOverTimeForAction {
            currentTimeLabel.textColor = UIColor.blackColor()
            currentActionTimerCounter = currentActionTimerCounter - 1
            
            isOverTimeForAction = currentActionTimerCounter <= 0
            
            // if we are over time, make sound
            if isOverTimeForAction {
                let soundID: SystemSoundID = 1103
                AudioServicesPlaySystemSound(soundID)
            }
        }
            
        // if they go over the alloted time
        else {
            currentTimeLabel.textColor = UIColor.redColor()
            currentActionTimerCounter = currentActionTimerCounter + 1
        }

        // update our RoutineResults
        let action = routine.actions[currentActionIndex-1]
        if let _ = routineResults.routineTimes[action] {
            routineResults.routineTimes[action]! += 1
        }
        else {
            routineResults.routineTimes[action] = 0
        }
        
        print("Action timer ticking...\(currentActionTimerCounter)")
        
        updateTimers()
    }
    
    func updateTimers() {
        let actionTimerRepresenation = formatSecondsToString(currentActionTimerCounter)
        let elapsedTimerRepresentation = formatSecondsToString(totalElapsedTimerCounter)
        
        currentTimeLabel.text = actionTimerRepresenation
        totalTimeLabel.text = elapsedTimerRepresentation
    }
    
    func startTimers() {
        totalElapsedTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(elapsedTimerTick), userInfo: nil, repeats: true)
        currentActionTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(actionTimerTick), userInfo: nil, repeats: true)
    }
    
    func stopTimers() {
        totalElapsedTimer.invalidate()
        currentActionTimer.invalidate()
    }
    
}
