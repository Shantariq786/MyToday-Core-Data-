//
//  CalculatorViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/15/23.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var spinView: SpinView!
    @IBOutlet weak var sacrtachView: SpinView!
    @IBOutlet weak var shareView: SpinView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinView.setData(title1: "SPIN to", title2: "WIN", title3: "Earn Reward")
        sacrtachView.setData(title1: "SACRATCH to", title2: "WIN", title3: "Earn Reward")
        shareView.setData(title1: "SHARE to", title2: "WIN", title3: "Earn Reward")
    }
    // MARK: - Navigation
}
