//
//  String+Extension.swift
//  MyToday
//
//  Created by Ch. Shan on 10/27/23.
//

import Foundation


extension String{
    
    func isEmailValid() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self) // self = value = shan
    }
    
    //    func isPasswordValid() -> Bool{
    //        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    //        return passwordTest.evaluate(with: self)
    //    }
    
    func isPasswordValid() -> Bool {
        return self.count >= 8
    }
}



extension String {
    
    //code for swift 2.3
    
    
    func makeLocalizationOnLabel()->String{
        let selectedLanguageIndex = LanguageIndex.currentIndex
        
        if selectedLanguageIndex == 0{
            return self.getLocalized(loc: "en")
            
        }else if selectedLanguageIndex == 1{
            return self.getLocalized(loc: "ur")
            
        }else if selectedLanguageIndex == 2{
            return self.getLocalized(loc: "hi")
            
        }else if selectedLanguageIndex == 3{
            return self.getLocalized(loc: "fr")
            
        }else if selectedLanguageIndex == 4{
            return self.getLocalized(loc: "de")
            
        }else if selectedLanguageIndex == 5{
            return self.getLocalized(loc: "zh-Hant")
            
        }else if selectedLanguageIndex == 6{
            return self.getLocalized(loc: "it")
            
        }else if selectedLanguageIndex == 7{
            return self.getLocalized(loc: "sv")
            
        }else if selectedLanguageIndex == 8{
            return self.getLocalized(loc: "ko")
            
        }else if selectedLanguageIndex == 9{
            return self.getLocalized(loc: "ar")
            
        }else if selectedLanguageIndex == 10{
            return self.getLocalized(loc: "tr")
            
        }else{
            return self.getLocalized(loc: "en")
        }
    }
    
    
    private func getLocalized(loc:String) -> String {
        
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!,   value: "", comment: "")
        
    }
}
