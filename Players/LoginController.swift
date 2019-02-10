//
//  LoginController.swift
//  Players
//
//  Created by Gurvinder Singh  on 05/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var tf_Id: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_Id.becomeFirstResponder()
        self.login()
    }
    

}


extension LoginController {
    func getFilters() {
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.filters(), params: "", requestType: .GET) {
            (success, reason, data) in
            do {
                let filters = try JSONDecoder().decode(Filters.self, from: data ?? Data())
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
                    let loginDetails = try JSONDecoder().decode(LoginDetails.self, from: data ?? Data())
                    if (loginDetails.success ?? false == true) {
                        APIManager.apiInstance.loginDetails = loginDetails
                        self.getFilters()
                        self.getPlayerList()
                    } else {
                        let error = loginDetails.error?[0].msg ?? ""
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

extension LoginController {
    func getPlayerList() {

        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.playersList(), params: "", requestType: .POST) { (success, reason, data) in

            do {
                let players = try JSONDecoder().decode(PlayersData.self, from: data ?? Data())
            }
            catch let err {
                print(err)
            }
        }
        
    }
}

