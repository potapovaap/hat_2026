import UIKit
extension emptyhatVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "emptyHatBack")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		infoView.backgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.8)
		infoView.layer.cornerRadius = 20
		infoView.clipsToBounds = true
		infoView.tag = 2
		self.view.addSubview(infoView)

		okButton.contentMode = .scaleAspectFit
		okButton.setTitle("", for: .normal)
		okButton.setBackgroundImage(UIImage(named: "okButton"), for: .normal)
		okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
		okButton.tag = 3
		self.view.addSubview(okButton)

		fontSize = iphoneConstraints ? 24 : 36
		titleLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		titleLabel.textColor = UIColor(hex: "464CFA")
		titleLabel.textAlignment = .center
		//titleLabel.text = title("titleLabel")
		titleLabel.tag = 4
		self.view.addSubview(titleLabel)

		fontSize = iphoneConstraints ? 16 : 26
		textLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		textLabel.textColor = UIColor(hex: "464CFA")
		textLabel.textAlignment = .center
		//textLabel.text = title("textLabel")
		textLabel.numberOfLines = 6
		textLabel.tag = 5
        //textLabel.line
		self.view.addSubview(textLabel)


    }

}
