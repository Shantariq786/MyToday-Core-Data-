//
//  SidemMenuButtonViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 1/31/24.
//

import UIKit

class SidemMenuButtonViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sideMenuButtonTapped(_ sender: Any){
        
        let storybord = UIStoryboard(name: "SideMenu", bundle: nil)
        let vc = storybord.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }

}
