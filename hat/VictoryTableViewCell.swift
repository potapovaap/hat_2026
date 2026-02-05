//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 29.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class VictoryTableViewCell : UITableViewCell
	
{
	var placeImageView = UIImageView()
	var numberLabel = UILabel()
	var nameLabel = UILabel()
	var totalBackView = UIView()
	var totalScoreLabel = UILabel()
	

	var fontSize = CGFloat(20.0)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }



    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		placeImageView.contentMode = .scaleAspectFit
		placeImageView.image = UIImage(named: "placeOtherPink")
		placeImageView.tag = 1
		self.contentView.addSubview(placeImageView)

		fontSize = iphoneConstraints ? 18 : 22
		numberLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		numberLabel.textColor = UIColor(hex: "ffffff")
		numberLabel.textAlignment = .center
		numberLabel.tag = 2
		self.contentView.addSubview(numberLabel)

		fontSize = iphoneConstraints ? 18 : 22
		nameLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		nameLabel.textColor = UIColor(hex: "ffffff")
		nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
		nameLabel.tag = 3
		self.contentView.addSubview(nameLabel)

		totalBackView.backgroundColor = UIColor(hex: "40AF4B")
		totalBackView.layer.cornerRadius = 3
		totalBackView.clipsToBounds = true
		totalBackView.tag = 4
		self.contentView.addSubview(totalBackView)

		fontSize = iphoneConstraints ? 18 : 22
		totalScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		totalScoreLabel.textColor = UIColor(hex: "ffffff")
		totalScoreLabel.textAlignment = .center
		totalScoreLabel.tag = 5
		self.contentView.addSubview(totalScoreLabel)


    }

    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [placeImageView, numberLabel, nameLabel, totalBackView, totalScoreLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor, multiplier: 70/70).isActive = true
		placeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

		numberLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor, constant: 0).isActive = true
		numberLabel.centerXAnchor.constraint(equalTo: placeImageView.centerXAnchor, constant: 0).isActive = true

		nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 10).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: totalBackView.leadingAnchor, constant: -5).isActive = true

		totalBackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		totalBackView.heightAnchor.constraint(equalTo: totalBackView.widthAnchor, multiplier: 0.8).isActive = true
		totalBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

		totalScoreLabel.centerYAnchor.constraint(equalTo: totalBackView.centerYAnchor, constant: 0).isActive = true
		totalScoreLabel.centerXAnchor.constraint(equalTo: totalBackView.centerXAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		placeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95).isActive = true

		totalBackView.heightAnchor.constraint(equalToConstant: 34).isActive = true


        }
        // iPad constraints
        else {
            
		placeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95).isActive = true

		totalBackView.heightAnchor.constraint(equalToConstant: 46).isActive = true


        }
        
        // items order
        for itemView in [placeImageView, numberLabel, nameLabel, totalBackView, totalScoreLabel] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol VictoryTableViewCellDelegate: AnyObject {
	
}
