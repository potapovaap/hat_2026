//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 29.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
import AVFAudio
//import StoreKit

class victoryVC : UIViewController,
	UITableViewDataSource,
	UITableViewDelegate
{
	var backgroundImageView = UIImageView()
	var victoryImageView = UIImageView()
	var playersTableView = UITableView()
	var rateButton = UIButton()
	var menuButton = UIButton()
	
	var players = [Player]()
    var sortedPlayers = [Player]()
	var selectedPlayerId = 1
	var moc: NSManagedObjectContext?

	var fontSize = CGFloat(20.0)

    var endGameSound : AVAudioPlayer?
}
