//
//  Constants.swift
//  Players
//
//  Created by Gurvinder Singh  on 06/02/19.
//  Copyright © 2019 Players. All rights reserved.
//


import UIKit

class Constants {

    static let sharedInstance = Constants()
    let basePath = "http://13.233.218.85/api/"
    
    private init() { }
    
    func loginUser() -> String {
        return "\(basePath)user/login"
    }

    func filters() -> String {
        return "\(basePath)players/filters"
    }
    
    func playersList() -> String {
        return "\(basePath)players"
    }
    
}
