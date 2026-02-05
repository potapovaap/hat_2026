import UIKit
extension victoryVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "backgroundMenu")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		victoryImageView.contentMode = .scaleAspectFit
		victoryImageView.image = UIImage(named: "victory")
		victoryImageView.tag = 2
		self.view.addSubview(victoryImageView)

		playersTableView.delegate = self
		playersTableView.dataSource = self
		playersTableView.backgroundColor = .clear
		playersTableView.contentInsetAdjustmentBehavior = .never
		playersTableView.register(VictoryTableViewCell.self, forCellReuseIdentifier: "VictoryTableViewCell")
		playersTableView.tag = 3
		self.view.addSubview(playersTableView)

		rateButton.contentMode = .scaleAspectFit
		rateButton.setTitle("", for: .normal)
		rateButton.setBackgroundImage(UIImage(named: "rateButton"), for: .normal)
		rateButton.addTarget(self, action: #selector(rateButtonPressed), for: .touchUpInside)
		rateButton.tag = 4
		self.view.addSubview(rateButton)

		menuButton.contentMode = .scaleAspectFit
		menuButton.setTitle("", for: .normal)
		menuButton.setBackgroundImage(UIImage(named: "menuButtonGameEnd"), for: .normal)
		menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
		menuButton.tag = 5
		self.view.addSubview(menuButton)


    }

}