import UIKit
import AVFAudio
import CoreData

extension gameVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDidLoadParameters()
        
        setBackButton() //params: withTitle withCustomImage customImageName backToMenu
        setAttributes()
        setConstraints()
        
        updateControls()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = lang_scheme[cur_lang]?["gameVCTitle"] as? String ?? "navigationBar title"
        
        // ADDITIONAL_INFO
        let roundText = lang_scheme[cur_lang]?["roundText"] as? String ?? "".uppercased()
        self.navigationItem.title = "\(roundText) \(roundNumber + 1): \(roundNames[roundsInGameIndex])".uppercased()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }


    func getAllDidLoadParameters() {
        // ADDITIONAL_INFO
        moc = getContext()

        // получаем все слова для текущей игры
        wordsForTheGame = userDefaults.stringArray(forKey: "wordsForTheGame") ?? [String]()
        // получаем уже использованные слова в текущем раунде
        usedWordsIndexesForTheGame = (userDefaults.object(forKey: "usedWordsIndexesForTheGame") as? [Int]) ?? []

        //получаем результаты игр
        results = getEntity(type: Result.self, moc: moc, sortdDescriptors: [NSSortDescriptor.init(key: "id", ascending: true)], predicates: [])
        
        // получаем настройки
        wordsCount = Int(settings["wordsCount"] ?? "\(defaultWordsCount)") ?? defaultWordsCount
        roundTime = Int(settings["roundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
        ownRoundTime = Int(settings["ownRoundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
        ownWordsCount = Int(settings["ownWordsCount"] ?? "\(defaultWordsCount)") ?? defaultWordsCount
        selectOwnRoundTime = Bool(settings["selectOwnRoundTime"] ?? "\(defaultSelectOwnRoundTime)") ?? defaultSelectOwnRoundTime
        selectOwnWordsCount = Bool(settings["selectOwnWordsCount"] ?? "\(defaultSelectOwnWordsCount)") ?? defaultSelectOwnWordsCount
        gameType = Int(settings["gameType"] ?? "\(defaultGameType)") ?? defaultGameType
        moveTime = Bool(settings["moveTime"] ?? "\(defaultMoveTime)") ?? defaultMoveTime
        extraTime = Bool(settings["extraTime"] ?? "\(defaultExtraTime)") ?? defaultExtraTime
        commonLastWord = Bool(settings["commonLastWord"] ?? "\(defaultCommonLastWord)") ?? defaultCommonLastWord
        gameWithTasks = Bool(settings["gameWithTasks"] ?? "\(defaultGameWithTasks)") ?? defaultGameWithTasks
        minusForMistake = Bool(settings["minusForMistake"] ?? "\(defaultMinusForMistake)") ?? defaultMinusForMistake
        plusForSpeed = Bool(settings["plusForSpeed"] ?? "\(defaultPlusForSpeed)") ?? defaultPlusForSpeed
        gameSounds = Bool(settings["gameSounds"] ?? "\(defaultGameSounds)") ?? defaultGameSounds
        roundStartsFirstPlayer = Bool(settings["roundStartsFirstPlayer"] ?? "\(defaultRoundStartsFirstPlayer)") ?? defaultRoundStartsFirstPlayer
        
        // текущий раунд
        roundNumber = (userDefaults.object(forKey: "roundNumber") as? Int) ?? roundNumber
        roundsInGameIndex = (userDefaults.object(forKey: "roundsInGameIndex") as? Int) ?? roundsInGameIndex
        
        // текущее количество слов - берем время из пресетов или из своего значения
        resultWordsCount = selectOwnWordsCount ? ownWordsCount : wordsCount
        // сколько слов уже сыграно в раунде
        curGameWordsCount = (userDefaults.object(forKey: "curGameWordsCount") as? Int) ?? 0 //defaultWordsCount

        // текущее время - берем время из пресетов или из своего значения
        let resultRoundTime = selectOwnRoundTime ? ownRoundTime : roundTime
        curTime = (userDefaults.object(forKey: "curTime") as? Int) ?? resultRoundTime
        
        //curTime = 10 // для теста удалить
        
        // если время игрока больше чем время раунда, то уменьшить его до resultRoundTime
        if curTime > resultRoundTime { curTime = resultRoundTime }
        roundTimeLabel.text = "\(curTime)"
        //время последнего ответа
        prevRightAnswerTime = curTime
        
        // текущие очки
        curScore = (userDefaults.object(forKey: "curScore") as? Int) ?? curScore
        scoreLabel.text = "\(curScore)"
        
        //print("nextWord")
        // текущее слово
        curWord = (userDefaults.object(forKey: "curWord") as? String) ?? "--"
        if curWord == "--" { nextWord() }
        else { wordLabel.text = curWord }
        
        //print("nextTask")
        // текущее задание
        curTask = (userDefaults.object(forKey: "curTask") as? String) ?? ""
        if gameWithTasks == false { taskLabel.isHidden = true }
        else { taskLabel.text = curTask.uppercased() }
       // taskLabel.text = "Получая поджопник от всех игроков по очереди".uppercased() // для теста удалить
        
        // текущие игроки
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        let explainsTeamText = lang_scheme[cur_lang]?["Team"] as? String ?? "".uppercased()
        let explainsPlayerText = lang_scheme[cur_lang]?["explainsPlayer"] as? String ?? "".uppercased()
        // номер текущего игрока
        playerNumber = (userDefaults.object(forKey: "playerNumber") as? Int) ?? playerNumber
        // тип игры: 0 - командная  / 1 - одночная
        if gameType == 0 {
            playersLabel.text = "играет команда:\n\(players[playerNumber].name ?? "")".uppercased()
            // нужно ли добавлять игроку кнопку ДОП ВРЕМЯ
            //print(extraTime)
            //print(!players[playerNumber].extraTimeIsUsed)
            
            if extraTime && !players[playerNumber].extraTimeIsUsed { extraTimeButton.isHidden = false }
            else { extraTimeButton.isHidden = true }
        } else {
            nextPlayerNumber = 0
            if playerNumber == players.count - 1 {
                nextPlayerNumber = 0
            } else {
                nextPlayerNumber = playerNumber + 1
            }
            playersLabel.text = "\(players[playerNumber].name ?? "") → \(players[nextPlayerNumber].name ?? "")".uppercased()
            // нужно ли добавлять игроку кнопку ДОП ВРЕМЯ
            //print(extraTime)
            //print(!players[playerNumber].extraTimeIsUsed)
            
            if extraTime && !players[nextPlayerNumber].extraTimeIsUsed { extraTimeButton.isHidden = false }
            else { extraTimeButton.isHidden = true }
        }
        
        //print(extraTimeButton.isHidden)
        
        //playersLabel.text = "50 оттенков проигрыша → Штормовое предупреждение".uppercased() // для теста удалить
        //playersLabel.text = "Штормовое предупреждение → 50 оттенков проигрыша".uppercased() // для теста удалить
        //playersLabel.text = "играет команда:\nШтормовое предупреждение".uppercased() // для теста удалить
        
        // НЕ последнее слово
        isLastWord = false
    
        // звуки
        rightSound = initializePlayer(fileName: "correct", fileType: "wav")
        wrongSound = initializePlayer(fileName: "wrong", fileType: "wav")
        timerSound = initializePlayer(fileName: "timer", fileType: "wav")
        
        
        gameResultStatus = "gameInProcess"
        userDefaults.set(gameResultStatus, forKey: "gameResultStatus")
        
        // счетчик времени
        count = curTime
        //count = 0 //для быстрых тестов
        
        
        // запускаем таймер
        resetTimer()

    }
    
    //Запускаем таймер
    func resetTimer(){
        let waitTime = Double(1)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: waitTime, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    }
    
    
    @objc func counter() {
        // Пока тикает таймер, на каждый тик
        if count > 0 {
            count -= 1
            curTime = count
            roundTimeLabel.text = "\(curTime)"
        }
        // Когда время игрока истекло
        else {
            timer.invalidate()
            isLastWord = true
            if gameSounds { timerSound?.play() }
            
            //завершаем игру
            //finishGame(currentGameResultStatus: "timeIsOver")
        }
    }

    
    func updateControls() {

    }

}
