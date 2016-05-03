//
//  NewActionViewController.swift
//  Routine Manager
//
//  Created by Robert Zalog on 4/30/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class NewActionViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet var nameField: UITextField!
    @IBOutlet var timeField: UITextField!
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumIntegerDigits = 1
        nf.maximumIntegerDigits = 2
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0

        return nf
    }()
    
    var action: Action!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if action.name.characters.count != 0 {
            navigationItem.title = action.name
            nameField.text = action.name
            timeField.text = numberFormatter.stringFromNumber(action.timeInMinutes)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        action.name = nameField.text ?? "???"

        if let timeText = timeField.text, time = numberFormatter.numberFromString(timeText) {
            action.timeInMinutes = time.integerValue
        }
        else {
            action.timeInMinutes = 10
        }
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var success = true
        
        if range.length != 1 {
            var maxChars: Int
            
            switch textField {
            case timeField:
                maxChars = 2
            default:
                maxChars = 20
            }
            
            if let text = textField.text {
                success = text.characters.count < maxChars
            }
        }
        
        return success
    }
    
    
}
