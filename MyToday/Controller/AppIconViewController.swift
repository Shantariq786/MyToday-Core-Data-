//
//  AppIconViewController.swift
//  MyToday
//
//  Created by Ch. Shan on 12/30/23.
//

import UIKit

class AppIconViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var icons = [ "icon 1", "icon 2", "icon 3", "icon 4", "icon 5", "icon 6", "icon 7", "icon 8", "icon 9", "icon 10","icon 11", "icon 12", "icon 13", "icon 14", "icon 15"
    ]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AppIconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppIconCollectionViewCell")
        selectedIndex = ColorTheme.currentIndex
        
    }
}


//MARK: App icon functions



extension AppIconViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppIconCollectionViewCell", for: indexPath) as! AppIconCollectionViewCell
        cell.appIconImage.image = UIImage(named: icons[indexPath.row])
        
        if indexPath.row == selectedIndex{
            cell.tickImage.isHidden = false
        }else {
            cell.tickImage.isHidden = true
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionviewWidth = collectionView.frame.width - 64
        let cellWidth = collectionviewWidth / 3
        return CGSize(width: cellWidth , height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        ColorTheme.currentIndex = selectedIndex
        collectionView.reloadData()
        
        
        // notify full app
        NotificationCenter.default.post(name: Notification.Name("currentThemeChanged"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelsLanguage), name: Notification.Name("currentThemeChanged"), object: nil)
    }
    
    @objc func updateLabelsLanguage() {
        DispatchQueue.main.async {
            
            self.navigationController?.navigationBar.tintColor = UIColor(named: THEME_COLORS[self.selectedIndex])
            
        }
    }
    
}
