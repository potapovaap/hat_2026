//
//  Extension.swift
//  tabAppProject
//
//  Created by Alisa Potapova on 05.10.2020.
//  Copyright © 2020 Alisa Potapova. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI
import CoreData

extension UIViewController {
    
    func insertSegments(segmentedControl: UISegmentedControl, segmentedControlItems: [String]) {
        for i in 0..<segmentedControlItems.count {
            let item = segmentedControlItems[i]
            let itemName = lang_scheme[cur_lang]?["\(item)"] as? String ?? item
            segmentedControl.insertSegment(withTitle: itemName, at: i, animated: false)
        }
    }
    
    func userDefaultsGetInt(forKey: String, defaultValue: Int) -> Int {
        if let object = UserDefaults.standard.object(forKey: forKey) as? Int {
            return Int(object)
        } else { return defaultValue }
    }
    
    func userDefaultsGetBool(forKey: String, defaultValue: Bool) -> Bool {
        if let object = UserDefaults.standard.object(forKey: forKey) as? Bool {
            return Bool(object)
        } else { return defaultValue }
    }
    
    func getItemsTitles(items: [String]) -> [String] {
        var itemsNames = [String]()
        for item in items {
            let itemName = lang_scheme[cur_lang]?["\(item)"] as? String ?? item
            itemsNames.append(itemName)
        }
        return itemsNames
    }

