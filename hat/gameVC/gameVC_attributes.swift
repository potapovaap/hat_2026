import UIKit
extension gameVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		wordBackImageView.contentMode = .scaleAspectFit
		wordBackImageView.image = UIImage(named: "wordBack")
		wordBackImageView.tag = 2
		self.view.addSubview(wordBackImageView)

		wordBackTimeImageView.contentMode = .scaleAspectFit
		wordBackTimeImageView.image = UIImage(named: "wordBackTime")
		wordBackTimeImageView.tag = 3
		self.view.addSubview(wordBackTimeImageView)

		fontSize = iphoneConstraints ? 20 : 30 //30 : 50
		playersLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		playersLabel.textColor = UIColor(hex: "ffffff")
		playersLabel.textAlignment = .center
		//playersLabel.text = title("playersLabel")
        playersLabel.numberOfLines = 2
		playersLabel.tag = 4
		self.view.addSubview(playersLabel)

		fontSize = iphoneConstraints ? 35 : 60
		roundTimeLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		roundTimeLabel.textColor = UIColor(hex: "ffffff")
		roundTimeLabel.textAlignment = .center
		//roundTimeLabel.text = title("roundTimeLabel")
		roundTimeLabel.tag = 5
		self.view.addSubview(roundTimeLabel)

		fontSize = iphoneConstraints ? 20 : 30
		taskLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		taskLabel.textColor = UIColor(hex: "ffffff")
		taskLabel.textAlignment = .center
		//taskLabel.text = title("taskLabel")
		taskLabel.numberOfLines = 2
		taskLabel.tag = 6
		self.view.addSubview(taskLabel)

		fontSize = iphoneConstraints ? 30 : 50
		wordLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		wordLabel.textColor = UIColor(hex: "E84170")
		wordLabel.textAlignment = .center
		//wordLabel.text = title("wordLabel")
		wordLabel.numberOfLines = 4
		wordLabel.tag = 7
		self.view.addSubview(wordLabel)

		fontSize = iphoneConstraints ? 60 : 80
		scoreLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		scoreLabel.textColor = UIColor(hex: "ffffff")
		scoreLabel.textAlignment = .center
		//scoreLabel.text = title("scoreLabel")
		scoreLabel.tag = 8
		self.view.addSubview(scoreLabel)

		wrongButton.contentMode = .scaleAspectFit
		wrongButton.setTitle("", for: .normal)
		wrongButton.setBackgroundImage(UIImage(named: "wrongButton"), for: .normal)
		wrongButton.addTarget(self, action: #selector(wrongButtonPressed), for: .touchUpInside)
		wrongButton.tag = 9
		self.view.addSubview(wrongButton)

		rightButton.contentMode = .scaleAspectFit
		rightButton.setTitle("", for: .normal)
		rightButton.setBackgroundImage(UIImage(named: "rightButton"), for: .normal)
		rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
		rightButton.tag = 10
		self.view.addSubview(rightButton)
        
        extraTimeButton.contentMode = .scaleAspectFit
        extraTimeButton.setTitle("", for: .normal)
        extraTimeButton.setBackgroundImage(UIImage(named: "extraTimeButton"), for: .normal)
        extraTimeButton.addTarget(self, action: #selector(extraTimeButtonPressed), for: .touchUpInside)
        extraTimeButton.tag = 11
        self.view.addSubview(extraTimeButton)
        

        let pauseButton = UIBarButtonItem(image: UIImage(named: "pauseButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(pauseButtonPressed))
        pauseButton.tag = 12
        navigationItem.rightBarButtonItems = [pauseButton]
    }

}
