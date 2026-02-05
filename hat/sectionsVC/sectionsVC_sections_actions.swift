//
//  Untitled.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 24.06.2025.
//

import Foundation
import UIKit
import CoreData

extension sectionsVC {
    
    func showSectionsModesButtons() {
        selectSectionsButton.isHidden = !selectSectionsModeAdded
        selectAllSectionsButton.isHidden = !selectAllSectionsModeAdded
        //addSectionsButton.isHidden = !addSectionModeAdded
        contextActionsSectionsButton.isHidden = !contextSectionsModeAdded
        deleteAllSectionsButton.isHidden = !deleteAllSectionsModeAdded
        sectionsSearchBar.isHidden = !searchSectionsModeAdded
        sortSectionsOrderButton.isHidden = !sortSectionsManyFieldsModeAdded
        sortSectionsCollectionView.isHidden = !(sortSectionsOneFieldModeAdded || sortSectionsManyFieldsModeAdded)
        groupSectionsCollectionView.isHidden = !groupSectionsModeAdded
        
        // for navigation bar buttons
        //navigationItem.rightBarButtonItems?[0].isHidden = !addSectionModeAdded
        
        // если кнопки SELECT SELECT ALL -  с названием, а не с изображением
        //selectSectionsButton.setTitle(selectTitle, for: .normal)
        //selectAllSectionsButton.setTitle(selectAllTitle, for: .normal)
        
        // если кнопки SELECT SELECT ALL -  с названием, а не с изображением
        selectSectionsButton.setBackgroundImage(UIImage(named: "selectButton_\(cur_lang)"), for: .normal)
        selectAllSectionsButton.setBackgroundImage(UIImage(named: "selectAllButton_\(cur_lang)"), for: .normal)
        
        //режим с кнопкой Выбрать или без
        if selectSectionsOnlyInSelectingMode {
            //режим с кнопкой выбрать
            deselectAllSections()
            isSelectingSectionsMode = false
            selectSectionsButton.isHidden = false
            selectAllSectionsButton.isHidden = true
            
        }
        else {
            //режим БЕЗ кнопки выбрать
            isSelectingSectionsMode = true
            selectSectionsButton.isHidden = true
            selectAllSectionsButton.isHidden = false
        }
        
        // кнопка сортировка Ascending / Descending
        let buttonImage = sortSectionsOrderIsAscending ? "sortAscending" : "sortDescending"
        sortSectionsOrderButton.setBackgroundImage(UIImage(named: buttonImage), for: .normal)
        
    }
    