    func dismissController() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func showPopupVC(_ popupVC_ID: String) {
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: popupVC_ID)
        addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
    }

    func goNextVC(_ nextVC_ID: String) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: nextVC_ID)
        
        if appType == "navApp" || appType == "tabApp" {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            //nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: false, completion: nil)
        }
    }
    func popToVC(toVC: AnyClass){
        if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: toVC) }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    func goBackVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goMenuVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func goBackTo(backToMenu: Bool = true) {
        if backToMenu { goMenuVC() }
        else { goBackVC() }
    }
    
    @objc func backButtonPressed() {
        goBackTo()
    }
    
    func setBackButton(withTitle: Bool = false, withCustomImage: Bool = true, customImageName: String = "buttonBack") {
        let buttonImage = withCustomImage ? UIImage(named: customImageName) : UIImage(systemName: "chevron.left")
        var backButton = UIBarButtonItem(title: backTitle, style: .plain, target: self, action: #selector(backButtonPressed))
        
        if withTitle {
            backButton = UIBarButtonItem(title: backTitle, style: .plain, target: self, action: #selector(backButtonPressed))
        } else {
            backButton = UIBarButtonItem(image: buttonImage?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        }
        
        //if #available(iOS 26.0, *) { backButton.hidesSharedBackground = true }
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func removePopupVC(){
        view.removeFromSuperview()
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openFullVersion() {
        let url_str = "itms-apps://itunes.apple.com/us/app/apple-store/id\(full_app_id)?mt=8"
        openURL(url_str)
    }
    
    func rateApp() {
        let url_str = "itms-apps:itunes.apple.com/us/app/apple-store/id\(app_id)?mt=8&action=write-review"
        openURL(url_str)
    }
    
    
    
    func openURL(_ url_str: String){
        if let url = URL(string: url_str),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened) {
                    //print("App Store Opened")
                }
            }
        } else {
            //print("Can't Open URL on Simulator")
        }
    }
   
    func showAlertOk(title: String, message: String) {
        //создаем alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // добавляем кнопку
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   
    /*
    func showAlertConfirm(title: String, message: String, cancelFunc: (()  -> Void)? = nil, okFunc: @escaping (_ param: Int)  -> Void, param: Int){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //отмена
        alert.addAction(UIAlertAction(title: attributeTitles["cancel_\(curLang)"], style: .default) { (_) in
            cancelFunc?()
        })
        //если нажали ОК
        alert.addAction(UIAlertAction(title: attributeTitles["ok_\(curLang)"], style: .default) { (_) in okFunc(param)
        })
        self.present(alert, animated: true, completion: nil)
    }*/
    
    func minutesIsValid(_ textField: UITextField)->Double? {
        if textFieldNotEmpty(textField) {
           if let count = Int(textField.text!), (count >= 1 && count <= 999) {
                return Double(count)
            }
        }
        showAlertOk(title: "Некорректное число", message: "Минуты должны быть в диапазоне от 1 до 999")
        return nil
    }
    func questionsCountIsValid(_ textField: UITextField)->Double? {
       if textFieldNotEmpty(textField) {
           if let count = Int(textField.text!), (count >= 1 && count <= 999) {
                return Double(count)
            }
        }
        showAlertOk(title: "Некорректное число", message: "Количество заданий в тесте должно быть в диапазоне от 1 до 999")
        return nil
    }
    func marafonQuestionsCountIsValid(_ textField: UITextField, min: Int, max: Int)->Int? {
       if textFieldNotEmpty(textField) {
           if let count = Int(textField.text!), (count >= min && count <= max) {
                return count
            }
        }
        showAlertOk(title: "Некорректное число", message: "Номерьвопроса должен быть в диапазоне от \(min) до \(max)")
        return nil
    }
    func mistakesCountIsValid(_ textField: UITextField)->Double? {
        if textFieldNotEmpty(textField) {
           if let count = Int(textField.text!), (count >= 1 && count <= 999) {
                return Double(count)
            }
        }
        showAlertOk(title: "Некорректное число", message: "Количество ошибок в тесте должно быть в диапазоне от 1 до 999")
        return nil
    }
    
    func colorSubstring(mainString: String, subString: String)->NSMutableAttributedString  {
        let range = (mainString as NSString).range(of: subString, options: .caseInsensitive)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.orange, range: range)
        return mutableAttributedString
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func getRandomItem(exsisitingItems: [String], fromRandomArray: [String]) -> String? {
        if fromRandomArray.count == 0 { return nil }
        if Set(fromRandomArray).isSubset(of: Set(exsisitingItems)) { return nil }
        //выбираем элемент из случайных элементов массива fromRandomArray, которого нет в списке exsisitingItems
        var newItem = fromRandomArray[Random.randomInt(min: 0, max: fromRandomArray.count-1)]
        //выбираем до тех пор пока не найдем свободный элемент
        while exsisitingItems.contains(newItem) {
            newItem = fromRandomArray[Random.randomInt(min: 0, max: fromRandomArray.count-1)]
        }
        return newItem
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func title(_ key: String) -> String {
        return lang_scheme[cur_lang]?[key] ?? key
    }
    
    func save(key: String, value: String) {
        settings[key] = value
        UserDefaults.standard.set(settings, forKey: "settings")
    }
    
    func saveDoubleArray<T>(key: String, array: [[T]]) {
        var savedStr = ""
        var resultString = ""
        if array.count == 0 {
            resultString = savedStr
        }
        else {
            for item in array {
                savedStr += "|".join(item) + "__"
            }
            let start = savedStr.startIndex
            let end = savedStr.index(savedStr.endIndex, offsetBy: -2)
            resultString = String(savedStr[start..<end])
        }
        save(key: key, value: resultString)
    }
    
    func saveDictArray<T>(key: String, array: [[T:T]]) {
        var savedStr = ""
        var resultString = ""
        if array.count == 0 { resultString = savedStr }
        else {
            for dict in array {
                var strArray = [String]()
                for (key, value) in dict {
                    strArray.append("\(key):::\(value)")
                }
                savedStr += "|".join(strArray) + "__"
            }
            let start = savedStr.startIndex
            let end = savedStr.index(savedStr.endIndex, offsetBy: -2)
            resultString = String(savedStr[start..<end])
            
        }
        save(key: key, value: resultString)
    }
    
    func getToDoubleArray(key: String)-> [[Int]] {
        var array = [[Int]]()
        let gettingStr = get(key: key)
        
        if gettingStr == "" { return array }
        let firstArray = gettingStr.components(separatedBy: "__")
        for item1 in firstArray {
            let secondArray = item1.components(separatedBy: "|")
            var intArray = [Int]()
            for item2 in secondArray {
                if let intItem = Int(item2) {
                    intArray.append(intItem)
                }
            }
            array.append(intArray)
        }
        return array
    }
    
    
    func getToDoubleArray(key: String)-> [[String]] {
        var array = [[String]]()
        let gettingStr = get(key: key)
        if gettingStr == "" { return array }
        let firstArray = gettingStr.components(separatedBy: "__")
        for item1 in firstArray {
            let secondArray = item1.components(separatedBy: "|")
            var intArray = [String]()
            for item2 in secondArray {
                intArray.append(String(item2))
            }
            array.append(intArray)
        }
        return array
    }
    func getToDictArray(key: String)-> [[Int:Int]] {
        var array = [[Int:Int]]()
        let gettingStr = get(key: key)
        if gettingStr == "" { return array }
        
        let firstArray = gettingStr.components(separatedBy: "__")
        for item1 in firstArray {
            let pairsArray = item1.components(separatedBy: "|")
            var dict = [Int: Int]()
            for item2 in pairsArray {
                let curPair = item2.components(separatedBy: ":::")
                if let key = Int(curPair[0]), let value = Int(curPair[1]) {
                    dict[key] = value
                }
            }
            array.append(dict)
        }
        return array
    }
    
    func get(key: String)->String {
        return settings[key] ?? ""
    }
    
    func getToIntArray(key: String)->[Int] {
        var intArray: [Int] = []
        let strArray = (settings[key] ?? "").components(separatedBy: "|")
        for str in strArray {
            if let curInt = Int(str) {
                intArray.append(curInt)
            }
        }
        return intArray
    }
    
    func getToInt(key: String)->Int {
        return Int(settings[key] ?? "") ?? -1
    }
    
    func getToStringArray(key: String)->[String] {
        return (settings[key] ?? "").components(separatedBy: "|")
    }
    
    func getToClassArray<T: DictProtocol>(key: [[String : String]]) -> [T]{
        var resArray: [T] = []
        for curDict in key {
            resArray.append(T.init(dict: curDict))
        }
        return resArray
    }

    
    func setTitleFont() {
        var fontSize: CGFloat = 19
        switch UIDevice().type {
        case .iPhone5S,.iPhoneSE: fontSize = 17
        default: break
        }
        if UIDevice.current.userInterfaceIdiom == .pad { fontSize = 22 }
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont(name: appFont, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)]
    }
    func setTitleFont(fontColor: UIColor) {
        var fontSize: CGFloat = 19
        switch UIDevice().type {
        case .iPhone5S,.iPhoneSE: fontSize = 17
        default: break
        }
        if UIDevice.current.userInterfaceIdiom == .pad { fontSize = 22 }
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: fontColor, .font : UIFont(name: appFont, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)]
    }
    
    func setShadows(forLabel: UILabel) {
        forLabel.layer.shadowColor = UIColor.black.cgColor
        forLabel.layer.shadowOpacity = 0.3
        forLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        forLabel.layer.shadowRadius = 3
    }
    
    func getContext() -> NSManagedObjectContext? {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }
    
    func saveContext(moc: NSManagedObjectContext?) {
        do { try moc?.save() } catch let error as NSError  {
             print("Could not edit \(error), \(error.userInfo)")
         }
    }
    
    func getEntity<T: NSManagedObject>(type : T.Type, moc: NSManagedObjectContext?, sortdDescriptors: [NSSortDescriptor] = [], predicates: [NSPredicate] = [], predicateType: NSCompoundPredicate.LogicalType = .and)->[T] {
        var resultArray = [T]()
        let entityName = T.description()
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        fetchRequest.sortDescriptors = sortdDescriptors
        let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: predicates)
        fetchRequest.predicate = predicateCompound
        
        do {
            if let mocOpt = moc {
                resultArray = try mocOpt.fetch(fetchRequest)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return resultArray
    }
    
    func timeStr(_ time: Float)->String {
        let min = Int(time / 60)
        let minTxt = min < 10 ? "0\(min)" : "\(min)"
        let sec = Int(time) % 60
        let secTxt = sec < 10 ? "0\(sec)" : "\(sec)"
        return "\(minTxt):\(secTxt)"
    }
    
    func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func addOwnWords(id: Int) {
        userDefaults.set(id, forKey: "selectedSectionId")
        goNextVC("ownwordsVC")
    }
}

extension String {
    func containsCharacters(charactersString: String) -> Bool {
        let charset = CharacterSet(charactersIn: charactersString)
        return rangeOfCharacter(from: charset) != nil
    }
}


extension UIViewController {
    func setupLinearGradient(colors: [CGColor], locations: [NSNumber]) {
        
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradient.bounds = self.view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)

        gradient.position = self.view.center
        gradient.frame = self.view.bounds
       
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}



extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
}

class Random {
    public static func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}

func initializePlayer(fileName: String, fileType: String) -> AVAudioPlayer? {
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else {
        return nil
    }
    return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
}

class Loader {
    public static func loadJson(fileName: String, fileType: String)-> Any? {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .mappedIfSafe)
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print("contents could not be loaded")
            }
        } else {
            // fileName not found
        }
        return nil
    }
    
    public static func loadAllImages()->[String:UIImage]{
        var imagesDict = [String:UIImage]()
        if let images = loadJson(fileName: "images", fileType: "json") as? [String] {
            for image in images {
                imagesDict[image] = UIImage(named: image)
            }
        }
        return imagesDict
    }
    
    
    public static func loadSounds()->[String : AVAudioPlayer?]{
        var soundsDict = [String:AVAudioPlayer?]()
        if let sounds = loadJson(fileName: "sounds", fileType: "json") as? [String] {
            for sound in sounds {
                let sound_item = sound.components(separatedBy: ".")
                soundsDict[sound] = initializePlayer(fileName: "sounds/" + sound_item[0], fileType: sound_item[1])
            }
        }
        return soundsDict
    }
    
    public static func loadToClass<T: DictProtocol>(fileName: String, fileType: String) -> [T]{
        var resArray: [T] = []
        //print(loadJson(fileName: fileName, fileType: fileType))
        if let dataDict = loadJson(fileName: fileName, fileType: fileType) as? [[String : String]] {
            for curDict in dataDict {
                resArray.append(T.init(dict: curDict))
            }
        }
        return resArray
    }
    
    public static func loadToClass<T: DictProtocol>(fromArray: [[String : String]]) -> [T]{
        var resArray: [T] = []
        for curDict in fromArray {
            resArray.append(T.init(dict: curDict))
        }
        return resArray
    }
    
    public static func loadToClassFromJson<T: JsonProtocol>(fromArray: [[String : AnyObject]]) -> [T]{
        var resArray: [T] = []
        for curDict in fromArray {
            resArray.append(T.init(data: curDict))
        }
        return resArray
    }
    
    func arrayToStr<T: Codable>(_ array: [T]) -> String {
        var str = ""
        do {
            str = try String(data: JSONEncoder().encode(array), encoding: .utf8) ?? ""
        } catch { print(error) }
        return str
    }
    
    func arrayFromStr<T: Codable>(_ str: String) -> [T] {
        var array: [T] = []
        do {
            array = try JSONDecoder().decode([T].self, from: Data(str.utf8))
        } catch { print(error) }
        return array
    }
    
    
}

