import UIKit
extension emptyhatVC {

    func setConstraints() {
        //let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, infoView, okButton, titleLabel, textLabel] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 388/562).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		infoView.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.8).isActive = true
		infoView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.7).isActive = true
		infoView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: 0).isActive = true
		infoView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: -20).isActive = true

		okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
		okButton.widthAnchor.constraint(equalTo: okButton.heightAnchor, multiplier: 228/52).isActive = true
		okButton.centerYAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2).isActive = true

		titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

		textLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
		textLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8).isActive = true
		textLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 0).isActive = true
		//textLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -20).isActive = true
        //textLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
        titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20).isActive = true
            
		backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 388/375).isActive = true

		okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 228/375).isActive = true


        }
        // iPad constraints
        else {
            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 50).isActive = true
            
		backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 388/500).isActive = true

		okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 228/500).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, infoView, okButton, titleLabel, textLabel] {
            view.bringSubviewToFront(itemView)
        }
    }

}
