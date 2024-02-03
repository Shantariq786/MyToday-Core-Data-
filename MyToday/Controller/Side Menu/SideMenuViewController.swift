//
//  SideMenuViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 1/31/24.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var backgroundView:UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    let menueWidth = 240.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapped))
        backgroundView.addGestureRecognizer(tap)
        sideMenuLeadingConstraint.constant = -1 * menueWidth // -240 when the screen is loaded
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMene()
    }
    
    func showMene(){
        
        UIView.animate(withDuration: 0.3) {
            self.sideMenuLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func bgViewTapped() {
        hideMenu()
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.3) {
            self.sideMenuLeadingConstraint.constant =  -1 * self.menueWidth
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    
}
