//
//  ButtomSheetButtonViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 1/31/24.
//

import UIKit

class ButtomSheetButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ButtonSheetButtonTapped(_ sender: Any){
        
        print("tapped")
        
        let storybord = UIStoryboard(name: "Bottonsheet", bundle: nil)
        let vc = storybord.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
        
    }

}
