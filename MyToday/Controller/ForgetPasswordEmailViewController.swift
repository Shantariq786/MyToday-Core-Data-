//
//  ForgetPasswordEmailViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 11/1/23.
//

import UIKit
import Loaf

class ForgetPasswordEmailViewController: UIViewController {
    
    @IBOutlet weak var enteredEmail: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    let userCoreDataManager = UserCoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let enteredEmail = enteredEmail.text ?? ""
        let id = userCoreDataManager.isEmailFoundWithUUID(email: enteredEmail)
        if id == nil{
            Loaf("Please enter valid email", state: .error, location: .top, sender: self).show()
            
        }else{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotPasswordNewPasswordViewController") as! forgotPasswordNewPasswordViewController
            vc.id = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
