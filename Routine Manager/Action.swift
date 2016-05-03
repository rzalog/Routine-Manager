//
//  Action.swift
//  Routine Manager
//
//  Created by Robert Zalog on 4/30/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

class Action: NSObject {
    var name: String
    var timeInMinutes: Int
    
    init (name: String, time: Int) {
        self.name = name
        self.timeInMinutes = time
    }
    
    convenience override init() {
        self.init(name: "", time: 1)
    }
}