protocol DictProtocol {
    init(dict: [String: String])
}

protocol JsonProtocol {
    init(data: [String: AnyObject])
}



//##################### ОТПРАВКА EMAIL ######################
extension UIViewController: @retroactive MFMailComposeViewControllerDelegate {
    func showEmail() {
        //Отправка письма на почту
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["alisa.potapova.apps@gmail.com"])
        mailComposerVC.setSubject("Вопросы по приложению \(appName)")
        mailComposerVC.setMessageBody("Напишите здесь свой вопрос:", isHTML: false)
        return mailComposerVC
    }

    func showSendMailErrorAlert() {
    }

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
//#############################################################


//##################### СДЕЛАТЬ СКРИНШОТ ЭКРАНА ######################
extension UIApplication {
    func makeSnapshot() -> UIImage? {
        // return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.layer.makeSnapshot()
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        return keyWindow?.layer.makeSnapshot()
    }
}

extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}


//##################### ОТПРАВКА EMAIL ######################



//##################### РАЗНЫЕ ТИПЫ ДАННЫХ ######################

//replace string in place
extension RangeReplaceableCollection where Self: StringProtocol {
    mutating func replaceOccurrences<Target: StringProtocol, Replacement: StringProtocol>(of target: Target, with replacement: Replacement, options: String.CompareOptions = [], range searchRange: Range<String.Index>? = nil) {
        self = .init(replacingOccurrences(of: target, with: replacement, options: options, range: searchRange))
    }
}

