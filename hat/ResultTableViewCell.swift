//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 28.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class ResultTableViewCell : UITableViewCell
	
{
	var correctImageView = UIImageView()
	var wordLabel = UILabel()
	var guessButton = UIButton()
	
	weak var delegate: ResultTableViewCellDelegate?

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
        
		correctImageView.contentMode = .scaleAspectFit
		correctImageView.image = UIImage(named: "resultScoreCircleRight")
		correctImageView.tag = 1
		self.contentView.addSubview(correctImageView)

		fontSize = iphoneConstraints ? 18 : 22
		wordLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		wordLabel.textColor = UIColor(hex: "ffffff")
		wordLabel.textAlignment = .left
        wordLabel.numberOfLines = 2
		wordLabel.tag = 2
		self.contentView.addSubview(wordLabel)

		guessButton.contentMode = .scaleAspectFit
		guessButton.setTitle("", for: .normal)
		guessButton.setBackgroundImage(UIImage(named: "editRowButton"), for: .normal)
		guessButton.addTarget(self, action: #selector(guessButtonPressed), for: .touchUpInside)
		guessButton.tag = 3
		self.contentView.addSubview(guessButton)


    }
	@objc func guessButtonPressed() {
		delegate?.guessButtonPressedInCell(onCell: self)
	}


    func setConstraints() {
        //let safeArea = contentView.layoutMarginsGuide
        
        for itemView in [correctImageView, wordLabel, guessButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		correctImageView.widthAnchor.constraint(equalTo: correctImageView.heightAnchor, multiplier: 70/70).isActive = true
		correctImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		correctImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

		wordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true

		guessButton.widthAnchor.constraint(equalTo: guessButton.heightAnchor, multiplier: 32/30).isActive = true
		guessButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
		guessButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		correctImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.98).isActive = true

		wordLabel.leadingAnchor.constraint(equalTo: correctImageView.trailingAnchor, constant: 10).isActive = true
		wordLabel.trailingAnchor.constraint(equalTo: guessButton.leadingAnchor, constant: -10).isActive = true

		guessButton.heightAnchor.constraint(equalToConstant: 25).isActive = true


        }
        // iPad constraints
        else {
            
		correctImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.98).isActive = true

		wordLabel.leadingAnchor.constraint(equalTo: correctImageView.trailingAnchor, constant: 16).isActive = true
		wordLabel.trailingAnchor.constraint(equalTo: guessButton.leadingAnchor, constant: -16).isActive = true

		guessButton.heightAnchor.constraint(equalToConstant: 35).isActive = true


        }
        
        // items order
        for itemView in [correctImageView, wordLabel, guessButton] {
            contentView.bringSubviewToFront(itemView)
        }
    }
}

protocol ResultTableViewCellDelegate: AnyObject {
	func guessButtonPressedInCell(onCell cell: ResultTableViewCell)
	
}
