//
//  Login.swift
//  Podium
//
//  Created by Carlos M Solis on 10/20/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

class Login {
    
    init(email : String, password : String) {
        
        let parameters: [String: AnyObject?] = [
            "email": email as Optional<AnyObject>, //email
            "password": password as Optional<AnyObject> //password
        ]
        
        var statusCode: Int = 0
        Alamofire.request(BASE_URL, method: .POST , parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                statusCode = (response.response?.statusCode)! //Gets HTTP status code, useful for debugging
                if let value: AnyObject = response.result.value {
                    //Handle the results as JSON
                    let post = JSON(value)
                    if let key = post["session_id"].string {
                        //At this point the user should have authenticated, store the session id and use it as you wish
                    } else {
                        print("error detected")
                    }
                }
        }
    }
}
