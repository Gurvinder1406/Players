//
//  Constants.swift
//  Players
//
//  Created by Gurvinder Singh  on 13/01/19.
//  Copyright © 2019 Players. All rights reserved.
//


import UIKit

class Constants {

    static let sharedInstance = Constants()
    let basePath = "http://13.233.218.85/"
    
    private init() { }
    
    func loginUser() -> String {
        return "\(basePath)api/user/login"
    }

    
    enum Segues: String {
        
        case ProductListToDetail
        case HomeToProductList
        case HomeToCategorySearch
        case SearchToProductList
        
        func value() -> String {
            return self.rawValue
        }
    }
    
}
