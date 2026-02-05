//
//  RateAppViewController.swift
//  tabAppProject
//
//  Created by Alisa Potapova on 25.03.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//


import UIKit
import MessageUI
import StoreKit

//ДЛЯ ОТЗЫВОВ - нажатие на кнопку экзамен, обучение, марафон
var gamesCount: Int = 0
var gamesToRate: Int = 1                            //исправить на 1
var remindLaterCountAfterNotNowButtonPressed = 3    //исправить на 3
var remindLaterCountAfterStoreKitReview = 5         //исправить на 5
var remindLaterCountAfterStars45Pressed = 8         //исправить на 8
var remindLaterCountAfterStars123Pressed = 15        //исправить на 15
var appIsRated: Bool = false
var appRateVersion: String = ""
var rateWithReviewNow = false
var rateAppCounter = 0



class rateAppVC: UIViewController {
    
    var iphoneConstraints = false
    
    var starButton_1 = UIButton()
    var starButton_2 = UIButton()
    var starButton_3 = UIButton()
    var starButton_4 = UIButton()
    var starButton_5 = UIButton()
    var notNowButton = UIButton()
    var reviewBackImage = UIImageView()
    var reviewBackButtonImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewBlock()
        setAttributes()
        setConstraints()
    }
    
    func reviewBlock() {
        //################## ASK FOR REVIEW BLOCK ############
        //количество сыгранных  игр для показывания окна "оставить отзыв"
        gamesCount = (UserDefaults.standard.object(forKey: "gamesCount") as? Int) ?? 0
        gamesToRate = (UserDefaults.standard.object(forKey: "gamesToRate") as? Int) ?? gamesToRate
        appIsRated = (UserDefaults.standard.object(forKey: "appIsRated") as? Bool) ?? false
        rateAppCounter = (UserDefaults.standard.object(forKey: "rateAppCounter") as? Int) ?? 0
        //######################################################
    }

    func setAttributes() {
        
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        reviewBackImage.contentMode = .scaleAspectFit
        reviewBackImage.image = UIImage(named: "reviewBackImage")
        self.view.addSubview(reviewBackImage)
        
        reviewBackButtonImage.contentMode = .scaleAspectFit
        reviewBackButtonImage.image = UIImage(named: "reviewBackButtonImage")
        self.view.addSubview(reviewBackButtonImage)
        
        starButton_1.addTarget(self, action: #selector(starButton_1Pressed), for: .touchUpInside)
        starButton_1.contentMode = .scaleAspectFit
        starButton_1.setBackgroundImage(UIImage(named: "starButton"), for: .normal)
        starButton_1.setTitle("", for: .normal)
        self.view.addSubview(starButton_1)
        
        starButton_2.addTarget(self, action: #selector(starButton_2Pressed), for: .touchUpInside)
        starButton_2.contentMode = .scaleAspectFit
        starButton_2.setBackgroundImage(UIImage(named: "starButton"), for: .normal)
        starButton_2.setTitle("", for: .normal)
        self.view.addSubview(starButton_2)
        
        starButton_3.addTarget(self, action: #selector(starButton_3Pressed), for: .touchUpInside)
        starButton_3.contentMode = .scaleAspectFit
        starButton_3.setBackgroundImage(UIImage(named: "starButton"), for: .normal)
        starButton_3.setTitle("", for: .normal)
        self.view.addSubview(starButton_3)
        
        starButton_4.addTarget(self, action: #selector(starButton_4Pressed), for: .touchUpInside)
        starButton_4.contentMode = .scaleAspectFit
        starButton_4.setBackgroundImage(UIImage(named: "starButton"), for: .normal)
        starButton_4.setTitle("", for: .normal)
        self.view.addSubview(starButton_4)
        
        
        starButton_5.addTarget(self, action: #selector(starButton_5Pressed), for: .touchUpInside)
        starButton_5.contentMode = .scaleAspectFit
        starButton_5.setBackgroundImage(UIImage(named: "starButton"), for: .normal)
        starButton_5.setTitle("", for: .normal)
        self.view.addSubview(starButton_5)
        
        
        notNowButton.addTarget(self, action: #selector(notNowButtonPressed), for: .touchUpInside)
        notNowButton.contentMode = .scaleAspectFit
        notNowButton.setBackgroundImage(UIImage(named: "notNowButton"), for: .normal)
        notNowButton.setTitle("", for: .normal)
        self.view.addSubview(notNowButton)
        
        
        
        
    }
    
    @objc func starButton_1Pressed(_ sender: Any) {
        checkForReview(starCount: 1)
     }
    
    @objc func starButton_2Pressed(_ sender: Any) {
        checkForReview(starCount: 2)
     }
    
    @objc func starButton_3Pressed(_ sender: Any) {
        checkForReview(starCount: 3)
     }
    
    @objc func starButton_4Pressed(_ sender: Any) {
        checkForReview(starCount: 4)
     }
    
    @objc func starButton_5Pressed(_ sender: Any) {
        checkForReview(starCount: 5)
     }
    
    @objc func notNowButtonPressed(_ sender: Any) {
        self.remindLater(gamesCnt: remindLaterCountAfterNotNowButtonPressed)
        
        self.dismiss(animated: false, completion: nil)
     }
    
    func checkForReview(starCount: Int) {
        if starCount >= 4 {
            
            remindLater(gamesCnt: remindLaterCountAfterStars45Pressed)
            rateAppCounter += 1
            UserDefaults.standard.set(rateAppCounter, forKey: "rateAppCounter")
            
            self.rateAppWithReview()
            self.dismiss(animated: false, completion: nil)
            
        }
        else {
            // 1-2-3 stars skip
            remindLater(gamesCnt: remindLaterCountAfterStars123Pressed)
            self.dismiss(animated: false, completion: nil)
        }
    }

    

    
    
    
    
    func setConstraints() {
        //let safeArea = view.layoutMarginsGuide
        
        
        reviewBackImage.translatesAutoresizingMaskIntoConstraints = false
        reviewBackButtonImage.translatesAutoresizingMaskIntoConstraints = false
        notNowButton.translatesAutoresizingMaskIntoConstraints = false
        starButton_1.translatesAutoresizingMaskIntoConstraints = false
        starButton_2.translatesAutoresizingMaskIntoConstraints = false
        starButton_3.translatesAutoresizingMaskIntoConstraints = false
        starButton_4.translatesAutoresizingMaskIntoConstraints = false
        starButton_5.translatesAutoresizingMaskIntoConstraints = false
        
        reviewBackImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        reviewBackImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0).isActive = true
        
        reviewBackButtonImage.centerXAnchor.constraint(equalTo: reviewBackImage.centerXAnchor, constant: 0.0).isActive = true
        
        starButton_3.centerXAnchor.constraint(equalTo: reviewBackImage.centerXAnchor, constant: 0.0).isActive = true
        notNowButton.centerXAnchor.constraint(equalTo: reviewBackImage.centerXAnchor, constant: 0.0).isActive = true
        
        starButton_2.trailingAnchor.constraint(equalTo: starButton_3.leadingAnchor, constant: 0).isActive = true
        starButton_1.trailingAnchor.constraint(equalTo: starButton_2.leadingAnchor, constant: 0).isActive = true
        
        starButton_4.leadingAnchor.constraint(equalTo: starButton_3.trailingAnchor, constant: 0).isActive = true
        starButton_5.leadingAnchor.constraint(equalTo: starButton_4.trailingAnchor, constant: 0).isActive = true
        
        
        notNowButton.bottomAnchor.constraint(equalTo: reviewBackImage.bottomAnchor, constant: 0).isActive = true
        reviewBackButtonImage.bottomAnchor.constraint(equalTo: notNowButton.topAnchor, constant: 0).isActive = true
        starButton_1.centerYAnchor.constraint(equalTo: reviewBackButtonImage.centerYAnchor, constant: 0).isActive = true
        starButton_2.centerYAnchor.constraint(equalTo: reviewBackButtonImage.centerYAnchor, constant: 0).isActive = true
        starButton_3.centerYAnchor.constraint(equalTo: reviewBackButtonImage.centerYAnchor, constant: 0).isActive = true
        starButton_4.centerYAnchor.constraint(equalTo: reviewBackButtonImage.centerYAnchor, constant: 0).isActive = true
        starButton_5.centerYAnchor.constraint(equalTo: reviewBackButtonImage.centerYAnchor, constant: 0).isActive = true
        
        starButton_1.widthAnchor.constraint(equalTo: starButton_1.heightAnchor, multiplier: 125/133).isActive = true
        starButton_2.widthAnchor.constraint(equalTo: starButton_2.heightAnchor, multiplier: 125/133).isActive = true
        starButton_3.widthAnchor.constraint(equalTo: starButton_3.heightAnchor, multiplier: 125/133).isActive = true
        starButton_4.widthAnchor.constraint(equalTo: starButton_4.heightAnchor, multiplier: 125/133).isActive = true
        starButton_5.widthAnchor.constraint(equalTo: starButton_5.heightAnchor, multiplier: 125/133).isActive = true
        notNowButton.widthAnchor.constraint(equalTo: notNowButton.heightAnchor, multiplier: 625/130).isActive = true
        reviewBackButtonImage.widthAnchor.constraint(equalTo: reviewBackButtonImage.heightAnchor, multiplier: 810/134).isActive = true
        reviewBackImage.widthAnchor.constraint(equalTo: reviewBackImage.heightAnchor, multiplier: 810/850).isActive = true
        
        
        
        if iphoneConstraints {
            starButton_1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 125/1170).isActive = true
            starButton_2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 125/1170).isActive = true
            starButton_3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 125/1170).isActive = true
            starButton_4.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 125/1170).isActive = true
            starButton_5.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 125/1170).isActive = true
            notNowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 625/1170).isActive = true
            reviewBackImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 810/1170).isActive = true
            reviewBackButtonImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 810/1170).isActive = true
            
        } else {
            starButton_1.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 125/810).isActive = true
            starButton_2.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 125/810).isActive = true
            starButton_3.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 125/810).isActive = true
            starButton_4.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 125/810).isActive = true
            starButton_5.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 125/810).isActive = true
            
            notNowButton.widthAnchor.constraint(equalTo: reviewBackButtonImage.widthAnchor, multiplier: 625/810).isActive = true
            reviewBackImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
            reviewBackButtonImage.widthAnchor.constraint(equalTo: reviewBackImage.widthAnchor, multiplier: 1).isActive = true
            
        }
        
        
        for itemView in [reviewBackImage, reviewBackButtonImage, notNowButton, starButton_1, starButton_2, starButton_3, starButton_4, starButton_5] {
            view.bringSubviewToFront(itemView)
        }
        
       
        
    }
    
    
}

