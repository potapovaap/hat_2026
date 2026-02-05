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

class SectionTableViewCell : UITableViewCell
	
{
	var backgroundImageView = UIImageView()
	var imageImageView = UIImageView()
	var selectedImageView = UIImageView()
	var nameLabel = UILabel()
	var descLabel = UILabel()
	var questionsCountLabel = UILabel()
	var favoriteButton = UIButton()
	var lockedImageView = UIImageView()
	var addWordsButton = UIButton()
	
	weak var delegate: SectionTableViewCellDelegate?

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
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "themeBackYellow")
		backgroundImageView.tag = 1
		self.contentView.addSubview(backgroundImageView)

		imageImageView.contentMode = .scaleAspectFit
		imageImageView.image = UIImage(named: "themeImage")
		imageImageView.tag = 2
		self.contentView.addSubview(imageImageView)

		selectedImageView.contentMode = .scaleAspectFit
		selectedImageView.image = UIImage(named: "selectThemeCircleYellow")
		selectedImageView.tag = 3
		self.contentView.addSubview(selectedImageView)

		fontSize = iphoneConstraints ? 17 : 24
		nameLabel.font = UIFont(name: "Helvetica", size: fontSize)
		nameLabel.textColor = UIColor(hex: "ffffff")
		nameLabel.textAlignment = .right
		nameLabel.tag = 4
		self.contentView.addSubview(nameLabel)

		fontSize = iphoneConstraints ? 12 : 18
		descLabel.font = UIFont(name: "Helvetica", size: fontSize)
		descLabel.textColor = UIColor(hex: "ffffff")
		descLabel.textAlignment = .right
		descLabel.numberOfLines = 3
		descLabel.tag = 5
		self.contentView.addSubview(descLabel)

		fontSize = iphoneConstraints ? 14 : 18
		questionsCountLabel.font = UIFont(name: "Helvetica", size: fontSize)
		questionsCountLabel.textColor = UIColor(hex: "ffffff")
		questionsCountLabel.textAlignment = .right
		questionsCountLabel.tag = 6
		self.contentView.addSubview(questionsCountLabel)

		favoriteButton.contentMode = .scaleAspectFit
		favoriteButton.setTitle("", for: .normal)
		favoriteButton.setBackgroundImage(UIImage(named: "favoriteButtonOff"), for: .normal)
		favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
		favoriteButton.tag = 7
		self.contentView.addSubview(favoriteButton)

		lockedImageView.contentMode = .scaleAspectFit
		lockedImageView.image = UIImage(named: "locked")
		lockedImageView.isHidden = true
		lockedImageView.tag = 8
		self.contentView.addSubview(lockedImageView)

		addWordsButton.contentMode = .scaleAspectFit
		addWordsButton.setTitle("", for: .normal)
		addWordsButton.setBackgroundImage(UIImage(named: "addWordsButtonYellow"), for: .normal)
		addWordsButton.addTarget(self, action: #selector(addWordsButtonPressed), for: .touchUpInside)
		addWordsButton.tag = 9
		self.contentView.addSubview(addWordsButton)


    }
	@objc func favoriteButtonPressed() {
		delegate?.favoriteButtonPressedInCell(onCell: self)
	}

	@objc func addWordsButtonPressed() {
		delegate?.addWordsButtonPressedInCell(onCell: self)
	}


    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [backgroundImageView, imageImageView, selectedImageView, nameLabel, descLabel, questionsCountLabel, favoriteButton, lockedImageView, addWordsButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        var labelPadding = 20.0
        if iphoneConstraints {
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE, .iPhone6, .iPhone7, .iPhone8, .iPhone6S: labelPadding = 14.0
            default: break
            }
        } else {
            switch UIDevice().type {
            case .iPadPro2_12_9, .iPadPro3_12_9, .iPadPro12_9, .iPadPro12_9_5rd: labelPadding = 50.0
            default: labelPadding = 30.0
            }
            
        }
        
        // common constraints
		backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

		imageImageView.widthAnchor.constraint(equalTo: imageImageView.heightAnchor, multiplier: 220/220).isActive = true
		imageImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: -5).isActive = true
		imageImageView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.7).isActive = true
        imageImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: labelPadding).isActive = true
        
		selectedImageView.widthAnchor.constraint(equalTo: selectedImageView.heightAnchor, multiplier: 70/70).isActive = true
		selectedImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: 0).isActive = true
		

		nameLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: labelPadding).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: imageImageView.trailingAnchor, constant: 10).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -1 * labelPadding-7).isActive = true

		descLabel.leadingAnchor.constraint(equalTo: imageImageView.trailingAnchor, constant: 0).isActive = true
		descLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -1 * labelPadding-7).isActive = true

		
		questionsCountLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true

		favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor, multiplier: 22/30).isActive = true
		favoriteButton.heightAnchor.constraint(equalToConstant: 36).isActive = true

		lockedImageView.widthAnchor.constraint(equalTo: lockedImageView.heightAnchor, multiplier: 26/33).isActive = true
		lockedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		lockedImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10).isActive = true

		addWordsButton.widthAnchor.constraint(equalTo: addWordsButton.heightAnchor, multiplier: 138/20).isActive = true
		addWordsButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true
        addWordsButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -1 * labelPadding-7).isActive = true


        
        
        // iPhone constraints
        if iphoneConstraints {
            
            selectedImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
            questionsCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
            
		backgroundImageView.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: 10).isActive = true
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 352/142).isActive = true
		backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true

            

		selectedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true

		

		favoriteButton.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 16).isActive = true
		favoriteButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0).isActive = true

		lockedImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

		addWordsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
		


        }
        // iPad constraints
        else {
            selectedImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
            questionsCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
            
		backgroundImageView.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: 16).isActive = true
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 352/142).isActive = true
		backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true

		//imageImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 30).isActive = true

		selectedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true

		favoriteButton.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 26).isActive = true
		favoriteButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0).isActive = true

		lockedImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

		addWordsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		//addWordsButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -20).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, imageImageView, selectedImageView, nameLabel, descLabel, questionsCountLabel, favoriteButton, lockedImageView, addWordsButton] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol SectionTableViewCellDelegate: AnyObject {
	func favoriteButtonPressedInCell(onCell cell: SectionTableViewCell)
	func addWordsButtonPressedInCell(onCell cell: SectionTableViewCell)
	
}
