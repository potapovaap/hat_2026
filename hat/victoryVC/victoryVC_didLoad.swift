import UIKit
import AVFAudio

extension victoryVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDidLoadParameters()
        
        setBackButton() //params: withTitle withCustomImage customImageName backToMenu
        setAttributes()
        setConstraints()
        
        let gameSounds = Bool(settings["gameSounds"] ?? "\(defaultGameSounds)") ?? defaultGameSounds
        endGameSound = initializePlayer(fileName: "endGame", fileType: "wav")
        if gameSounds {  endGameSound?.play() }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = lang_scheme[cur_lang]?["victoryVCTitle"] as? String ?? "navigationBar title"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }

    override func backButtonPressed() {
        //some action here
        
        goBackTo(backToMenu: false)
    }

    func getAllDidLoadParameters() {
		moc = getContext()

        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        sortedPlayers = players.sorted(by: {$0.totalScore > $1.totalScore})
		playersTableView.reloadData()
        
        //делаем кнопку Назад невидимой
        self.navigationItem.hidesBackButton = true

    }


}
