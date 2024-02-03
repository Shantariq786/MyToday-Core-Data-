//
//  CreatTaskViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 11/4/23.
//

import UIKit
import Loaf
import CoreData

class CreatTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var discriptionTF: UITextField!
    @IBOutlet weak var priorityTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var creatTapped: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var timeLabel:UILabel!
    
    let todoCoreDataManager = TodoCoreDataManager()
    var localItems: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDateTimePicker))
        timeTF.addGestureRecognizer(tapGesture)
        
        creatTapped.layer.cornerRadius = 16
        
        requestForNotificationAutherization()
    
        creatTapped.setThemeColor()
        
        updateLabelsLanguage()
        
    }
    
    func updateLabelsLanguage() {
        
        self.titleLabel.text = "title".makeLocalizationOnLabel()
        self.descriptionLabel.text = "description".makeLocalizationOnLabel()
        self.priorityLabel.text = "priority".makeLocalizationOnLabel()
        self.timeLabel.text = "time".makeLocalizationOnLabel()
        self.creatTapped.setTitle("create".makeLocalizationOnLabel(), for: .normal)

    }
    
    @IBAction func creatButtonTapped(_ sender: Any){
        
        let title = titleTF.text ?? ""
        let description = discriptionTF.text ?? ""
        let priority = priorityTF.text ?? ""
        let time = timeTF.text ?? ""
        
        let isInuputValid = checkInput(title: title, description: description, priority: priority, time: time)
        let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        if isInuputValid == true{ // save data
            
            let uuid = UUID()
            todoCoreDataManager.createTodo(uuid:uuid, title: title, description: description, priority: priority, time: time, userID: UUID(uuidString: isUserId)!)
            
            // triger notification
            requestForNotificationAutherization()
            triggerLocalNotification(uuid: uuid)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
        func checkInput(title: String, description: String, priority: String, time: String) -> Bool{
            
            if title == ""{
                Loaf("Please enter the title", state: .error, location: .top, sender: self).show()
                return false
                
            } else if description == ""{
                Loaf("Please enter the description", state: .error, location: .top, sender: self).show()
                return false
                
            }else if priority == ""{
                Loaf("Please enter the priority", state: .error, location: .top, sender: self).show()
                return false
                
            }else if time == ""{
                Loaf("Please select the date and time", state: .error, location: .top, sender: self).show()
                return false
                
            }else{
                return true
            }
            
        }
        
    }
    
    
    @objc func showDateTimePicker() {
        let alertController = UIAlertController(title: "\n\n", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: alertController.view.frame.width - 110, height: 100))
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        
        alertController.view.addSubview(datePicker)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            self.timeTF.text = dateFormatter.string(from: datePicker.date)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func requestForNotificationAutherization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil{
                print("permission granted")
                
            }else{
                print("error for notification autherization ",error?.localizedDescription ?? "")
                
            }
        }
    }
    
    
    func triggerLocalNotification(uuid:UUID) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                
                // Fetch all items from CoreData
                let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
                
                // Parse the time from each item
                let time = self.timeTF.text ?? ""
                
                // Parse stored time
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                guard let notificationTime = dateFormatter.date(from: time) else {
                    print("Error parsing notification time")
                    return
                }
                
                // Calculate time difference between current time and stored time
                let timeDifference = notificationTime.timeIntervalSinceNow
                
                // Check if the time difference is positive (in the future)
                if timeDifference > 0 {
                    // Trigger local notification with calculated time difference
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeDifference, repeats: false)
                    
                    // Creating the notification content
                    let content = UNMutableNotificationContent()
                    content.title = self.titleTF.text ?? ""
                    
                    // Getting the notification request
                    let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                    
                    // Adding the notification to the notification center
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    
                    print("Notification triggered for \(self.titleTF.text ?? "")")
                }
            }
        }
    }
}
