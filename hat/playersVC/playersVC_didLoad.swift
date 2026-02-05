import UIKit
extension playersVC {

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
        navigationItem.title = (lang_scheme[cur_lang]?["playersVCTitle"] as? String ?? "navigationBar title").uppercased()
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
		moc = getContext()
        
        // тип игры
        gameType = Int(settings["gameType"] ?? "\(defaultGameType)") ?? defaultGameType
        // номер текущего игрока
        playerNumber = (userDefaults.object(forKey: "playerNumber") as? Int) ?? playerNumber
        
        // дефолтные имена игроков
        defaultPlayersNames = gameType == 0 ? teamPlayersNames : singlePlayersNames
        
		getAllDidLoadPlayersParameters()
		playersTableView.reloadData()

    }

    func updateControls() {
		playersTableView.reloadData()

    }

}