extension UIViewController {
    //########################## просьба оставить отзыв ДЛЯ ОТЗЫВОВ #####################
    
    func checkIfShowRateApp()->Bool {
        if (gamesCount == gamesToRate) { //!appIsRated &&
            reviewApp()
            return true
        }
        else {
            if (gamesCount >= 0 && gamesCount <= gamesToRate){
                gamesCount = gamesCount + 1
                UserDefaults.standard.set(gamesCount, forKey: "gamesCount")
            }
            return false
         }
    }
    
    func reviewApp() {
        
        rateAppCounter = (UserDefaults.standard.object(forKey: "rateAppCounter") as? Int) ?? 0
        if rateAppCounter % 2 == 0 {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                
                //после отзыва через remindLaterCountAfterStoreKitReview открытий показываем снова
                remindLater(gamesCnt: remindLaterCountAfterStoreKitReview)
                rateAppCounter += 1
                UserDefaults.standard.set(rateAppCounter, forKey: "rateAppCounter")
            }
        } else {
            if let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rateAppVC") as? rateAppVC {
                popupVC.modalPresentationStyle = .overFullScreen
                //popupVC.reviewDelegate = self
                self.present(popupVC, animated: false, completion:nil)
            }
        }
    
    }
    func remindLater(gamesCnt: Int) {
        
        gamesToRate = gamesCnt
        UserDefaults.standard.set(gamesToRate, forKey: "gamesToRate")
        
        gamesCount = 0
        UserDefaults.standard.set(gamesCount, forKey: "gamesCount")
    }
    
    func rateAppWithReview() {
        rateApp()
    }
    
    //#############################################################
}
