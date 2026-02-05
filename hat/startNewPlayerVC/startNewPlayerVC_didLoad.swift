import UIKit
import CoreData

extension startNewPlayerVC {

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
        navigationItem.title = lang_scheme[cur_lang]?["startNewPlayerVCTitle"] as? String ?? "navigationBar title"
        
        // ADDITIONAL_INFO
        let roundText = lang_scheme[cur_lang]?["roundText"] as? String ?? "".uppercased()
        self.navigationItem.title = "\(roundText) \(roundNumber + 1): \(roundNames[roundsInGameIndex])".uppercased()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }

    override func backButtonPressed() {
        //some action here
        
        goBackTo(backToMenu: false)
    }

    func getAllDidLoadParameters() {

        roundNumber = (userDefaults.object(forKey: "roundNumber") as? Int) ?? roundNumber
        roundsInGameIndex = (userDefaults.object(forKey: "roundsInGameIndex") as? Int) ?? roundsInGameIndex
        playerNumber = (userDefaults.object(forKey: "playerNumber") as? Int) ?? playerNumber
        
        var moc = getContext()
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        var players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        let explainsTeamText = lang_scheme[cur_lang]?["explainsTeam"] as? String ?? "".uppercased()
        let explainsPlayerText = lang_scheme[cur_lang]?["explainsPlayer"] as? String ?? "".uppercased()
        
        // тип игры: 0 - командная  / 1 - одночная
        let gameType = Int(settings["gameType"] ?? "0") ?? 0
        if gameType == 0 {
            print(players)
            print(players.count)
            print(playerNumber)
            
            firstPlayerLabel.isHidden = true
            infoLabel.text = "\(explainsTeamText)\(playerNumber + 1):".uppercased()
            secondPlayerLabel.text = (players[playerNumber].name ?? "").uppercased()
        } else {
            var nextPlayer = 0
            if playerNumber == players.count - 1 {
                nextPlayer = 0
            } else {
                nextPlayer = playerNumber + 1
            }
            firstPlayerLabel.isHidden = false
            firstPlayerLabel.text = (players[playerNumber].name ?? "").uppercased()
            infoLabel.text = "\(explainsPlayerText):".uppercased()
            secondPlayerLabel.text = (players[nextPlayer].name ?? "").uppercased()
        }
        
        //firstPlayerLabel.text = "Штормовое предупреждение".uppercased() // для теста удалить
        //secondPlayerLabel.text = "Штормовое предупреждение".uppercased() // для теста удалить
        
        
        // удаляем предыдушие результаты игры
        let sortdDescriptorResult = NSSortDescriptor.init(key: "id", ascending: true)
        var results = getEntity(type: Result.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        for result in results { moc?.delete(result) }
        saveContext(moc: moc)
        results.removeAll()
        
        // обнуляем очки
        userDefaults.set(0, forKey: "curScore")
        
       
        /*  // ЗДЕСЬ НЕ НАДО ПЕРЕУСТАНАВЛИВАТЬ
         // переустанавливаем текущее время - берем время из пресетов или из своего значения
         let roundTime = Int(settings["roundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
         let ownRoundTime = Int(settings["ownRoundTime"] ?? "\(defaultRoundTime)") ?? defaultRoundTime
         let selectOwnRoundTime = Bool(settings["selectOwnRoundTime"] ?? "\(defaultSelectOwnRoundTime)") ?? defaultSelectOwnRoundTime
         let resultRoundTime = selectOwnRoundTime ? ownRoundTime : roundTime
         userDefaults.set(resultRoundTime,forKey: "curTime")
         */
        
        
        //показываем задание
        let taskText = lang_scheme[cur_lang]?["taskText"] as? String ?? "".uppercased()
        let gameWithTasks = Bool(settings["gameWithTasks"] ?? "\(defaultGameWithTasks)") ?? defaultGameWithTasks
        let curTask = (userDefaults.object(forKey: "curTask") as? String) ?? ""
        if gameWithTasks {
            taskLabel.isHidden = false
            taskLabel.text =  "\(taskText)\n\(curTask)".uppercased()
        } else {
            taskLabel.isHidden = true
        }
        
        //taskLabel.text = "Получая поджопник от всех игроков по очереди".uppercased() // для теста удалить
        
        userDefaults.set("newPlayerStarts", forKey: "gameResultStatus")

    }

    func updateControls() {

    }

}

