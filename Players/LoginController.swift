//
//  LoginController.swift
//  Players
//
//  Created by Gurvinder Singh  on 05/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.login()
    }
    

}


extension LoginController {
    func getFilters() {
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.filters(), params: "", requestType: .GET) {
            (success, reason, data) in
            do {
                let filters = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(filters)
            } catch let err {
                print(err)
            }
        }
    }
}



extension LoginController {
    func login() {
        
        let params = "email=maheshwari@techcetra.com&&password=qwerty123"
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.loginUser(), params: params, requestType: .POST) {
            (success, reason, data) in
            if success {
                do {
                    let loginDetails = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject] ?? [String: AnyObject]()
                    if (loginDetails["success"] as? Bool ?? false == true) {
                        APIManager.apiInstance.token = (loginDetails["data"] as? [String: String] ?? [String: String]())["token"] ?? ""
                        self.getFilters()
                    } else {
                        let error = ((loginDetails["errors"] as? [AnyObject] ?? [AnyObject]())?[0] as? [String: String] ?? [String: String]())?["msg"] ?? ""
                        print("Login failed with reason: \(error)")
                    }
                } catch let err {
                    print(err)
                }
            } else {
                print("Login Failed")
            }
            
        }
    }
}


