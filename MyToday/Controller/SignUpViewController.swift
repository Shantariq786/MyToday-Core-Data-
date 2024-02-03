//
//  SignUpViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 10/25/23.
//

import UIKit
import Loaf

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpButtonView: UIView!
    @IBOutlet weak var passwordHideEyeButton: UIButton!
    @IBOutlet weak var confirmPasswordHideEyeButton: UIButton!
    @IBOutlet weak var signUPButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPassowrdLabel: UILabel!
    @IBOutlet weak var creatAccoutnLabel: UILabel!
    @IBOutlet weak var creatAccoutnDescriptionLabel: UILabel!
    
    
    let userCoreDataManager = UserCoreDataManager()
    let firebaseAuthManager = FirebaseAuthManager()
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        roundSignUpButton()
        passwordInDots()
        signUPButton.setThemeColor()
        updateLabelsLanguage()
        
    }
    
    func updateLabelsLanguage() {

        self.creatAccoutnLabel.text = "create_account".makeLocalizationOnLabel()
        self.nameLabel.text = "name".makeLocalizationOnLabel()
        self.emailLabel.text = "email".makeLocalizationOnLabel()
        self.passwordLabel.text = "password".makeLocalizationOnLabel()
        self.confirmPassowrdLabel.text = "confirm_password".makeLocalizationOnLabel()
        self.creatAccoutnDescriptionLabel.text = "create_your_account_and_feel_the_benefits".makeLocalizationOnLabel()
        self.signUPButton.setTitle("sign_up".makeLocalizationOnLabel(), for: .normal)

    }
    
    
    func passwordInDots(){
        
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        
    }
    
    func roundSignUpButton(){
        
        signUpButton.layer.cornerRadius = 16
        signUpButtonView.layer.cornerRadius = 16
        
    }
    
    @IBAction func passwordViewButtonTapped(_ sender: Any) {
        
        if iconClick {
            let image = UIImage(named: "showeye")
            passwordHideEyeButton.setImage(image, for: .normal)
            passwordTF.isSecureTextEntry = false
            
        } else {
            let image = UIImage(named: "eyes")
            passwordHideEyeButton.setImage(image, for: .normal)
            passwordTF.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
    }
    
    @IBAction func confirmPasswordViewButtonTapped(_ sender: Any) {
        
        if iconClick {
            let image = UIImage(named: "showeye")
            confirmPasswordHideEyeButton.setImage(image, for: .normal)
            confirmPasswordTF.isSecureTextEntry = false
        } else {
            let image = UIImage(named: "eyes")
            confirmPasswordHideEyeButton.setImage(image, for: .normal)
            confirmPasswordTF.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        
        let enteredName = nameTF.text ?? ""
        let entereEmail = emailTF.text ?? ""
        let enteredPassword = passwordTF.text ?? ""
        let enteredConfirmPassword = confirmPasswordTF.text ?? ""

        if enteredName == "" {
            
            Loaf("Pleease enter the name", state: .error, location: .top, sender: self).show()
            
        }else if entereEmail == "" {
            
            Loaf("Pleease enter the email", state: .error, location: .top, sender: self).show()
            
        }else if enteredPassword == ""{
            
            Loaf("Pleease enter the password", state: .error, location: .top, sender: self).show()
            
        }else if enteredConfirmPassword == "" {
            
            Loaf("Pleease enter the confirm password", state: .error, location: .top, sender: self).show()
            
        }else if enteredPassword != enteredConfirmPassword {
            
            Loaf("Passwords do not match", state: .error, location: .top, sender: self).show()
            
        }else if !enteredPassword.isPasswordValid(){
            
            Loaf("Pleease enter atleast eight characters", state: .error, location: .top, sender: self).show()
            
        }else if !entereEmail.isEmailValid() {
            
            Loaf("Pleease enter the valid email", state: .error, location: .top, sender: self).show()
            
        }else if userCoreDataManager.isEmailFound(email: entereEmail){
            
            Loaf("Account Already Exist with this email", state: .error, location: .top, sender: self).show()
            
        }else{
            
            userCoreDataManager.createUser(name: enteredName, email: entereEmail, password: enteredPassword)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any){
        
        self.navigationController?.popViewControllers(viewsToPop: 1)
        
    }
    
}
