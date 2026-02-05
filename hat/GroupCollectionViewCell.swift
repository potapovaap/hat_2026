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

class GroupCollectionViewCell : UICollectionViewCell
	
{
	var backView = UIView()
	var bottomView = UIView()
	var groupFieldLabel = UILabel()
	

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
        
		backView.backgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
		backView.layer.cornerRadius = 3
		backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		backView.layer.masksToBounds = true
		backView.tag = 1
		self.contentView.addSubview(backView)

		bottomView.backgroundColor = UIColor(hex: "000000")
		bottomView.tag = 2
		self.contentView.addSubview(bottomView)

		fontSize = iphoneConstraints ? 14 : 18
		groupFieldLabel.font = UIFont(name: "Helvetica Neue", size: fontSize) // Helvetica Neue
		groupFieldLabel.textColor = UIColor(hex: "ffffff")
		groupFieldLabel.textAlignment = .center
		groupFieldLabel.tag = 3
		self.contentView.addSubview(groupFieldLabel)


    }

    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [backView, bottomView, groupFieldLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
		backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true

		bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
		bottomView.heightAnchor.constraint(equalToConstant: 5).isActive = true

		groupFieldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		groupFieldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		groupFieldLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            

        }
        // iPad constraints
        else {
            

        }
        
        // items order
        for itemView in [backView, bottomView, groupFieldLabel] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol GroupCollectionViewCellDelegate: AnyObject {
	
}
