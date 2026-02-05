import UIKit
extension startNewPlayerVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		whiteCenterImageView.contentMode = .scaleAspectFit
		whiteCenterImageView.image = UIImage(named: "whiteCenter")
		whiteCenterImageView.tag = 2
		self.view.addSubview(whiteCenterImageView)

		fontSize = iphoneConstraints ? 24 : 38
		infoLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		infoLabel.textColor = UIColor(hex: "635959") //4C54F3
		infoLabel.textAlignment = .center
		//infoLabel.text = title("infoLabel")
		infoLabel.numberOfLines = 2
		infoLabel.tag = 3
		self.view.addSubview(infoLabel)

		fontSize = iphoneConstraints ? 30 : 45
		firstPlayerLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		firstPlayerLabel.textColor = UIColor(hex: "E84070") //4C54F3
		firstPlayerLabel.textAlignment = .center
        firstPlayerLabel.numberOfLines = 2
		//firstPlayerLabel.text = title("firstPlayerLabel")
		firstPlayerLabel.tag = 4
		self.view.addSubview(firstPlayerLabel)

		fontSize = iphoneConstraints ? 30 : 45
		secondPlayerLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		secondPlayerLabel.textColor = UIColor(hex: "E84070") //4C54F3
		secondPlayerLabel.textAlignment = .center
        secondPlayerLabel.numberOfLines = 2
		//secondPlayerLabel.text = title("secondPlayerLabel")
		secondPlayerLabel.tag = 5
		self.view.addSubview(secondPlayerLabel)
        
		startButton.contentMode = .scaleAspectFit
		startButton.setTitle("", for: .normal)
		startButton.setBackgroundImage(UIImage(named: "startGameButton"), for: .normal)
		startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
		startButton.tag = 6
		self.view.addSubview(startButton)
        
        fontSize = iphoneConstraints ? 20 : 26
        taskLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
        taskLabel.textColor = UIColor(hex: "4C54F3") //E84070
        taskLabel.textAlignment = .center
        //taskLabel.text = title("taskLabel")
        taskLabel.tag = 7
        taskLabel.numberOfLines = 3
        self.view.addSubview(taskLabel)


    }

}
