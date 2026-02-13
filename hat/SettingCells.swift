//
//  SettingCells.swift
//  tabAppProject
//
//  Created by Alisa Potapova on 29.03.2021.
//  Copyright © 2021 Alisa Potapova. All rights reserved.
//

import UIKit





class SettingSampleCell: UITableViewCell {
    var backView = ViewWithCornerRadius()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       setBackAttributes()
       setBackConstraints()
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func setBackAttributes() {
        self.contentView.addSubview(backView)
        backgroundColor = .clear
        backView.backgroundColor = .clear //.white
        selectionStyle = .none
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
    }

    func setBackConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }
}

class SettingCellText: SettingSampleCell, UITextFieldDelegate {
    var textField = SettingsTextField()
    var label = SettingsLabel()
    weak var delegate: SettingCellTextDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(onCell: self)
    }

    func setAttributes() {
        self.contentView.addSubview(backView)
        self.contentView.addSubview(textField)
        self.contentView.addSubview(label)
        textField.delegate = self
        textField.keyboardType = .numberPad
        backgroundColor = .clear
        //backView.backgroundColor = settingCellBackColor
    }

    func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}


protocol SettingCellTextDelegate: AnyObject {
    func didEndEditing(onCell cell: SettingCellText)
}


class SettingCellLabel: SettingSampleCell {
    var label = SettingsLabel()
    var valueLabel = SettingsLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func setAttributes() {
        self.contentView.addSubview(backView)
        self.contentView.addSubview(valueLabel)
        self.contentView.addSubview(label)
        valueLabel.textAlignment = .right
        backgroundColor = .clear
        //backView.backgroundColor = .red
    }

    func setConstraints() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}



class MyPickerView : UIPickerView {
    var row : Int? = nil
    var section : Int? = nil
}

class SettingCellTextFieldPicker: SettingSampleCell, UITextFieldDelegate {
    
    var label = SettingsLabel()
    var textField = SettingsTextField()
    weak var delegate: SettingCellTextFieldPickerDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(onCell: self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(onCell: self)
    }
    
    func setAttributes() {
        self.contentView.addSubview(textField)
        self.contentView.addSubview(label)
        textField.delegate = self
        backgroundColor = .clear
    }

    func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
}

protocol SettingCellTextFieldPickerDelegate: AnyObject {
    func didEndEditing(onCell cell: SettingCellTextFieldPicker)
    func didBeginEditing(onCell cell: SettingCellTextFieldPicker)
}


class SettingCellSwitch: SettingSampleCell {
    
    var switchItem = SettingsSwitch()
    var label = SettingsLabel()
    var descLabel = SettingsDescLabel()
    weak var delegate: SettingCellSwitchDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        delegate?.switchValueChanged(onCell: self)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(switchItem)
        self.contentView.addSubview(label)
        self.contentView.addSubview(descLabel)
        descLabel.numberOfLines = 2
        label.textAlignment = .left
        switchItem.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }

    func setConstraints() {
        switchItem.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        //label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        switchItem.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        switchItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        descLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 0).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: switchItem.trailingAnchor, constant: 0).isActive = true
        
        /*
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        switchItem.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switchItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        */
    }
}

protocol SettingCellSwitchDelegate: AnyObject {
    func switchValueChanged(onCell cell: SettingCellSwitch)
}

class SettingCellSwitchLong: SettingSampleCell {
    
    var switchItem = SettingsSwitch()
    var label = SettingsLabel()
    var descLabel = SettingsDescLabel()
    weak var delegate: SettingCellSwitchLongDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        delegate?.switchValueChanged(onCell: self)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(switchItem)
        self.contentView.addSubview(label)
        self.contentView.addSubview(descLabel)
        descLabel.numberOfLines = 4
        label.textAlignment = .left
        switchItem.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }

    func setConstraints() {
        switchItem.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        //label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        switchItem.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        switchItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        descLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 0).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: switchItem.trailingAnchor, constant: 0).isActive = true
        
        /*
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        switchItem.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switchItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        */
    }
}

protocol SettingCellSwitchLongDelegate: AnyObject {
    func switchValueChanged(onCell cell: SettingCellSwitchLong)
}



class SettingCellImage: SettingSampleCell {
    
    var cellImage = UIImageView()
    var label = SettingsLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(cellImage)
        self.contentView.addSubview(label)
        
        
    }

    func setConstraints() {
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        cellImage.widthAnchor.constraint(equalTo: cellImage.heightAnchor, multiplier: 1.0/1.0).isActive = true
        cellImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
    }
}




class SettingCellSlider: SettingSampleCell {
    
