//
//  UserTableViewCell.swift
//  MyToday
//
//  Created by Ch. Shan on 11/4/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var preantView: UIView!
    
    @IBOutlet weak var childView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        preantView.layer.cornerRadius = 8
        
        childView.layer.cornerRadius = 8
        childView.layer.masksToBounds = true
        childView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    

}



