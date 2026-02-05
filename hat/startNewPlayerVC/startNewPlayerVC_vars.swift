//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 28.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
//import StoreKit

class startNewPlayerVC : UIViewController
	
{
	var backgroundImageView = UIImageView()
	var whiteCenterImageView = UIImageView()
	var infoLabel = UILabel()
	var firstPlayerLabel = UILabel()
	var secondPlayerLabel = UILabel()
	var startButton = UIButton()
    var taskLabel = UILabel()

	var fontSize = CGFloat(20.0)

    // ADDITIONAL_INFO
    var roundNumber = 0
    var roundsInGameIndex = 0
    var playerNumber = 0
}
