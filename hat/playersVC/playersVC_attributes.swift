import UIKit
extension playersVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		infoView.backgroundColor = UIColor(hex: "40AF4B")
		infoView.tag = 2
		self.view.addSubview(infoView)

		fontSize = iphoneConstraints ? 15 : 18
		gameTypeLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize) //"Helvetica"
		gameTypeLabel.textColor = UIColor(hex: "ffffff")
		gameTypeLabel.textAlignment = .center
		gameTypeLabel.text = title("gameTypeLabel")
		gameTypeLabel.tag = 3
		self.view.addSubview(gameTypeLabel)

		playersTableView.delegate = self
		playersTableView.dataSource = self
		playersTableView.backgroundColor = .clear
		playersTableView.contentInsetAdjustmentBehavior = .never
		playersTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
		playersTableView.tag = 4
		self.view.addSubview(playersTableView)

		whiteBottomImageView.contentMode = .scaleAspectFit
		whiteBottomImageView.image = UIImage(named: "whiteBottom")
		whiteBottomImageView.tag = 5
		self.view.addSubview(whiteBottomImageView)

		clearResultsButton.contentMode = .scaleAspectFit
		clearResultsButton.setTitle("", for: .normal)
		clearResultsButton.setBackgroundImage(UIImage(named: "clearResultsButton"), for: .normal)
		clearResultsButton.addTarget(self, action: #selector(clearResultsButtonPressed), for: .touchUpInside)
		clearResultsButton.tag = 6
		self.view.addSubview(clearResultsButton)

		let addPlayersButton = UIBarButtonItem(image: UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addPlayersButtonPressed))
		addPlayersButton.tag = 7
        
        
        let deleteAllPlayersButton = UIBarButtonItem(image: UIImage(named: "deleteAllPlayersButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(deleteAllPlayersButtonPressed))
        deleteAllPlayersButton.tag = 8
        
        
		navigationItem.rightBarButtonItems = [addPlayersButton, deleteAllPlayersButton]
        
        

        setGameType()
    }

}
