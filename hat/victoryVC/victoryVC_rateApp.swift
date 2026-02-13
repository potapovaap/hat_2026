//
//  Untitled.swift
//  hat
//
//  Created by Alisa Potapova on 10.02.2026.
//

import UIKit
extension victoryVC {
    
    func checkIfNeedToRateApp() {
    
        if (appIsRated == false && gamesCount == gamesToRate) {
            showAlertLikeApp()
        }
        else {
            if (gamesCount >= 0 && gamesCount <= gamesToRate)
            {
                gamesCount=gamesCount+1
                userDefaults.set(gamesCount, forKey: "gamesCount")
            }
            goMenuVC()
        }
    }
    
    
    func showAlertLikeApp(){
        let alert = UIAlertController(title: lang_scheme[cur_lang]?["alertLikeAppTitle"] as? String, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertNo"] as? String, style: .default) { (_) in
            //Поделитесь что не так?
            self.showAlertTellWrong()
            self.goMenuVC()
            
        })
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertYes"] as? String, style: .default) { (_) in
            //герой!
            self.showAlertRatePlease()
        })
        self.present(alert, animated: false, completion: nil)
    }
    
    func showAlertTellWrong() {
        let alert = UIAlertController(title: "Мы исправимся!", message: "Поделитесь, что не так?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertNo"] as? String, style: .default) { (_) in
            //напомнить позже через 10 игр
            self.remindLater(gamesCnt: 7)
            self.goMenuVC()
        })
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertYes"] as? String, style: .default) { (_) in
            //емайл
            self.showEmail()
        })
        self.present(alert, animated: false, completion: nil)
    }
    
    
    func showAlertRatePlease() {
        let alert = UIAlertController(title: lang_scheme[cur_lang]?["alertRatePleaseTitle"] as? String, message: lang_scheme[cur_lang]?["alertRatePleaseMessage"] as? String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertRatePleaseLater"] as? String, style: .default) { (_) in
            //напомнить позже через 5 игр
            self.remindLater(gamesCnt: 5)
            self.goMenuVC()
        })
        alert.addAction(UIAlertAction(title: lang_scheme[cur_lang]?["alertYes"] as? String, style: .default) { (_) in
            //оставить отзыв
            self.rateAppEndGame()
            self.goMenuVC()
        })
        self.present(alert, animated: false, completion: nil)
        
    }
    
    /*
    func remindLater(gamesCnt: Int) {
        
        gamesToRate = gamesCnt
        userDefaults.set(gamesToRate, forKey: "gamesToRate")
        
        gamesCount = 0
        userDefaults.set(gamesCount, forKey: "gamesCount")
        
    }
    */
    
    func rateAppEndGame() {
        
        let url_str = "itms-apps:itunes.apple.com/us/app/apple-store/id\(app_id)?mt=8&action=write-review"
        
        if let url = URL(string: url_str),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    //print("App Store Opened")
                    
                }
            }
        } else {
            //print("Can't Open URL on Simulator")
        }
        
        appIsRated = true
        gamesToRate = 1
        gamesCount = 0
        userDefaults.set(appIsRated, forKey: "appIsRated")
        userDefaults.set(gamesToRate, forKey: "gamesToRate")
        userDefaults.set(gamesCount, forKey: "gamesCount")
        
    }

}
