//
//  WebserviceManager.swift
//  Players
//
//  Created by Gurvinder Singh  on 06/02/19.
//  Copyright © 2019 Players. All rights reserved.
//


import UIKit

class APIManager: NSObject {

    static let apiInstance = APIManager()
    var loginDetails: LoginDetails!
    
    
    override init() {
        super.init()
    }

    
    func getData(urlString: String, params: String, requestType: RequestType ,completion: @escaping (_ isSuccess: Bool, _ reason: String ,_ data: Data?) -> Void) {
        
        if let url = URL(string: urlString) {
            let apiRequest = NSMutableURLRequest(url: url)
            apiRequest.httpMethod = requestType.value()
            apiRequest.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            apiRequest.setValue(loginDetails?.data?.token ?? "", forHTTPHeaderField: "token")
            apiRequest.httpBody = params.data(using: .utf8)
            
            let getDataTask = URLSession.shared.dataTask(with: apiRequest as URLRequest)
            {
                (data, urlResponse, error) in
                
                if error != nil {
                    print("Error -> \(error!.localizedDescription)")
                    completion(false, "\(error!.localizedDescription)", nil)
                } else if data == nil {
                    print("Data not Found !")
                    completion(false, "Data not Found !", nil)
                } else if (urlResponse as? HTTPURLResponse)?.statusCode == 200 {
                    completion(true, "", data)
                } else {
                    print("Invalid Response Code !")
                    completion(false, "Invalid Response Code !", nil)
                }
            }
            getDataTask.resume()
        } else {
            completion(false, "Invalid URL", nil)
            print("Invalid URL")
        }
    }

    
}


enum RequestType: String {
    case GET
    case POST
    
    func value() -> String {
        return self.rawValue
    }
}
