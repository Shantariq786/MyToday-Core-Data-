//
//  EditNameViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/28/23.
//

import UIKit
import CoreData
import Loaf

class EditNameViewController: UIViewController {
    
    @IBOutlet weak var updatedName: UITextField!
    @IBOutlet weak var updateNameButton: UIButton!
    
    var nameUpdated:((_ name:String)->Void)?
    let userCoreDataManager = UserCoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNameButton.layer.cornerRadius = 16
        updateNameButton.setThemeColor()
        
    }
    
    @IBAction func updateButtonTapped(_ sender: Any){
        
        if updatedName.text != ""{
            let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
            print("UserID \(isUserId)")
            userCoreDataManager.editUserName(id: UUID(uuidString: isUserId)!, Name: updatedName.text ?? "")
            let updatedName = updatedName.text ?? ""
            nameUpdated?(updatedName)
            self.navigationController?.popViewController(animated: true)
        }
        else{
            Loaf("Updated name cannot be empty", state: .error, location: .top, sender: self).show()
        }
    }
}
