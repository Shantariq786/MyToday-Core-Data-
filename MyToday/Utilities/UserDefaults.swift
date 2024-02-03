//
//  UserDefaults.swift
//  MyToday
//
//  Created by Ch. Shan on 1/6/24.
//

import Foundation




struct ColorTheme {
    static let keyforLaunch = "themeColor"
    static var currentIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: keyforLaunch)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyforLaunch)
        }
    }
}


struct LanguageIndex {
    static let keyforLaunch = "languageIndex"
    static var currentIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: keyforLaunch)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyforLaunch)
        }
    }
}
