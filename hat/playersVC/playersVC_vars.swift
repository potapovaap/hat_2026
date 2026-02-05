//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 01.12.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class playersVC : UIViewController,
	UITableViewDataSource,
	UITableViewDelegate,
	addOrEditPlayersDelegate
{
	var backgroundImageView = UIImageView()
	var infoView = UIView()
	var gameTypeLabel = UILabel()
	var playersTableView = UITableView()
	var whiteBottomImageView = UIImageView()
	var clearResultsButton = UIButton()
	
	var players = [Player]()


    // players for add random
    var defaultPlayersNames = ["alex", "max"] // or [String]()
    // players for add or edit by one field
    var addOrEditPlayerByOneField = true
    var addRandomPlayerModeAdded = true
    let playerNameMinimumSymbolsCount = 1
    let playerNameMaximumSymbolsCount = 24
    // players for edit
    var selectedPlayersIds = [Int]()
    var isEditPlayerMode = true
    var editPlayerActionBackgroundColor = UIColor(hex: "FF1100")
    // players for delete
    var deletePlayerActionBackgroundColor = UIColor(hex: "FFFF00")
    // players for select if view backgroud color changed
    let playersViewBackgroundColor = UIColor(hex: "FFFF00")
    let playersViewBackgroundColorSelected = UIColor(hex: "FF1100")
	let minimumPlayersCount = 2
	let maximumPlayersCount = 20
	var selectedPlayerId = 1
	var moc: NSManagedObjectContext?

	var fontSize = CGFloat(20.0)

    var gameType = defaultGameType
    var playerNumber = 0
    
    //NEW
    var isDeletePlayersWithMinimumPlayersCount = true
    
}
