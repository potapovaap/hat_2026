import UIKit
import CoreData

extension sectionsVC {
    
    func getAllDidLoadGroupfieldsectionsParameters() {
        groupFieldSections = (userDefaults.object(forKey: "groupFieldSections") as? [String]) ?? defaultGroupfieldsections
        //selectedGroupfieldsectionsIndexes = (userDefaults.object(forKey: "selectedGroupfieldsectionsIndexes") as? [Int]) ?? defaultSelectedGroupfieldsectionsIndexes
    }
    
    func getAllDidLoadSortfieldsectionsParameters() {
        sortFieldSections = (userDefaults.object(forKey: "sortFieldSections") as? [String]) ?? defaultSortfieldsections
        //selectedSortfieldsectionsIndexes = (userDefaults.object(forKey: "selectedSortfieldsectionsIndexes") as? [Int]) ?? defaultSelectedSortfieldsectionsIndexes
    }
	@objc func searchSectionsButtonPressed() {
		
	}

    func favoriteButtonPressedInCell(onCell cell: SectionTableViewCell) {
        if let indexPath = sectionsTableView.indexPath(for: cell) {
            let section = filteredSections[indexPath.row]
            switchSectionInFavorites(id: Int(section.id))
            sectionsTableView.reloadData()
        }
    }
    func addWordsButtonPressedInCell(onCell cell: SectionTableViewCell) {
        if let indexPath = sectionsTableView.indexPath(for: cell) {
            let section = filteredSections[indexPath.row]
            addOwnWords(id: Int(section.id))
            sectionsTableView.reloadData()
        }
    }
    
    func getAllDidLoadSectionsParameters() {
        getSections()
        selectedSectionsIds = (userDefaults.object(forKey: "selectedSectionsIds") as? [Int]) ?? defaultSelectedSectionsIds
        favoritesSectionsIds = (userDefaults.object(forKey: "favoritesSectionsIds") as? [Int]) ?? []
        ownSectionsIds = (userDefaults.object(forKey: "ownSectionsIds") as? [Int]) ?? []
        
        sortSectionsOrderIsAscending = (userDefaults.object(forKey: "sortSectionsOrderIsAscending") as? Bool) ?? true
        selectedSortFieldSectionIndex = (userDefaults.object(forKey: "selectedSortFieldSectionIndex") as? Int) ?? 0
        selectedGroupFieldSectionIndex = (userDefaults.object(forKey: "selectedGroupFieldSectionIndex") as? Int) ?? 0
        
        setInApps()
    }

    //get
    func getSections() {
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        sections = getEntity(type: Section.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        
        if sections.isEmpty {
            if let mc = moc {
                for i in 0..<sectionPresets.count {
                    let newItem = Section(context: mc)
                    newItem.id = Int32(sectionPresets[i].id)
                    newItem.image = sectionPresets[i].image
                    newItem.name = sectionPresets[i].name
                    newItem.desc = sectionPresets[i].desc
                    newItem.wordsCount = sectionPresets[i].wordsCount
                    sections.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
    }

    //get own
    func getOwnSections() {
        ownSectionsIds = (userDefaults.object(forKey: "ownSectionsIds") as? [Int]) ?? []
    }
    
    func setInApps(){
        productIds.removeAll()
        productIds.append(product_id)
    }

    func restoreSections(){
        guard let restoredIds = userDefaults.object(forKey: "restoredIds") as? [String] else { return }
        for inAppId in restoredIds {
            userDefaults.setValue("unlocked", forKey: inAppId)
        }
        updateSections()
        showAlertOk(title: restorePurchasesTitle, message: restorePurchasesMessage)
    }

    func purchaseSection() {
        guard let purchasedId = userDefaults.object(forKey: "purchasedId") as? String else { return }
        userDefaults.setValue("unlocked", forKey: purchasedId)
        updateSections()
        
        showAlertOk(title: completePurchasesTitle, message: completePurchasesMessage)
    }

    func trySectionForFree() {
        goMenuVC()
    }


}
