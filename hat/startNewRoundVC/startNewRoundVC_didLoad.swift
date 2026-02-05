import UIKit
extension startNewRoundVC {

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
        navigationItem.title = lang_scheme[cur_lang]?["startNewRoundVCTitle"] as? String ?? "navigationBar title"
        
        // ADDITIONAL_INFO
        let roundText = lang_scheme[cur_lang]?["roundText"] as? String ?? "".uppercased()
        self.navigationItem.title = ("\(roundText) \(roundNumber + 1): \(roundNames[roundsInGameIndex])").uppercased()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }


    func getAllDidLoadParameters() {
        // ADDITIONAL_INFO
        roundNumber = (userDefaults.object(forKey: "roundNumber") as? Int) ?? roundNumber
        let roundText = lang_scheme[cur_lang]?["roundText"] as? String ?? "".uppercased()
        roundNumberLabel.text = "\(roundText) #\(roundNumber + 1)"
        
        let roundTypeString = settings["roundType"] ?? defaultRoundTypes
        let roundTypesArray: [String] = arrayFromStr(roundTypeString)
        // массив с индексами раундов, которые участвуют в игре
        var roundsInGameIndexes = [Int]()
        for i in 0..<roundTypesArray.count {
            if roundTypesArray[i] == "1" {
                roundsInGameIndexes.append(i)
            }
        }
        // индекс раунда в исходном массиве всех раундов
        roundsInGameIndex = roundsInGameIndexes[roundNumber]
        roundNameLabel.text = roundNames[roundsInGameIndex].uppercased()
        roundDescLabel.text = roundDescs[roundsInGameIndex].uppercased()
        userDefaults.set(roundsInGameIndex, forKey: "roundsInGameIndex")
        

        // новое задание curTask
        let curTask = tasks[Random.randomInt(min: 0, max: tasks.count-1)]
        userDefaults.set(curTask, forKey: "curTask")
        //показываем задание
        let taskText = lang_scheme[cur_lang]?["taskText"] as? String ?? "".uppercased()
        let gameWithTasks = Bool(settings["gameWithTasks"] ?? "\(defaultGameWithTasks)") ?? defaultGameWithTasks
        if gameWithTasks {
            taskLabel.isHidden = false
            taskLabel.text =  "\(taskText)\n\(curTask)".uppercased()
        } else {
            taskLabel.isHidden = true
        }
        //taskLabel.text = "Получая поджопник от всех игроков по очереди".uppercased() // для теста удалить
        
        userDefaults.set("newRoundStarts", forKey: "gameResultStatus")
    }

    func updateControls() {

    }

}
