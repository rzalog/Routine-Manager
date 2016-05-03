//
//  RoutineManager.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

class RoutineManager {
    
    var allRoutines = [Routine]()
    
    func createRoutine(name: String) -> Routine {
        let routine = Routine(name: name)
        allRoutines.append(routine)
        return routine
    }
    
    func removeRoutine(routine: Routine) {
        if let index = allRoutines.indexOf({
            $0.name == routine.name
        }) {
            allRoutines.removeAtIndex(index)
        }
    }
    
    func moveRoutineAtIndex(fromIndex: Int, toIndex: Int) {
        let routine = allRoutines[fromIndex]
        self.removeRoutine(routine)
        allRoutines.insert(routine, atIndex: toIndex)
    }
}