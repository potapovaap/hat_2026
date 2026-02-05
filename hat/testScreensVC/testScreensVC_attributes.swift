import UIKit
extension testScreensVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		menuButton.setTitle("menuVC", for: .normal)
		menuButton.setTitleColor(UIColor.black, for: .normal)
		menuButton.backgroundColor = UIColor.green
		menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
		menuButton.tag = 1
		self.view.addSubview(menuButton)

		emptyhatButton.setTitle("emptyhatVC", for: .normal)
		emptyhatButton.setTitleColor(UIColor.black, for: .normal)
		emptyhatButton.backgroundColor = UIColor.green
		emptyhatButton.addTarget(self, action: #selector(emptyhatButtonPressed), for: .touchUpInside)
		emptyhatButton.tag = 2
		self.view.addSubview(emptyhatButton)

		gameButton.setTitle("gameVC", for: .normal)
		gameButton.setTitleColor(UIColor.black, for: .normal)
		gameButton.backgroundColor = UIColor.green
		gameButton.addTarget(self, action: #selector(gameButtonPressed), for: .touchUpInside)
		gameButton.tag = 3
		self.view.addSubview(gameButton)

		ownwordsButton.setTitle("ownwordsVC", for: .normal)
		ownwordsButton.setTitleColor(UIColor.black, for: .normal)
		ownwordsButton.backgroundColor = UIColor.green
		ownwordsButton.addTarget(self, action: #selector(ownwordsButtonPressed), for: .touchUpInside)
		ownwordsButton.tag = 4
		self.view.addSubview(ownwordsButton)

		playersButton.setTitle("playersVC", for: .normal)
		playersButton.setTitleColor(UIColor.black, for: .normal)
		playersButton.backgroundColor = UIColor.green
		playersButton.addTarget(self, action: #selector(playersButtonPressed), for: .touchUpInside)
		playersButton.tag = 5
		self.view.addSubview(playersButton)

		resultsButton.setTitle("resultsVC", for: .normal)
		resultsButton.setTitleColor(UIColor.black, for: .normal)
		resultsButton.backgroundColor = UIColor.green
		resultsButton.addTarget(self, action: #selector(resultsButtonPressed), for: .touchUpInside)
		resultsButton.tag = 6
		self.view.addSubview(resultsButton)

		sectionsButton.setTitle("sectionsVC", for: .normal)
		sectionsButton.setTitleColor(UIColor.black, for: .normal)
		sectionsButton.backgroundColor = UIColor.green
		sectionsButton.addTarget(self, action: #selector(sectionsButtonPressed), for: .touchUpInside)
		sectionsButton.tag = 7
		self.view.addSubview(sectionsButton)

		startNewPlayerButton.setTitle("startNewPlayerVC", for: .normal)
		startNewPlayerButton.setTitleColor(UIColor.black, for: .normal)
		startNewPlayerButton.backgroundColor = UIColor.green
		startNewPlayerButton.addTarget(self, action: #selector(startNewPlayerButtonPressed), for: .touchUpInside)
		startNewPlayerButton.tag = 8
		self.view.addSubview(startNewPlayerButton)

		startNewRoundButton.setTitle("startNewRoundVC", for: .normal)
		startNewRoundButton.setTitleColor(UIColor.black, for: .normal)
		startNewRoundButton.backgroundColor = UIColor.green
		startNewRoundButton.addTarget(self, action: #selector(startNewRoundButtonPressed), for: .touchUpInside)
		startNewRoundButton.tag = 9
		self.view.addSubview(startNewRoundButton)

		victoryButton.setTitle("victoryVC", for: .normal)
		victoryButton.setTitleColor(UIColor.black, for: .normal)
		victoryButton.backgroundColor = UIColor.green
		victoryButton.addTarget(self, action: #selector(victoryButtonPressed), for: .touchUpInside)
		victoryButton.tag = 10
		self.view.addSubview(victoryButton)
        
        
        settingsButton.setTitle("settingsVC", for: .normal)
        settingsButton.setTitleColor(UIColor.black, for: .normal)
        settingsButton.backgroundColor = UIColor.green
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        settingsButton.tag = 11
        self.view.addSubview(settingsButton)
        
        rulesButton.setTitle("rulesVC", for: .normal)
        rulesButton.setTitleColor(UIColor.black, for: .normal)
        rulesButton.backgroundColor = UIColor.green
        rulesButton.addTarget(self, action: #selector(rulesButtonPressed), for: .touchUpInside)
        rulesButton.tag = 12
        self.view.addSubview(rulesButton)


    }

}
