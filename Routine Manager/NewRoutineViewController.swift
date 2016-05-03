//
//  NewRoutineViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 4/30/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class NewRoutineViewController: UITableViewController, UITextFieldDelegate {

    var routine: Routine!
    
    @IBOutlet var routineNameField: UITextField!
    @IBOutlet var totalMinutesLabel: UILabel!

    // Overriding functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.rightBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if routine.name.characters.count != 0 {
            navigationItem.title = routine.name
            routineNameField.text = routine.name
        }
        
        tableView.reloadData()
        updateTime()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        routine.name = routineNameField.text ?? ""
    }
    
    // number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine.actions.count
    }
    
    // creating the rows
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell", forIndexPath: indexPath) as! ActionCell

        let action = routine.actions[indexPath.row]
        
        // configure the cell with the item
        cell.actionNameLabel.text = action.name
        cell.minutesLabel.text = "\(action.timeInMinutes)"
        
        return cell
    }
    
    // deleting cells
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if deleting...
        if editingStyle == .Delete {
            let action = routine.actions[indexPath.row]
            
            routine.removeAction(action)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    // Moving cells
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        routine.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "AddNewActionSegue":
                // create placeholder action to pass into NewActionCellViewController
                let action = routine.addAction("", time: 0)
                let newActionController = segue.destinationViewController as! NewActionViewController
                newActionController.action = action
            case "EditActionSegue":
                if let row = tableView.indexPathForSelectedRow?.row {
                    // Retrieve the selected item, pass it to NewActionCellViewController
                    let action = routine.actions[row]
                    let newActionController = segue.destinationViewController as! NewActionViewController
                    newActionController.action = action
                }
            default:
                break
            }
        }
    }
    
    // MARK: Actions
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func updateTime() {
        totalMinutesLabel.text = "\(routine.giveTotalRoutineTime()) minutes"
    }
    
}
