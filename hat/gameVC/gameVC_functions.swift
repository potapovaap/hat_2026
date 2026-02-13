import UIKit
import AVFAudio
import CoreData

extension gameVC {
    @objc func extraTimeButtonPressed() {
        
        // показываем сообщение на 2 секунды - активированы 15 доп секунд
        let alert = UIAlertController(title: lang_scheme[cur_lang]?["extraTimeIsActivatedTitle"] as? String, message: "", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true) {
            // Автоматически закрываем через 2 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                alert.dismiss(animated: true)
            }
        }
        
        // добавляем 15 секунд
        curTime += 15
        userDefaults.set(curTime,forKey: "curTime")
        count = curTime
        roundTimeLabel.text = "\(curTime)"
        
        
        if gameType == 0 {
            players[playerNumber].extraTimeIsUsed = true
        } else {
            players[nextPlayerNumber].extraTimeIsUsed = true
        }
        saveContext(moc: moc)
        extraTimeButton.isHidden = true
    }
    
	@objc func wrongButtonPressed() {
        if gameSounds { wrongSound?.play() }
        
        // если пропускаем слово - то возвращаем это слово в шляпу:
        if let wordIndex = wordsForTheGame.firstIndex(of: curWord),
           let deletedIndex = usedWordsIndexesForTheGame.firstIndex(of: wordIndex) {
            usedWordsIndexesForTheGame.remove(at: deletedIndex)
            userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
        }
        
        // если не последнее слово
        if (!isLastWord) {
            //добавляем результат
            addResult(word: curWord, isCorrect: false)
            //если неправильный ответ и есть минус за пропуск уменьшаем очко
            if (minusForMistake && curScore > 0) { minusScore() }
            //  если слова в шляпе еще есть то перехордим к следующему слову, иначе завершаем игру
            //if curGameWordsCount < resultWordsCount { nextWord() }
            if usedWordsIndexesForTheGame.count < wordsForTheGame.count { nextWord() }
            else { finishGame(currentGameResultStatus: "hatIsEmpty") }
        }
        // если последнее слово
        else {
            if commonLastWord {  //если общее последнее слово - не штрафуем
                let commonText = lang_scheme[cur_lang]?["commonText"] as? String ?? ""
                //добавляем результат
                addResult(word: "\(curWord) (\(commonText))" , isCorrect: false)
                updateCurScoreAndLabel(newValue: curScore)
                //завершаем игру
                finishGame(currentGameResultStatus: "timeIsOver")
            }
            else {
                //добавляем результат
                addResult(word: curWord, isCorrect: false)
                
               
                //если неправильный ответ и есть минус за пропуск уменьшаем очко - НЕ ШТРАФУЕМ ЗА ПОСЛЕДНЕЕ СЛОВО
                //if (minusForMistake && curScore > 0) { minusScore() }
                
                //вместо штрафа - обновляем очко
                updateCurScoreAndLabel(newValue: curScore)
                
                //завершаем игру
                finishGame(currentGameResultStatus: "timeIsOver")
            }
        }
	}
    
	@objc func rightButtonPressed() {
        
        if gameSounds { rightSound?.play() }
        
        // проверяем нужно ли давать доп очко если игрок угадал слово меньше чем за 10 секунд
        var addedBall = 1
        if plusForSpeed && (prevRightAnswerTime - curTime <= 10)  {
            addedBall = 2
        }
        prevRightAnswerTime = curTime
        
        
        if (!isLastWord) { // если не последнее слово
            //добавляем результат
            addResult(word: curWord, isCorrect: true)
            plusScore(addedBall: addedBall)
            //  если слова в шляпе еще есть то перехордим к следующему слову, иначе завершаем игру
            if usedWordsIndexesForTheGame.count < wordsForTheGame.count { nextWord() }
            else { finishGame(currentGameResultStatus: "hatIsEmpty") }
        }
        else {
            if commonLastWord {  //если общее последнее слово
                // показываем алерт - кто отгадал последнее слво? со списком команд-кнопками
                let alert = UIAlertController(title: lang_scheme[cur_lang]?["whoGuessAlertTitle"] as? String, message: "", preferredStyle: UIAlertController.Style.alert)
                // добавляем в алерте кнопки с названиями игроков
                for i in 0..<players.count {
                    alert.addAction(UIAlertAction(title: players[i].name, style: UIAlertAction.Style.default, handler: { action in
                        self.playerInAlertPressed(index: i, addedBall: addedBall)
                        
                        //завершаем игру
                        var gameOverStatus = "timeIsOver"
                        if self.usedWordsIndexesForTheGame.count >= self.wordsForTheGame.count { gameOverStatus = "hatIsEmpty" }
                        self.finishGame(currentGameResultStatus: gameOverStatus)
                    }))
                }
                self.present(alert, animated: true, completion: nil)
            }
            else { // плюсуем слово игроку и завершаем игру
                //добавляем результат
                addResult(word: curWord, isCorrect: true)
                plusScore(addedBall: addedBall)
                
                //завершаем игру
                var gameOverStatus = "timeIsOver"
                if self.usedWordsIndexesForTheGame.count >= self.wordsForTheGame.count { gameOverStatus = "hatIsEmpty" }
                self.finishGame(currentGameResultStatus: gameOverStatus)
            }
        }
	}
    
    
    @objc override func backButtonPressed(){
        if isPaused == false { timer.invalidate() }
        userDefaults.set(curTime,forKey: "curTime")
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func pauseButtonPressed(){
        if isPaused { //если были на паузе - то запускаем таймер и включаем кнопки
            timer = Timer.scheduledTimer(timeInterval: Double(1), target: self, selector: #selector(counter), userInfo: nil, repeats: true)
            rightButton.isEnabled = true
            wrongButton.isEnabled = true
            wordLabel.text = curWord
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "pauseButton")?.withRenderingMode(.alwaysOriginal)
            isPaused = false
        } else { //ставим на паузу - выкл таймер и блок кнопки
            timer.invalidate()
            rightButton.isEnabled = false
            wrongButton.isEnabled = false
            wordLabel.text = lang_scheme[cur_lang]?["pauseText"] as? String
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "playButton")?.withRenderingMode(.alwaysOriginal)
            isPaused = true
        }
    }
    
    func nextWord() {
        var index = Random.randomInt(min: 0, max: wordsForTheGame.count-1)
        var whiteStep = 0
        while usedWordsIndexesForTheGame.contains(index) {
            index = Random.randomInt(min: 0, max: wordsForTheGame.count-1)
            whiteStep += 1
            if whiteStep > 10000 {
                usedWordsIndexesForTheGame = []
                userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
            }
        }
        curWord = wordsForTheGame[index]
        
        //добавляем его в предыдующие слова
        usedWordsIndexesForTheGame.append(index)
        userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
        //увеличиваем количество использованных в игре слов
        curGameWordsCount += 1
        userDefaults.set(curGameWordsCount, forKey: "curGameWordsCount")
       
        //curWord = "В чужой монастырь со своим уставом не ходят" // для теста удалить
        wordLabel.text = curWord
        userDefaults.set(curWord, forKey: "curWord")
        

        
    }
    
    func finishGame(currentGameResultStatus: String) {
        //timer.invalidate()
        // сохраняем статус игры - Время вышло или слова закончились
        gameResultStatus = currentGameResultStatus
        userDefaults.set(gameResultStatus, forKey: "gameResultStatus")
        // сохраняем имя игрока, кто набирал очки
        let gameResultPlayerName = (gameType == 0 ? players[playerNumber].name : players[nextPlayerNumber].name) ?? ""
        userDefaults.set(gameResultPlayerName, forKey: "gameResultPlayerName")
        //обновляем номера текущих игроков
        updatePlayersNumbers()
        updateRoundNumber()
        
        
        //если шляпа пустая - то обнуляем использованные в игре слова
        if currentGameResultStatus == "hatIsEmpty" {
            usedWordsIndexesForTheGame.removeAll()
            userDefaults.set(usedWordsIndexesForTheGame,forKey: "usedWordsIndexesForTheGame")
            curGameWordsCount = 0
            userDefaults.set(curGameWordsCount, forKey: "curGameWordsCount")
        }
    
        // если переносим время раунда когда шляпа пуста - то сохраняем текущее время - время, которое осталось у игрока на следующий раунд
        if !roundStartsFirstPlayer && moveTime && currentGameResultStatus == "hatIsEmpty" {
            userDefaults.set(curTime,forKey: "curTime")
        }
        // ИНАЧЕ если время игрока вышло / или нелязя переносить время / или раунд начинает первый игрок -  то переустанавливаем время раунда для нового игрока
        else {
            let selectOwnRoundTime = Bool(settings["selectOwnRoundTime"] ?? "\(defaultSelectOwnRoundTime)") ?? defaultSelectOwnRoundTime
            let roundTime = Int(settings["roundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
            let ownRoundTime = Int(settings["ownRoundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
            curTime = selectOwnRoundTime ? ownRoundTime : roundTime
            userDefaults.set(curTime,forKey: "curTime")
        }
        
        // переходим к окну результат
        goNextVC("resultsVC")
        
        //обнуляем слово
        userDefaults.set("--", forKey: "curWord")
        
   }
   

    func updatePlayersNumbers() {
        // вычисляем номер следующего игрока
        let newNextPlayer = (playerNumber == players.count - 1) ? 0 : playerNumber + 1
        
        //  если время вышло - переходим к следующему игроку
        if gameResultStatus == "timeIsOver" {
            userDefaults.set(newNextPlayer, forKey: "playerNumber")
        }
        // если Включена настройка roundStartsFirstPlayer то раунд начинает первый игрок
        else if roundStartsFirstPlayer {
            userDefaults.set(0, forKey: "playerNumber")
        }
        // если Выключена настройка roundStartsFirstPlayer + включена настройка Переносить остаток времени + у игрока осталось время на игру  - то раунд начинает тот же игрок
        else if moveTime && curTime != 0 {
            userDefaults.set(playerNumber, forKey: "playerNumber")
        }
        // иначе раунд начинает игрок, следующий за игроком который завершал предыдущий раунд
        else {
            userDefaults.set(newNextPlayer, forKey: "playerNumber")
        }
    }
    
    func updateRoundNumber() {
        // если шляпа НЕ пуста то не обновляем раунд, а продолжаем тот же раунд
        if gameResultStatus != "hatIsEmpty" { return }
    
        // иначе обновляем номер раунда
        
        // массив из Настроек типов райндов [1,1,1,0]
        let roundTypeString = settings["roundType"] ?? defaultRoundTypes
        let roundTypesArray: [String] = arrayFromStr(roundTypeString)
        // массив с индексами раундов, которые участвуют в игре
        var roundsInGameIndexes = [Int]()
        for i in 0..<roundTypesArray.count {
            if roundTypesArray[i] == "1" {
                roundsInGameIndexes.append(i)
            }
        }
        
        // если раунд - последний то завершаем игру
        if roundNumber == roundsInGameIndexes.count - 1 {
            // статус игры - конец игры
            gameResultStatus = "gameEnd"
            userDefaults.set(gameResultStatus, forKey: "gameResultStatus")
            //настройка новой игры
            userDefaults.set(false, forKey: "inGame")
        }
        // если раунд не последний - обновляем номер раунда
        else {
            roundNumber += 1
            userDefaults.set(roundNumber, forKey: "roundNumber")
        }
    }
    
    func updateCurScoreAndLabel(newValue: Int) {
        curScore = newValue
        userDefaults.set(curScore, forKey: "curScore")
        scoreLabel.text = "\(curScore)"
    }
    
    
    func addResult(word: String, isCorrect: Bool) {
        // добавляем новый результат
        guard let mc = moc else { return }
        let newResult = Result(context: mc)
        let resultIds = results.map({$0.id})
        let lastResultId = resultIds.max() ?? 0
        newResult.id = lastResultId + 1
        newResult.word = word
        newResult.isCorrect = isCorrect
        saveContext(moc: moc)
    }
    
    func updatePlayerScore(playerIndex: Int, score: Int) {
        // добавляем очко к нужному раунду
        switch roundsInGameIndex {
            case 0: players[playerIndex].wordsRoundScore += Int32(score)
            case 1: players[playerIndex].gesturesRoundScore += Int32(score)
            case 2: players[playerIndex].onewordRoundScore += Int32(score)
            case 3: players[playerIndex].drawingRoundScore += Int32(score)
            default: break
        }
        // и к общему количеству очков
        players[playerIndex].totalScore += Int32(score)
        saveContext(moc: moc)
    }
    
    func minusScore() {
        updateCurScoreAndLabel(newValue: curScore - 1)
        // если командная игра то уменьшаем очко у текущей команды
        if gameType == 0 {
            updatePlayerScore(playerIndex: playerNumber, score: -1)
        }
        // если одиночная игра то уменьшаем очко у следующей команды (угадывающей)
        else {
            updatePlayerScore(playerIndex: nextPlayerNumber, score: -1)
        }
    }
    
    func plusScore(addedBall: Int) {
        updateCurScoreAndLabel(newValue: curScore + addedBall)
        if gameType == 0 {
            //добавляем очки команде
            updatePlayerScore(playerIndex: playerNumber, score: addedBall)
        } else {
            //добавляем очки игроку, который угадывает слово (nextPlayer)
            updatePlayerScore(playerIndex: nextPlayerNumber, score: addedBall)
        }
    }

    func playerInAlertPressed(index: Int, addedBall: Int) {
        
        var playerNumberToCompare = playerNumber
        if gameType == 1 {
            playerNumberToCompare = nextPlayerNumber
        }

        updatePlayerScore(playerIndex: index, score: addedBall)
        
        // если угадал текущий игрок
        if index == playerNumberToCompare {
            //добавляем результат
            addResult(word: curWord, isCorrect: true)
            // меняем очко в лейбле
            updateCurScoreAndLabel(newValue: curScore + addedBall)
        }
        // если угадал другой игрок
        else {
            //добавляем результат
            //let commonText = lang_scheme[cur_lang]?["commonText"] as? String ?? ""
            let commonText = players[index].name ?? ""
            addResult(word: "\(curWord) (\(commonText))" , isCorrect: true)
        }
    }
    
    
}