    var slider = SettingsSlider()
    var label = SettingsLabel()
    var valueLabel = SettingsLabel()
    weak var delegate: SettingCellSliderDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        delegate?.sliderValueChanged(onCell: self)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(slider)
        self.contentView.addSubview(label)
        self.contentView.addSubview(valueLabel)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        valueLabel.textAlignment = .right
    }

    func setConstraints() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        //label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        //label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        
        slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: 4).isActive = true
        slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        //slider.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        //slider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //slider.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        
        valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor).isActive = true
    }
}

protocol SettingCellSliderDelegate: AnyObject {
    func sliderValueChanged(onCell cell: SettingCellSlider)
}

class SettingCellStepper: SettingSampleCell {
    
    var stepper = SettingsStepper()
    var label = SettingsLabel()
    var valueLabel = SettingsLabel()
    weak var delegate: SettingCellStepperDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func stepperValueChanged(sender: UIStepper) {
        delegate?.stepperValueChanged(onCell: self)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(stepper)
        self.contentView.addSubview(label)
        self.contentView.addSubview(valueLabel)
        valueLabel.textAlignment = .center
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }

    func setConstraints() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        //stepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -8).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

protocol SettingCellStepperDelegate: AnyObject {
    func stepperValueChanged(onCell cell: SettingCellStepper)
}

class SettingCellSegmentControl: SettingSampleCell {
    
    var segmentControl = SettingsSegmentControl(items: [])
    var label = SettingsLabel()
    var descLabel = SettingsDescLabel()
    weak var delegate: SettingCellSegmentControlDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func segmentControlValueChanged(sender: UISegmentedControl) {
        delegate?.segmentControlValueChanged(onCell: self)
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(segmentControl)
        self.contentView.addSubview(label)
        self.contentView.addSubview(descLabel)
        descLabel.numberOfLines = 5
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }

    func setConstraints() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        

        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
        //label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        //label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        //label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        //label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 0).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        segmentControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
        
        
    
        //segmentControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        //segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //segmentControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        //segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //segmentControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        //segmentControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}

protocol SettingCellSegmentControlDelegate: AnyObject {
    func segmentControlValueChanged(onCell cell: SettingCellSegmentControl)
}

class SettingCellButtons: SettingSampleCell {
    
    var first = true
    var selectedButtonIndex = 0
    var buttonsArray = [UIButton]()
    var buttonsNames = [String]()
    var label = SettingsLabel()
    weak var delegate: SettingCellButtonsControlDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setSelectedButton(_ buttonIndex: Int) {
        selectedButtonIndex = buttonIndex
        changeSelectedButton()
    }
    func setButtonsArray(_ abuttonsNames: [String]) {
        buttonsArray = []
        buttonsNames = abuttonsNames
        
        for i in 0..<buttonsNames.count {
            let viewW = self.contentView.frame.width
            let count = CGFloat(buttonsNames.count)
            let buttonAsp = CGFloat(110.0/36.0)
            let padding = CGFloat(10)
            var buttonWidth = CGFloat(0)
            var buttonHeight = CGFloat(0)
            var curX = CGFloat(0)
            var curY = CGFloat(0)
            let topPadding = CGFloat(40)
            
            if buttonsNames.count == 3 {
                buttonWidth = (viewW - padding * (count + 1)) / count
                buttonHeight = buttonWidth/buttonAsp
                curX = buttonWidth*CGFloat(i) + padding
                curY = self.contentView.frame.height/2
            }
            else if buttonsNames.count % 2 == 0 {
                buttonWidth = (viewW - padding * 3) / 2
                buttonHeight = buttonWidth/buttonAsp
                curX = buttonWidth*CGFloat(i%2) + padding * CGFloat(i%2 + 1)
                curY = topPadding + (buttonHeight + padding) * CGFloat(Int(i/2))
            }
            
            let button = UIButton(frame: CGRect(x: curX, y: curY , width: buttonWidth, height: buttonHeight))
            
            button.setBackgroundImage(UIImage(named: buttonsNames[i]), for: .normal)
            button.setTitle("", for: .normal)
            self.contentView.addSubview(button)
            buttonsArray.append(button)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.contentView.addSubview(button)
        }
        
    }

    @objc func buttonPressed(_ sender: UIButton) {
        if let buttonIndex = buttonsArray.firstIndex(of: sender) {
            setSelectedButton(buttonIndex)
            delegate?.pressedButtonInCell(onCell: self)
        }
    }
    
    func changeSelectedButton() {
        for i in 0..<buttonsArray.count {
            let curImage = selectedButtonIndex == i ? UIImage(named: buttonsNames[i]) : UIImage(named:
                "\(buttonsNames[i])Off")
            buttonsArray[i].setBackgroundImage(curImage, for: .normal)
        }
    }

    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(label)
        
    }

    func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
    }
}

protocol SettingCellButtonsControlDelegate: AnyObject {
    func pressedButtonInCell(onCell cell: SettingCellButtons)
}


