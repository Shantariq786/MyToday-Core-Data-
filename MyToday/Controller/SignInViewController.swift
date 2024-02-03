//
//  SignInViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 10/25/23.
//

import UIKit
import Loaf

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var passwordHideButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var welcomebackLabel: UILabel!
    @IBOutlet weak var welcomebackDescriptionLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpNowButton: UIButton!
    @IBOutlet weak var rememberMeLabel: UILabel!
    
    let userCoreDataManager = UserCoreDataManager()
    let firebaseAuthManager = FirebaseAuthManager()
    var rememberMeIcon: Bool = false
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordInDots()
        signInButton.setThemeColor()
        updateLabelsLanguage()
        roundSignInButton()
    }
    
    func updateLabelsLanguage() {
        
        self.welcomebackLabel.text = "welcome_back".makeLocalizationOnLabel()
        self.welcomebackDescriptionLabel.text = "your_work_faster_and_structured_with_todyapp".makeLocalizationOnLabel()
        self.emailAddressLabel.text = "email_address".makeLocalizationOnLabel()
        self.passwordLabel.text = "password".makeLocalizationOnLabel()
        self.rememberMeLabel.text = "remember_me".makeLocalizationOnLabel()
        self.dontHaveAccountLabel.text = "don't_have_an_account".makeLocalizationOnLabel()
        self.forgotPasswordButton.setTitle("forgot_password".makeLocalizationOnLabel(), for: .normal)
        self.signUpNowButton.setTitle("sign_up_now".makeLocalizationOnLabel(), for: .normal)
        self.signInButton.setTitle("sign_in".makeLocalizationOnLabel(), for: .normal)
        
    }
    
    
    func passwordInDots(){
        
        passwordTF.isSecureTextEntry = true
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        let enteredEmail = emailTF.text ?? ""
        let enteredPassword = passwordTF.text ?? ""
        if enteredEmail.lowercased() == "" {
            Loaf("Pleease enter the email", state: .error, location: .top, sender: self).show()
        }else if enteredPassword == "" {
            Loaf("Please entered the password", state: .error, location: .top, sender: self).show()
        }else if !enteredEmail.lowercased().isEmailValid(){
            Loaf("Please enter valid email", state: .error, location: .top, sender: self).show()
        }else if !enteredPassword.isPasswordValid(){
            Loaf("Pleease enter atleast eight characters", state: .error, location: .top, sender: self).show()
        }else if userCoreDataManager.getUser(forEmail: enteredEmail, password: enteredPassword) == nil{ // email or passsword invalid
            Loaf("Email or password is not correct", state: .error, location: .top, sender: self).show()
        }
        else {
            guard let user = userCoreDataManager.getUser(forEmail: enteredEmail, password: enteredPassword) else { return }
            let userId = user.id ?? UUID()
            
            if rememberMeIcon == true{
                UserDefaults.standard.set(true, forKey: "isRememberMe")
            }
            
            UserDefaults.standard.set(userId.uuidString, forKey: "isUserId")
            
            let tabbar = TabbarViewController()
            self.navigationController?.pushViewController(tabbar, animated: true)
            Loaf("Success", state: .success, location: .top, sender: self).show()
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordEmailViewController") as! ForgetPasswordEmailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func rememberMeButtonTapped(_ sender: Any){
        
        if rememberMeIcon == false {
            
            rememberMeButton.setImage(UIImage(named: "tick-icon"), for: .normal)
        }
        else{
            
            rememberMeButton.setImage(UIImage(named: "square"), for: .normal)
        }
        
        rememberMeIcon.toggle()
        
        
        rememberMeButton.setImage(rememberMeIcon == false ?  UIImage(named: "tick-icon") : UIImage(named: "square"), for: .normal)
        rememberMeIcon.toggle()
        
    }
    
    @IBAction func passwordHideButton(_ sender: Any){
        
        if iconClick {
            let image = UIImage(named: "showeye")
            passwordHideButton.setImage(image, for: .normal)
            passwordTF.isSecureTextEntry = false
            
        } else {
            let image = UIImage(named: "eyes")
            passwordHideButton.setImage(image, for: .normal)
            passwordTF.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
    }
    
    func roundSignInButton(){
        
        signInButton.layer.cornerRadius = 16
        
    }
}
