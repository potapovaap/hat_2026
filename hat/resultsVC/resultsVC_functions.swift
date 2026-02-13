import UIKit
extension resultsVC {
    func guessButtonPressedInCell(onCell cell: ResultTableViewCell) {
        if let indexPath = resultsTableView.indexPath(for: cell) {
            let result = results[indexPath.row]
            result.isCorrect = !result.isCorrect
            saveContext(moc: moc)
            resultsTableView.reloadData()
            
            // если был НЕ угадан, а стал угадан: ТО прибывляем очко
            if result.isCorrect {
                updateCurScoreAndLabel(score: 1)
                updatePlayerScore(score: 1)
            }
            // если был угадан, а стал НЕ угадан: ТО вычитаем очко
            else {
                if curScore > 0 {
                    updateCurScoreAndLabel(score: -1)
                    updatePlayerScore(score: -1)
                }
            }
            
            
        }
    }
    
    func getAllDidLoadResultsParameters() {
        getResults()
        //selectedResultsIds = (userDefaults.object(forKey: "selectedResultsIds") as? [Int]) ?? defaultSelectedResultsIds
    }

    func getResults() {
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        results = getEntity(type: Result.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
    }
	func guessedActionPressed(index: Int) {
        if results[index].isCorrect { return }
        
        results[index].isCorrect = true
        saveContext(moc: moc)
        resultsTableView.reloadData()
        
        updateCurScoreAndLabel(score: 1)
        updatePlayerScore(score: 1)
	}
    
    func notguessedActionPressed(index: Int) {
        if !results[index].isCorrect { return }
        
        results[index].isCorrect = false
        saveContext(moc: moc)
        resultsTableView.reloadData()
        
        if curScore > 0 {
            updateCurScoreAndLabel(score: -1)
            updatePlayerScore(score: -1)
        }
    }
    
    
    func updateCurScoreAndLabel(score: Int) {
        curScore += score
        userDefaults.set(curScore, forKey: "curScore")
        scoreLabel.text = "\(curScore)"
    }
    
    func updatePlayerScore(score: Int) {
        guard let currentPlayer = players.first(where: {$0.name == gameResultPlayerName}) else { return }
        
        // добавляем очко к нужному раунду
        switch roundsInGameIndex {
            case 0: currentPlayer.wordsRoundScore += Int32(score)
            case 1: currentPlayer.gesturesRoundScore += Int32(score)
            case 2: currentPlayer.onewordRoundScore += Int32(score)
            case 3: currentPlayer.drawingRoundScore += Int32(score)
            default: break
        }
        // и к общему количеству очков
        currentPlayer.totalScore += Int32(score)
        saveContext(moc: moc)
    }
    
    
    // ПОКА НЕ ДЕЛАЕМ - СЛОЖНО - если пропускаем слово - то возвращаем это слово в шляпу:
    /*
     // проверяем нужно ли вернуть слово в шляпу или наоборот добавить в уже сыгранные
    func checkIfNeedReturnWordToHat(guessedStatus: Bool, curWord: String) {
        
        // получаем все слова для текущей игры
        let wordsForTheGame = userDefaults.stringArray(forKey: "wordsForTheGame") ?? [String]()
        // получаем уже использованные слова в текущем раунде
        var usedWordsIndexesForTheGame = (userDefaults.object(forKey: "usedWordsIndexesForTheGame") as? [Int]) ?? []
        
        
        
        
        // если статус изменился с НЕугадано на Угадано -
        if guessedStatus {
            // то возвращаем это слово в ИГРУ:
            if let wordIndex = wordsForTheGame.firstIndex(of: curWord) {
                usedWordsIndexesForTheGame.append(wordIndex)
                userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
                
                if usedWordsIndexesForTheGame.count == wordsForTheGame.count {
                    //шляпа стала пуста
                }
            }
        }
        // если статус изменился с Угадано на НЕугадано
        else {
            // то возвращаем это слово в шляпу:
            if let wordIndex = wordsForTheGame.firstIndex(of: curWord),
               let deletedIndex = usedWordsIndexesForTheGame.firstIndex(of: wordIndex) {
                usedWordsIndexesForTheGame.remove(at: deletedIndex)
                userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
                
                if usedWordsIndexesForTheGame.count < wordsForTheGame.count {
                    //шляпа стала НЕпуста
                }
            }
        }
        
    }
    */

	@objc func nextPlayerButtonPressed() {
        //  если время вышло - переходим к следующему игроку
        if gameResultStatus == "timeIsOver" {
            goNextVC("startNewPlayerVC")
        }
       // если в шляпе закончились слова - начинаем новый раунд
        else if gameResultStatus == "hatIsEmpty" {
            goNextVC("startNewRoundVC")
        }
        // завершаем игру
        else if gameResultStatus == "gameEnd" {
            goNextVC("victoryVC")
        }
        else {
            goMenuVC()
        }
	}

	@objc func goToMenuButtonPressed() {
        if gameResultStatus == "gameEnd" {
           goNextVC("victoryVC")
       }
       else {
           goMenuVC()
       }
	}


}