class SettingCellCollectionView: SettingSampleCell, UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var label = SettingsLabel()
    weak var delegate: SettingCellCollectionViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func collectionViewValueChanged(sender: UISlider) {
        delegate?.collectionViewSelectCell(onCell: self)
    }

    func setAttributes() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "SettingsCollectionViewCell")
        
        collectionView.backgroundColor = .clear
        
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(label)
        
        collectionView.delegate = self
        
    }

    func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        //label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        //label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewSelectCell(onCell: self)
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forSection section: Int, forRow row: Int) -> Int {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        let sectionStr = String(section)
        let rowStr = String(row)
        let tagStr = "\(sectionStr.count)\(rowStr.count)\(sectionStr)\(rowStr)"
        let curTag = Int(tagStr) ?? 0
        collectionView.tag = curTag
        return curTag
    }

}



protocol SettingCellCollectionViewDelegate: AnyObject {
    func collectionViewSelectCell(onCell cell: SettingCellCollectionView)
}

class SettingsCollectionViewCell : UICollectionViewCell {
    var imageView = UIImageView()
    var textLabel = SettingsLabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func setAttributes() {
        //self.contentView.addSubview(backView)
        textLabel.text = "60"
        self.contentView.addSubview(textLabel)
        
        imageView.isHidden = false
        imageView.image = UIImage(named: "settingsButton")
        self.contentView.addSubview(imageView)

    }

    func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 0).isActive = true
        
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true

        // items order
        for itemView in [imageView, textLabel] {
            contentView.bringSubviewToFront(itemView)
        }
    }
    
    

}



class SettingCellCollectionViewTable: SettingSampleCell, UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var label = SettingsLabel()
    weak var delegate: SettingCellCollectionViewTableDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @objc func collectionViewValueChanged(sender: UISlider) {
        delegate?.collectionViewSelectCell(onCell: self)
    }

    func setAttributes() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(SettingsCollectionViewTableCell.self, forCellWithReuseIdentifier: "SettingsCollectionViewTableCell")
        
        collectionView.backgroundColor = .clear
        
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(label)
        
        collectionView.delegate = self
        
    }

    func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        //label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewSelectCell(onCell: self)
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forSection section: Int, forRow row: Int) -> Int {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        let sectionStr = String(section)
        let rowStr = String(row)
        let tagStr = "\(sectionStr.count)\(rowStr.count)\(sectionStr)\(rowStr)"
        let curTag = Int(tagStr) ?? 0
        collectionView.tag = curTag
        return curTag
    }

}

protocol SettingCellCollectionViewTableDelegate: AnyObject {
    func collectionViewSelectCell(onCell cell: SettingCellCollectionViewTable)
}


class SettingsCollectionViewTableCell : UICollectionViewCell {
  
    //var imageView = UIImageView()
    var textLabel = SettingsLabel()
    var selectedImage = UIImageView()
    var backView = UIView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    func setAttributes() {
        
        textLabel.text = "60"
        self.contentView.addSubview(textLabel)
        
        //imageView.image = UIImage(named: "roundBackYellow")
        //self.contentView.addSubview(imageView)
        backView.backgroundColor = UIColor(hex: "40AF4B").withAlphaComponent(0.6)
        backView.layer.cornerRadius = 18
        backView.clipsToBounds = true
        self.contentView.addSubview(backView)
        
        
        selectedImage.image = UIImage(named: "selectThemeCircleYellow")
        self.contentView.addSubview(selectedImage)

    }

    func setConstraints() {

        //imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedImage.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false

        textLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 25).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true
        
        //imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        //imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        //imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 265/60).isActive = true
        //imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        //imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        selectedImage.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 10).isActive = true
        selectedImage.widthAnchor.constraint(equalTo: selectedImage.heightAnchor, multiplier: 1/1).isActive = true
        selectedImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        selectedImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true

        // items order
        for itemView in [backView, textLabel] {
            contentView.bringSubviewToFront(itemView)
        }
    }

}


class SettingCellHeader: UITableViewCell {
    
    var label = SettingsHeaderLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setConstraints()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setAttributes() {
        backgroundColor = .clear
        self.contentView.addSubview(label)
        label.numberOfLines = 0
        
        
    }

    func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        //label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        //label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        //label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        //label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

}



class SettingsTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
    
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

    override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

    func setAttributes() {
        backgroundColor = settingsTextFieldBackgroundColor
        textColor = settingsTextFieldColor
        textAlignment = .right
        layer.borderColor = backgroundColor?.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 8
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        if iphoneConstraints {
            var fontSize: CGFloat = 18
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE: fontSize = 16
            default: break
            }
            self.font = UIFont(name: appFont, size: fontSize)
            //self.font = UIFont(name: appFont, size: 18)
        } else {
            self.font = UIFont(name: appFont, size: 20)
        }
        clipsToBounds = true
        
    }
}

