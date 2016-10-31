//
//  File.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

class SaveData {
    
    func SaveUserInfo(){
        
        
        var user: UserCoreData!
        var userToEdit: UserCoreData?
        var loginUser: User!
        
        
        if userToEdit == nil {
            
            user = UserCoreData(context: context)
            
        } else {
            
            user = userToEdit
            
        }
        
        
        if  let nameOfUser: String = loginUser.name {
            
            user.name = nameOfUser
            
        }
        
        
        if  let lastNameOfUser: String = loginUser.lastName {
            
            user.lastname = lastNameOfUser
            
        }
        
        if  let lastName2OfUser: String = loginUser.lastName2 {
            
            user.lastname2 = lastName2OfUser
            
        }
        
        
        if  let email: String = loginUser.email {
            
            user.email = email
            
        }
        
        
        if let address: String = loginUser.address {
            
            user.address = address
            
        }
        
        //
        
        
        if let idUniversity: Int = loginUser.idUniversity{
            
            user.idUniversity = Int64(idUniversity)
            
        }
        
        
        if let phone: String = loginUser.phone{
            
            user.phone = phone
            
        }
        
        if let idToken: String = loginUser.idToken{
            
            user.idToken = idToken
            
        }
        
        ad.saveContext()
        
    }
    
}
