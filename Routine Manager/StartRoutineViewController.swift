//
//  StartRoutineViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class StartRoutineViewController: UITableViewController {
    
    var routineManager: RoutineManager!
    
    // MARK: Overriding functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineManager.allRoutines.count
    }
    
    // create rows
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // try to reuse a cell
        let routineCell = tableView.dequeueReusableCellWithIdentifier("RoutineCell", forIndexPath: indexPath) as! RoutineCell
        
        let routine = routineManager.allRoutines[indexPath.row]

        // configure the cell
        routineCell.routineLabel.text = routine.name
        routineCell.minutesLabel.text = "\(routine.giveTotalRoutineTime())"
        
        return routineCell
    }
    
    // deleting cells
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if deleting...
        if editingStyle == .Delete {
            let routine = routineManager.allRoutines[indexPath.row]
            
            routineManager.removeRoutine(routine)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // Moving cells
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        routineManager.moveRoutineAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "DisplayRoutineSegue":
                if let row = tableView.indexPathForSelectedRow?.row {
                    let routine = routineManager.allRoutines[row]
                    let displayController = segue.destinationViewController as! DisplayRoutineViewController
                    displayController.routine = routine
                }
            case "NewRoutineSegue":
                let routine = routineManager.createRoutine("")
                let editRoutineController = segue.destinationViewController as! NewRoutineViewController
                editRoutineController.routine = routine
            default:
                break
            }
        }
    }

}
