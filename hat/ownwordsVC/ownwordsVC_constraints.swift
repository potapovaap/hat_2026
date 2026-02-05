import UIKit
extension ownwordsVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, infoView, categoryLabel, wordsCountLabel, ownwordsTableView, deleteAllOwnwordsButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		infoView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true

		categoryLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 0).isActive = true

		wordsCountLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 0).isActive = true

		ownwordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		ownwordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		ownwordsTableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20).isActive = true
		ownwordsTableView.bottomAnchor.constraint(equalTo: deleteAllOwnwordsButton.topAnchor, constant: -20).isActive = true

		deleteAllOwnwordsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		deleteAllOwnwordsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
		deleteAllOwnwordsButton.widthAnchor.constraint(equalTo: deleteAllOwnwordsButton.heightAnchor, multiplier: 248/52).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		infoView.heightAnchor.constraint(equalToConstant: 44).isActive = true

		categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

		wordsCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

		deleteAllOwnwordsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/375*widthCoefiPhone).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		infoView.heightAnchor.constraint(equalToConstant: 54).isActive = true

		categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true

		wordsCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34).isActive = true

		deleteAllOwnwordsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248/500*widthCoefiPad).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, infoView, categoryLabel, wordsCountLabel, ownwordsTableView, deleteAllOwnwordsButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}