    //add
    @objc func addSectionsButtonPressed() {
        isEditSectionMode = false
        
        if sections.count >= maximumSectionsCount { // слишком много элементов
            let alertTitle = lang_scheme[cur_lang]?["alertMaxSectionsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMaxSectionsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "maximumCount", with: "\(maximumSectionsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // если добавляем элемент по одному полю
            if addOrEditSectionByOneField {
                // добавляем рандомного
                if addRandomSectionModeAdded {  addRandomSection() }
                // добавляем своего
                else { showAddOrEditSectionAlert(isEditById: false, id: 0) }
            }
            // если добавляем элемент по многим полям
            else { showAddOrEditSectionVC(isEditById: false, id: 0) }
        }
        
    }
    
    //add new random
    func addRandomSection() {
        guard let mc = moc else { return }
        let newSection = Section(context: mc)
        let sectionIds = sections.map({$0.id})
        let lastSectionId = sectionIds.max() ?? 0
        newSection.id = lastSectionId + 1
        newSection.name = getRandomItem(exsisitingItems: sections.map({$0.name ?? ""}), fromRandomArray: defaultSectionsNames)

        newSection.desc = lang_scheme[cur_lang]?["ownSectionDesc"] as? String ?? ""
        newSection.wordsCount = "0"
        newSection.image = "themeImage_own"
        newSection.product_id = "none"
        newSection.state = "unlocked"
        
        saveContext(moc: moc)
        
        // добавляем в own
        ownSectionsIds.append(Int(newSection.id))
        userDefaults.set(ownSectionsIds, forKey: "ownSectionsIds")
        
        getSections()
        updateSections()
    }
    
    //edit
    func editSelectedSection() {
        isEditSectionMode = true
        if addOrEditSectionByOneField { showAddOrEditSectionAlert(isEditById: false, id: 0) }
        else { showAddOrEditSectionVC(isEditById: false, id: 0) }
    }
    
    //edit by id
    func editSection(id: Int) {
        isEditSectionMode = true
        if addOrEditSectionByOneField { showAddOrEditSectionAlert(isEditById: true, id: id) }
        else { showAddOrEditSectionVC(isEditById: true, id: id) }
    }
    
    //add or edit by many fields
    func showAddOrEditSectionVC(isEditById: Bool, id: Int) {
        guard let currentAddOrEditSectionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addOrEditSectionVC") as? addOrEditSectionVC else { return }
        //sectionInfoViewController.modalPresentationStyle = .fullScreen
        currentAddOrEditSectionVC.isEditSectionMode = isEditSectionMode
        currentAddOrEditSectionVC.delegate = self
        if isEditSectionMode {
            if isEditById {
                guard let sectionIndex = sections.firstIndex(where: {$0.id == id}) else { return }
                currentAddOrEditSectionVC.section = sections[sectionIndex]
            } else {
                guard selectedSectionsIds.count == 1 else { return }
                guard let selectedSectionIndex = sections.firstIndex(where: {$0.id == selectedSectionsIds[0]}) else { return }
                currentAddOrEditSectionVC.section = sections[selectedSectionIndex]
            }
        } else {
            currentAddOrEditSectionVC.section = nil
        }
        self.navigationController?.pushViewController(currentAddOrEditSectionVC, animated: false)
        //self.present(currentAddOrEditSectionVC, animated: true, completion: nil) // показать поп-ап поверх текущего
        //self.navigationController?.present(currentAddOrEditSectionVC, animated: true, completion: nil)
    }
    
    func closeAddOrEditSectionVC() {
        getSections()
        getOwnSections()
        updateSections()
    }
    
    //add or edit by one field
    func showAddOrEditSectionAlert(isEditById: Bool, id: Int) {
        var currentSectionId = 0
        var oldSectionName = ""
        var placeholderText = ""
        
        var alertTitle = lang_scheme[cur_lang]?["alertAddSectionTitle"] as? String ?? ""
        var alertMessage = lang_scheme[cur_lang]?["alertAddSectionMessage"] as? String ?? ""
        
        if isEditSectionMode {
            //edit by index
            if isEditById { currentSectionId = id }
            //edit selected
            else {
                if selectedSectionsIds.count == 1 {
                    currentSectionId = selectedSectionsIds[0]
                }
            }
            oldSectionName = sections.first(where: { $0.id == currentSectionId })?.name ?? ""
            placeholderText = oldSectionName
            
            alertTitle = lang_scheme[cur_lang]?["alertEditSectionTitle"] as? String ?? ""
            alertMessage = (lang_scheme[cur_lang]?["alertEditSectionMessage"] as? String ?? "") + oldSectionName
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholderText
            textField.keyboardType = .default // Можно настроить тип клавиатуры
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            if let textField = alert.textFields?.first {
                textField.placeholder = placeholderText
                self.addOrEditSection(newSectionName: textField.text ?? "", oldSectionName: oldSectionName, id: currentSectionId)
            }
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addOrEditSection(newSectionName: String, oldSectionName: String, id: Int) {
        let addedElementTitle = lang_scheme[cur_lang]?["name"] as? String ?? ""
        
        let newSectionName = newSectionName.trimmingCharacters(in: .whitespacesAndNewlines)
        let textCount = newSectionName.count
        
        let sectionaNames = sections.map({$0.name?.lowercased() ?? ""})
        // такое название уже есть
        if newSectionName.lowercased() != oldSectionName.lowercased() && sectionaNames.contains(newSectionName.lowercased()) {
            var alertTitle = lang_scheme[cur_lang]?["alertIncorrectNameTitle"] as? String ?? ""
            alertTitle = alertTitle.replacingOccurrences(of: "currentTitle", with: addedElementTitle.lowercased())
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectNameMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle.lowercased()))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // некорректное число символов
        else if textCount < sectionNameMinimumSymbolsCount || textCount > sectionNameMaximumSymbolsCount {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle))
            alertMessage = alertMessage.replacingOccurrences(of: "minimumSymbolsCount", with: String(sectionNameMinimumSymbolsCount))
            alertMessage = alertMessage.replacingOccurrences(of: "maximumSymbolsCount", with: String(sectionNameMaximumSymbolsCount))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // нельзя использовать эти символы
        else if newSectionName.containsCharacters(charactersString: incorrectSymblosString) {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "incorrectSymblosString", with: incorrectSymblosString)
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            if isEditSectionMode {
                // изменяем выбранный
                guard let sectionIndex = sections.firstIndex(where: { $0.id == id }) else { return }
                sections[sectionIndex].name = newSectionName
                saveContext(moc: moc)
                
                getSections()
                updateSections()
            }
            else {
                // добавляем новый
                guard let mc = moc else { return }
                let newSection = Section(context: mc)
                let sectionIds = sections.map({$0.id})
                let lastSectionId = sectionIds.max() ?? 0
                newSection.id = lastSectionId + 1
                newSection.name = newSectionName
                
                newSection.desc = lang_scheme[cur_lang]?["ownSectionDesc"] as? String ?? ""
                newSection.wordsCount = "0"
                newSection.image = "themeImage_own"
                newSection.product_id = "none"
                newSection.state = "unlocked"
                
                saveContext(moc: moc)
                
                // добавляем в own
                ownSectionsIds.append(Int(newSection.id))
                userDefaults.set(ownSectionsIds, forKey: "ownSectionsIds")
                
                getSections()
                updateSections()
            }
        }
    }
    
    //#########################################################################
    //button enable
    func checkSectionsButtonsEnabled() {
        // если режим с кнопкой Выбрать
        if selectSectionsOnlyInSelectingMode {
            contextActionsSectionsButton.isEnabled = !selectedSectionsIds.isEmpty
            selectSectionsButton.isEnabled = filteredSections.count != 0
            selectAllSectionsButton.isEnabled = filteredSections.count != 0
            deleteAllSectionsButton.isEnabled = filteredSections.count != 0
            selectAllSectionsButton.isHidden = !isSelectingSectionsMode
        }
        // если режим БЕЗ кнопки Выбрать
        else {
            contextActionsSectionsButton.isEnabled = !selectedSectionsIds.isEmpty
            selectSectionsButton.isEnabled = filteredSections.count != 0
            selectAllSectionsButton.isEnabled = filteredSections.count != 0
            deleteAllSectionsButton.isEnabled = filteredSections.count != 0
            
            if selectedSectionsIds.isEmpty {
                //selectAllSectionsButton.setTitle(selectAllTitle, for: .normal)
                selectAllSectionsButton.setBackgroundImage(UIImage(named: "selectAllButton_\(cur_lang)"), for: .normal)
                isSelectingSectionsMode = true
            }
        }
    }
    
    //select
    @objc func selectSectionsButtonPressed() {
        // если режим с кнопкой Выбрать
        if selectSectionsOnlyInSelectingMode {
            if isSelectingSectionsMode {
                deselectAllSections()
                isSelectingSectionsMode = false
                //selectSectionsButton.setTitle(selectTitle, for: .normal)
                selectSectionsButton.setBackgroundImage(UIImage(named: "selectButton_\(cur_lang)"), for: .normal)
                selectAllSectionsButton.isHidden = false
            }
            else {
                //selectSectionsButton.setTitle(unselectTitle, for: .normal)
                selectSectionsButton.setBackgroundImage(UIImage(named: "unselectButton_\(cur_lang)"), for: .normal)
                isSelectingSectionsMode = true
                selectAllSectionsButton.isHidden = true
            }
            updateSections()
        }
        // если режим БЕЗ кнопки Выбрать - ничего не делаем
        else { }
    }
    
    //select all button
    @objc func selectAllSectionsButtonPressed() {
        // если режим с кнопкой Выбрать
        if selectSectionsOnlyInSelectingMode {
            selectAllSections()
            //selectSectionsButton.setTitle(unselectTitle, for: .normal)
            selectSectionsButton.setBackgroundImage(UIImage(named: "unselectButton_\(cur_lang)"), for: .normal)
            isSelectingSectionsMode = true
            updateSections()
        }
        // если режим БЕЗ кнопки Выбрать
        else {
            if isSelectingSectionsMode {
                selectAllSections()
                //selectAllSectionsButton.setTitle(unselectAllTitle, for: .normal)
                selectAllSectionsButton.setBackgroundImage(UIImage(named: "unselectAllButton_\(cur_lang)"), for: .normal)
                isSelectingSectionsMode = false
            }
            else {
                deselectAllSections()
                //selectAllSectionsButton.setTitle(selectAllTitle, for: .normal)
                selectAllSectionsButton.setBackgroundImage(UIImage(named: "selectAllButton_\(cur_lang)"), for: .normal)
                isSelectingSectionsMode = true
            }
            updateSections()
        }
    }
    //########################################################################
    
    func selectAllSections() {
        selectedSectionsIds.removeAll()
        
        //выбираем только до maximumSelectedSectionsCount
        for i in 0..<filteredSections.count {
            if selectedSectionsIds.count < maximumSelectedSectionsCount {
                selectedSectionsIds.append(Int(filteredSections[i].id))
            }
        }
        userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
        updateSections()
    }
    
    
    //добавляем до minimumSelectedCount
    func selectMinimumSelectedSections() {
        if selectedSectionsIds.count >= minimumSelectedSectionsCount { return }
        for i in 0..<filteredSections.count {
            if selectedSectionsIds.count < minimumSelectedSectionsCount {
                selectedSectionsIds.append(Int(filteredSections[i].id))
            }
        }
        userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
    }
    
    //deselect
    func deselectAllSections() {
        selectedSectionsIds.removeAll()
        userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
        updateSections()
    }
    
    //add selected to favorites
    func addSelectedSectionsToFavorites() {
        for sectionId in selectedSectionsIds {
            if !favoritesSectionsIds.contains(sectionId) {
                favoritesSectionsIds.append(sectionId)
            }
        }
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        updateSections()
    }
    
    //delete selected from favorites
    func deleteSelectedSectionsFromFavorites() {
        for sectionId in selectedSectionsIds {
            if let favoriteSectionIndex = favoritesSectionsIds.firstIndex(of: sectionId) {
                favoritesSectionsIds.remove(at: favoriteSectionIndex)
            }
        }
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        updateSections()
    }
    
    //add item to favorites
    func addSectionToFavorites(id: Int) {
        if !favoritesSectionsIds.contains(id) {
            favoritesSectionsIds.append(id)
        }
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        updateSections()
    }
    
    //delete item from favorites
    func deleteSectionFromFavorites(id: Int) {
        if let favoriteSectionIndex = favoritesSectionsIds.firstIndex(of: id) {
            favoritesSectionsIds.remove(at: favoriteSectionIndex)
        }
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        updateSections()
    }
    
    //switch item in favorites (on/off)
    func switchSectionInFavorites(id: Int) {
        if let favoriteSectionIndex = favoritesSectionsIds.firstIndex(of: id) {
            favoritesSectionsIds.remove(at: favoriteSectionIndex)
        } else {
            favoritesSectionsIds.append(id)
        }
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        updateSections()
    }
    
    //delete selected
    func deleteSelectedSections() {
        for sectionId in selectedSectionsIds {
            if let deletedElementIndex = sections.firstIndex(where: {$0.id == sectionId}) {
                let deletedElement = sections[deletedElementIndex]
                sections.remove(at: deletedElementIndex)
                moc?.delete(deletedElement)
                
                // удаляем из избранных
                if let favoriteSectionIndex = favoritesSectionsIds.firstIndex(of: sectionId) {
                    favoritesSectionsIds.remove(at: favoriteSectionIndex)
                }
                // удаляем из own
                if let ownSectionIndex = ownSectionsIds.firstIndex(of: sectionId) {
                    ownSectionsIds.remove(at: ownSectionIndex)
                }
                // удаляем из filtered
                if let filteredSectionIndex = filteredSections.firstIndex(of: deletedElement) {
                    filteredSections.remove(at: filteredSectionIndex)
                }
            }
        }
        
        selectedSectionsIds.removeAll()
        
        saveContext(moc: moc)
        userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        userDefaults.set(ownSectionsIds, forKey: "ownSectionsIds")
        
        deselectAllSections()
        updateSections()
    }
    
    func deleteSelectedSectionsAlert() {
        if (sections.count - selectedSectionsIds.count) < minimumSectionsCount { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinSectionsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinSectionsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumSectionsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteSelectedSectionsTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteSelectedSectionsMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteSelectedSections()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // delete by id
    func deleteSectionAlert(id: Int) {
        if (sections.count - 1) < minimumSectionsCount { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinSectionsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinSectionsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumSectionsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteSectionTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteSectionMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteSection(id: id)
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteSection(id: Int) {
        if let deletedElementIndex = sections.firstIndex(where: {$0.id == id}) {
            let deletedElement = sections[deletedElementIndex]
            sections.remove(at: deletedElementIndex)
            moc?.delete(deletedElement)
            
            // remove from selected
            if let selectedSectionIndex = selectedSectionsIds.firstIndex(of: id) {
                selectedSectionsIds.remove(at: selectedSectionIndex)
            }
            
            // remove from favorites
            if let favoriteSectionIndex = favoritesSectionsIds.firstIndex(of: id) {
                favoritesSectionsIds.remove(at: favoriteSectionIndex)
            }
            
            // remove from own
            if let ownSectionIndex = ownSectionsIds.firstIndex(of: id) {
                ownSectionsIds.remove(at: ownSectionIndex)
            }
            
            // remove from filtered
            if let filteredSectionIndex = filteredSections.firstIndex(of: deletedElement) {
                filteredSections.remove(at: filteredSectionIndex)
            }
            
            saveContext(moc: moc)
            userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
            userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
            userDefaults.set(ownSectionsIds, forKey: "ownSectionsIds")
            
            updateSections()
        }
    }
    
    //delete all
    @objc func deleteAllSectionsButtonPressed() {
        deleteAllSectionsAlert()
    }
    
    func deleteAllSectionsAlert() {
        if minimumSectionsCount > 0 { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinSectionsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinSectionsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumSectionsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteAllSectionsTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteAllSectionsMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteAllSections()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteAllSections() {
        for section in sections { moc?.delete(section) }
        saveContext(moc: moc)
        
        sections.removeAll()
        filteredSections.removeAll()
        selectedSectionsIds.removeAll()
        favoritesSectionsIds.removeAll()
        ownSectionsIds.removeAll()
        
        userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
        userDefaults.set(favoritesSectionsIds, forKey: "favoritesSectionsIds")
        userDefaults.set(ownSectionsIds, forKey: "ownSectionsIds")
        
        resetSearchBar(sectionsSearchBar)
        goToAllSections()
        updateSections()
    }
    
    //context
    @objc func contextActionsSectionsButtonPressed() {
        let contextActionsMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let addSelectedToFavoritesAction = UIAlertAction(title: addToFavoritesTitle, style: .default, handler:{ (UIAlertAction) in
            self.addSelectedSectionsToFavorites()
        })
        
        let deleteSelectedFromFavoritesAction = UIAlertAction(title: deleteFromFavoritesTitle, style: .default, handler:{ (UIAlertAction) in
            self.deleteSelectedSectionsFromFavorites()
        })
        
        let editSelectedAction = UIAlertAction(title: editTitle, style: .default, handler:{ (UIAlertAction) in
            self.editSelectedSection()
        })
        
        let deleteSelectedAction = UIAlertAction(title: deleteSelectedTitle, style: .default, handler:{ (UIAlertAction) in
            self.deleteSelectedSectionsAlert()
        })
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        
        
        if addToFavoritesSectionsModeAdded {
            contextActionsMenu.addAction(addSelectedToFavoritesAction)
            contextActionsMenu.addAction(deleteSelectedFromFavoritesAction)
        }
        
        if editSelectedSectionsModeAdded && selectedSectionsIds.count == 1 {
            contextActionsMenu.addAction(editSelectedAction)
        }
        
        if deleteSelectedSectionsModeAdded {
            contextActionsMenu.addAction(deleteSelectedAction)
        }
        
        contextActionsMenu.addAction(cancelAction)
        
        // On iPad, action sheets must be presented from a popover.
        contextActionsMenu.popoverPresentationController?.sourceView =  self.contextActionsSectionsButton
        contextActionsMenu.popoverPresentationController?.sourceRect = self.contextActionsSectionsButton.bounds
        
        self.present(contextActionsMenu, animated: true, completion: nil)
    }
    
    /*
     //sort
     @objc func sortSectionsSegmentedControlValueChanged(_ sender: UISegmentedControl) {
     sortSectionsIndex = sender.selectedSegmentIndex
     userDefaults.set(sortSectionsIndex, forKey: "sortSectionsIndex")
     updateSections()
     }
     */
    
    func sortSections() {
        /*
        switch selectedSortFieldSectionIndex {
        case 0:
            if sortSectionsOrderIsAscending { filteredSections.sort(by: { $0.name ?? "" < $1.name ?? "" }) }
            else { filteredSections.sort(by: { $0.name ?? "" > $1.name ?? "" }) }
        case 1:
            if sortSectionsOrderIsAscending { filteredSections.sort(by: { $0.surname ?? "" < $1.surname ?? "" }) }
            else { filteredSections.sort(by: { $0.surname ?? "" > $1.surname ?? "" }) }
        default: break
        }
        */
        switch selectedSortFieldSectionIndex {

        default: break
        }
    }
    
    @objc func sortSectionsOrderButtonPressed() {
        sortSectionsOrderIsAscending = !sortSectionsOrderIsAscending
        
        if sortSectionsOneFieldModeAdded {
            selectedSortFieldSectionIndex = sortSectionsOrderIsAscending ? 0 : 1
        }
        
        //for button with image
        let buttonImage = sortSectionsOrderIsAscending ? "sortAscending" : "sortDescending"
        sortSectionsOrderButton.setBackgroundImage(UIImage(named: buttonImage), for: .normal)
        updateSections()
    }
    
    /*
     //show groups
     @objc func groupSectionsSegmentedControlValueChanged(_ sender: UISegmentedControl) {
     groupSectionsIndex = sender.selectedSegmentIndex
     userDefaults.set(groupSectionsIndex, forKey: "groupSectionsIndex")
     updateSections()
     }
     */
    
    func getSectionsGroup() -> [Section] {
        switch groupFieldSections[selectedGroupFieldSectionIndex] {
        case "all": return sections
        case "own": return sections.filter { ownSectionsIds.contains(Int($0.id)) }
        case "favorites": return sections.filter { favoritesSectionsIds.contains(Int($0.id)) }
        case "selected": return sections.filter { selectedSectionsIds.contains(Int($0.id)) }
        default: return []
        }
    }
    
    func goToAllSections() {
        //groupSectionsSegmentedControl.selectedSegmentIndex = 0 // переходим на вкладку all
        selectedGroupFieldSectionIndex = 0
    }
    
    //filter by search
    func getSectionsGroupAndFilterBySearch() {
        var searchText = ""
        searchText = sectionsSearchBar.text ?? ""
        if !searchText.isEmpty {
            filteredSections = getSectionsGroup().filter {
                /*
                ($0.name ?? "").lowercased().contains(searchText.lowercased()) ||
                ($0.surname ?? "").lowercased().contains(searchText.lowercased())
                */
				($0.name ?? "").lowercased().contains(searchText.lowercased()) ||
				($0.desc ?? "").lowercased().contains(searchText.lowercased()) 
            }
        } else {
            filteredSections = getSectionsGroup()
        }
    }
    
    func updateSections() {
        getSectionsGroupAndFilterBySearch()
        sortSections()
        selectMinimumSelectedSections()
        sectionsTableView.reloadData()
        checkSectionsButtonsEnabled()
    }
    
}
