//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 01.12.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class SortCollectionViewCell : UICollectionViewCell
	
{
	var backView = UIView()
	var sortFieldLabel = UILabel()
	

	var fontSize = CGFloat(20.0)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }



    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backView.backgroundColor = .clear
		backView.layer.cornerRadius = 16
		backView.clipsToBounds = true
		backView.tag = 1
		self.contentView.addSubview(backView)

		fontSize = iphoneConstraints ? 15 : 20
		sortFieldLabel.font = UIFont(name: "Helvetica Neue", size: fontSize)
		sortFieldLabel.textColor = UIColor(hex: "ffffff")
		sortFieldLabel.textAlignment = .center
		sortFieldLabel.tag = 2
		self.contentView.addSubview(sortFieldLabel)


    }

    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [backView, sortFieldLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6).isActive = true
		backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
		backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
		backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true

		sortFieldLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0).isActive = true
		sortFieldLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0).isActive = true
		sortFieldLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            

        }
        // iPad constraints
        else {
            

        }
        
        // items order
        for itemView in [backView, sortFieldLabel] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol SortCollectionViewCellDelegate: AnyObject {
	
}
