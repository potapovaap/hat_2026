//
//  gateVC.swift
//  handsup
//
//  Created by Alisa Potapova on 28.10.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI

protocol DownloadDelegate: AnyObject {
    func showInAppWindow()
}

class parentalGateVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var titleLabel = UILabel()
    var numbersCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var backButton = UIButton()
    var taskLabel = UILabel()
    var popupback = UIImageView()
    
    weak var downloadDelegate: DownloadDelegate?
    
    var curLang = "ru"
    var soundsIsOn = true
    var iphoneConstraints = false
    var numbers = Array(0...9)
    var result = 0
    var errorSound: AVAudioPlayer?
    var fromView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes()
        setConstraints()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        numbersCollectionView.collectionViewLayout.invalidateLayout()
    }

    
    func generateTask(){
        result = Random.randomInt(min: 0, max: 9)
        let a = Random.randomInt(min: 1, max: 9)
        let b = result - a
        let sign = (b < 0) ? "-" : "+"
        taskLabel.text = "\(a) \(sign) \(abs(b)) = ?"
    }
    
    @objc func parentBackButtonPressed(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    
    func setAttributes() {
        
        
        fromView = (UserDefaults.standard.object(forKey: "fromView") as? String) ?? "fromDownload"
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        curLang = (UserDefaults.standard.object(forKey: "curLang") as? String) ?? "ru"
        soundsIsOn = (UserDefaults.standard.object(forKey: "soundsIsOn") as? Bool) ?? true
        

        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        titleLabel.text = lang_scheme[cur_lang]?["parentControl"] as? String ?? ""
        taskLabel.text = ""
        
        popupback.image = UIImage(named: "popupback")
        self.view.addSubview(popupback)
        
        backButton.setTitle("", for: .normal)
        backButton.addTarget(self, action: #selector(parentBackButtonPressed), for: .touchUpInside)
        backButton.contentMode = .scaleAspectFit
        backButton.setBackgroundImage(UIImage(named: "cancelButton"), for: .normal)
        self.view.addSubview(backButton)
        
    
        if iphoneConstraints {
            titleLabel.font = UIFont(name: appFont, size: 21)
            taskLabel.font = UIFont(name: appFont, size: 28)
        } else {
            titleLabel.font = UIFont(name: appFont, size: 34)
            taskLabel.font = UIFont(name: appFont, size: 50)
        }
        
        titleLabel.textColor = UIColor(hex: "36755F")
        taskLabel.textColor = UIColor(hex: "36755F")
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(taskLabel)
       
        
        numbersCollectionView.delegate = self
        numbersCollectionView.dataSource = self
        numbersCollectionView.backgroundColor = .clear
        numbersCollectionView.register(ParentalGateTableViewCell.self, forCellWithReuseIdentifier: "ParentalGateTableViewCell")
        
       
        if let flowLayout = numbersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        self.view.addSubview(numbersCollectionView)
        
        generateTask()
        numbersCollectionView.reloadData()
        
        errorSound = initializePlayer(fileName: "wrong", fileType: "wav")
        
        
        

    }

    func setConstraints() {
        //let safeArea = view.layoutMarginsGuide
        popupback.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        numbersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        numbersCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        numbersCollectionView.centerYAnchor.constraint(equalTo: popupback.centerYAnchor, constant: 0).isActive = true
        numbersCollectionView.widthAnchor.constraint(equalTo: numbersCollectionView.heightAnchor, multiplier: 3.0/1.0).isActive = true
        
        popupback.widthAnchor.constraint(equalTo: popupback.heightAnchor, multiplier: 360.0/580.0).isActive = true
        popupback.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        if fromView == "fromDownload" {
            popupback.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        } else {
            popupback.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        }
        
        
       
        backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 84.0/74.0).isActive = true
        backButton.topAnchor.constraint(equalTo: popupback.topAnchor, constant: 0).isActive = true
        backButton.trailingAnchor.constraint(equalTo: popupback.trailingAnchor, constant: 0).isActive = true
        backButton.widthAnchor.constraint(equalTo: popupback.widthAnchor, multiplier: 0.2).isActive = true
        
        
        titleLabel.bottomAnchor.constraint(equalTo: taskLabel.topAnchor, constant: -20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: popupback.centerXAnchor, constant: 0).isActive = true
        taskLabel.bottomAnchor.constraint(equalTo: numbersCollectionView.topAnchor, constant: -20).isActive = true
        taskLabel.centerXAnchor.constraint(equalTo: popupback.centerXAnchor, constant: 0).isActive = true
        
        
        
        if iphoneConstraints {
            
            popupback.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 360/375).isActive = true
            numbersCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        } else {

            popupback.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 360/500).isActive = true
            numbersCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        }

        for itemView in [popupback, titleLabel, backButton, taskLabel, numbersCollectionView] {
            view.bringSubviewToFront(itemView)
        }
    }

    
    //#################### collection view delegate ##################################
                 
           func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return numbers.count
            }
                 
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = numbersCollectionView.dequeueReusableCell(withReuseIdentifier: "ParentalGateTableViewCell", for: indexPath)  as! ParentalGateTableViewCell
               let numberIndex = indexPath.item
               cell.numberLabel.text = "\(numbers[numberIndex])"
               //setShadows(forLabel: cell.numberLabel)
               return cell
            }
                 
           //размер ячейки
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let height = collectionView.frame.size.height
                let cellHeight = (height / 2.0) - 5.0
                return CGSize(width: cellHeight, height: cellHeight)
            }
                 
           //  отступ между ячейками
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                     return 10.0
                 }
           //  отступ между ячейками
           func collectionView(_ collectionView: UICollectionView, layout
                     collectionViewLayout: UICollectionViewLayout,
                                     minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                         return 5.0
                 }
       //горизональное центрирование ячеек в collectionView
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                let width = collectionView.frame.size.width
                let height = collectionView.frame.size.height
                let cellHeight = (height / 2.0) - 5.0
                let cellWidth = cellHeight
                let cellCount = CGFloat(5)
                let cellSpacing = CGFloat(10)
                let totalCellWidth = cellWidth * cellCount
                let totalSpacingWidth = cellSpacing * (cellCount - 1)
           
                let leftInset = (width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
                let rightInset = leftInset

                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
           }
       
    //ВЫБОР ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == result {
            switch fromView {
            case "fromDownload":
                downloadDelegate?.showInAppWindow()
                view.removeFromSuperview()
            case "fromAskQuestion":
                showEmail()
                view.removeFromSuperview()
            case "fromRateApp":
                rateApp()
                view.removeFromSuperview()
            default: break
            }
        }
        else {
            errorSound?.play()
        }
        
    }


    

    
}




