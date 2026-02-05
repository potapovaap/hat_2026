import UIKit
extension startNewRoundVC {

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

		fontSize = iphoneConstraints ? 20 : 26
		roundDescLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		roundDescLabel.textColor = UIColor(hex: "635959")
		roundDescLabel.textAlignment = .center
		//roundDescLabel.text = title("roundDescLabel")
		roundDescLabel.numberOfLines = 4
		roundDescLabel.tag = 3
		self.view.addSubview(roundDescLabel)

		fontSize = iphoneConstraints ? 30 : 45
		roundNameLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		roundNameLabel.textColor = UIColor(hex: "E84070")
		roundNameLabel.textAlignment = .center
		//roundNameLabel.text = title("roundNameLabel")
		roundNameLabel.tag = 4
		self.view.addSubview(roundNameLabel)

		fontSize = iphoneConstraints ? 30 : 45
		roundNumberLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		roundNumberLabel.textColor = UIColor(hex: "4C54F3")
		roundNumberLabel.textAlignment = .center
		//roundNumberLabel.text = title("roundNumberLabel")
		roundNumberLabel.tag = 5
		self.view.addSubview(roundNumberLabel)

		startButton.contentMode = .scaleAspectFit
		startButton.setTitle("", for: .normal)
		startButton.setBackgroundImage(UIImage(named: "startGameButton"), for: .normal)
		startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
		startButton.tag = 6
		self.view.addSubview(startButton)
        
        fontSize = iphoneConstraints ? 20 : 26
        taskLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
        taskLabel.textColor = UIColor(hex: "4C54F3")
        taskLabel.textAlignment = .center
        //taskLabel.text = title("taskLabel")
        taskLabel.tag = 7
        taskLabel.numberOfLines = 3
        self.view.addSubview(taskLabel)


    }

}
