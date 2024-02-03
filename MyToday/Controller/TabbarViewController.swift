//
//  Tabbar.swift
//  MyToday
//
//  Created by Ch. Shan on 12/6/23.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var dashboardNavigation: UINavigationController!
    var upcomingsNavigation: UINavigationController!
    var settingsNavigation: UINavigationController!
    
    var themeIndex = ColorTheme.currentIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashbordViewController") as! DashbordViewController
        dashboardNavigation = UINavigationController(rootViewController: dashboardVC)
        dashboardNavigation.title = "Home"
        dashboardNavigation.tabBarItem.image = UIImage(named: "Home 1")
        
        
        let upcomingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpComingsViewController") as! UpComingsViewController
        upcomingsNavigation = UINavigationController(rootViewController: upcomingsVC)
        upcomingsNavigation.title = "Upcomings"
        upcomingsNavigation.tabBarItem.image = UIImage(named: "calendar")
        
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        settingsNavigation = UINavigationController(rootViewController: settingsVC)
        settingsNavigation.title = "Account Settings"
        settingsNavigation.tabBarItem.image = UIImage(named: "Category")
        
        viewControllers = [dashboardNavigation, upcomingsNavigation, settingsNavigation]
        tabBar.tintColor = UIColor(named: THEME_COLORS[themeIndex])
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelsLanguage), name: Notification.Name("currentLanguageChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTabbarColours), name: Notification.Name("currentThemeChanged"), object: nil)
    }
    
    @objc func updateLabelsLanguage() {
        dashboardNavigation.title = "home".makeLocalizationOnLabel()
        upcomingsNavigation.title = "upcomings".makeLocalizationOnLabel()
        settingsNavigation.title = "settings".makeLocalizationOnLabel()
    }
    
    @objc func updateTabbarColours(){
        
        self.themeIndex = ColorTheme.currentIndex
        self.tabBar.tintColor = UIColor(named: THEME_COLORS[themeIndex])
        
    }
    
}