class SettingsLabel : UILabel {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        //self.text = "endlabel"
        self.textColor = settingsLabelTextColor
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        if iphoneConstraints {
            var fontSize: CGFloat = 16
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE: fontSize = 13
            default: break
            }
            self.font = UIFont(name: appFontBold, size: fontSize)
            //self.font = UIFont(name: appFont, size: 16)
        } else {
            self.font = UIFont(name: appFontBold, size: 18)
        }

    }

    func setConstraints() {
    }

}

class SettingsStepper: UIStepper {
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setAttributes() {
        //tintColor backColor cornRad decImg incImg backImg divImg
        //tintColor = UIColor.red
        //backgroundColor = UIColor.blue
        layer.cornerRadius = 7
        //setBackgroundImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
        //setDecrementImage(UIImage(named: "prevButton"), for: .normal)
        //setIncrementImage(UIImage(named: "nextButton"), for: .normal)
        //setDividerImage(<#T##image: UIImage?##UIImage?#>, forLeftSegmentState: .normal, rightSegmentState: .normal)
    }
}

class SettingsSlider: UISlider {
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
       
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
       
    func setAttributes() {
        tintColor = settingsColor //стандарнтый цвет слайдера меняем
        //minimumTrackTintColor = UIColor.red //линия до круга
        //maximumTrackTintColor = UIColor.green //линия после круга
        //thumbTintColor = UIColor.blue //сам круг-ползунок
        
        //minimumValueImage = allImages["prevButton"]
        //maximumValueImage = allImages["prevButton"]
        //setMinimumTrackImage(allImages["prevButton"], for: .normal)
        //setMaximumTrackImage(allImages["prevButton"], for: .normal)
        //setThumbImage(allImages["prevButton"], for: .normal)
    }
}


class SettingsSegmentControl: UISegmentedControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required override init(items: [Any]?) {
        super.init(items: items)
        setAttributes()
    }

    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
       
    func setAttributes() {
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = UIColor(hex: "40AF4B")
        }
        
        //UIColor(hex: "40AF4B") //settingsColor //appMainColor
        backgroundColor = UIColor(hex: "40AF4B").withAlphaComponent(0.7)
        tintColor = UIColor(hex: "40AF4B")
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: appFontBold, size: 14) ?? UIFont.systemFont(ofSize: 14)], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: appFontBold, size: 14) ?? UIFont.systemFont(ofSize: 14)], for: .selected)
        
        
        //backgroundColor = .yellow
        //tintColor = .blue
        //setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: 12)], for: .normal)
        
        //setBackgroundImage(allImages["prevButton"], for: .normal, barMetrics: .default)
        
        //Image between two unselected segments.
        //setDividerImage(allImages["prevButton"], forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
         
        // Image between segment selected on the left and unselected on the right.
        //setDividerImage(allImages["prevButton"], forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
         
        // Image between segment selected on the right and unselected on the left.
        //setDividerImage(allImages["prevButton"], forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
    }
}




class SettingsSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
           setAttributes()
    }
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
       
    func setAttributes() {
        //Достаточно только onTintColor - для вкл
        onTintColor = settingsColor
        //А это если для выключенного тоже надо
        //tintColor = UIColor.red
        //layer.cornerRadius = self.frame.height / 2
        //backgroundColor = UIColor.red
    }
}

class SettingsNameLabel : UILabel {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        self.textColor = settingsNameLabelColor
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        var fontSize: CGFloat = 19
        switch UIDevice().type {
        case .iPhone5S,.iPhoneSE: fontSize = 17
        default: break
        }

        if iphoneConstraints {
            self.font = UIFont(name: appFont, size: fontSize)
        } else {
            self.font = UIFont(name: appFont, size: 22)
        }

    }

    func setConstraints() {
    }

}

class SettingsHeaderLabel : UILabel {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        self.textColor = settingsHeaderLabelColor
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        if iphoneConstraints {
            var fontSize: CGFloat = 17
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE: fontSize = 15
            default: break
            }
            self.font = UIFont(name: appFontBold, size: fontSize)
        } else {
            self.font = UIFont(name: appFontBold, size: 20)
        }

    }
}

class SettingsDescLabel : UILabel {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        //self.text = "endlabel"
        self.textColor = settingsLabelTextColor
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        if iphoneConstraints {
            var fontSize: CGFloat = 13
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE: fontSize = 10
            default: break
            }
            self.font = UIFont(name: appFont, size: fontSize)
            //self.font = UIFont(name: appFont, size: 16)
        } else {
            self.font = UIFont(name: appFont, size: 16)
        }

    }

    func setConstraints() {
    }

}


