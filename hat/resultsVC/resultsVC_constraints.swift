import UIKit
extension resultsVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, timeoutLabel, playerLabel, scoreImageView, scoreLabel, resultsTableView, whiteBottomImageView, nextPlayerButton, goToMenuButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		timeoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		timeoutLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true

		//playerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		playerLabel.topAnchor.constraint(equalTo: timeoutLabel.bottomAnchor, constant: 14).isActive = true

		scoreImageView.widthAnchor.constraint(equalTo: scoreImageView.heightAnchor, multiplier: 158/158).isActive = true
		scoreImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		scoreImageView.topAnchor.constraint(equalTo: playerLabel.bottomAnchor, constant: 14).isActive = true

		scoreLabel.centerXAnchor.constraint(equalTo: scoreImageView.centerXAnchor, constant: 0).isActive = true
		scoreLabel.centerYAnchor.constraint(equalTo: scoreImageView.centerYAnchor, constant: 0).isActive = true

		resultsTableView.topAnchor.constraint(equalTo: scoreImageView.bottomAnchor, constant: 14).isActive = true
		resultsTableView.bottomAnchor.constraint(equalTo: nextPlayerButton.topAnchor, constant: -14).isActive = true

		whiteBottomImageView.widthAnchor.constraint(equalTo: whiteBottomImageView.heightAnchor, multiplier: 500/230).isActive = true
		whiteBottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		whiteBottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		

		nextPlayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		nextPlayerButton.widthAnchor.constraint(equalTo: nextPlayerButton.heightAnchor, multiplier: 292/52).isActive = true
		

		goToMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		goToMenuButton.widthAnchor.constraint(equalTo: goToMenuButton.heightAnchor, multiplier: 292/52).isActive = true
		


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		scoreImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 158/375).isActive = true

		resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

		nextPlayerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/375).isActive = true

		goToMenuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/375).isActive = true
            
            nextPlayerButton.topAnchor.constraint(equalTo: whiteBottomImageView.topAnchor, constant: -2).isActive = true
            goToMenuButton.topAnchor.constraint(equalTo: nextPlayerButton.bottomAnchor, constant: 10).isActive = true
            
            whiteBottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            
            playerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            playerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		scoreImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 158/500).isActive = true

		resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
            
            playerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            playerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true

		nextPlayerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/500).isActive = true

		goToMenuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/500).isActive = true

            nextPlayerButton.bottomAnchor.constraint(equalTo: goToMenuButton.topAnchor, constant: -16).isActive = true
            goToMenuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
            
            whiteBottomImageView.centerYAnchor.constraint(equalTo: goToMenuButton.topAnchor, constant: 0).isActive = true
        }
        
        // items order
        for itemView in [backgroundImageView, timeoutLabel, playerLabel, scoreImageView, scoreLabel, resultsTableView, whiteBottomImageView, nextPlayerButton, goToMenuButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}
