//
//  DashbordViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 10/26/23.
//

import UIKit
import UserNotifications

class DashbordViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let todoCoreDataManager = TodoCoreDataManager()
    var localItems: [Todo] = []
    var themeIndex = ColorTheme.currentIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataFromLocalDB()
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification), name: Notification.Name("currentThemeChanged"), object: nil)
    }
    
    @objc func methodOfReceivedNotification() {
        DispatchQueue.main.async {
            self.themeIndex = ColorTheme.currentIndex
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any){
        
        let vc = UIStoryboard(name: "Bottonsheet", bundle: nil).instantiateViewController(withIdentifier: "ButtomSheetButtonViewController") as! ButtomSheetButtonViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: - TABLEVIEW DELEGETES

extension DashbordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchDataFromLocalDB(){
        let isUserId = UserDefaults.standard.string(forKey: "isUserId") ?? ""
        localItems = todoCoreDataManager.fetchTodo(userId: isUserId) // user if pass 1 5, 10
        tableView.reloadData() //userId: isUserId
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        // Write action code for the trash
        let TrashAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            // will delete the certain item
            let todo = self.localItems[indexPath.row]
            let id = todo.id ?? UUID() //10
            self.todoCoreDataManager.deleteTodo(id: id)
            
            
            self.fetchDataFromLocalDB()
            self.deleteNotification(id: id)
            
            success(true)
        })
        TrashAction.backgroundColor = .red
        
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            // Add your edit logic here
            // For example, you might present a modal for editing
            
            let editVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditTodayViewController") as! EditTodayViewController
            let todo = self.localItems[indexPath.row]
            editVC.editItem = todo
            self.navigationController?.pushViewController(editVC, animated: true)
            
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [TrashAction, editAction])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        
        let todo = localItems[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.descriptionLabel.text = todo.discription
        cell.priorityLabel.text = todo.priority
        cell.dateAndTimeLabel.text = todo.time
        
        if themeIndex == 4{
            cell.titleLabel.textColor = .white
            cell.descriptionLabel.textColor = .white
            cell.dateAndTimeLabel.textColor = .white
            
        }else{
            cell.titleLabel.textColor = .black
            cell.descriptionLabel.textColor = .black
            cell.dateAndTimeLabel.textColor = .black
        }
        
        cell.childView.backgroundColor = UIColor(named: THEME_COLORS[themeIndex])
        return cell
    }
    
    
    func deleteNotification(id: UUID) {
        // Create a notification identifier based on the UUID
        let notificationIdentifier = id.uuidString
        
        // Get the current list of delivered notifications
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            // Find the notification with the specified identifier
            let matchingNotification = notifications.first { $0.request.identifier == notificationIdentifier }
            
            // If a matching notification is found, remove it
            if let notificationToRemove = matchingNotification {
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationToRemove.request.identifier])
            }
            // You might also want to cancel scheduled notifications with the same identifier
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        }
    }
}
