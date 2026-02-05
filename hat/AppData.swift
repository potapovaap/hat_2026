import Foundation
import UIKit

// МЕНЯЕМ
let cur_lang = "ru"
let currentAppVersion = "1.0.0"
let currentDataVersion = "v_1.0.0"
let appName = "Kit test"
let shareText = "Kit test: "
let demoState = Demo.inapp
let app_id = 1577373615
let full_app_id = 1577373433
let bundle_id = "com.potapova.hat"
let product_id = "com.potapova.hat.fullVersion"
let freeSectionsIds = [1]
let withAllSections = false

var rulesPagesCount = 15
var withParentalGate = false

var productIds = [String]()
var iphoneConstraints = true
let appType = "navApp"


// SETTINGS
let userDefaults = UserDefaults.standard
var settings = (userDefaults.object(forKey: "settings") as? [String: String]) ?? [String: String]()

// FONTS
let appFont = "Helvetica"
let appFontBold = "Helvetica-Bold"
let appFontItalic = "Helvetica-Italic"
let defaultFont = UIFont.systemFont(ofSize: 17)

// COLORS
let appMainColor = UIColor(hex: "E84070") //pink

let rulesAllPagesCircleColor = UIColor(hex: "FFFFFF")
let rulesCurrentPageCircleColor = appMainColor

let settingsColor = UIColor(hex: "40AF4B")
let settingsLabelTextColor = UIColor(hex: "ffffff")
let settingsTextFieldColor = UIColor(hex: "555555")
let settingsNameLabelColor = UIColor(hex: "111111")
let settingsHeaderLabelColor = UIColor(hex: "222222")
let settingsTextFieldBackgroundColor = UIColor(hex: "333333")

let deleteColor = UIColor.red
let deleteActionColor = UIColor(hex: "E84070")
let editActionColor = UIColor(hex: "40AF4B")

// NAVIGATION BAR
let navigationBarBackgroundColor = appMainColor
let navigationBarTintColor = UIColor.white
let navigationBarTitleColor = UIColor.white
let navigationBarFont = UIFont(name: appFontBold, size: 17) ?? UIFont.systemFont(ofSize: 22)

// OTHER
let incorrectSymblosString = ";~`^@#$%№&*|\'/[](){}<>"

let widthCoefiPhone = 0.8
let widthCoefiPad = 0.75

enum Demo {
    case free
    case full
    case inapp
}