extension UITextField {
    func isEmpty(_ textField: UITextField)->Bool {
        let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        return textCount > 0 ? false : true
    }
}


extension Array where Element: Hashable {
    var isUnique: Bool {
        var seen = Set<Element>()
        return allSatisfy { seen.insert($0).inserted }
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self).replacingOccurrences(of: ".", with: ",")
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    func join<T>(_ array:[T]) -> String {
        var str:String = ""
        for (index, item) in array.enumerated() {
            str += "\(item)"
            if index < array.count-1 {
                str += self
            }
        }
        return str
    }
}

/*
 "y, M d"                // 2020, 10 29
 "YY, MMM d"             // 20, Oct 29
 "YY, MMM d, hh:mm"      // 20, Oct 29, 02:18
 "YY, MMM d, HH:mm:ss"   // 20, Oct 29, 14:18:31
 "dd.MM.YY hh:mm"       // 12.06.21 14:18
 */
func convertDateToString(currentDateTime: Date, dateFormat: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    return formatter.string(from: currentDateTime) //
}

func convertDateToString(currentDateTime: Date, timeStyle: DateFormatter.Style) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = timeStyle
    formatter.dateStyle = .short
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: currentDateTime) // "10/8/16, 10:52 PM"
}

func convertStringToDate(currentDateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.date(from: currentDateString)
}

