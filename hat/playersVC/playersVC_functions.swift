import UIKit
import CoreData

extension playersVC {
    
    func getAllDidLoadPlayersParameters() {
        getPlayers()
        //selectedPlayersIds = (userDefaults.object(forKey: "selectedPlayersIds") as? [Int]) ?? defaultSelectedPlayersIds
    }

    func getPlayers() {
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        
        if players.isEmpty {
            if let mc = moc {
                for i in 0..<playerPresets.count {
                    let newItem = Player(context: mc)
                    newItem.id = Int32(playerPresets[i].id)
                    newItem.name = playerPresets[i].name
                    newItem.wordsRoundScore = Int32(playerPresets[i].wordsRoundScore)
                    newItem.gesturesRoundScore = Int32(playerPresets[i].gesturesRoundScore)
                    newItem.onewordRoundScore = Int32(playerPresets[i].onewordRoundScore)
                    newItem.drawingRoundScore = Int32(playerPresets[i].drawingRoundScore)
                    newItem.totalScore = Int32(playerPresets[i].totalScore)
                    players.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
    }
	
    
    @objc func clearResultsButtonPressed() {
        clearResultsAlert()
	}

    
}
