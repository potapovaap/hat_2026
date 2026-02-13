import UIKit
extension emptyhatVC {

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
        navigationItem.title = lang_scheme[cur_lang]?["emptyhatVCTitle"] as? String ?? "navigationBar title"
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
        let hatIsEmptyText = lang_scheme[cur_lang]?["hatIsEmpty"] as? String ?? ""
        titleLabel.text = hatIsEmptyText.uppercased()
        //titleLabel.sizeToFit()
        
        let curTime = (userDefaults.object(forKey: "curTime") as? Int) ?? 0
        
        let hatIsEmptyMessage = lang_scheme[cur_lang]?["hatIsEmptyMessage"] as? String ?? ""
        textLabel.text = hatIsEmptyMessage.replacingOccurrences(of: "TIME", with: "\(curTime)").uppercased()
        //textLabel.sizeToFit()

    }

    func updateControls() {

    }

}
