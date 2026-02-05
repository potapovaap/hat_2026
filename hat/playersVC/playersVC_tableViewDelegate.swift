import UIKit
extension playersVC {
//############	TableView Delegate functions	###############################

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count

    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions = [UIContextualAction]()
        // Delete action
        let deleteAction = UIContextualAction(style: .normal, title: deleteTitle) { (action, view, completion) in
            self.deletePlayerAlert(id: Int(self.players[indexPath.row].id))
            completion(true)
        }
        //deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = deleteActionColor
        contextualActions.append(deleteAction)
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: editTitle) { (action, view, completion) in
            self.editPlayer(id: Int(self.players[indexPath.row].id))
            completion(true)
        }
        //editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = editActionColor
        contextualActions.append(editAction)

        return UISwipeActionsConfiguration(actions: contextualActions)

    }


    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else { return UITableViewCell() }
            let player = players[indexPath.row]

			let cellSelected = (selectedPlayerId == player.id)
			cell.numberLabel.text = "#\(indexPath.row + 1)"
            cell.nameLabel.text = player.name?.uppercased()
			cell.wordsRoundScoreLabel.text = player.wordsRoundScore == 0 ? "-" : "\(player.wordsRoundScore)"
			cell.gesturesRoundScoreLabel.text = player.gesturesRoundScore == 0 ? "-" : "\(player.gesturesRoundScore)"
			cell.onewordRoundScoreLabel.text = player.onewordRoundScore == 0 ? "-" : "\(player.onewordRoundScore)"
			cell.drawingRoundScoreLabel.text = player.drawingRoundScore == 0 ? "-" : "\(player.drawingRoundScore)"
			cell.totalScoreLabel.text = "\(player.totalScore)"
         
        /*
            cell.wordsNoRoundImageView.isHidden = player.drawingRoundScore != 0
            cell.gesturesNoRoundImageView.isHidden = player.drawingRoundScore != 0
            cell.onewordNoRoundImageView.isHidden = player.drawingRoundScore != 0
            cell.drawingNoRoundImageView.isHidden = player.drawingRoundScore != 0
        */
        cell.wordsNoRoundImageView.isHidden = true
        cell.gesturesNoRoundImageView.isHidden = true
        cell.onewordNoRoundImageView.isHidden = true
        cell.drawingNoRoundImageView.isHidden = true
        
        
        
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear


            return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			selectedPlayerId = Int(players[indexPath.row].id)
			userDefaults.set(selectedPlayerId,forKey: "selectedPlayerId")
			tableView.reloadData()

    }

    //изменение ячейки в таблице через текстовое поле в alert - если текстовое поле пусто или только пробелы, то блокируем кнопку ОК
    @objc func alertTextFieldDidChange(sender: UITextField, alert: UIAlertController) {
        let textCount = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        alert.actions[1].isEnabled = textCount > 0
    }



//############	End TableView Delegate functions	############################


}
