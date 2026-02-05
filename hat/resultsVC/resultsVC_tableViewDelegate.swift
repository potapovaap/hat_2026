import UIKit
extension resultsVC {
//############	TableView Delegate functions	###############################

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count

    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions = [UIContextualAction]()
        let guessedActionTitle = lang_scheme[cur_lang]?["guessedAction"] as? String ?? ""
        let guessedAction = UIContextualAction(style: .normal, title: guessedActionTitle) { (action, view, completion) in
            self.guessedActionPressed(index: indexPath.row)
            completion(true)
        }
        //guessedAction.image = UIImage(systemName: "star")
        guessedAction.backgroundColor = editActionColor
        contextualActions.append(guessedAction)

        let notguessedActionTitle = lang_scheme[cur_lang]?["notguessedAction"] as? String ?? ""
        let notguessedAction = UIContextualAction(style: .normal, title: notguessedActionTitle) { (action, view, completion) in
            self.notguessedActionPressed(index: indexPath.row)
            completion(true)
        }
        //notguessedAction.image = UIImage(systemName: "star")
        notguessedAction.backgroundColor = deleteActionColor
        contextualActions.append(notguessedAction)

        return UISwipeActionsConfiguration(actions: contextualActions)
        
        //пока не добавляем функцию изменения ответов так как слишком сложно менять очки в одиночной игре:
        //return UISwipeActionsConfiguration(actions: [UIContextualAction]())

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
            let result = results[indexPath.row]

			//let cellSelected = (selectedResultId == result.id)
			cell.correctImageView.image = UIImage(named: result.isCorrect ? "resultScoreCircleRight" : "resultScoreCircleWrong")
			cell.wordLabel.text = result.word
			cell.guessButton.setBackgroundImage(UIImage(named:"editRowButton"), for: .normal)
            
            //пока убираем кнопку изменения ответов так как слишком сложно менять очки в одиночной игре:
            //cell.guessButton.isHidden = true
        
        
			cell.delegate = self
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear


            return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			selectedResultId = Int(results[indexPath.row].id)
			userDefaults.set(selectedResultId,forKey: "selectedResultId")
			tableView.reloadData()

    }

    //изменение ячейки в таблице через текстовое поле в alert - если текстовое поле пусто или только пробелы, то блокируем кнопку ОК
    @objc func alertTextFieldDidChange(sender: UITextField, alert: UIAlertController) {
        let textCount = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        alert.actions[1].isEnabled = textCount > 0
    }



//############	End TableView Delegate functions	############################


}
