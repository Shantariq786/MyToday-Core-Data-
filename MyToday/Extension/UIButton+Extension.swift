//
//  UIButton+Extension.swift
//  MyToday
//
//  Created by Ch. Shan on 12/31/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func setThemeColor(){
        
        let themeColor =  UserDefaults.standard.integer(forKey: "themeColor")
        self.backgroundColor = UIColor(named: THEME_COLORS[themeColor])
        
    }
    
}
