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
        
        let red = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))/255.0
        let green = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))/255.0
        let blue = CGFloat(self.randomNumberGenerator(lowerThreshHold: 0, upperThreshHold: 255))/255.0

        return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func showAlert(msg: String, context: UIViewController) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                break
            }}))
        context.present(alert, animated: true, completion: nil)
    }
    
}


