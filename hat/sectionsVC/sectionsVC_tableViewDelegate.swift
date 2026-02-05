import UIKit
extension sectionsVC {
//############	TableView Delegate functions	###############################

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSections.count

    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight = CGFloat(150)
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        if iphoneConstraints {
            switch UIDevice().type {
            case .iPhone5S,.iPhoneSE: rowHeight = 140
            default: break
            }
        } else {
            rowHeight = 230
        }
        return rowHeight

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions = [UIContextualAction]()
        let section = filteredSections[indexPath.row]
        if !ownSectionsIds.contains(Int(section.id)) { return UISwipeActionsConfiguration(actions: contextualActions) }
        // Delete action
        let deleteAction = UIContextualAction(style: .normal, title: deleteTitle) { (action, view, completion) in
            self.deleteSectionAlert(id: Int(self.filteredSections[indexPath.row].id))
            completion(true)
        }
        //deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = deleteActionColor
        contextualActions.append(deleteAction)
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: editTitle) { (action, view, completion) in
            self.editSection(id: Int(self.filteredSections[indexPath.row].id))
            completion(true)
        }
        //editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = editActionColor
        contextualActions.append(editAction)

        return UISwipeActionsConfiguration(actions: contextualActions)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell", for: indexPath) as? SectionTableViewCell else { return UITableViewCell() }
        let section = filteredSections[indexPath.row]
        
        
        
        var curColor = "Yellow"
        switch (indexPath.row + 1) % 4 {
        case 1:curColor = "Yellow"
        case 2: curColor = "Orange"
        case 3: curColor = "Pink"
        case 0: curColor = "Green"
        default: curColor = "Yellow"
        }
        
        cell.backgroundImageView.image = UIImage(named: "themeBack\(curColor)")
        cell.imageImageView.image = UIImage(named: section.image ?? "themeImage")
        
        cell.nameLabel.text = section.name?.uppercased()
        cell.descLabel.text = section.desc?.uppercased()
        cell.questionsCountLabel.text = title("categoryWordsCount").uppercased() + (section.wordsCount ?? "")
        cell.favoriteButton.setBackgroundImage(favoritesSectionsIds.contains(Int(section.id)) ? UIImage(named: "favoriteButtonOn\(curColor)") : UIImage(named: "favoriteButtonOff"), for: .normal)
        cell.addWordsButton.setBackgroundImage(UIImage(named: "addWordsButton\(curColor)"), for: .normal)
        cell.delegate = self
        cell.lockedImageView.image = UIImage(named: section.state == "locked" ? "locked" : "unlocked")
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        setShadows(forLabel: cell.nameLabel)
        setShadows(forLabel: cell.descLabel)
        setShadows(forLabel: cell.questionsCountLabel)
        
        
        if ownSectionsIds.contains(Int(section.id)) {
            cell.descLabel.text = lang_scheme[cur_lang]?["ownTheme"] as? String ?? ""
            cell.questionsCountLabel.text = title("categoryWordsCount").uppercased() + String(getWordsCountForOwnSection(id: Int(section.id)))
            cell.imageImageView.image = UIImage(named: "themeOwn")
            cell.addWordsButton.isHidden = false
            cell.addWordsButton.isEnabled = true
        } else {
            cell.addWordsButton.isHidden = true
            cell.addWordsButton.isEnabled = false
        }
        
        
        /*
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
        */
        
        
        var cellSelected = selectedSectionsIds.contains(Int(section.id))
        cell.selectedImageView.image = UIImage(named: cellSelected ? "selectThemeCircle\(curColor)" : "themeUnSelected")

        
        return cell

    }
    
    func getWordsCountForOwnSection(id: Int) -> Int {
            let predicate = NSPredicate(format: "section.id = %d", id)
            let ownwords = getEntity(type: Ownword.self, moc: moc, sortdDescriptors: [], predicates: [predicate])
            return ownwords.count
        }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = filteredSections[indexPath.row]
        let inAppState = userDefaults.object(forKey: product_id) as? String ?? "locked"

        let iapLocked = (demoState == .inapp && inAppState == "locked")
        let notFreeSection = !( freeSectionsIds.contains(where: { $0 == section.id }) || ownSectionsIds.contains(where: { $0 == section.id }) )
        
        //если выбрали тему Свои слова и Количество своих слов < 2
                let qCount = getWordsCountForOwnSection(id: Int(section.id))
                        if (ownSectionsIds.contains(where: { $0 == section.id }) && qCount < 2) {
                            showAlertOk(title: lang_scheme[cur_lang]?["addOwnWordsTitle"] as? String ?? "", message: lang_scheme[cur_lang]?["addOwnWordsForThemeMessage"] as? String ?? "")
                            return
                        }


        if notFreeSection && iapLocked {
            userDefaults.set(Int(section.id),forKey: "selectedSectionId")
            showDownload()
        } else {
                        // если включена опция - выбор элементов только в режиме выбора, то выбираем элемент только в режиме выбора, иначе не выбираем элемент (return) ИЛИ делаем что-то другое - переход на другой VC
            if selectSectionsOnlyInSelectingMode && !isSelectingSectionsMode {
                return
            }
            let selectedSection = filteredSections[indexPath.row]
            selectedSectionId = Int(selectedSection.id)
            if let selectedSectionIndex = selectedSectionsIds.firstIndex(of: selectedSectionId) {
                if selectedSectionsIds.count > minimumSelectedSectionsCount {
                    selectedSectionsIds.remove(at: selectedSectionIndex)
                }
            } else {
                if selectedSectionsIds.count < maximumSelectedSectionsCount {
                    selectedSectionsIds.append(selectedSectionId)
                }
            }
            userDefaults.set(selectedSectionsIds, forKey: "selectedSectionsIds")
            updateSections()

        }

    }

    //изменение ячейки в таблице через текстовое поле в alert - если текстовое поле пусто или только пробелы, то блокируем кнопку ОК
    @objc func alertTextFieldDidChange(sender: UITextField, alert: UIAlertController) {
        let textCount = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        alert.actions[1].isEnabled = textCount > 0
    }


    func showDownload() {
        if let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "downloadVC") as? downloadVC {
            popupVC.iapDelegate = self
            popupVC.modalPresentationStyle = .overFullScreen
            self.present(popupVC, animated: true, completion: nil)
        }
    }


//############	End TableView Delegate functions	############################


}
