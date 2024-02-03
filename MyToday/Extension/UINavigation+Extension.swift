//
//  UINavigation+Extension.swift
//  MyToday
//
//  Created by Ch. Shan on 11/2/23.
//

import Foundation
import UIKit

extension UINavigationController{
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true){
        if viewControllers.count > viewsToPop{
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}
