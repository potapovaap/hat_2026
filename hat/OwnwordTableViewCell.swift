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

class OwnwordTableViewCell : UITableViewCell
	
{
	var numberLabel = UILabel()
	var nameLabel = UILabel()
	var editButton = UIButton()
	var deleteButton = UIButton()
	
	weak var delegate: OwnwordTableViewCellDelegate?

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
        
		fontSize = iphoneConstraints ? 18 : 22
		numberLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		numberLabel.textColor = UIColor(hex: "ffffff")
		numberLabel.textAlignment = .left
		numberLabel.tag = 1
		self.contentView.addSubview(numberLabel)

		fontSize = iphoneConstraints ? 18 : 22
		nameLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		nameLabel.textColor = UIColor(hex: "ffffff")
		nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
		nameLabel.tag = 2
		self.contentView.addSubview(nameLabel)

		editButton.contentMode = .scaleAspectFit
		editButton.setTitle("", for: .normal)
		editButton.setBackgroundImage(UIImage(named: "editRowButton"), for: .normal)
		editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
		editButton.tag = 3
		self.contentView.addSubview(editButton)

		deleteButton.contentMode = .scaleAspectFit
		deleteButton.setTitle("", for: .normal)
		deleteButton.setBackgroundImage(UIImage(named: "deleteRowButton"), for: .normal)
		deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
		deleteButton.tag = 4
		self.contentView.addSubview(deleteButton)


    }
	@objc func editButtonPressed() {
		delegate?.editButtonPressedInCell(onCell: self)
	}

	@objc func deleteButtonPressed() {
		delegate?.deleteButtonPressedInCell(onCell: self)
	}


    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [numberLabel, nameLabel, editButton, deleteButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

		nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -5).isActive = true

		editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor, multiplier: 35/32).isActive = true
		editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true

		deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor, multiplier: 35/32).isActive = true
		deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10).isActive = true

		editButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
		editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -15).isActive = true

		deleteButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
		deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true


        }
        // iPad constraints
        else {
            
		nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20).isActive = true

		editButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
		editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -25).isActive = true

		deleteButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
		deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true


        }
        
        // items order
        for itemView in [numberLabel, nameLabel, editButton, deleteButton] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol OwnwordTableViewCellDelegate: AnyObject {
	func editButtonPressedInCell(onCell cell: OwnwordTableViewCell)
	func deleteButtonPressedInCell(onCell cell: OwnwordTableViewCell)
	
}
