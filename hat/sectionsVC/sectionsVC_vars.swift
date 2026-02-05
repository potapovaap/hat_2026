//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 01.12.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class sectionsVC : UIViewController,
	UICollectionViewDataSource,
	UICollectionViewDelegate,
	UICollectionViewDelegateFlowLayout,
	UISearchBarDelegate,
	UITableViewDataSource,
	UITableViewDelegate,
	SectionTableViewCellDelegate,
	IAPManagerDelegate,
	addOrEditSectionsDelegate
{
	var backgroundImageView = UIImageView()
	var groupSectionsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
	var sortSectionsOrderButton = UIButton()
	var sortSectionsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
	var searchSectionsButton = UIButton()
	var sectionsSearchBar = UISearchBar()
	var sectionsTableView = UITableView()
	var actionsSectionsPanelView = UIView()
	var selectSectionsButton = UIButton()
	var selectAllSectionsButton = UIButton()
	var contextActionsSectionsButton = UIButton()
	var deleteAllSectionsButton = UIButton()
	
	var groupFieldSections = [String]()
	var defaultGroupfieldsections = ["all", "favorites", "own", "selected"]
	var selectedGroupFieldSectionIndex = 0
	var sortFieldSections = [String]()
	var defaultSortfieldsections = ["name", "desc", "questionsCount"]
	var selectedSortFieldSectionIndex = 0

    // sections current modes
	var selectSectionsModeAdded = true
	var selectAllSectionsModeAdded = false
	var selectSectionsOnlyInSelectingMode = false
	var addSectionModeAdded = true
	var addOrEditSectionByOneField = true
	var addRandomSectionModeAdded = false
	var editSectionModeAdded = true
	var editSelectedSectionsModeAdded = true
	var deleteSectionModeAdded = true
	var deleteSelectedSectionsModeAdded = true
	var deleteAllSectionsModeAdded = false
	var contextSectionsModeAdded = false
	var addToFavoritesSectionsModeAdded = true
	var searchSectionsModeAdded = false
	var groupSectionsModeAdded = true
	var sortSectionsOneFieldModeAdded = false
	var sortSectionsManyFieldsModeAdded = false
	var sortOrderButtonIsHidden = false

    
    var sections = [Section]()
    var filteredSections: [Section] = []
    var favoritesSectionsIds = [Int]()
    var ownSectionsIds = [Int]()
    let defaultSectionsNames = ["name1", "name2", "name3"] // or [String]()
    
    var selectedSectionId = 1
    var selectedSectionIndex = 1
    var isSelectingSectionsMode = false
    var isEditSectionMode = true
    var sortSectionsOrderIsAscending = true

    let sectionNameMinimumSymbolsCount = 1
    let sectionNameMaximumSymbolsCount = 16

    var moc: NSManagedObjectContext?

	var selectedSectionsIds = [Int]()
	//var defaultSelectedSectionsIds = [Int]()
	var minimumSelectedSectionsCount = 1
	var maximumSelectedSectionsCount = 1000000
	let minimumSectionsCount = 0
	let maximumSectionsCount = 1000000

	var fontSize = CGFloat(20.0)


}
