import UIKit
extension sectionsVC {

    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
		backgroundImageView.contentMode = .scaleAspectFit
		backgroundImageView.image = UIImage(named: "background")
		backgroundImageView.tag = 1
		self.view.addSubview(backgroundImageView)

		groupSectionsCollectionView.delegate = self
		groupSectionsCollectionView.dataSource = self
		groupSectionsCollectionView.backgroundColor = .clear
		groupSectionsCollectionView.contentInsetAdjustmentBehavior = .never
		groupSectionsCollectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: "GroupCollectionViewCell")
		if let flowLayout = groupSectionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
 			flowLayout.scrollDirection = .horizontal
			//flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // autoHeight or autoWidth for Cell
 		}
		groupSectionsCollectionView.tag = 2
		self.view.addSubview(groupSectionsCollectionView)

		sortSectionsOrderButton.contentMode = .scaleAspectFit
		sortSectionsOrderButton.setTitle(title(""), for: .normal)
		sortSectionsOrderButton.setBackgroundImage(UIImage(named: "sortOrderButton"), for: .normal)
		sortSectionsOrderButton.isHidden = false
		sortSectionsOrderButton.addTarget(self, action: #selector(sortSectionsOrderButtonPressed), for: .touchUpInside)
		sortSectionsOrderButton.tag = 3
		self.view.addSubview(sortSectionsOrderButton)

		sortSectionsCollectionView.delegate = self
		sortSectionsCollectionView.dataSource = self
		sortSectionsCollectionView.backgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
		sortSectionsCollectionView.layer.cornerRadius = 22
		sortSectionsCollectionView.layer.masksToBounds = true
		sortSectionsCollectionView.contentInsetAdjustmentBehavior = .never
		sortSectionsCollectionView.register(SortCollectionViewCell.self, forCellWithReuseIdentifier: "SortCollectionViewCell")
		if let flowLayout = sortSectionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
 			flowLayout.scrollDirection = .horizontal
			//flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // autoHeight or autoWidth for Cell
 		}
		sortSectionsCollectionView.tag = 4
		self.view.addSubview(sortSectionsCollectionView)

		searchSectionsButton.contentMode = .scaleAspectFit
		searchSectionsButton.setTitle(title(""), for: .normal)
		searchSectionsButton.setBackgroundImage(UIImage(named: "searchButton"), for: .normal)
		searchSectionsButton.isHidden = false
		searchSectionsButton.addTarget(self, action: #selector(searchSectionsButtonPressed), for: .touchUpInside)
		searchSectionsButton.tag = 5
		self.view.addSubview(searchSectionsButton)

		sectionsSearchBar.delegate = self
		sectionsSearchBar.searchTextField.textColor = UIColor(hex: "ffffff")
		sectionsSearchBar.searchTextField.backgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
		sectionsSearchBar.tintColor = UIColor(hex: "ffffff")
		sectionsSearchBar.backgroundImage = UIImage()
		sectionsSearchBar.placeholder = "search"
		sectionsSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: title("search"), attributes: [.foregroundColor: UIColor(hex: "ffffff")])
		sectionsSearchBar.searchTextField.layer.cornerRadius = 18
		sectionsSearchBar.searchTextField.layer.masksToBounds = true
		// цвет иконки поиска
		if let searchIcon = sectionsSearchBar.searchTextField.leftView as? UIImageView { searchIcon.tintColor = appMainColor }
		sectionsSearchBar.setValue(cancelTitle, forKey: "cancelButtonText")
		sectionsSearchBar.tag = 6
		self.view.addSubview(sectionsSearchBar)

		sectionsTableView.delegate = self
		sectionsTableView.dataSource = self
		sectionsTableView.backgroundColor = .clear
		sectionsTableView.separatorStyle = .none
		sectionsTableView.contentInsetAdjustmentBehavior = .never
		sectionsTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: "SectionTableViewCell")
		sectionsTableView.tag = 7
		self.view.addSubview(sectionsTableView)

		actionsSectionsPanelView.backgroundColor = UIColor(hex: "ff0800")
		actionsSectionsPanelView.layer.cornerRadius = 10
		actionsSectionsPanelView.clipsToBounds = true
		actionsSectionsPanelView.isHidden = true
		actionsSectionsPanelView.tag = 8
		self.view.addSubview(actionsSectionsPanelView)

		selectSectionsButton.contentMode = .scaleAspectFit
		selectSectionsButton.setTitle(title(""), for: .normal)
		selectSectionsButton.setBackgroundImage(UIImage(named: "selectButton_\(cur_lang)"), for: .normal)
		selectSectionsButton.isHidden = false
		selectSectionsButton.addTarget(self, action: #selector(selectSectionsButtonPressed), for: .touchUpInside)
		selectSectionsButton.tag = 9
		self.view.addSubview(selectSectionsButton)

		selectAllSectionsButton.contentMode = .scaleAspectFit
		selectAllSectionsButton.setTitle(title(""), for: .normal)
		selectAllSectionsButton.setBackgroundImage(UIImage(named: "selectAllButton"), for: .normal)
		selectAllSectionsButton.isHidden = false
		selectAllSectionsButton.addTarget(self, action: #selector(selectAllSectionsButtonPressed), for: .touchUpInside)
		selectAllSectionsButton.tag = 10
		self.view.addSubview(selectAllSectionsButton)

		contextActionsSectionsButton.contentMode = .scaleAspectFit
		contextActionsSectionsButton.setTitle(title(""), for: .normal)
		contextActionsSectionsButton.setBackgroundImage(UIImage(named: "contextActionsButton"), for: .normal)
		contextActionsSectionsButton.isHidden = false
		contextActionsSectionsButton.addTarget(self, action: #selector(contextActionsSectionsButtonPressed), for: .touchUpInside)
		contextActionsSectionsButton.tag = 11
		self.view.addSubview(contextActionsSectionsButton)

		deleteAllSectionsButton.contentMode = .scaleAspectFit
		deleteAllSectionsButton.setTitle(title(""), for: .normal)
		deleteAllSectionsButton.setBackgroundImage(UIImage(named: "deleteAllButton"), for: .normal)
		deleteAllSectionsButton.isHidden = false
		deleteAllSectionsButton.addTarget(self, action: #selector(deleteAllSectionsButtonPressed), for: .touchUpInside)
		deleteAllSectionsButton.tag = 12
		self.view.addSubview(deleteAllSectionsButton)

        let addSectionsButton = UIBarButtonItem(image: UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addSectionsButtonPressed))
		addSectionsButton.tag = 13
		navigationItem.rightBarButtonItems = [addSectionsButton]
    }

}
