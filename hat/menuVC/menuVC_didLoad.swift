import UIKit
extension menuVC {

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
        
        hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = lang_scheme[cur_lang]?["menuVCTitle"] as? String ?? "navigationBar title"
        
        // ADDITIONAL_INFO
        inGame = (userDefaults.object(forKey: "inGame") as? Bool) ?? false
        continueButton.isEnabled = inGame ?? false
        
        
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
        loadSectionsAndPlayers()
    }

    func updateControls() {

    }

}
