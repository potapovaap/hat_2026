import UIKit
extension ownwordsVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		infoView.backgroundColor = UIColor(hex: "40AF4B")
		infoView.tag = 2
		self.view.addSubview(infoView)

		fontSize = iphoneConstraints ? 15 : 18
		categoryLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		categoryLabel.textColor = UIColor(hex: "ffffff")
		categoryLabel.textAlignment = .left
		//categoryLabel.text = title("categoryLabel")
		categoryLabel.tag = 3
		self.view.addSubview(categoryLabel)

		fontSize = iphoneConstraints ? 15 : 18
		wordsCountLabel.font = UIFont(name: "Helvetica-Bold", size: fontSize)
		wordsCountLabel.textColor = UIColor(hex: "ffffff")
		wordsCountLabel.textAlignment = .right
		//wordsCountLabel.text = title("wordsCountLabel")
		wordsCountLabel.tag = 4
		self.view.addSubview(wordsCountLabel)

		ownwordsTableView.delegate = self
		ownwordsTableView.dataSource = self
		ownwordsTableView.backgroundColor = .clear
		ownwordsTableView.contentInsetAdjustmentBehavior = .never
		ownwordsTableView.register(OwnwordTableViewCell.self, forCellReuseIdentifier: "OwnwordTableViewCell")
		ownwordsTableView.tag = 5
		self.view.addSubview(ownwordsTableView)

		deleteAllOwnwordsButton.contentMode = .scaleAspectFit
		deleteAllOwnwordsButton.setTitle("", for: .normal)
		deleteAllOwnwordsButton.setBackgroundImage(UIImage(named: "deleteAllButton"), for: .normal)
		deleteAllOwnwordsButton.addTarget(self, action: #selector(deleteAllOwnwordsButtonPressed), for: .touchUpInside)
		deleteAllOwnwordsButton.tag = 6
		self.view.addSubview(deleteAllOwnwordsButton)

        let addOwnwordsButton = UIBarButtonItem(image: UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addOwnwordsButtonPressed))
		addOwnwordsButton.tag = 7
		navigationItem.rightBarButtonItems = [addOwnwordsButton]
        

    }

}
