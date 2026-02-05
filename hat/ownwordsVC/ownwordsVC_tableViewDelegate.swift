import UIKit
extension ownwordsVC {
//############	TableView Delegate functions	###############################

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownwords.count

    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions = [UIContextualAction]()
        // Delete action
        let deleteAction = UIContextualAction(style: .normal, title: deleteTitle) { (action, view, completion) in
            self.deleteOwnwordAlert(id: Int(self.ownwords[indexPath.row].id))
            completion(true)
        }
        //deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = deleteActionColor
        contextualActions.append(deleteAction)
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: editTitle) { (action, view, completion) in
            self.editOwnword(id: Int(self.ownwords[indexPath.row].id))
            completion(true)
        }
        //editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = editActionColor
        contextualActions.append(editAction)

        return UISwipeActionsConfiguration(actions: contextualActions)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnwordTableViewCell", for: indexPath) as? OwnwordTableViewCell else { return UITableViewCell() }
            let ownword = ownwords[indexPath.row]

			let cellSelected = (selectedOwnwordId == ownword.id)
			cell.numberLabel.text = "\(indexPath.row + 1))"
			cell.nameLabel.text = ownword.name
			cell.editButton.setBackgroundImage(UIImage(named:"editRowButton"), for: .normal)
			cell.delegate = self
			cell.deleteButton.setBackgroundImage(UIImage(named:"deleteRowButton"), for: .normal)
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear


            return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			selectedOwnwordId = Int(ownwords[indexPath.row].id)
			userDefaults.set(selectedOwnwordId,forKey: "selectedOwnwordId")
			tableView.reloadData()

    }

    //изменение ячейки в таблице через текстовое поле в alert - если текстовое поле пусто или только пробелы, то блокируем кнопку ОК
    @objc func alertTextFieldDidChange(sender: UITextField, alert: UIAlertController) {
        let textCount = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        alert.actions[1].isEnabled = textCount > 0
    }



//############	End TableView Delegate functions	############################


}
