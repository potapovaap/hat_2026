import UIKit
extension sectionsVC {

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        for itemView in [backgroundImageView, groupSectionsCollectionView, sortSectionsOrderButton, sortSectionsCollectionView, searchSectionsButton, sectionsSearchBar, sectionsTableView, actionsSectionsPanelView, selectSectionsButton, selectAllSectionsButton, contextActionsSectionsButton, deleteAllSectionsButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // common constraints
		backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true

		groupSectionsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		groupSectionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		groupSectionsCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true

		sortSectionsOrderButton.widthAnchor.constraint(equalTo: sortSectionsOrderButton.heightAnchor, multiplier: 44/44).isActive = true

		searchSectionsButton.widthAnchor.constraint(equalTo: searchSectionsButton.heightAnchor, multiplier: 44/44).isActive = true

		selectSectionsButton.widthAnchor.constraint(equalTo: selectSectionsButton.heightAnchor, multiplier: 108/34).isActive = true
		selectSectionsButton.centerYAnchor.constraint(equalTo: actionsSectionsPanelView.centerYAnchor, constant: 0).isActive = true

		selectAllSectionsButton.widthAnchor.constraint(equalTo: selectAllSectionsButton.heightAnchor, multiplier: 40/40).isActive = true
		selectAllSectionsButton.centerYAnchor.constraint(equalTo: actionsSectionsPanelView.centerYAnchor, constant: 0).isActive = true

		contextActionsSectionsButton.widthAnchor.constraint(equalTo: contextActionsSectionsButton.heightAnchor, multiplier: 40/40).isActive = true
		contextActionsSectionsButton.centerYAnchor.constraint(equalTo: actionsSectionsPanelView.centerYAnchor, constant: 0).isActive = true

		deleteAllSectionsButton.widthAnchor.constraint(equalTo: deleteAllSectionsButton.heightAnchor, multiplier: 248/52).isActive = true
		deleteAllSectionsButton.centerYAnchor.constraint(equalTo: actionsSectionsPanelView.centerYAnchor, constant: 0).isActive = true


        
        // iPhone constraints
        if iphoneConstraints {
            
		backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

		groupSectionsCollectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true

		sortSectionsOrderButton.centerYAnchor.constraint(equalTo: sortSectionsCollectionView.centerYAnchor, constant: 0).isActive = true
		sortSectionsOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		sortSectionsOrderButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sortSectionsCollectionView.leadingAnchor.constraint(equalTo: sortSectionsOrderButton.trailingAnchor, constant: 10).isActive = true
		sortSectionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		sortSectionsCollectionView.topAnchor.constraint(equalTo: sectionsSearchBar.bottomAnchor, constant: 0).isActive = true
		sortSectionsCollectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true

		searchSectionsButton.centerYAnchor.constraint(equalTo: sectionsSearchBar.centerYAnchor, constant: 0).isActive = true
		searchSectionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		searchSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sectionsSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		sectionsSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		sectionsSearchBar.topAnchor.constraint(equalTo: groupSectionsCollectionView.bottomAnchor, constant: 0).isActive = true
		sectionsSearchBar.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sectionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		sectionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		sectionsTableView.topAnchor.constraint(equalTo: groupSectionsCollectionView.bottomAnchor, constant: 14).isActive = true
		sectionsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true

		actionsSectionsPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
		actionsSectionsPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
		actionsSectionsPanelView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16).isActive = true
		actionsSectionsPanelView.heightAnchor.constraint(equalToConstant: 0).isActive = true

		selectSectionsButton.leadingAnchor.constraint(equalTo: actionsSectionsPanelView.leadingAnchor, constant: 8).isActive = true
		selectSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		selectAllSectionsButton.leadingAnchor.constraint(equalTo: selectSectionsButton.trailingAnchor, constant: 8).isActive = true
		selectAllSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		contextActionsSectionsButton.trailingAnchor.constraint(equalTo: deleteAllSectionsButton.leadingAnchor, constant: -8).isActive = true
		contextActionsSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		deleteAllSectionsButton.trailingAnchor.constraint(equalTo: actionsSectionsPanelView.trailingAnchor, constant: -8).isActive = true
		deleteAllSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true


        }
        // iPad constraints
        else {
            
		backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

		groupSectionsCollectionView.heightAnchor.constraint(equalToConstant: 54).isActive = true

		sortSectionsOrderButton.centerYAnchor.constraint(equalTo: sortSectionsCollectionView.centerYAnchor, constant: 0).isActive = true
		sortSectionsOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		sortSectionsOrderButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sortSectionsCollectionView.leadingAnchor.constraint(equalTo: sortSectionsOrderButton.trailingAnchor, constant: 10).isActive = true
		sortSectionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		sortSectionsCollectionView.topAnchor.constraint(equalTo: sectionsSearchBar.bottomAnchor, constant: 0).isActive = true
		sortSectionsCollectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true

		searchSectionsButton.centerYAnchor.constraint(equalTo: sectionsSearchBar.centerYAnchor, constant: 0).isActive = true
		searchSectionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		searchSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sectionsSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		sectionsSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0).isActive = true
		sectionsSearchBar.topAnchor.constraint(equalTo: groupSectionsCollectionView.bottomAnchor, constant: 0).isActive = true
		sectionsSearchBar.heightAnchor.constraint(equalToConstant: 0).isActive = true

		sectionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
		sectionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
		sectionsTableView.topAnchor.constraint(equalTo: groupSectionsCollectionView.bottomAnchor, constant: 22).isActive = true
		sectionsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true

		actionsSectionsPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		actionsSectionsPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		actionsSectionsPanelView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16).isActive = true
		actionsSectionsPanelView.heightAnchor.constraint(equalToConstant: 0).isActive = true

		selectSectionsButton.leadingAnchor.constraint(equalTo: actionsSectionsPanelView.leadingAnchor, constant: 10).isActive = true
		selectSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		selectAllSectionsButton.leadingAnchor.constraint(equalTo: selectSectionsButton.trailingAnchor, constant: 16).isActive = true
		selectAllSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		contextActionsSectionsButton.trailingAnchor.constraint(equalTo: deleteAllSectionsButton.leadingAnchor, constant: -10).isActive = true
		contextActionsSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

		deleteAllSectionsButton.trailingAnchor.constraint(equalTo: actionsSectionsPanelView.trailingAnchor, constant: -10).isActive = true
		deleteAllSectionsButton.heightAnchor.constraint(equalToConstant: 0).isActive = true


        }
        
        // items order
        for itemView in [backgroundImageView, groupSectionsCollectionView, sortSectionsOrderButton, sortSectionsCollectionView, searchSectionsButton, sectionsSearchBar, sectionsTableView, actionsSectionsPanelView, selectSectionsButton, selectAllSectionsButton, contextActionsSectionsButton, deleteAllSectionsButton] {
            view.bringSubviewToFront(itemView)
        }
    }

}