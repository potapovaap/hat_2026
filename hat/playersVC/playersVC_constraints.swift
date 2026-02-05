import UIKit
extension playersVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, infoView, gameTypeLabel, playersTableView, whiteBottomImageView, clearResultsButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		infoView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true

		gameTypeLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 0).isActive = true
		gameTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		playersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		playersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		playersTableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20).isActive = true
		playersTableView.bottomAnchor.constraint(equalTo: whiteBottomImageView.topAnchor, constant: 20).isActive = true

		whiteBottomImageView.widthAnchor.constraint(equalTo: whiteBottomImageView.heightAnchor, multiplier: 500/230).isActive = true
		whiteBottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		whiteBottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		whiteBottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

		clearResultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		clearResultsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
		clearResultsButton.widthAnchor.constraint(equalTo: clearResultsButton.heightAnchor, multiplier: 292/52).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		infoView.heightAnchor.constraint(equalToConstant: 44).isActive = true

		clearResultsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/375*widthCoefiPhone).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		infoView.heightAnchor.constraint(equalToConstant: 54).isActive = true

		clearResultsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 292/500*widthCoefiPad).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, infoView, gameTypeLabel, playersTableView, whiteBottomImageView, clearResultsButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}
