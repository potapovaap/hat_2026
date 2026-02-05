import UIKit
extension resultsVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		fontSize = iphoneConstraints ? 27 : 38
		timeoutLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		timeoutLabel.textColor = UIColor(hex: "ffffff")
		timeoutLabel.textAlignment = .center
		//timeoutLabel.text = title("timeoutLabel")
		timeoutLabel.tag = 2
		self.view.addSubview(timeoutLabel)

		fontSize = iphoneConstraints ? 20 : 32
		playerLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		playerLabel.textColor = UIColor(hex: "ffffff")
		playerLabel.textAlignment = .center
		//playerLabel.text = title("playerLabel")
        playerLabel.numberOfLines = 2
		playerLabel.tag = 3
		self.view.addSubview(playerLabel)

		scoreImageView.contentMode = .scaleAspectFit
		scoreImageView.image = UIImage(named: "resultScoreCircle")
		scoreImageView.tag = 4
		self.view.addSubview(scoreImageView)

		fontSize = iphoneConstraints ? 45 : 70
		scoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		scoreLabel.textColor = UIColor(hex: "ffffff")
		scoreLabel.textAlignment = .center
		//scoreLabel.text = title("scoreLabel")
		scoreLabel.tag = 5
		self.view.addSubview(scoreLabel)

		resultsTableView.delegate = self
		resultsTableView.dataSource = self
		resultsTableView.backgroundColor = .clear
		resultsTableView.contentInsetAdjustmentBehavior = .never
		resultsTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "ResultTableViewCell")
		resultsTableView.tag = 6
		self.view.addSubview(resultsTableView)

		whiteBottomImageView.contentMode = .scaleAspectFit
		whiteBottomImageView.image = UIImage(named: "whiteBottom")
		whiteBottomImageView.tag = 7
		self.view.addSubview(whiteBottomImageView)

		nextPlayerButton.contentMode = .scaleAspectFit
		nextPlayerButton.setTitle("", for: .normal)
		//nextPlayerButton.setBackgroundImage(UIImage(named: "nextPlayer_0"), for: .normal)
		nextPlayerButton.addTarget(self, action: #selector(nextPlayerButtonPressed), for: .touchUpInside)
		nextPlayerButton.tag = 8
		self.view.addSubview(nextPlayerButton)

		goToMenuButton.contentMode = .scaleAspectFit
		goToMenuButton.setTitle("", for: .normal)
		goToMenuButton.setBackgroundImage(UIImage(named: "goToMenuButton"), for: .normal)
		goToMenuButton.addTarget(self, action: #selector(goToMenuButtonPressed), for: .touchUpInside)
		goToMenuButton.tag = 9
		self.view.addSubview(goToMenuButton)


    }

}
