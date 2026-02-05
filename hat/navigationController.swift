//
//  Untitled.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 18.06.2025.
//

import UIKit

class navigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
    
}

extension UINavigationController {
    
    func setNavigationBar(backgroundColor: UIColor = navigationBarBackgroundColor, barTintColor: UIColor = navigationBarTintColor, titleColor: UIColor = navigationBarTitleColor, titleFont: UIFont = navigationBarFont) {
        if #available(iOS 13.0, *) { //for iOS 15 navigatin bar background color bug:
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            // Цвет навигационной панели
            appearance.backgroundColor = backgroundColor
            // Цвет и шрифт заголовка на навигационной панели
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFont]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
           navigationBar.tintColor = barTintColor
        } else {
            // Цвет навигационной панели
            navigationBar.backgroundColor = backgroundColor
            navigationBar.barTintColor = barTintColor
            // Цвет и шрифт заголовка на навигационной панели
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFont]
        }
        
    }
    
}
