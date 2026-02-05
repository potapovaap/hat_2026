import UIKit
extension victoryVC {
//############	TableView Delegate functions	###############################

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPlayers.count

    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualActions = [UIContextualAction]()

        return UISwipeActionsConfiguration(actions: contextualActions)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VictoryTableViewCell", for: indexPath) as? VictoryTableViewCell else { return UITableViewCell() }
            let player = sortedPlayers[indexPath.row]
			
			
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear

            var numberLabelText = ""
            var placeImage = "placeOtherPink"
            var totalBackViewColor = UIColor(hex: "E84070")
            switch indexPath.row {
            case 0:
                placeImage = "placeFirst"
                totalBackViewColor = UIColor(hex: "F4B33F")
            case 1:
                placeImage = "placeSecond"
                totalBackViewColor = UIColor(hex: "CCCCCC")
            case 2:
                placeImage = "placeThird"
                totalBackViewColor = UIColor(hex: "EF7E32")
            default:
                numberLabelText = "\(indexPath.row + 1)"
            }
        
            cell.placeImageView.image = UIImage(named: placeImage)
            cell.numberLabel.text = numberLabelText
            cell.totalBackView.backgroundColor = totalBackViewColor
            cell.nameLabel.text = player.name
            cell.totalScoreLabel.text = "\(player.totalScore)"
        
            return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			

    }

    //изменение ячейки в таблице через текстовое поле в alert - если текстовое поле пусто или только пробелы, то блокируем кнопку ОК
    @objc func alertTextFieldDidChange(sender: UITextField, alert: UIAlertController) {
        let textCount = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        alert.actions[1].isEnabled = textCount > 0
    }



//############	End TableView Delegate functions	############################


}
