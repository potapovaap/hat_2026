import UIKit
extension ownwordsVC {
    func editButtonPressedInCell(onCell cell: OwnwordTableViewCell) {
        if let indexPath = ownwordsTableView.indexPath(for: cell) {
            let ownword = ownwords[indexPath.row]
            editOwnword(id: Int(ownword.id))
            ownwordsTableView.reloadData()
        }
    }
    func deleteButtonPressedInCell(onCell cell: OwnwordTableViewCell) {
        if let indexPath = ownwordsTableView.indexPath(for: cell) {
            let ownword = ownwords[indexPath.row]
            deleteOwnwordAlert(id: Int(ownword.id))
            ownwordsTableView.reloadData()
        }
    }
    
    func getAllDidLoadOwnwordsParameters() {
        getOwnwords()
        //selectedOwnwordsIds = (userDefaults.object(forKey: "selectedOwnwordsIds") as? [Int]) ?? defaultSelectedOwnwordsIds
    }

    func getOwnwords() {
        let selectedSectionId = userDefaults.object(forKey: "selectedSectionId") as? Int ?? 0
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        let predicate = NSPredicate(format: "section.id = %d", selectedSectionId)
        ownwords = getEntity(type: Ownword.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [predicate])
        wordsCountLabel.text = (title("totalWord") + ": \(ownwords.count)").uppercased()
        
        let sectionPredicate = NSPredicate(format: "id = %d", selectedSectionId)
        let curSection = getEntity(type: Section.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [sectionPredicate]).first
        categoryLabel.text = (title("category") + ": \(curSection?.name ?? "-")").uppercased()
    }


}
