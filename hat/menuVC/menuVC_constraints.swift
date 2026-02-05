import UIKit
extension menuVC {

    func setConstraints() {
        //let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, logoImageView, hatImageView, continueButton, newGameButton, themesButton, playersButton, rulesButton, modesButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 306/183).isActive = true
		logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		hatImageView.widthAnchor.constraint(equalTo: hatImageView.heightAnchor, multiplier: 280/280).isActive = true
		hatImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		

		continueButton.widthAnchor.constraint(equalTo: continueButton.heightAnchor, multiplier: 248/52).isActive = true
		continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		newGameButton.widthAnchor.constraint(equalTo: newGameButton.heightAnchor, multiplier: 248/52).isActive = true
		newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		newGameButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10).isActive = true

		themesButton.widthAnchor.constraint(equalTo: themesButton.heightAnchor, multiplier: 248/52).isActive = true
		themesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		themesButton.topAnchor.constraint(equalTo: newGameButton.bottomAnchor, constant: 10).isActive = true

		playersButton.widthAnchor.constraint(equalTo: playersButton.heightAnchor, multiplier: 248/52).isActive = true
		playersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		playersButton.topAnchor.constraint(equalTo: themesButton.bottomAnchor, constant: 10).isActive = true

		rulesButton.widthAnchor.constraint(equalTo: rulesButton.heightAnchor, multiplier: 56/70).isActive = true

		modesButton.widthAnchor.constraint(equalTo: modesButton.heightAnchor, multiplier: 70/70).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 306/375*widthCoefiPhone).isActive = true
		logoImageView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20).isActive = true

		hatImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 280/375*widthCoefiPhone).isActive = true

		continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375*widthCoefiPhone).isActive = true
		continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 2).isActive = true

		newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375*widthCoefiPhone).isActive = true

		themesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375*widthCoefiPhone).isActive = true

		playersButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375*widthCoefiPhone).isActive = true

		rulesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 56/375*widthCoefiPhone).isActive = true
		rulesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
		rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

		modesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 70/375*widthCoefiPhone).isActive = true
		modesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
		modesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
        hatImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 306/500*0.8).isActive = true
		logoImageView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10).isActive = true

		hatImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 280/500*widthCoefiPad).isActive = true

		continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500*widthCoefiPad).isActive = true
		continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true

		newGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500*widthCoefiPad).isActive = true

		themesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500*widthCoefiPad).isActive = true

		playersButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500*widthCoefiPad).isActive = true

        rulesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 56/500*widthCoefiPad).isActive = true
		rulesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
		rulesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true

        modesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 70/500*widthCoefiPad).isActive = true
		modesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
		modesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true

        hatImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15).isActive = true

        }
        
        // items order
        for itemView in [backgroundImageView, logoImageView, hatImageView, continueButton, newGameButton, themesButton, playersButton, rulesButton, modesButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}
