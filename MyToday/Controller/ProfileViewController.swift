//
//  EmptyViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/6/23.
// let url = "https://api.projectliberte.io/v1/"

import UIKit
import CoreData
import Alamofire
import Photos
import TOCropViewController

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var uploadProfileImage: UIButton!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var editName: UIButton!
    @IBOutlet weak var editEmail: UIButton!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let userCoreDataManager = UserCoreDataManager()
    var localItems: [Todo] = []
    let imagePicker = ImagePicker()
    var languageIndex = LanguageIndex.currentIndex
    var userImage:((_ image:UIImage)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateImage()
        searchUserId()
        buttonRadius()
        editName.setThemeColor()
        editEmail.setThemeColor()
        uploadProfileImage.setThemeColor()
        
        imagePicker.delegate = self
        
        let userId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        let userIDUUID = UUID(uuidString: userId) ?? UUID()
        let imageData = userCoreDataManager.getImage(id: userIDUUID)
        
        if let imageData = imageData{
            let image = UIImage(data: imageData)
            profileImage.image = image
        }
        
        updateLabelsLanguage()
        
    }
    
    func updateLabelsLanguage() {
        
        self.profileLabel.text = "profile".makeLocalizationOnLabel()
        self.nameLabel.text = "name".makeLocalizationOnLabel()
        self.emailLabel.text = "email".makeLocalizationOnLabel()
        self.editEmail.setTitle("edit_email".makeLocalizationOnLabel(), for: .normal)
        self.editName.setTitle("edit_name".makeLocalizationOnLabel(), for: .normal)
        self.uploadProfileImage.setTitle("upload_profile_image".makeLocalizationOnLabel(), for: .normal)
        
    }
    
    func searchUserId(){
        
        let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        let user = userCoreDataManager.getUserById(id: UUID(uuidString: isUserId)!)
        userName.text = user?.name
        userEmail.text = user?.email
        
    }
    
    func updateImage(){
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.image = UIImage(named: "calendar")
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let chooseLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.imagePicker.photoGalleryAsscessRequest()
        }
        let chooseCameraAction = UIAlertAction(title: "Choose from Camera", style: .default) { _ in
            self.imagePicker.cameraAsscessRequest()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseLibraryAction)
        alertController.addAction(chooseCameraAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editNameTapped(_ sender: Any){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditNameViewController") as! EditNameViewController
        vc.nameUpdated = { name in
            self.userName.text = name
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func editEmailTapped(_ sender: Any){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditEmailViewController") as! EditEmailViewController
        vc.emailUpdated = { email in
            self.userEmail.text  = email
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: ImagePickerDelegate

extension ProfileViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        let userId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        let userUUID =  UUID(uuidString: userId)!
        let pngImageData  = image.pngData() ?? Data()
        userCoreDataManager.saveUserImage(id: userUUID, image: pngImageData)
        profileImage.image = image
        userImage?(image)
        
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    func buttonRadius(){
        uploadProfileImage.layer.cornerRadius = 16
        editName.layer.cornerRadius = 16
        editEmail.layer.cornerRadius = 16
    }
    
}





































/*
 func getProfile(){
 let params : [String:Any] = [ "user_id":110]
 let url = "https://api.projectliberte.io/v1/user-profile"
 
 
 AF.request(url, method: .get, parameters: params)
 .validate()
 .responseJSON { response in
 print(response.result)
 }
 
 }
 
 
 
 func updateProfile(){
 var params : [String:Any] = [ "user_id":110, "name":"shan"]
 let url = "https://api.projectliberte.io/v1/update-user-profile"
 
 AF.request(url, method: .post, parameters: params)
 .validate()
 .responseJSON { response in
 print(response.result)
 }
 
 }
 
 */
