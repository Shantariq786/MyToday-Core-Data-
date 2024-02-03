//
//  SpinView.swift
//  MyToday
//
//  Created by Ch. Shan on 12/15/23.
//

import UIKit

class SpinView: UIView {
    
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UILabel!
    
    
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        self.configureView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init (coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "SpinView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    
    
    func setData(title1:String,title2:String,title3:String){
        firstTitleLabel.text = title1
        secondTitleLabel.text = title2
        thirdTitleLabel.text = title3
        
    }
}
