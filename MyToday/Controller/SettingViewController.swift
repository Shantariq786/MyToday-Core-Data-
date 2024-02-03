//
//  SettingViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/29/23.
//

import UIKit
import Loaf
import CoreData

class SettingViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var appIconLabel: UILabel!
    @IBOutlet weak var changeModeLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var helpCenterLabel: UILabel!
    @IBOutlet weak var logOutLabel: UILabel!
    
    let userCoreDataManager = UserCoreDataManager()
    var languageIndex = LanguageIndex.currentIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editImageandView()
        profileImage()
        userLoginName()
        updateLabelsLanguage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelsLanguage), name: Notification.Name("currentLanguageChanged"), object: nil)
    }
    
    @objc func updateLabelsLanguage() {
        DispatchQueue.main.async {
            
            self.accountLabel.text = "account".makeLocalizationOnLabel()
            self.languagesLabel.text = "languages".makeLocalizationOnLabel()
            self.appIconLabel.text = "app_icon".makeLocalizationOnLabel()
            self.changeModeLabel.text = "change_mode".makeLocalizationOnLabel()
            self.privacyLabel.text = "privacy_policy".makeLocalizationOnLabel()
            self.helpCenterLabel.text = "help_center".makeLocalizationOnLabel()
            self.logOutLabel.text = "log_out".makeLocalizationOnLabel()
            self.title = "Settings"
            
        }
    }
    
    @IBAction func accountButtonTapped(_ sender: Any) {
        
        print("tapped")
        let accountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        accountVC.userImage = { image in
            self.profileImageView.image  = image
        }
        self.navigationController?.pushViewController(accountVC, animated: true)
        
    }
    
    @IBAction func appIconButtonTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppIconViewController") as! AppIconViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func switchButtonTapped(_ sender: UISwitch ) {
        if #available(iOS 13.0 , *){
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn{
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
        }else {
            Loaf("Dark mode is not available for iOS versions lower than 13.0", state: .error, location: .top, sender: self).show()
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.performLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func performLogout() {
        
        UserDefaults.standard.set(false, forKey: "isRememberMe")
        
        // 2. set root controller
        
        let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let signInNavigation = UINavigationController(rootViewController: signInVC)
        signInNavigation.isNavigationBarHidden = true
        
        let window = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).window
        window?.rootViewController = signInNavigation
        window?.makeKeyAndVisible()
    }
    
    @IBAction func languagesButtonTapped(_ sender: Any){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguagesViewController") as! LanguagesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func editImageandView(){
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
    }
    
    
    func profileImage(){
        let userId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        let imageData = userCoreDataManager.getImage(id: UUID(uuidString: userId)!)
        
        if let imageData = imageData{
            let image = UIImage(data: imageData)
            profileImageView.image = image
        }
    }
    
    
    func userLoginName(){
        let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        let user = userCoreDataManager.getUserById(id: UUID(uuidString: isUserId)!)
        userName.text = user?.name
    }
}
