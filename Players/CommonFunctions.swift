//
//  CommonFunctions.swift
//  Players
//
//  Created by Gurvinder Singh  on 10/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class CommonFunctions {

    private init() {}
    static let sharedInstance = CommonFunctions()
    
    var dictDynamicColorList: Dictionary<String, UIColor>! = [:]

    func randomNumberGenerator(lowerThreshHold: Int, upperThreshHold: Int) -> Int {
        return Int.random(in: lowerThreshHold..<upperThreshHold)
    }
    
    func generateRandomColor() -> UIColor {
        
        let red = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))
        let green = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))
        let blue = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))

        return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

