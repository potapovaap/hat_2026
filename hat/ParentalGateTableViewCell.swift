//
//  vf.swift
//  hat
//
//  Created by Alisa Potapova on 01.12.2025.
//
import UIKit

class ParentalGateTableViewCell: UICollectionViewCell {
    var backView = UIView()
    var numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    

    func setAttributes() {
        backView.layer.borderWidth = 0
        backView.layer.cornerRadius = 7
        backView.backgroundColor = UIColor(hex: "E4306A")
        self.contentView.addSubview(backView)
        
        numberLabel.textColor = .white
        numberLabel.font = UIFont(name: appFont, size: (UIDevice.current.userInterfaceIdiom == .phone ? 21 : 34))
        numberLabel.textAlignment = .center
        self.contentView.addSubview(numberLabel)
        
    }

    func setConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:0).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
    }
    
}