func convertStringToDate(currentDateString: String, dateFormat: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    return formatter.date(from: currentDateString)
}

func convertDoubleToString(number: Double, localeId: String, digitsNumber: Int)->String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: localeId)
        formatter.maximumFractionDigits = digitsNumber
        //formatter.minimumFractionDigits = digitsNumber
        return formatter.string(from: number as NSNumber) ?? ""
}

func textContainsCharacters(text: String, characters: String) -> Bool {
    let charset = CharacterSet(charactersIn: characters)
    if text.rangeOfCharacter(from: charset) != nil {
        return true
    }
    else {
        return false
    }
}

func arrayToStr<T: Codable>(_ array: [T]) -> String {
    var str = ""
    do {
        str = try String(data: JSONEncoder().encode(array), encoding: .utf8) ?? ""
    } catch { print(error) }
    return str
}

func arrayFromStr<T: Codable>(_ str: String) -> [T] {
    var array: [T] = []
    do {
        array = try JSONDecoder().decode([T].self, from: Data(str.utf8))
    } catch { print(error) }
    return array
}

extension String {

    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    

}
//clear button image
extension UITextField {
    @objc func modifyClearButton(with image : UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }

    @objc func clear(_ sender : AnyObject) {
        if delegate?.textFieldShouldClear?(self) == true {
            self.text = ""
            sendActions(for: .editingChanged)
        }
    }
}
    

extension UIView {
    func setGradientBackground(colors: [Any]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0,y: 0.0)
        
        //var updatedFrame = self.bounds
        //updatedFrame.size.height += self.frame.origin.y
        //gradient.frame = updatedFrame
        
