import UIKit
extension sectionsVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDidLoadParameters()
        
        setBackButton() //params: withTitle withCustomImage customImageName backToMenu
        setAttributes()
        setConstraints()
        
        updateControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = (lang_scheme[cur_lang]?["sectionsVCTitle"] as? String ?? "navigationBar title").uppercased()
        
        updateControls()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }

    override func backButtonPressed() {
        //some action here
        
        goBackTo(backToMenu: false)
    }

    func getAllDidLoadParameters() {
		moc = getContext()

		getAllDidLoadGroupfieldsectionsParameters()
		groupSectionsCollectionView.reloadData()
		getAllDidLoadSortfieldsectionsParameters()
		sortSectionsCollectionView.reloadData()
		getAllDidLoadSectionsParameters()

    }

    //ADDITIONAL INFO
    func updateControls() {
        updateSelectedSectionsIdsForSelectedOwnWordCategories()
		groupSectionsCollectionView.reloadData()
		sortSectionsCollectionView.reloadData()
		showSectionsModesButtons()
		updateSections()
        

    }
    
    //ADDITIONAL INFO
    //удаляем из выбранных категорий свою категорию в которой меньше 2х слов:
    func updateSelectedSectionsIdsForSelectedOwnWordCategories() {
        for section in sections {
            // СВОИ КАТЕГОРИИ - ВЫБРАНА ИЛИ НЕТ
            let qCount = getWordsCountForOwnSection(id: Int(section.id))
            var cellSelected = selectedSectionsIds.contains(Int(section.id))
            // если выбрана эта категория и эта категория своя и количество слов < 2 и  -- то исключаем эту категорию
            if ( cellSelected && qCount < 2 && ownSectionsIds.contains(where: { $0 == section.id }) ) {
                // исключаем эту категорию
                if let selectedSectionIndex = selectedSectionsIds.firstIndex(of: Int(section.id)) {
                    selectedSectionsIds.remove(at: selectedSectionIndex)
                    cellSelected = false
                }
                // если выбранных категорий стало ноль, то делаем выбранную категорию одну
                if selectedSectionsIds.count == 0 {
                    selectedSectionsIds.append(1)
                }
                userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
            }
        }
    }
    

}
