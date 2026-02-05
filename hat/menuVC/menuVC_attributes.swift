import UIKit
extension menuVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "backgroundMenu")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		logoImageView.contentMode = .scaleAspectFit
		logoImageView.image = UIImage(named: "logo")
		logoImageView.tag = 2
		self.view.addSubview(logoImageView)

		hatImageView.contentMode = .scaleAspectFit
		hatImageView.image = UIImage(named: "hat")
		hatImageView.tag = 3
		self.view.addSubview(hatImageView)

		continueButton.contentMode = .scaleAspectFit
		continueButton.setTitle("", for: .normal)
		continueButton.setBackgroundImage(UIImage(named: "continueButton"), for: .normal)
		continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
		continueButton.tag = 4
		self.view.addSubview(continueButton)

		newGameButton.contentMode = .scaleAspectFit
		newGameButton.setTitle("", for: .normal)
		newGameButton.setBackgroundImage(UIImage(named: "newGameButton"), for: .normal)
		newGameButton.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
		newGameButton.tag = 5
		self.view.addSubview(newGameButton)

		themesButton.contentMode = .scaleAspectFit
		themesButton.setTitle("", for: .normal)
		themesButton.setBackgroundImage(UIImage(named: "themesButton"), for: .normal)
		themesButton.addTarget(self, action: #selector(themesButtonPressed), for: .touchUpInside)
		themesButton.tag = 6
		self.view.addSubview(themesButton)

		playersButton.contentMode = .scaleAspectFit
		playersButton.setTitle("", for: .normal)
		playersButton.setBackgroundImage(UIImage(named: "playersButton"), for: .normal)
		playersButton.addTarget(self, action: #selector(playersButtonPressed), for: .touchUpInside)
		playersButton.tag = 7
		self.view.addSubview(playersButton)

		rulesButton.contentMode = .scaleAspectFit
		rulesButton.setTitle("", for: .normal)
		rulesButton.setBackgroundImage(UIImage(named: "rulesButton"), for: .normal)
		rulesButton.addTarget(self, action: #selector(rulesButtonPressed), for: .touchUpInside)
		rulesButton.tag = 8
		self.view.addSubview(rulesButton)

		modesButton.contentMode = .scaleAspectFit
		modesButton.setTitle("", for: .normal)
		modesButton.setBackgroundImage(UIImage(named: "modesButton"), for: .normal)
		modesButton.addTarget(self, action: #selector(modesButtonPressed), for: .touchUpInside)
		modesButton.tag = 9
		self.view.addSubview(modesButton)


    }

}