        //gradient.frame = self.bounds
        //gradient.cornerRadius = 4
        //clipsToBounds = true
        gradient.colors = colors
        //gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at:0)
        //gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        //self.layer.addSublayer(gradient)
        //self.layer.insertSublayer(gradient, at:0)
    }
    
    func removeSublayer(layerIndex index: Int) {
        guard let sublayers = self.layer.sublayers else { return }
        if sublayers.count > index {
            self.layer.sublayers?.remove(at: index)
        }
    }

}

func textFieldNotEmpty(_ textField: UITextField)->Bool {
    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
    if textCount > 0 {
        return true
    }
    else {
        return false
    }
}

// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
//MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
enum Model : String {
    case simulator     = "simulator/sandbox",
         //iPod
         iPod1              = "iPod 1",
         iPod2              = "iPod 2",
         iPod3              = "iPod 3",
         iPod4              = "iPod 4",
         iPod5              = "iPod 5",
         
         //iPad
         iPad2              = "iPad 2",
         iPad3              = "iPad 3",
         iPad4              = "iPad 4",
         iPad5              = "iPad 5th",
         iPad6              = "iPad 6th",
         iPad7              = "iPad 7th",
         iPad8              = "iPad 8th",
         iPad9              = "iPad 9th",
         iPad10             = "iPad 10th",
         
         //iPadAir
         iPadAir            = "iPad Air ",
         iPadAir2           = "iPad Air 2",
         iPadAir3           = "iPad Air 3",
         iPadAir4           = "iPad Air 4",
         iPadAir_5rd        = "iPad Air 5rd",
         
         //iPad mini
         iPadMini           = "iPad Mini",
         iPadMini2          = "iPad Mini 2",
         iPadMini3          = "iPad Mini 3",
         iPadMini4          = "iPad Mini 4",
         iPadMini5th        = "iPad Mini 5th",
         iPadMini6th        = "iPad Mini 6th",
         
         //iPad pro
         iPadPro9_7         = "iPad Pro 9.7",
         iPadPro10_5        = "iPad Pro 10.5",
              
         iPadPro11          = "iPad Pro 11",
         iPadPro11_2nd      = "iPad Pro 11 2nd",
         iPadPro11_3rd      = "iPad Pro 11 3rd",
         iPadPro11_4th      = "iPad Pro 11 4th",
              
         iPadPro12_9        = "iPad Pro 12.9",
         iPadPro2_12_9      = "iPad Pro 2 12.9",
         iPadPro3_12_9      = "iPad Pro 3 12.9",
         iPadPro12_9_4th    = "iPad Pro 12_9 4th",
         iPadPro12_9_5rd    = "iPad Pro 12_9 5rd",
         iPadPro12_9_6rd    = "iPad Pro 12_9 6rd",
         

         //iPhone
         iPhone4            = "iPhone 4",
         iPhone4S           = "iPhone 4S",
         iPhone5            = "iPhone 5",
         iPhone5S           = "iPhone 5S",
         iPhone5C           = "iPhone 5C",
         iPhone6            = "iPhone 6",
         iPhone6plus        = "iPhone 6 Plus",
         iPhone6S           = "iPhone 6S",
         iPhone6Splus       = "iPhone 6S Plus",
         iPhoneSE           = "iPhone SE",
         iPhone7            = "iPhone 7",
         iPhone7plus        = "iPhone 7 Plus",
         iPhone8            = "iPhone 8",
         iPhone8plus        = "iPhone 8 Plus",
         iPhoneX            = "iPhone X",
         iPhoneXS           = "iPhone XS",
         iPhoneXSMax        = "iPhone XS Max",
         iPhoneXR           = "iPhone XR",
         iPhone11           = "iPhone 11",
         iPhone11Pro        = "iPhone 11 Pro",
         iPhone11ProMax     = "iPhone 11 Pro Max",
         iPhone12           = "iPhone 12",
         iPhone12Pro        = "iPhone 12 Pro",
         iPhone12ProMax     = "iPhone 12 Pro Max",
         iPhone12mini       = "iPhone 12 mini",
         iPhone13           = "iPhone 13",
         iPhone13Pro        = "iPhone 13 Pro",
         iPhone13ProMax     = "iPhone 13 Pro Max",
         iPhone13mini       = "iPhone 13 mini",
         iPhone14           = "iPhone 14",
         iPhone14Plus       = "iPhone 14 Plus",
         iPhone14Pro        = "iPhone 14 Pro",
         iPhone14ProMax     = "iPhone 14 Pro Max",
         iPhoneSE2nd        = "iPhone SE 2nd gen",
         iPhoneSE3nd        = "iPhone SE 3nd gen",
         iPhone15           = "iPhone 15",
         iPhone15Plus       = "iPhone 15 Plus",
         iPhone15Pro        = "iPhone 15 Pro",
         iPhone15ProMax     = "iPhone 15 Pro Max",
         
