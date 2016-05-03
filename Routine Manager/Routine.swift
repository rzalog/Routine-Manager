//
//  Routine.swift
//  Routine Manager
//
//  Created by Robert Zalog on 4/30/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class Routine {
    var actions = [Action]()
    var name: String

    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "")
    }
    
    func addAction(name: String, time: Int) -> Action {
        let action = Action(name: name, time: time)
        actions.append(action)
        
        return action
    }
    
    func removeAction(action: Action) {
        if let index = actions.indexOf(action) {
            actions.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // get the item to move
        let action = actions[fromIndex]
        self.removeAction(action)
        actions.insert(action, atIndex: toIndex)
    }
    
    func giveTotalRoutineTime() -> Int {
        var total = 0
        for action in actions {
            total += action.timeInMinutes
        }
        return total
    }
    
}
