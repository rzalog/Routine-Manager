//
//  DisplayRoutineViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class DisplayRoutineViewController: UITableViewController {
    
    var routine: Routine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = routine.name
        navigationItem.prompt = "\(routine.giveTotalRoutineTime()) minutes"
        
        tableView.reloadData()
    }
    
    // count the rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine.actions.count
    }
    
    // display the rows
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell", forIndexPath: indexPath) as! ActionCell
        
        let action = routine.actions[indexPath.row]
        
        // fill up the cell
        cell.actionNameLabel.text = action.name
        cell.minutesLabel.text = "\(action.timeInMinutes)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EditRoutineSegue":
                let editController = segue.destinationViewController as! NewRoutineViewController
                editController.routine = routine
            case "StartRoutineSegue":
                let runController = segue.destinationViewController as! RunRoutineViewController
                runController.routine = routine
                runController.routineResults = RoutineResults(routine: routine)
            default:
                break
            }
        }
    }
}
