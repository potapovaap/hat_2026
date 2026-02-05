import UIKit
extension gameVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, wordBackImageView, wordBackTimeImageView, playersLabel, roundTimeLabel, taskLabel, wordLabel, scoreLabel, wrongButton, rightButton, extraTimeButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		wordBackImageView.widthAnchor.constraint(equalTo: wordBackImageView.heightAnchor, multiplier: 445/416).isActive = true
		wordBackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		wordBackTimeImageView.widthAnchor.constraint(equalTo: wordBackTimeImageView.heightAnchor, multiplier: 445/79).isActive = true
		wordBackTimeImageView.centerXAnchor.constraint(equalTo: wordBackImageView.centerXAnchor, constant: 0).isActive = true
		wordBackTimeImageView.widthAnchor.constraint(equalTo: wordBackImageView.widthAnchor, multiplier: 445/445).isActive = true
		wordBackTimeImageView.topAnchor.constraint(equalTo: wordBackImageView.topAnchor, constant: 0).isActive = true

		playersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		roundTimeLabel.centerXAnchor.constraint(equalTo: wordBackTimeImageView.centerXAnchor, constant: 0).isActive = true

		taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		wrongButton.widthAnchor.constraint(equalTo: wrongButton.heightAnchor, multiplier: 145/152).isActive = true
		wrongButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		wrongButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true

		rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor, multiplier: 145/152).isActive = true
		rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

        extraTimeButton.widthAnchor.constraint(equalTo: extraTimeButton.heightAnchor, multiplier: 296/16).isActive = true
        extraTimeButton.bottomAnchor.constraint(equalTo: taskLabel.topAnchor, constant: -10).isActive = true
        extraTimeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        extraTimeButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		wordBackImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
		wordBackImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true

		playersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		playersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		//playersLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        playersLabel.bottomAnchor.constraint(equalTo: wordBackTimeImageView.topAnchor, constant: -22).isActive = true

		roundTimeLabel.bottomAnchor.constraint(equalTo: wordBackTimeImageView.bottomAnchor, constant: -2).isActive = true

		taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		taskLabel.topAnchor.constraint(equalTo: wordBackImageView.bottomAnchor, constant: 16).isActive = true

		wordLabel.leadingAnchor.constraint(equalTo: wordBackImageView.leadingAnchor, constant: 28).isActive = true
		wordLabel.trailingAnchor.constraint(equalTo: wordBackImageView.trailingAnchor, constant: -28).isActive = true
		wordLabel.centerYAnchor.constraint(equalTo: wordBackImageView.centerYAnchor, constant: 20).isActive = true

		scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

		wrongButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 145/375).isActive = true

		rightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 145/375).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		wordBackImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
		wordBackImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

		playersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
		playersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
		//playersLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26).isActive = true
        playersLabel.bottomAnchor.constraint(equalTo: wordBackTimeImageView.topAnchor, constant: -22).isActive = true

		roundTimeLabel.bottomAnchor.constraint(equalTo: wordBackTimeImageView.bottomAnchor, constant: -6).isActive = true

		taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
		taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
		taskLabel.topAnchor.constraint(equalTo: wordBackImageView.bottomAnchor, constant: 22).isActive = true

		wordLabel.leadingAnchor.constraint(equalTo: wordBackImageView.leadingAnchor, constant: 28).isActive = true
		wordLabel.trailingAnchor.constraint(equalTo: wordBackImageView.trailingAnchor, constant: -28).isActive = true
		wordLabel.centerYAnchor.constraint(equalTo: wordBackImageView.centerYAnchor, constant: 30).isActive = true

		scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true

		wrongButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 145/500).isActive = true

		rightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 145/500).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, wordBackImageView, wordBackTimeImageView, playersLabel, roundTimeLabel, wordLabel, scoreLabel, wrongButton, rightButton, extraTimeButton, taskLabel ] {
            view.bringSubviewToFront(itemView)
        }
    }

}
