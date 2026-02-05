//
//  rulesPageVC.swift
//  hat
//
//  Created by Alisa Potapova on 01.12.2025.
//

import UIKit

class rulesPageVC: UIViewController {

    var pageIndex: Int = 0
    var imageFile: String = "rules1"
    var pageImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pageImage)
        
        view.backgroundColor = .clear
        
        pageImage.image = UIImage(named: imageFile)
        
        pageImage.translatesAutoresizingMaskIntoConstraints = false
        
        let curW = UIDevice.current.userInterfaceIdiom == .phone ? 0.7 : 0.55
        pageImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: curW).isActive = true
        pageImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        pageImage.widthAnchor.constraint(equalTo: pageImage.heightAnchor, multiplier: 332/488).isActive = true
        
    }

}
