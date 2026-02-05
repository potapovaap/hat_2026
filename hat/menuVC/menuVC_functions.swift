import UIKit
import CoreData

extension menuVC {
    @objc func continueButtonPressed() {
        
        
        let gameResultStatus = (userDefaults.object(forKey: "gameResultStatus") as? String) ?? ""
        
        //  если время вышло - переходим к следующему игроку
        if gameResultStatus == "timeIsOver" || gameResultStatus == "newPlayerStarts"{
            goNextVC("startNewPlayerVC")
        }
       // если в шляпе закончились слова - начинаем новый раунд
        else if gameResultStatus == "hatIsEmpty" || gameResultStatus == "newRoundStarts" {
            goNextVC("startNewRoundVC")
        }
        // завершаем игру
        else if gameResultStatus == "gameEnd" {
            goNextVC("victoryVC")
        }
        // инача возвращаемся к игре
        else if gameResultStatus == "gameInProcess" {
            goNextVC("gameVC")
        }
	}
    
	@objc func newGameButtonPressed() {
        // ADDITIONAL_INFO
        showNewGameAlert()
	}
    
	@objc func themesButtonPressed() {
		goNextVC("sectionsVC")
	}

	@objc func playersButtonPressed() {
		goNextVC("playersVC")
	}

	@objc func rulesButtonPressed() {
		goNextVC("rulesVC")
	}

	@objc func modesButtonPressed() {
		goNextVC("settingsVC")
	}


