//
//  EditEmailViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/28/23.
//

import UIKit
import CoreData
import Loaf

class EditEmailViewController: UIViewController {
    
    @IBOutlet weak var updatedEmail: UITextField!
    @IBOutlet weak var updateEmailButton: UIButton!
    
    let userCoreDataManager = UserCoreDataManager()
    var emailUpdated:((_ email:String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateEmailButton.layer.cornerRadius = 16
        updateEmailButton.setThemeColor()
        
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any){
        
        if updatedEmail.text != ""{
            let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
            let user = userCoreDataManager.editUserEmail(id: UUID(uuidString: isUserId)!, Email: updatedEmail.text ?? "")
            let updatedEmail1 = updatedEmail.text ?? ""
            emailUpdated?(updatedEmail1)
            self.navigationController?.popViewController(animated: true)
        } else {
            Loaf("Updated name cannot be empty", state: .error, location: .top, sender: self).show()
        }
    }
}
