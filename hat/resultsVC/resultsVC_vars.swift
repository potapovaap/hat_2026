//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 28.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
import AVFAudio
//import StoreKit

class resultsVC : UIViewController,
	UITableViewDataSource,
	UITableViewDelegate,
	ResultTableViewCellDelegate
{
	var backgroundImageView = UIImageView()
	var timeoutLabel = UILabel()
	var playerLabel = UILabel()
	var scoreImageView = UIImageView()
	var scoreLabel = UILabel()
	var resultsTableView = UITableView()
	var whiteBottomImageView = UIImageView()
	var nextPlayerButton = UIButton()
	var goToMenuButton = UIButton()
	
	var results = [Result]()
	var selectedResultId = 1
	var moc: NSManagedObjectContext?

	var fontSize = CGFloat(20.0)
    
    // ADDITIONAL_INFO
    var gameResultStatus = "timeIsOver"
    var moveTime = defaultMoveTime
    var roundStartsFirstPlayer = defaultRoundStartsFirstPlayer
    var players = [Player]()
    var playerNumber = 0
    var gameResultPlayerName = "firstPlayer"
    var curScore = 0
    var roundsInGameIndex = 0

    var resultSound : AVAudioPlayer?

}