    // ADDITIONAL_INFO ###########################################
    func showNewGameAlert() {
        //если игра еще не началась
        if inGame == false {
            startNewGame()
        }
        else { //если уже в игре
            //алерт - точно начать новую игру?
            let alert = UIAlertController(title: lang_scheme[cur_lang]?["newGameAlertTitle"] as? String, message: lang_scheme[cur_lang]?["newGameAlertMessage"] as? String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: yesTitle, style: .default) { (_) in
                //удаляем результаты предыдущей игры
                self.deleteOldGameResults()
                //настройка новой игры
                self.startNewGame()
            })
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func deleteOldGameResults() {
        inGame = false
        userDefaults.set(false, forKey: "inGame")
        continueButton.isEnabled = false
    }
    
    func startNewGame() {
        let prepareForNewGameResult = prepareForNewGame()
        if prepareForNewGameResult {
            //настройка новой игры
            inGame = true
            userDefaults.set(inGame, forKey: "inGame")
            goNextVC("startNewRoundVC")
        }
    }
    func prepareForNewGame() -> Bool {

        // новое задание curTask
        let curTask = tasks[Random.randomInt(min: 0, max: tasks.count-1)]
        userDefaults.set(curTask, forKey: "curTask")
        
        // переустанавливаем время раунда curTime
        let selectOwnRoundTime = Bool(settings["selectOwnRoundTime"] ?? "\(defaultSelectOwnRoundTime)") ?? defaultSelectOwnRoundTime
        let roundTime = Int(settings["roundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
        let ownRoundTime = Int(settings["ownRoundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
        let curTime = selectOwnRoundTime ? ownRoundTime : roundTime
        userDefaults.set(curTime, forKey: "curTime")
        
        // обнуляем scores у каждого игрока
        let moc = getContext()
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        let players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        for player in players {
            player.wordsRoundScore = 0
            player.gesturesRoundScore = 0
            player.onewordRoundScore = 0
            player.drawingRoundScore = 0
            player.totalScore = 0
            player.extraTimeIsUsed = false
        }
        
        //удаляем предыдушие результаты игры
        let sortdDescriptorResult = NSSortDescriptor.init(key: "id", ascending: true)
        var results = getEntity(type: Result.self, moc: moc, sortdDescriptors: [sortdDescriptorResult], predicates: [])
        for result in results { moc?.delete(result) }
        saveContext(moc: moc)
        results.removeAll()
        
        userDefaults.set(0, forKey: "roundNumber")
        userDefaults.set(0, forKey: "playerNumber")
        userDefaults.set(0, forKey: "curScore")
        userDefaults.set("--", forKey: "curWord")
        userDefaults.set(0, forKey: "curGameWordsCount")
        let usedWordsIndexesForTheGame = [Int]()
        userDefaults.set(usedWordsIndexesForTheGame, forKey: "usedWordsIndexesForTheGame")
        
        
        //print("generateWordsArray")
        // генерим новый набор слов на игру
        let generatedWordsResult = generateWordsArray()
        return generatedWordsResult
        
    }
    
    func generateWordsArray() -> Bool {
        // генерим новый набор слов на игру
        var prevIndexes: [Int] = []
        var curThemesWordsCount = 10
        var curSections = defaultSections
        var words = [String]()
        var all_words_for_selected_themes = [Int]()
        var all_words_with_own = [String]()
                
        
        
        // выбранные темы
        let selectedSectionsIds = (userDefaults.object(forKey: "selectedSectionsIds") as? [Int]) ?? defaultSelectedSectionsIds
        
        // слова пользователя
        let moc = getContext()
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        let ownWords = getEntity(type: Ownword.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        // получаем вообще все слова вместе со своими
        all_words_with_own = []
        all_words_with_own.append(contentsOf: all_words)
        
        //print(sectionPresets.count)
        //print(all_themes.count)
        //print(ownSectionsCount)
        
        // обнуляем свои темы - начиная с ID 40, 41, 42 и тд:
        let ownSectionsCount = all_themes.count - sectionPresets.count
        for i in 0..<ownSectionsCount {
            all_themes[String(sectionPresets.count + i + 1)] = nil
        }
        //print(all_themes.count)
        
        for ownWord in ownWords {
            if let curWordSectionId = ownWord.section?.id, let ownWordName = ownWord.name {
                all_words_with_own.append(ownWordName)
                if all_themes[String(curWordSectionId)] == nil { all_themes[String(curWordSectionId)] = [] }
                all_themes[String(curWordSectionId)]?.append(all_words_with_own.count - 1)
                //print(all_themes[String(curWordSectionId)])
            }
        }
        
        // получаем все слова для выбранных тем
        var all_words_for_selected_themes_SET = Set<Int>()
        
        for selectedSectionsId in selectedSectionsIds {
            //print("selectedSectionsId: \(selectedSectionsId)")
            //print(all_themes[String(selectedSectionsId)])
            all_words_for_selected_themes_SET.formUnion(all_themes[String(selectedSectionsId)] ?? [])
        }
        all_words_for_selected_themes = Array(all_words_for_selected_themes_SET)
        //print("all_words_for_selected_themes: \(all_words_for_selected_themes)")
        curThemesWordsCount = all_words_for_selected_themes.count
        
        //Массив с индексами предыдущих слов
        prevIndexes = (userDefaults.object(forKey: "prevIndexes") as? [Int]) ?? []
        if prevIndexes.count >= curThemesWordsCount || prevIndexes.count > 10000 {
            prevIndexes = []
            userDefaults.set(prevIndexes,forKey: "prevIndexes")
        }
        
        
        // текущее количество слов - берем время из пресетов или из своего значения
        let wordsCount = Int(settings["wordsCount"] ?? "\(defaultWordsCount)") ?? defaultWordsCount
        let ownWordsCount = Int(settings["ownWordsCount"] ?? "\(defaultWordsCount)") ?? defaultWordsCount
        let selectOwnWordsCount = Bool(settings["selectOwnWordsCount"] ?? "\(defaultSelectOwnWordsCount)") ?? defaultSelectOwnWordsCount
        let resultWordsCount = selectOwnWordsCount ? ownWordsCount : wordsCount

        
        
        //  если выбрали категории, в которых суммарно слов меньше, чем задано в настройках игры то не начинаем новую игру
        if all_words_for_selected_themes.count < resultWordsCount {
            var message = lang_scheme[cur_lang]?["notEnoughWordsAlertMessage"] as? String ?? ""
            message = message.replacingOccurrences(of: "GAME_WORDS_COUNT", with: "\(all_words_for_selected_themes.count)")
            message = message.replacingOccurrences(of: "SETTINGS_WORDS_COUNT", with: "\(resultWordsCount)")
            showAlertOk(title: lang_scheme[cur_lang]?["notEnoughWordsAlertTitle"] as? String ?? "", message: message)
            return false
        }

        //если все слова есть в prevIndexes
        //prevIndexes = []
        //all_words_for_selected_themes
        
        // если слов хватает, то генерим массив слов для игры с количеством слов resultWordsCount
        var wordsForTheGame = [String]()
        for i in 0..<resultWordsCount {
            //print(i)
            //находим рандомное слово
            var index = Random.randomInt(min: 0, max: all_words_for_selected_themes.count-1)
            var word_index = all_words_for_selected_themes[index] //индекс слова
            var whiteStep = 0
            while prevIndexes.contains(word_index) {
                index = Random.randomInt(min: 0, max: all_words_for_selected_themes.count-1)
                word_index = all_words_for_selected_themes[index] //индекс слова
                whiteStep += 1
                if whiteStep > 10000 {
    
                    prevIndexes = []
                    userDefaults.set(prevIndexes,forKey: "prevIndexes")
                }
            }
            let currentWord = all_words_with_own[word_index]
            //добавляем слово в массив слов для игры
            wordsForTheGame.append(currentWord)
            userDefaults.set(wordsForTheGame,forKey: "wordsForTheGame")
            //добавляем слово в предыдующие слова
            prevIndexes.append(word_index)
            userDefaults.set(prevIndexes,forKey: "prevIndexes")
            
            
        }
         return true
    }
    
    
    func loadSectionsAndPlayers() {
        let moc = getContext()
        
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        var sections = getEntity(type: Section.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        if sections.isEmpty {
            if let mc = moc {
                for i in 0..<sectionPresets.count {
                    let newItem = Section(context: mc)
                    newItem.id = Int32(sectionPresets[i].id)
                    newItem.image = sectionPresets[i].image
                    newItem.name = sectionPresets[i].name
                    newItem.desc = sectionPresets[i].desc
                    newItem.wordsCount = sectionPresets[i].wordsCount
                    sections.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
        var players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        if players.isEmpty {
            if let mc = moc {
                for i in 0..<playerPresets.count {
                    let newItem = Player(context: mc)
                    newItem.id = Int32(playerPresets[i].id)
                    newItem.name = playerPresets[i].name
                    newItem.wordsRoundScore = Int32(playerPresets[i].wordsRoundScore)
                    newItem.gesturesRoundScore = Int32(playerPresets[i].gesturesRoundScore)
                    newItem.onewordRoundScore = Int32(playerPresets[i].onewordRoundScore)
                    newItem.drawingRoundScore = Int32(playerPresets[i].drawingRoundScore)
                    newItem.totalScore = Int32(playerPresets[i].totalScore)
                    players.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
    }
    
    // ADDITIONAL_INFO - END ###########################################
    
}


