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

class PlayerTableViewCell : UITableViewCell
	
{
	var numberLabel = UILabel()
	var nameLabel = UILabel()
	var wordsRoundView = UIView()
	var gesturesRoundView = UIView()
	var onewordRoundView = UIView()
	var drawingRoundView = UIView()
	var totalBackImageView = UIImageView()
	var wordsRoundScoreLabel = UILabel()
	var gesturesRoundScoreLabel = UILabel()
	var onewordRoundScoreLabel = UILabel()
	var drawingRoundScoreLabel = UILabel()
	var totalScoreLabel = UILabel()
	var wordsNoRoundImageView = UIImageView()
	var gesturesNoRoundImageView = UIImageView()
	var onewordNoRoundImageView = UIImageView()
	var drawingNoRoundImageView = UIImageView()
	

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
        
		fontSize = iphoneConstraints ? 16 : 18
		numberLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		numberLabel.textColor = UIColor(hex: "ffffff")
		numberLabel.textAlignment = .left
		numberLabel.tag = 1
		self.contentView.addSubview(numberLabel)

		fontSize = iphoneConstraints ? 16 : 18
		nameLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		nameLabel.textColor = UIColor(hex: "ffffff")
		nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
		nameLabel.tag = 2
		self.contentView.addSubview(nameLabel)

		wordsRoundView.backgroundColor = UIColor(hex: "F4B33F")
		wordsRoundView.layer.cornerRadius = 3
		wordsRoundView.clipsToBounds = true
		wordsRoundView.tag = 3
		self.contentView.addSubview(wordsRoundView)

		gesturesRoundView.backgroundColor = UIColor(hex: "EF7E32")
		gesturesRoundView.layer.cornerRadius = 3
		gesturesRoundView.clipsToBounds = true
		gesturesRoundView.tag = 4
		self.contentView.addSubview(gesturesRoundView)

		onewordRoundView.backgroundColor = UIColor(hex: "40AF4B")
		onewordRoundView.layer.cornerRadius = 3
		onewordRoundView.clipsToBounds = true
		onewordRoundView.tag = 5
		self.contentView.addSubview(onewordRoundView)

		drawingRoundView.backgroundColor = UIColor(hex: "E84070")
		drawingRoundView.layer.cornerRadius = 3
		drawingRoundView.clipsToBounds = true
		drawingRoundView.tag = 6
		self.contentView.addSubview(drawingRoundView)

		totalBackImageView.contentMode = .scaleAspectFit
		totalBackImageView.image = UIImage(named: "totalScoreBack")
		totalBackImageView.tag = 7
		self.contentView.addSubview(totalBackImageView)

		fontSize = iphoneConstraints ? 16 : 18
		wordsRoundScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		wordsRoundScoreLabel.textColor = UIColor(hex: "ffffff")
		wordsRoundScoreLabel.textAlignment = .center
		wordsRoundScoreLabel.tag = 8
		self.contentView.addSubview(wordsRoundScoreLabel)

		fontSize = iphoneConstraints ? 16 : 18
		gesturesRoundScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		gesturesRoundScoreLabel.textColor = UIColor(hex: "ffffff")
		gesturesRoundScoreLabel.textAlignment = .center
		gesturesRoundScoreLabel.tag = 9
		self.contentView.addSubview(gesturesRoundScoreLabel)

		fontSize = iphoneConstraints ? 16 : 18
		onewordRoundScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		onewordRoundScoreLabel.textColor = UIColor(hex: "ffffff")
		onewordRoundScoreLabel.textAlignment = .center
		onewordRoundScoreLabel.tag = 10
		self.contentView.addSubview(onewordRoundScoreLabel)

		fontSize = iphoneConstraints ? 16 : 18
		drawingRoundScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		drawingRoundScoreLabel.textColor = UIColor(hex: "ffffff")
		drawingRoundScoreLabel.textAlignment = .center
		drawingRoundScoreLabel.tag = 11
		self.contentView.addSubview(drawingRoundScoreLabel)

