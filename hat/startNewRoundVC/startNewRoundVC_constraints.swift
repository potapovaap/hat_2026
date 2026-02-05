import UIKit
extension startNewRoundVC {

    func setConstraints() {
        //let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, whiteCenterImageView, roundDescLabel, roundNameLabel, roundNumberLabel, startButton, taskLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		whiteCenterImageView.widthAnchor.constraint(equalTo: whiteCenterImageView.heightAnchor, multiplier: 500/531).isActive = true

		roundDescLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		roundNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		roundNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
		startButton.widthAnchor.constraint(equalTo: startButton.heightAnchor, multiplier: 248/52).isActive = true
		


        let gameWithTasks = Bool(settings["gameWithTasks"] ?? "\(defaultGameWithTasks)") ?? defaultGameWithTasks
        if gameWithTasks {
            taskLabel.topAnchor.constraint(equalTo: whiteCenterImageView.centerYAnchor, constant: 30).isActive = true
            roundDescLabel.bottomAnchor.constraint(equalTo: taskLabel.topAnchor, constant: -20).isActive = true
            roundNameLabel.bottomAnchor.constraint(equalTo: roundDescLabel.topAnchor, constant: -20).isActive = true
            roundNumberLabel.bottomAnchor.constraint(equalTo: roundNameLabel.topAnchor, constant: -20).isActive = true
            startButton.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 25).isActive = true
        } else {
            roundDescLabel.topAnchor.constraint(equalTo: whiteCenterImageView.centerYAnchor, constant: 0).isActive = true
            roundNameLabel.bottomAnchor.constraint(equalTo: roundDescLabel.topAnchor, constant: -20).isActive = true
            roundNumberLabel.bottomAnchor.constraint(equalTo: roundNameLabel.topAnchor, constant: -20).isActive = true
            taskLabel.bottomAnchor.constraint(equalTo: roundNumberLabel.topAnchor, constant: -20).isActive = true
            startButton.topAnchor.constraint(equalTo: roundDescLabel.bottomAnchor, constant: 25).isActive = true
        }
        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		whiteCenterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
		whiteCenterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -65).isActive = true
		whiteCenterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 65).isActive = true

		roundDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		roundDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

		roundNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		roundNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

		roundNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		roundNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            
        taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

		startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		whiteCenterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
		whiteCenterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		whiteCenterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

		roundDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
		roundDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

		roundNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
		roundNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

		roundNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
		roundNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
            
        taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -24).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

		startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, whiteCenterImageView, roundDescLabel, roundNameLabel, roundNumberLabel, startButton, taskLabel] {
            view.bringSubviewToFront(itemView)
        }
    }

}
