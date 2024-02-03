//
//  LanguagesViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 1/16/24.
//

import UIKit

class LanguagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let languages = ["English", "Urdu", "Hindi", "French", "German", "Chineese", "Italian", "Swedish", "Korean", "Arabic", "Turkish"]
    var selectedLanguageIndex = 0
    
    var themeIndex = ColorTheme.currentIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "LanguagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguagesTableViewCell")
        selectedLanguageIndex = LanguageIndex.currentIndex
            
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesTableViewCell") as! LanguagesTableViewCell
        cell.imageLabel.image = UIImage(named: "tick 1")
        cell.laguageLabel.text = languages[indexPath.row]
        
        if indexPath.row == selectedLanguageIndex{
            cell.imageLabel.isHidden = false
        }else {
            cell.imageLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguageIndex = indexPath.row
        LanguageIndex.currentIndex = selectedLanguageIndex
        tableView.reloadData()
        
        NotificationCenter.default.post(name: Notification.Name("currentLanguageChanged"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
