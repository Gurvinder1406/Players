//
//  LoginDetails.swift
//  Players
//
//  Created by Gurvinder Singh  on 05/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class LoginDetails: Codable {
   var error: Array<Error>?
   var data: LoginData?
   var msg: String?
   var success: Bool?
   
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        msg = try container.decode(String?.self, forKey: .msg)
        success = try container.decode(Bool?.self, forKey: .success)
        if !(success ?? false) {
            error = try container.decode(Array<Error>?.self, forKey: .error)
        } else {
            data = try container.decode(LoginData?.self, forKey: .data)
        }
    }
    
    enum Keys: String, CodingKey {
        case error = "errors"
        case msg  = "msg"
        case success = "success"
        case data = "data"
    }
    
    
}


class Error: Codable {
    var location: String?
    var msg: String?
    var param: String?
    var value: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        location = try container.decode(String?.self, forKey: .location)
        msg = try container.decode(String?.self, forKey: .msg)
        param = try container.decode(String?.self, forKey: .param)
        value = try container.decode(String?.self, forKey: .value)
    }

    enum Keys: String, CodingKey {
        case location
        case msg
        case param
        case value
    }
    
}

class LoginData: Codable {
    var permission: String?
    var token: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        permission = try container.decode(String?.self, forKey: .permission)
        token = try container.decode(String?.self, forKey: .token)
    }

    enum Keys: String, CodingKey {
        case permission
        case token
    }
    
}
