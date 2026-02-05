import UIKit
import AVFAudio
extension resultsVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDidLoadParameters()
        
        //setBackButton() //params: withTitle withCustomImage customImageName backToMenu
        
        setAttributes()
        setConstraints()
        
        updateControls()
        
        let gameSounds = Bool(settings["gameSounds"] ?? "\(defaultGameSounds)") ?? defaultGameSounds
        resultSound = initializePlayer(fileName: "result", fileType: "wav")
        if gameSounds { resultSound?.play() }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = (lang_scheme[cur_lang]?["resultsVCTitle"] as? String ?? "navigationBar title").uppercased()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //показываем ли окно "Время будет перенесено на следующий раунд"
        if !roundStartsFirstPlayer && moveTime && gameResultStatus == "hatIsEmpty" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                // Код, который выполнится через 1 секунду
                self.showEmptyHatMessage()
            }
        }
    }

    override func backButtonPressed() {
        //some action here
        
        //goBackTo(backToMenu: false)
    }

    func getAllDidLoadParameters() {
		moc = getContext()

		getAllDidLoadResultsParameters()
		resultsTableView.reloadData()
        
        // все игроки
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        // текущий игрок
        playerNumber = (userDefaults.object(forKey: "playerNumber") as? Int) ?? 0
        
        // текущий раунд
        roundsInGameIndex = (userDefaults.object(forKey: "roundsInGameIndex") as? Int) ?? roundsInGameIndex
        
        
        
        moveTime = Bool(settings["moveTime"] ?? "\(defaultMoveTime)") ?? defaultMoveTime
        // настройка Раунд начинает первый игрок
        roundStartsFirstPlayer = Bool(settings["roundStartsFirstPlayer"] ?? "\(defaultRoundStartsFirstPlayer)") ?? defaultRoundStartsFirstPlayer
        
        //статус игры timeIsOver или hatIsEmpty
        gameResultStatus = (userDefaults.object(forKey: "gameResultStatus") as? String) ?? ""
        let timeIsOverText = lang_scheme[cur_lang]?["timeIsOver"] as? String ?? "".uppercased()
        let hatIsEmptyText = lang_scheme[cur_lang]?["hatIsEmpty"] as? String ?? "".uppercased()
        timeoutLabel.text = (gameResultStatus == "timeIsOver" ? timeIsOverText : hatIsEmptyText).uppercased()
        
        //имя игрока
        let gameType = settings["gameType"] ?? "\(defaultGameType)"
        let gotScoresText = lang_scheme[cur_lang]?["gotScoresText_\(gameType)"] as? String ?? "".uppercased()
        gameResultPlayerName = (userDefaults.object(forKey: "gameResultPlayerName") as? String) ?? ""
        playerLabel.text = (gameResultPlayerName + gotScoresText).uppercased()
        
        
        //print(players.map({$0.name}))
        //print(gameResultPlayerName)
        //print(players[playerNumber].name)
        //print(roundsInGameIndex)
        
        //playerLabel.text = "Штормовое предупреждение \(gotScoresText)".uppercased() // для теста удалить
        
        //очки игрока
        curScore = (userDefaults.object(forKey: "curScore") as? Int) ?? 0
        scoreLabel.text = "\(curScore)"
        
        if gameResultStatus == "hatIsEmpty" {
            nextPlayerButton.setBackgroundImage(UIImage(named: "nextRound"), for: .normal)
        } else {
            nextPlayerButton.setBackgroundImage(UIImage(named: "nextPlayer_\(gameType)"), for: .normal)
        }
        
        //делаем кнопку Назад невидимой
        self.navigationItem.hidesBackButton = true
    }

    func updateControls() {
		resultsTableView.reloadData()

    }

    func showEmptyHatMessage() {
        if let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "emptyhatVC") as? emptyhatVC {
            popupVC.modalPresentationStyle = .overFullScreen
            self.present(popupVC, animated: true, completion: nil)
        }
    }
}

