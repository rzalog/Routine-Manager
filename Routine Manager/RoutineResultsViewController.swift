//
//  RoutineResultsViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class RoutineResultsViewController: UITableViewController {
    
    var routineResults: RoutineResults!
    
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var totalActualTimeLabel: UILabel!
    
    let goodTimeColor = UIColor(red:0.35, green:0.85, blue:0.49, alpha:1.0)
    let badTimeColor = UIColor(red:0.93, green:0.00, blue:0.08, alpha:1.0)
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        
        let totalExpectedTime = formatSecondsToString(routineResults.routine.giveTotalRoutineTime() * 60)
        totalActualTimeLabel.text = "(\(totalExpectedTime))"

        let totalTime = formatSecondsToString(routineResults.totalTime)
        totalTimeLabel.text = totalTime
        if routineResults.totalTime - routineResults.routine.giveTotalRoutineTime() * 60 < 0 {
            totalTimeLabel.textColor = goodTimeColor
        }
        else {
            totalTimeLabel.textColor = badTimeColor
        }        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "FinishToEditRoutineSegue":
                let editController = segue.destinationViewController as! NewRoutineViewController
                editController.routine = routineResults.routine
            default:
                break
            }
        }
    }
    
    // TableViewController stuff
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineResults.routine.actions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActionResultCell", forIndexPath: indexPath) as! ActionResultCell
        
        let action = routineResults.routine.actions[indexPath.row]
        let actionTime = routineResults.routineTimes[action]!
        let actionTimeText = formatSecondsToString(actionTime)
        
        cell.timeLabel.text = "\(action.timeInMinutes)"
        cell.actionLabel.text = action.name
        cell.resultTimeLabel.text = actionTimeText
        
        if actionTime - action.timeInMinutes * 60 < 0 {
            cell.resultTimeLabel.textColor = goodTimeColor
        }
        else {
            cell.resultTimeLabel.textColor = badTimeColor
        }
        
        return cell
    }
    
    @IBAction func returnToHomeScreen(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
