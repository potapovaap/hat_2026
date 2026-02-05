//
//
//  singleAppProject
//
//  Created by Alisa Potapova on 27.11.2025.
//  Copyright © 2025 Alisa Potapova. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class gameVC : UIViewController
	
{
	var backgroundImageView = UIImageView()
	var wordBackImageView = UIImageView()
	var wordBackTimeImageView = UIImageView()
	var playersLabel = UILabel()
	var roundTimeLabel = UILabel()
	var taskLabel = UILabel()
	var wordLabel = UILabel()
	var scoreLabel = UILabel()
	var wrongButton = UIButton()
	var rightButton = UIButton()
    var extraTimeButton = UIButton()
	

	var fontSize = CGFloat(20.0)

    
    // ADDITIONAL_INFO
    var curScore = 0
    var curTime = 0
    var curWord = ""
    var curTask = ""

    var prevIndexes: [Int] = []
    var curThemesWordsCount = 10
    var curSections = defaultSections
    var words = [String]()
    var ownWords = [String]()
    var all_words_for_selected_themes = [Int]()
    var all_words_with_own = [String]()
    
    var wordsForTheGame = [String]()
    var usedWordsIndexesForTheGame = [Int]()
    var resultWordsCount = defaultWordsCount
    
    var roundNumber = 0
    var roundsInGameIndex = 0
    var playerNumber = 0
    var nextPlayerNumber = 0
    var players = [Player]()
    var results = [Result]()
    
    var prevRightAnswerTime = defaultRoundTime
    var curGameWordsCount = 0//defaultWordsCount
    var gameResultStatus = "timeIsOver"
    //  настройки
    var roundTime = defaultRoundTime
    var wordsCount = defaultWordsCount
    var ownRoundTime = defaultRoundTime
    var ownWordsCount = defaultWordsCount
    var selectOwnRoundTime = defaultSelectOwnRoundTime
    var selectOwnWordsCount = defaultSelectOwnWordsCount
    var gameType = defaultGameType
    var moveTime = defaultMoveTime
    var extraTime = defaultExtraTime
    var commonLastWord = defaultCommonLastWord
    var gameWithTasks = defaultGameWithTasks
    var minusForMistake = defaultMinusForMistake
    var gameSounds = defaultGameSounds
    var plusForSpeed = defaultPlusForSpeed
    var roundStartsFirstPlayer = defaultRoundStartsFirstPlayer

    var timer = Timer()
    var count = 10
    var isPaused = false
    var isLastWord = false

    var rightSound : AVAudioPlayer?
    var wrongSound : AVAudioPlayer?
    var timerSound : AVAudioPlayer?
    
    var moc: NSManagedObjectContext?


}
