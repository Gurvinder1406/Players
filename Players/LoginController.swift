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
    }
    
    @IBAction func login(sender: UIButton) {
        self.login()
    }
    
}

extension LoginController {
    func login() {
        
//        let params = "email=maheshwari@techcetra.com&&password=qwerty123"
        let params = "email=\(tf_Id.text ?? "")&&password=\(tf_Password.text ?? "")"
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.loginUser(), params: params, requestType: .POST) {
            (success, reason, data) in
           DispatchQueue.main.async {
            if success {
                do {
                    let loginDetails = try JSONDecoder().decode(LoginDetails.self, from: data ?? Data())
                    if (loginDetails.success ?? false == true) {
                        APIManager.apiInstance.loginDetails = loginDetails
                        self.performSegue(withIdentifier: "loginToPlayerDetails", sender: self)
                    } else {
                        let error = loginDetails.error?[0].msg ?? ""
                        CommonFunctions.sharedInstance.showAlert(msg: error, context: self)
                     }
                } catch let err {
                    CommonFunctions.sharedInstance.showAlert(msg: err.localizedDescription, context: self)
                }
            } else {
                CommonFunctions.sharedInstance.showAlert(msg: "Login Failed", context: self)
            }
        }
        }
    }
}


