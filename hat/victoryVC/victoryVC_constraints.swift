import UIKit
extension victoryVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, victoryImageView, playersTableView, rateButton, menuButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		victoryImageView.widthAnchor.constraint(equalTo: victoryImageView.heightAnchor, multiplier: 269/199).isActive = true
		victoryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		victoryImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true

		playersTableView.topAnchor.constraint(equalTo: victoryImageView.bottomAnchor, constant: 16).isActive = true
		playersTableView.bottomAnchor.constraint(equalTo: rateButton.topAnchor, constant: -10).isActive = true

		rateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		rateButton.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: -10).isActive = true
		rateButton.widthAnchor.constraint(equalTo: rateButton.heightAnchor, multiplier: 248/52).isActive = true

		menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		menuButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
		menuButton.widthAnchor.constraint(equalTo: menuButton.heightAnchor, multiplier: 248/52).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		victoryImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 269/375).isActive = true

		playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

		rateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375).isActive = true

		menuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		victoryImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 269/500).isActive = true

		playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
		playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true

		rateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500).isActive = true

		menuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, victoryImageView, playersTableView, rateButton, menuButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}