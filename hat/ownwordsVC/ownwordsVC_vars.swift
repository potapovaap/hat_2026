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

class ownwordsVC : UIViewController,
	UITableViewDataSource,
	UITableViewDelegate,
	OwnwordTableViewCellDelegate,
	addOrEditOwnwordsDelegate
{
	var backgroundImageView = UIImageView()
	var infoView = UIView()
	var categoryLabel = UILabel()
	var wordsCountLabel = UILabel()
	var ownwordsTableView = UITableView()
	var deleteAllOwnwordsButton = UIButton()
	
	var ownwords = [Ownword]()


    // ownwords for add random
    let defaultOwnwordsNames = ["alex", "max"] // or [String]()
    // ownwords for add or edit by one field
    var addOrEditOwnwordByOneField = true
    var addRandomOwnwordModeAdded = false
    let ownwordNameMinimumSymbolsCount = 1
    let ownwordNameMaximumSymbolsCount = 30
    // ownwords for edit
    var selectedOwnwordsIds = [Int]()
    var isEditOwnwordMode = true
    var editOwnwordActionBackgroundColor = UIColor(hex: "FF1100")
    // ownwords for delete
    var deleteOwnwordActionBackgroundColor = UIColor(hex: "FFFF00")
    // ownwords for select if view backgroud color changed
    let ownwordsViewBackgroundColor = UIColor(hex: "FFFF00")
    let ownwordsViewBackgroundColorSelected = UIColor(hex: "FF1100")
	let minimumOwnwordsCount = 0
	let maximumOwnwordsCount = 30
	var selectedOwnwordId = 1
	var moc: NSManagedObjectContext?

	var fontSize = CGFloat(20.0)


}
