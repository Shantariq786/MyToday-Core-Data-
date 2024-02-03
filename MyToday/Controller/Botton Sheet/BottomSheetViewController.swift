//
//  BottomSheetViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 1/31/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var bottomSheetDownConstraint: NSLayoutConstraint!
    
    let sheetHeight = 490.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapped))
        backgroundView.addGestureRecognizer(tap)
        bottomSheetDownConstraint.constant = -1 * sheetHeight
        
        bottomSheetView.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMene()
    }
    
    func showMene(){
        
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetDownConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func bgViewTapped() {
        hideBottomSheet()
    }
    
    func hideBottomSheet(){
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetDownConstraint.constant =  -1 * self.sheetHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func crossButtonTapped(_ sender: Any){
        
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetDownConstraint.constant =  -1 * self.sheetHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
        
    }
}
