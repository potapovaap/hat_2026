//
//  Untitled.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 24.06.2025.
//

import Foundation
import UIKit
import CoreData

extension playersVC {
    
    
    //add
    @objc func addPlayersButtonPressed() {
        isEditPlayerMode = false
        
        if players.count >= maximumPlayersCount { // слишком много элементов
            let alertTitle = lang_scheme[cur_lang]?["alertMaxPlayersCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMaxPlayersCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "maximumCount", with: "\(maximumPlayersCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // если добавляем элемент по одному полю
            if addOrEditPlayerByOneField {
                // добавляем рандомного
                if addRandomPlayerModeAdded {  addRandomPlayer() }
                // добавляем своего
                else { showAddOrEditPlayerAlert(isEditById: false, id: 0) }
            }
            // если добавляем элемент по многим полям
            else { showAddOrEditPlayerVC(isEditById: false, id: 0) }
        }
        
    }
    
    //add new random
    func addRandomPlayer() {
        guard let mc = moc else { return }
        guard let newPlayerName = getRandomItem(exsisitingItems: players.map({$0.name ?? ""}), fromRandomArray: defaultPlayersNames) else { return }
        
        let newPlayer = Player(context: mc)
        let playerIds = players.map({$0.id})
        let lastPlayerId = playerIds.max() ?? 0
        newPlayer.id = lastPlayerId + 1
        newPlayer.name = newPlayerName
        newPlayer.extraTimeIsUsed = false
        newPlayer.wordsRoundScore = 0
        newPlayer.gesturesRoundScore = 0
        newPlayer.onewordRoundScore = 0
        newPlayer.drawingRoundScore = 0
        newPlayer.totalScore = 0
        
        saveContext(moc: moc)
        
        getPlayers()
        updatePlayers()
    }
    
    //edit by id
    func editPlayer(id: Int) {
        isEditPlayerMode = true
        if addOrEditPlayerByOneField { showAddOrEditPlayerAlert(isEditById: true, id: id) }
        else { showAddOrEditPlayerVC(isEditById: true, id: id) }
    }
    
    //add or edit by many fields
    func showAddOrEditPlayerVC(isEditById: Bool, id: Int) {
        guard let currentAddOrEditPlayerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addOrEditPlayerVC") as? addOrEditPlayerVC else { return }
        //playerInfoViewController.modalPresentationStyle = .fullScreen
        currentAddOrEditPlayerVC.isEditPlayerMode = isEditPlayerMode
        currentAddOrEditPlayerVC.delegate = self
        if isEditPlayerMode {
            if isEditById {
                guard let playerIndex = players.firstIndex(where: {$0.id == id}) else { return }
                currentAddOrEditPlayerVC.player = players[playerIndex]
            } else {
                guard selectedPlayersIds.count == 1 else { return }
                guard let selectedPlayerIndex = players.firstIndex(where: {$0.id == selectedPlayersIds[0]}) else { return }
                currentAddOrEditPlayerVC.player = players[selectedPlayerIndex]
            }
        } else {
            currentAddOrEditPlayerVC.player = nil
        }
        self.navigationController?.pushViewController(currentAddOrEditPlayerVC, animated: false)
        //self.present(currentAddOrEditPlayerVC, animated: true, completion: nil) // показать поп-ап поверх текущего
        //self.navigationController?.present(currentAddOrEditPlayerVC, animated: true, completion: nil)
    }
    
    func closeAddOrEditPlayerVC() {
        getPlayers()
        updatePlayers()
    }
    
    //add or edit by one field
    func showAddOrEditPlayerAlert(isEditById: Bool, id: Int) {
        var currentPlayerId = 0
        var oldPlayerName = ""
        var placeholderText = ""
        
        var alertTitle = lang_scheme[cur_lang]?["alertAddPlayerTitle"] as? String ?? ""
        var alertMessage = lang_scheme[cur_lang]?["alertAddPlayerMessage"] as? String ?? ""
        
        if isEditPlayerMode {
            //edit by index
            if isEditById { currentPlayerId = id }
            //edit selected
            else {
                if selectedPlayersIds.count == 1 {
                    currentPlayerId = selectedPlayersIds[0]
                }
            }
            oldPlayerName = players.first(where: { $0.id == currentPlayerId })?.name ?? ""
            placeholderText = oldPlayerName
            
            alertTitle = lang_scheme[cur_lang]?["alertEditPlayerTitle"] as? String ?? ""
            alertMessage = (lang_scheme[cur_lang]?["alertEditPlayerMessage"] as? String ?? "") + oldPlayerName
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholderText
            textField.keyboardType = .default // Можно настроить тип клавиатуры
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            if let textField = alert.textFields?.first {
                textField.placeholder = placeholderText
                self.addOrEditPlayer(newPlayerName: textField.text ?? "", oldPlayerName: oldPlayerName, id: currentPlayerId)
            }
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addOrEditPlayer(newPlayerName: String, oldPlayerName: String, id: Int) {
        let addedElementTitle = lang_scheme[cur_lang]?["name"] as? String ?? ""
        
        let newPlayerName = newPlayerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let textCount = newPlayerName.count

        let playeraNames = players.map({$0.name?.lowercased() ?? ""})
        // такое название уже есть
        if newPlayerName.lowercased() != oldPlayerName.lowercased() && playeraNames.contains(newPlayerName.lowercased()) {
            var alertTitle = lang_scheme[cur_lang]?["alertIncorrectNameTitle"] as? String ?? ""
            alertTitle = alertTitle.replacingOccurrences(of: "currentTitle", with: addedElementTitle.lowercased())
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectNameMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle.lowercased()))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // некорректное число символов
        else if textCount < playerNameMinimumSymbolsCount || textCount > playerNameMaximumSymbolsCount {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle))
            alertMessage = alertMessage.replacingOccurrences(of: "minimumSymbolsCount", with: String(playerNameMinimumSymbolsCount))
            alertMessage = alertMessage.replacingOccurrences(of: "maximumSymbolsCount", with: String(playerNameMaximumSymbolsCount))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // нельзя использовать эти символы
        else if newPlayerName.containsCharacters(charactersString: incorrectSymblosString) {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "incorrectSymblosString", with: incorrectSymblosString)
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            if isEditPlayerMode {
                // изменяем выбранный
                guard let playerIndex = players.firstIndex(where: { $0.id == id }) else { return }
                players[playerIndex].name = newPlayerName
                saveContext(moc: moc)
                            
                getPlayers()
                updatePlayers()
            }
            else {
                // добавляем новый
                guard let mc = moc else { return }
                let newPlayer = Player(context: mc)
                let playerIds = players.map({$0.id})
                let lastPlayerId = playerIds.max() ?? 0
                newPlayer.id = lastPlayerId + 1
                newPlayer.name = newPlayerName
                newPlayer.extraTimeIsUsed = false
                newPlayer.wordsRoundScore = 0
                newPlayer.gesturesRoundScore = 0
                newPlayer.onewordRoundScore = 0
                newPlayer.drawingRoundScore = 0
                newPlayer.totalScore = 0
                
                
                saveContext(moc: moc)
                
                getPlayers()
                updatePlayers()
            }
        }
    }

    // delete by id
    func deletePlayerAlert(id: Int) {
        if (players.count - 1) < minimumPlayersCount { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinPlayersCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinPlayersCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumPlayersCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeletePlayerTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeletePlayerMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deletePlayer(id: id)
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deletePlayer(id: Int) {
        if let deletedElementIndex = players.firstIndex(where: {$0.id == id}) {
            let deletedElement = players[deletedElementIndex]
            players.remove(at: deletedElementIndex)
            moc?.delete(deletedElement)
            saveContext(moc: moc)
            
            if let selectedPlayerIdIndex = selectedPlayersIds.firstIndex(of: id) {
                selectedPlayersIds.remove(at: selectedPlayerIdIndex)
            }
            
            updatePlayers()
            
            updatePlayersNumbersAndGameResultStatus(deletedIndex: deletedElementIndex)
        }
    }
    
    

    func updatePlayersNumbersAndGameResultStatus(deletedIndex: Int) {
        
        // gameResultStatus
        
        var currentTimeIsOver = false
        // когда командная игра и удалили текущую команду или когда одиночная игра и удалили текущего игрока
        if deletedIndex == playerNumber {
            currentTimeIsOver = true
        }
        // когда одиночная игра и удалили игрока который находится сразу ПОСЛЕ текущего (то есть это nextPlayer)
        if gameType == 1 && deletedIndex == playerNumber + 1 {
            //userDefaults.set("timeIsOver", forKey: "gameResultStatus")
            currentTimeIsOver = true
        }
        // когда одиночная игра и удалили игрока который находится ПЕРВЫМ, а текущий игрок является последним
        if gameType == 1 && deletedIndex == 0 && playerNumber == players.count { //was: playerNumber == players.count - 1
            currentTimeIsOver = true
        }
        
        
        if currentTimeIsOver {
            userDefaults.set("timeIsOver", forKey: "gameResultStatus")
            //переустанавливаем время раунда для нового игрока
            let selectOwnRoundTime = Bool(settings["selectOwnRoundTime"] ?? "\(defaultSelectOwnRoundTime)") ?? defaultSelectOwnRoundTime
            let roundTime = Int(settings["roundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
            let ownRoundTime = Int(settings["ownRoundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
            let curTime = selectOwnRoundTime ? ownRoundTime : roundTime
            userDefaults.set(curTime,forKey: "curTime")
        }
        
        
        // playerNumber
        print(" UPDATE playerNumber:")
        print(" deletedIndex: \(deletedIndex)")
        print(" playerNumber: \(playerNumber)")
        // когда командная игра и удалили команду ДО текущей или когда одиночная игра и удалили игрока ДО текущего
        if deletedIndex < playerNumber {
            print("deletedIndex < playerNumber")
            playerNumber = playerNumber - 1
            userDefaults.set(playerNumber, forKey: "playerNumber")
            //userDefaults.set(playerNumber - 1, forKey: "playerNumber")
        }
        // когда одиночная игра и удалили текущего игрока и он был последний
        if gameType == 1 && deletedIndex == playerNumber && playerNumber == players.count { //was: playerNumber == players.count - 1
            print("gameType == 0 deletedIndex == playerNumber")
            playerNumber = playerNumber - 1
            userDefaults.set(playerNumber, forKey: "playerNumber")
            //userDefaults.set(playerNumber - 1, forKey: "playerNumber")
        }
        // когда командная игра и удалили текущую команду и она была последняя
        if gameType == 0 && deletedIndex == playerNumber && playerNumber == players.count {
            print(" gameType == 0  deletedIndex == playerNumber")
            playerNumber = 0
            userDefaults.set(playerNumber, forKey: "playerNumber")
            //userDefaults.set(0, forKey: "playerNumber")
        }

    }
    
    //delete all
    @objc func deleteAllPlayersButtonPressed() {
        if isDeletePlayersWithMinimumPlayersCount {
            deleteAllPlayersAlertWithMinimumPlayersCount()
        }
        else {
            deleteAllPlayersAlert()
        }
        
    }
    
    func deleteAllPlayersAlertWithMinimumPlayersCount() {
        // точно удаляем?
        let alertTitle = lang_scheme[cur_lang]?["alertDeleteAllPlayersTitle"] as? String ?? ""
        let alertMessage = lang_scheme[cur_lang]?["alertDeleteAllPlayersMessage"] as? String ?? ""
        let alertAdditionalMessage = lang_scheme[cur_lang]?["alertDeleteAllPlayersAdditionalMessage"] as? String ?? ""
        let alertAdditionalMessageReplaced = alertAdditionalMessage.replacingOccurrences(of: "PLAYERS_COUNT", with: String(minimumPlayersCount))
        let alert = UIAlertController(title: alertTitle, message: alertMessage + alertAdditionalMessageReplaced, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            self.deleteAllPlayersWithMinimumPlayersCount()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteAllPlayersWithMinimumPlayersCount() {
        for i in 0..<(players.count - minimumPlayersCount) {
            let deletedPlayer = players[players.count-1]
            players.remove(at: players.count-1)
            moc?.delete(deletedPlayer)
           
        }
        saveContext(moc: moc)
        selectedPlayersIds.removeAll()
        updatePlayers()
    }
    
    func deleteAllPlayersAlert() {
        if minimumPlayersCount > 0 { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinPlayersCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinPlayersCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumPlayersCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteAllPlayersTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteAllPlayersMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteAllPlayers()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteAllPlayers() {
        for player in players { moc?.delete(player) }
        saveContext(moc: moc)
        players.removeAll()
        selectedPlayersIds.removeAll()
        updatePlayers()
    }
    
    func updatePlayers() {
        userDefaults.set(selectedPlayersIds, forKey: "selectedPlayersIds")
        playersTableView.reloadData()
    }
    
    
}
