//
//  Untitled.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 24.06.2025.
//

import Foundation
import UIKit
import CoreData

extension ownwordsVC {
    
    
    //add
    @objc func addOwnwordsButtonPressed() {
        isEditOwnwordMode = false
        
        if ownwords.count >= maximumOwnwordsCount { // слишком много элементов
            let alertTitle = lang_scheme[cur_lang]?["alertMaxOwnwordsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMaxOwnwordsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "maximumCount", with: "\(maximumOwnwordsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // если добавляем элемент по одному полю
            if addOrEditOwnwordByOneField {
                // добавляем рандомного
                if addRandomOwnwordModeAdded {  addRandomOwnword() }
                // добавляем своего
                else { showAddOrEditOwnwordAlert(isEditById: false, id: 0) }
            }
            // если добавляем элемент по многим полям
            else { showAddOrEditOwnwordVC(isEditById: false, id: 0) }
        }
        
    }
    
    //add new random
    func addRandomOwnword() {
        guard let mc = moc else { return }
        guard let newOwnwordName = getRandomItem(exsisitingItems: ownwords.map({$0.name ?? ""}), fromRandomArray: defaultOwnwordsNames) else { return }
        
        let newOwnword = Ownword(context: mc)
        let ownwordIds = ownwords.map({$0.id})
        let lastOwnwordId = ownwordIds.max() ?? 0
        newOwnword.id = lastOwnwordId + 1
        newOwnword.name = newOwnwordName
        saveContext(moc: moc)
        
        getOwnwords()
        updateOwnwords()
    }
    
    //edit by id
    func editOwnword(id: Int) {
        isEditOwnwordMode = true
        if addOrEditOwnwordByOneField { showAddOrEditOwnwordAlert(isEditById: true, id: id) }
        else { showAddOrEditOwnwordVC(isEditById: true, id: id) }
    }
    
    //add or edit by many fields
    func showAddOrEditOwnwordVC(isEditById: Bool, id: Int) {
        guard let currentAddOrEditOwnwordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addOrEditOwnwordVC") as? addOrEditOwnwordVC else { return }
        //ownwordInfoViewController.modalPresentationStyle = .fullScreen
        currentAddOrEditOwnwordVC.isEditOwnwordMode = isEditOwnwordMode
        currentAddOrEditOwnwordVC.delegate = self
        if isEditOwnwordMode {
            if isEditById {
                guard let ownwordIndex = ownwords.firstIndex(where: {$0.id == id}) else { return }
                currentAddOrEditOwnwordVC.ownword = ownwords[ownwordIndex]
            } else {
                guard selectedOwnwordsIds.count == 1 else { return }
                guard let selectedOwnwordIndex = ownwords.firstIndex(where: {$0.id == selectedOwnwordsIds[0]}) else { return }
                currentAddOrEditOwnwordVC.ownword = ownwords[selectedOwnwordIndex]
            }
        } else {
            currentAddOrEditOwnwordVC.ownword = nil
        }
        self.navigationController?.pushViewController(currentAddOrEditOwnwordVC, animated: false)
        //self.present(currentAddOrEditOwnwordVC, animated: true, completion: nil) // показать поп-ап поверх текущего
        //self.navigationController?.present(currentAddOrEditOwnwordVC, animated: true, completion: nil)
    }
    
    func closeAddOrEditOwnwordVC() {
        getOwnwords()
        updateOwnwords()
    }
    
    //add or edit by one field
    func showAddOrEditOwnwordAlert(isEditById: Bool, id: Int) {
        var currentOwnwordId = 0
        var oldOwnwordName = ""
        var placeholderText = ""
        
        var alertTitle = lang_scheme[cur_lang]?["alertAddOwnwordTitle"] as? String ?? ""
        var alertMessage = lang_scheme[cur_lang]?["alertAddOwnwordMessage"] as? String ?? ""
        
        if isEditOwnwordMode {
            //edit by index
            if isEditById { currentOwnwordId = id }
            //edit selected
            else {
                if selectedOwnwordsIds.count == 1 {
                    currentOwnwordId = selectedOwnwordsIds[0]
                }
            }
            oldOwnwordName = ownwords.first(where: { $0.id == currentOwnwordId })?.name ?? ""
            placeholderText = oldOwnwordName
            
            alertTitle = lang_scheme[cur_lang]?["alertEditOwnwordTitle"] as? String ?? ""
            alertMessage = (lang_scheme[cur_lang]?["alertEditOwnwordMessage"] as? String ?? "") + oldOwnwordName
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholderText
            textField.keyboardType = .default // Можно настроить тип клавиатуры
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            if let textField = alert.textFields?.first {
                textField.placeholder = placeholderText
                self.addOrEditOwnword(newOwnwordName: textField.text ?? "", oldOwnwordName: oldOwnwordName, id: currentOwnwordId)
            }
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addOrEditOwnword(newOwnwordName: String, oldOwnwordName: String, id: Int) {
        let addedElementTitle = lang_scheme[cur_lang]?["name"] as? String ?? ""
        
        let newOwnwordName = newOwnwordName.trimmingCharacters(in: .whitespacesAndNewlines)
        let textCount = newOwnwordName.count

        let ownwordaNames = ownwords.map({$0.name?.lowercased() ?? ""})
        // такое название уже есть
        if newOwnwordName.lowercased() != oldOwnwordName.lowercased() && ownwordaNames.contains(newOwnwordName.lowercased()) {
            var alertTitle = lang_scheme[cur_lang]?["alertIncorrectNameTitle"] as? String ?? ""
            alertTitle = alertTitle.replacingOccurrences(of: "currentTitle", with: addedElementTitle.lowercased())
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectNameMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle.lowercased()))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // некорректное число символов
        else if textCount < ownwordNameMinimumSymbolsCount || textCount > ownwordNameMaximumSymbolsCount {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle))
            alertMessage = alertMessage.replacingOccurrences(of: "minimumSymbolsCount", with: String(ownwordNameMinimumSymbolsCount))
            alertMessage = alertMessage.replacingOccurrences(of: "maximumSymbolsCount", with: String(ownwordNameMaximumSymbolsCount))
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        // нельзя использовать эти символы
        else if newOwnwordName.containsCharacters(charactersString: incorrectSymblosString) {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "incorrectSymblosString", with: incorrectSymblosString)
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            if isEditOwnwordMode {
                // изменяем выбранный
                guard let ownwordIndex = ownwords.firstIndex(where: { $0.id == id }) else { return }
                ownwords[ownwordIndex].name = newOwnwordName
                saveContext(moc: moc)
                            
                getOwnwords()
                updateOwnwords()
            }
            else {
                // добавляем новый
                guard let mc = moc else { return }
                let newOwnword = Ownword(context: mc)
                let ownwordIds = ownwords.map({$0.id})
                let lastOwnwordId = ownwordIds.max() ?? 0
                newOwnword.id = lastOwnwordId + 1
                newOwnword.name = newOwnwordName
               
                let selectedSectionId = userDefaults.object(forKey: "selectedSectionId") as? Int ?? 0
                let predicate = NSPredicate(format: "id = %d", selectedSectionId)
                let selectedSection = getEntity(type: Section.self, moc: moc, sortdDescriptors: [], predicates: [predicate]).first
                newOwnword.section = selectedSection
                
                saveContext(moc: moc)
                
                getOwnwords()
                updateOwnwords()
            }
        }
    }

    // delete by id
    func deleteOwnwordAlert(id: Int) {
        if (ownwords.count - 1) < minimumOwnwordsCount { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinOwnwordsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinOwnwordsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumOwnwordsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteOwnwordTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteOwnwordMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteOwnword(id: id)
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteOwnword(id: Int) {
        if let deletedElementIndex = ownwords.firstIndex(where: {$0.id == id}) {
            let deletedElement = ownwords[deletedElementIndex]
            ownwords.remove(at: deletedElementIndex)
            moc?.delete(deletedElement)
            saveContext(moc: moc)
            
            if let selectedOwnwordIdIndex = selectedOwnwordsIds.firstIndex(of: id) {
                selectedOwnwordsIds.remove(at: selectedOwnwordIdIndex)
            }
            
            updateOwnwords()
        }
    }
    
    //delete all
    @objc func deleteAllOwnwordsButtonPressed() {
        deleteAllOwnwordsAlert()
    }
    
    func deleteAllOwnwordsAlert() {
        if minimumOwnwordsCount > 0 { // слишком мало
            let alertTitle = lang_scheme[cur_lang]?["alertMinOwnwordsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertMinOwnwordsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "minimumCount", with: "\(minimumOwnwordsCount)")
            showAlertOk(title: alertTitle, message: alertMessage)
        }
        else {
            // точно удаляем?
            let alertTitle = lang_scheme[cur_lang]?["alertDeleteAllOwnwordsTitle"] as? String ?? ""
            let alertMessage = lang_scheme[cur_lang]?["alertDeleteAllOwnwordsMessage"] as? String ?? ""
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
                self.deleteAllOwnwords()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteAllOwnwords() {
        for ownword in ownwords { moc?.delete(ownword) }
        saveContext(moc: moc)
        ownwords.removeAll()
        selectedOwnwordsIds.removeAll()
        updateOwnwords()
    }
    
    func updateOwnwords() {
        userDefaults.set(selectedOwnwordsIds, forKey: "selectedOwnwordsIds")
        ownwordsTableView.reloadData()
        
        wordsCountLabel.text = (title("totalWord") + ": \(ownwords.count)").uppercased()
        
    }
    
    
}
