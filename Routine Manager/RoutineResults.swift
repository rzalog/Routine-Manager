//
//  RoutineResults.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class RoutineResults {
    
    var routine: Routine
    var routineTimes = [Action:Int]()
    
    var totalTime = 0
    
    init(routine: Routine) {
        self.routine = routine
        
        for action in routine.actions {
            routineTimes[action] = 0
        }
    }
}
