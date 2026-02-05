import UIKit
extension testScreensVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [menuButton, emptyhatButton, gameButton, ownwordsButton, playersButton, resultsButton, sectionsButton, startNewPlayerButton, startNewRoundButton, victoryButton, rulesButton, settingsButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		menuButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		menuButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		menuButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true

		emptyhatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		emptyhatButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		emptyhatButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		emptyhatButton.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 10).isActive = true

		gameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		gameButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		gameButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		gameButton.topAnchor.constraint(equalTo: emptyhatButton.bottomAnchor, constant: 10).isActive = true

		ownwordsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		ownwordsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		ownwordsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		ownwordsButton.topAnchor.constraint(equalTo: gameButton.bottomAnchor, constant: 10).isActive = true

		playersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		playersButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		playersButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		playersButton.topAnchor.constraint(equalTo: ownwordsButton.bottomAnchor, constant: 10).isActive = true

		resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		resultsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		resultsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		resultsButton.topAnchor.constraint(equalTo: playersButton.bottomAnchor, constant: 10).isActive = true

		sectionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		sectionsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		sectionsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		sectionsButton.topAnchor.constraint(equalTo: resultsButton.bottomAnchor, constant: 10).isActive = true

		startNewPlayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		startNewPlayerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		startNewPlayerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		startNewPlayerButton.topAnchor.constraint(equalTo: sectionsButton.bottomAnchor, constant: 10).isActive = true

		startNewRoundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		startNewRoundButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		startNewRoundButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		startNewRoundButton.topAnchor.constraint(equalTo: startNewPlayerButton.bottomAnchor, constant: 10).isActive = true

		victoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		victoryButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
		victoryButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		victoryButton.topAnchor.constraint(equalTo: startNewRoundButton.bottomAnchor, constant: 10).isActive = true

        rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        rulesButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        rulesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rulesButton.topAnchor.constraint(equalTo: victoryButton.bottomAnchor, constant: 10).isActive = true
        
        
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsButton.topAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: 10).isActive = true
        
        // iPhone constraints
        if iphoneConstraints {
            

        }
        // iPad constraints
        else {
            

        }
        
        // items order
        for itemView in [menuButton, emptyhatButton, gameButton, ownwordsButton, playersButton, resultsButton, sectionsButton, startNewPlayerButton, startNewRoundButton, victoryButton, rulesButton, settingsButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}