         //Apple TV
         AppleTV            = "Apple TV",
         AppleTV_4K         = "Apple TV 4K",
         unrecognized       = "?unrecognized?"
}


extension UIDevice {
    var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        let modelMap : [ String : Model ] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            "arm64"     : .simulator,
            //iPod
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            //iPad
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad6,11"  : .iPad5,
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6,
            "iPad7,6"   : .iPad6,
            "iPad7,12"  : .iPad7,
            "iPad11,7"  : .iPad8,
            "iPad12,2"  : .iPad9,
            "iPad13,18" : .iPad10,
            //iPad Air
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad11,3"  : .iPadAir3,
            "iPad13,2"  : .iPadAir4,
            "iPad13,17" : .iPadAir_5rd,
            //iPad mini
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad11,1"  : .iPadMini5th,
            "iPad14,1"  : .iPadMini6th,
            //iPad pro
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            
            "iPad8,1"   : .iPadPro11,
            "iPad8,9"   : .iPadPro11_2nd,
            "iPad13,5"  : .iPadPro11_3rd,
            "iPad14,3"  : .iPadPro11_4th,
 
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,12"  : .iPadPro12_9_4th,
            "iPad13,10" : .iPadPro12_9_5rd,
            "iPad14,5"  : .iPadPro12_9_6rd,
            
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6Splus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7plus,
            "iPhone9,4" : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,5" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            "iPhone13,1" : .iPhone12mini,
            "iPhone14,5" : .iPhone13,
            "iPhone14,2" : .iPhone13Pro,
            "iPhone14,3" : .iPhone13ProMax,
            "iPhone14,4" : .iPhone13mini,
            "iPhone14,7" : .iPhone14,
            "iPhone14,8" : .iPhone14Plus,
            "iPhone15,2" : .iPhone14Pro,
            "iPhone15,3" : .iPhone14ProMax,
            "iPhone12,8" : .iPhoneSE2nd,
            "iPhone14,6" : .iPhoneSE3nd,
            "iPhone15,4" : .iPhone15,
            "iPhone15,5" : .iPhone15Plus,
            "iPhone16,1" : .iPhone15Pro,
            "iPhone16,2" : .iPhone15ProMax,
            //AppleTV
            "AppleTV5,3" : .AppleTV,
            "AppleTV6,2" : .AppleTV_4K
        ]
        
        //if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
        if let curModelCode = modelCode, let model = modelMap[curModelCode] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    //if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                    if let simModel = modelMap[simModelCode] {
                        return simModel
                    }
                    else {
                        //print(String.init(validatingUTF8: simModelCode)!)
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}


extension UILabel {
    func underline() {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

/*
extension UINavigationBar {
    @objc func setGradientBackground(colors: [Any]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        var updatedFrame = self.bounds
        updatedFrame.size.height += self.frame.origin.y
        gradient.frame = updatedFrame
        gradient.colors = colors;
        self.setBackgroundImage(self.image(fromLayer: gradient), for: .default)
    }

    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}
*/