		fontSize = iphoneConstraints ? 16 : 22
		totalScoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		totalScoreLabel.textColor = UIColor(hex: "4839FE")
		totalScoreLabel.textAlignment = .center
		totalScoreLabel.tag = 12
		self.contentView.addSubview(totalScoreLabel)

		wordsNoRoundImageView.contentMode = .scaleAspectFit
		wordsNoRoundImageView.image = UIImage(named: "noRound")
		wordsNoRoundImageView.tag = 13
		self.contentView.addSubview(wordsNoRoundImageView)

		gesturesNoRoundImageView.contentMode = .scaleAspectFit
		gesturesNoRoundImageView.image = UIImage(named: "noRound")
		gesturesNoRoundImageView.tag = 14
		self.contentView.addSubview(gesturesNoRoundImageView)

		onewordNoRoundImageView.contentMode = .scaleAspectFit
		onewordNoRoundImageView.image = UIImage(named: "noRound")
		onewordNoRoundImageView.tag = 15
		self.contentView.addSubview(onewordNoRoundImageView)

		drawingNoRoundImageView.contentMode = .scaleAspectFit
		drawingNoRoundImageView.image = UIImage(named: "noRound")
		drawingNoRoundImageView.tag = 16
		self.contentView.addSubview(drawingNoRoundImageView)


    }

    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [numberLabel, nameLabel, wordsRoundView, gesturesRoundView, onewordRoundView, drawingRoundView, totalBackImageView, wordsRoundScoreLabel, gesturesRoundScoreLabel, onewordRoundScoreLabel, drawingRoundScoreLabel, totalScoreLabel, wordsNoRoundImageView, gesturesNoRoundImageView, onewordNoRoundImageView, drawingNoRoundImageView] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

		nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: wordsRoundView.leadingAnchor, constant: -5).isActive = true

		wordsRoundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		wordsRoundView.heightAnchor.constraint(equalTo: wordsRoundView.widthAnchor, multiplier: 0.8).isActive = true

		gesturesRoundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		gesturesRoundView.heightAnchor.constraint(equalTo: gesturesRoundView.widthAnchor, multiplier: 0.8).isActive = true

		onewordRoundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		onewordRoundView.heightAnchor.constraint(equalTo: onewordRoundView.widthAnchor, multiplier: 0.8).isActive = true

		drawingRoundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		drawingRoundView.heightAnchor.constraint(equalTo: drawingRoundView.widthAnchor, multiplier: 0.8).isActive = true

		totalBackImageView.widthAnchor.constraint(equalTo: totalBackImageView.heightAnchor, multiplier: 60/60).isActive = true
		totalBackImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		totalBackImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

		wordsRoundScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		wordsRoundScoreLabel.centerXAnchor.constraint(equalTo: wordsRoundView.centerXAnchor, constant: 0).isActive = true

		gesturesRoundScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		gesturesRoundScoreLabel.centerXAnchor.constraint(equalTo: gesturesRoundView.centerXAnchor, constant: 0).isActive = true

		onewordRoundScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		onewordRoundScoreLabel.centerXAnchor.constraint(equalTo: onewordRoundView.centerXAnchor, constant: 0).isActive = true

		drawingRoundScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		drawingRoundScoreLabel.centerXAnchor.constraint(equalTo: drawingRoundView.centerXAnchor, constant: 0).isActive = true

		totalScoreLabel.centerYAnchor.constraint(equalTo: totalBackImageView.centerYAnchor, constant: 0).isActive = true
		totalScoreLabel.centerXAnchor.constraint(equalTo: totalBackImageView.centerXAnchor, constant: 0).isActive = true

		wordsNoRoundImageView.widthAnchor.constraint(equalTo: wordsNoRoundImageView.heightAnchor, multiplier: 19/19).isActive = true
		wordsNoRoundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		wordsNoRoundImageView.centerXAnchor.constraint(equalTo: wordsRoundView.centerXAnchor, constant: 0).isActive = true

		gesturesNoRoundImageView.widthAnchor.constraint(equalTo: gesturesNoRoundImageView.heightAnchor, multiplier: 19/19).isActive = true
		gesturesNoRoundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		gesturesNoRoundImageView.centerXAnchor.constraint(equalTo: gesturesRoundView.centerXAnchor, constant: 0).isActive = true

		onewordNoRoundImageView.widthAnchor.constraint(equalTo: onewordNoRoundImageView.heightAnchor, multiplier: 19/19).isActive = true
		onewordNoRoundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		onewordNoRoundImageView.centerXAnchor.constraint(equalTo: onewordRoundView.centerXAnchor, constant: 0).isActive = true

		drawingNoRoundImageView.widthAnchor.constraint(equalTo: drawingNoRoundImageView.heightAnchor, multiplier: 19/19).isActive = true
		drawingNoRoundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		drawingNoRoundImageView.centerXAnchor.constraint(equalTo: drawingRoundView.centerXAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10).isActive = true

		wordsRoundView.heightAnchor.constraint(equalToConstant: 24).isActive = true //34
		wordsRoundView.trailingAnchor.constraint(equalTo: gesturesRoundView.leadingAnchor, constant: -3).isActive = true

		gesturesRoundView.heightAnchor.constraint(equalToConstant: 24).isActive = true
		gesturesRoundView.trailingAnchor.constraint(equalTo: onewordRoundView.leadingAnchor, constant: -3).isActive = true

		onewordRoundView.heightAnchor.constraint(equalToConstant: 24).isActive = true
		onewordRoundView.trailingAnchor.constraint(equalTo: drawingRoundView.leadingAnchor, constant: -3).isActive = true

		drawingRoundView.heightAnchor.constraint(equalToConstant: 24).isActive = true
		drawingRoundView.trailingAnchor.constraint(equalTo: totalBackImageView.leadingAnchor, constant: -3).isActive = true

		totalBackImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true //60

		wordsNoRoundImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true //20

		gesturesNoRoundImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true

		onewordNoRoundImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true

		drawingNoRoundImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true


        }
        // iPad constraints
        else {
            
		nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20).isActive = true

		wordsRoundView.heightAnchor.constraint(equalToConstant: 46).isActive = true
		wordsRoundView.trailingAnchor.constraint(equalTo: gesturesRoundView.leadingAnchor, constant: -6).isActive = true

		gesturesRoundView.heightAnchor.constraint(equalToConstant: 46).isActive = true
		gesturesRoundView.trailingAnchor.constraint(equalTo: onewordRoundView.leadingAnchor, constant: -6).isActive = true

		onewordRoundView.heightAnchor.constraint(equalToConstant: 46).isActive = true
		onewordRoundView.trailingAnchor.constraint(equalTo: drawingRoundView.leadingAnchor, constant: -6).isActive = true

		drawingRoundView.heightAnchor.constraint(equalToConstant: 46).isActive = true
		drawingRoundView.trailingAnchor.constraint(equalTo: totalBackImageView.leadingAnchor, constant: -6).isActive = true

		totalBackImageView.heightAnchor.constraint(equalToConstant: 76).isActive = true

		wordsNoRoundImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true

		gesturesNoRoundImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true

		onewordNoRoundImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true

		drawingNoRoundImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true


        }
        
        // items order
        for itemView in [numberLabel, nameLabel, wordsRoundView, gesturesRoundView, onewordRoundView, drawingRoundView, totalBackImageView, wordsRoundScoreLabel, gesturesRoundScoreLabel, onewordRoundScoreLabel, drawingRoundScoreLabel, totalScoreLabel, wordsNoRoundImageView, gesturesNoRoundImageView, onewordNoRoundImageView, drawingNoRoundImageView] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol PlayerTableViewCellDelegate: AnyObject {
	
}


