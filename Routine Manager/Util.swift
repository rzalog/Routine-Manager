//
//  Util.swift
//  Routine Manager
//
//  Created by Robert Zalog on 5/1/16.
//  Copyright © 2016 Robert Zalog. All rights reserved.
//

import UIKit

func formatSecondsToString(counter: Int) -> String {
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.roundingMode = .RoundFloor
        nf.minimumIntegerDigits = 2
        nf.maximumIntegerDigits = 3
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        
        return nf
    }()
    
    let minutes = numberFormatter.stringFromNumber(counter / 60)
    let seconds = numberFormatter.stringFromNumber(counter % 60)
    
    return "\(minutes!):\(seconds!)"
}
