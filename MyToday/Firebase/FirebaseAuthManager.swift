//
//  FirebaseAuthManager.swift
//  MyToday
//
//  Created by Ch. Shan on 2/2/24.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager{
    
    func createAccount(email:String,
                       password:String,
                       name:String,
                       success:@escaping (()->Void),
                       failure:@escaping((_ error:String)->Void)){
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _eror = error {
                failure(_eror.localizedDescription)
            }else{
                //user registered successfully
                success()
            }
        }
        
    }
    
    func signIn(email: String,
                password: String,
                success:@escaping (()->Void),
                failure:@escaping ((_ error:String)->Void)){
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _eror = error {
                failure(_eror.localizedDescription)
            }else{
                success()
            }
        }
    }
}
