//
//  settingsVC.swift
//  navAppProject
//
//  Created by Alisa Potapova on 07.10.2020.
//  Copyright © 2020 Alisa Potapova. All rights reserved.
//

import UIKit

class SettingsSection {
    var data: [SettingsSectionData]
    var name: String
    
    init(name: String, data: [SettingsSectionData]) {
        self.name = name
        self.data = data
    }
}

class SettingsSectionData {
    var id: String
    var name: String
    var value: String
    var type: String
    var pickerData: [String]
    var desc: String
    
    init(id: String, name: String, value: String, type: String, pickerData: [String] = [], desc: String) {
        self.id = id
        self.name = name
        self.value = value
        self.type = type
        self.pickerData = pickerData
        self.desc = desc
    }
}

class SettingsRow {
    var id: String
    var name: String
    var value: String
    var type: String
    var pickerData: [String]
    var desc: String
    
    init(id: String, name: String, value: String, type: String, pickerData: [String] = [], desc: String) {
        self.id = id
        self.name = name
        self.value = value
        self.type = type
        self.pickerData = pickerData
        self.desc = desc
    }
}


class SettingsCollectionViewData {
    var type: String
    var pickerData: [String]
    var value: String
    var section: Int
    var row: Int
    
    
    
    init(type: String, pickerData: [String] = [], value: String, section: Int, row: Int) {
        self.value = value
        self.type = type
        self.pickerData = pickerData
        self.section = section
        self.row = row
    }
}



var settingsSections =
[
    SettingsSection(name: "Настройки игры",
        data: [
            SettingsSectionData(id: "gameType", name: "Тип игры:", value: "\(defaultGameType)", type: "SettingCellSegmentControl",  pickerData: ["Командная", "Одиночная"], desc: "Командная игра - игроки делятся на команды и слова объясняются игроками внутри команды. Одиночная игра - каждый играет сам за себя и слова объясняются по кругу"),
            SettingsSectionData(id: "roundType", name: "Раунды:", value: defaultRoundTypes, type: "SettingCellCollectionViewTable", pickerData: roundNames, desc: ""),
            SettingsSectionData(id: "roundTime", name: "Время на ход:", value: "\(defaultRoundTime)", type: "SettingCellCollectionView",   pickerData: roundTimes, desc: ""),
            SettingsSectionData(id: "selectOwnRoundTime", name: "Выбрать своё время на ход", value: "\(defaultSelectOwnRoundTime)", type: "SettingCellSwitch", desc: "Включите настройку, чтобы выбрать своё время на ход ниже"),
            SettingsSectionData(id: "ownRoundTime", name: "Своё время на ход:", value: "\(defaultRoundTime)", type: "SettingCellSlider", pickerData: ["\(minRoundTime)", "\(maxRoundTime)", "\(stepRoundTime)"], desc: "Выберете здесь своё время на ход"),
            SettingsSectionData(id: "wordsCount", name: "Слов в игре:", value: "\(defaultWordsCount)", type: "SettingCellCollectionView",   pickerData: wordsCountArray, desc: ""),
            SettingsSectionData(id: "selectOwnWordsCount", name: "Выбрать своё количество слов", value: "\(defaultSelectOwnWordsCount)", type: "SettingCellSwitch", desc: "Включите настройку, чтобы выбрать своё количество слов в игре ниже"),
            SettingsSectionData(id: "ownWordsCount", name: "Своё количество слов в игре:", value: "\(defaultWordsCount)", type: "SettingCellSlider", pickerData: ["\(minWordsCount)", "\(maxWordsCount)", "\(stepWordsCount)"], desc: "Выберете здесь своё количество слов в игре"),
            SettingsSectionData(id: "moveTime", name: "Переносить остаток времени", value: "\(defaultMoveTime)", type: "SettingCellSwitch", desc: "Если слова в шляпе закончились, но у команды осталось время, то следующий раунд начинает эта команда и время будет добавлено команде к ее ходу. Настройка \"Переносить остаток времени\" работает только если выключена настройка \"Раунд начинает первая команда\""),
            SettingsSectionData(id: "roundStartsFirstPlayer", name: "Раунд начинает первая команда", value: "\(defaultMoveTime)", type: "SettingCellSwitch", desc: "Если выбрана настройка \"Раунд начинает первая команда\", то новый раунд всегда начинает первая команда из списка команд. Если настройка выключена, то новый раунд начинает команда, следующая после команды, которая завершила предыдущий раунд"),
            SettingsSectionData(id: "extraTime", name: "Дополнительное время", value: "\(defaultExtraTime)", type: "SettingCellSwitch", desc: "Один раз за игру команда может использовать дополнительное время - плюс 15 секунд к своему ходу"),
            SettingsSectionData(id: "commonLastWord", name: "Общее последнее слово", value: "\(defaultCommonLastWord)", type: "SettingCellSwitch", desc: "Все команды могут отгадывать последнее слово"),
            SettingsSectionData(id: "gameWithTasks", name: "Игра с заданиями", value: "\(defaultGameWithTasks)", type: "SettingCellSwitch", desc: "Команды должны объяснять слова, выполняя задание"),
            SettingsSectionData(id: "minusForMistake", name: "Минус очко за пропуск", value: "\(defaultMinusForMistake)", type: "SettingCellSwitch", desc: "За пропуск слова снимается 1 очко"),
            SettingsSectionData(id: "plusForSpeed", name: "Плюс очко за скорость", value: "\(defaultPlusForSpeed)", type: "SettingCellSwitch", desc: "Если команда отгадывает слово меньше чем за 10 секунд, то прибавляется дополнительное очко"),
            SettingsSectionData(id: "gameSounds", name: "Звуки", value: "\(defaultGameSounds)", type: "SettingCellSwitch", desc: "Все звуки в игре")
        ])
]

var settingColors = [UIColor(hex:"7DB25C"), UIColor(hex:"8159A5"), UIColor(hex:"58C7FF"), UIColor(hex:"F7901D"), UIColor(hex:"EB5F96"), UIColor(hex:"FFCB55"), UIColor(hex:"358CD3"), UIColor(hex:"E7574F")]

class settingsVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,  SettingCellTextDelegate, SettingCellTextFieldPickerDelegate, SettingCellSwitchDelegate, SettingCellSliderDelegate, SettingCellStepperDelegate, SettingCellSegmentControlDelegate, SettingCellButtonsControlDelegate {
    

    var pickerData: [String] = [String]()
    var myPicker = MyPickerView()
    var collectionViewData = [Int: SettingsCollectionViewData]()
    var iphoneConstraints = false
    
    var settingsTableView = UITableView(frame: CGRect.zero, style: .grouped)
    var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        setAttributes()
        setConstraints()
        
        getSettings()
        settingsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = (lang_scheme[cur_lang]?["settingsVCTitle"] as? String ?? "navigationBar title").uppercased()
    }
    
    func getSettings() {
        for section in settingsSections {
            for data in section.data {
                data.value = settings[data.id] ?? data.value
            }
        }
    }
    
    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.tag = 1
        self.view.addSubview(backgroundImageView)
        
        settingsTableView.register(SettingCellTextFieldPicker.self, forCellReuseIdentifier: "SettingCellTextFieldPicker")
        settingsTableView.register(SettingCellText.self, forCellReuseIdentifier: "SettingCellText")
        settingsTableView.register(SettingCellSwitch.self, forCellReuseIdentifier: "SettingCellSwitch")
        settingsTableView.register(SettingCellSlider.self, forCellReuseIdentifier: "SettingCellSlider")
        settingsTableView.register(SettingCellStepper.self, forCellReuseIdentifier: "SettingCellStepper")
        settingsTableView.register(SettingCellSegmentControl.self, forCellReuseIdentifier: "SettingCellSegmentControl")
        settingsTableView.register(SettingCellButtons.self, forCellReuseIdentifier: "SettingCellButtons")
        settingsTableView.register(SettingCellHeader.self, forCellReuseIdentifier: "SettingCellHeader")
        settingsTableView.register(SettingCellImage.self, forCellReuseIdentifier: "SettingCellImage")
        settingsTableView.register(SettingCellCollectionView.self, forCellReuseIdentifier: "SettingCellCollectionView")
        settingsTableView.register(SettingCellCollectionViewTable.self, forCellReuseIdentifier: "SettingCellCollectionViewTable")
        
        settingsTableView.separatorStyle = .none
        settingsTableView.separatorColor = .gray
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.backgroundColor = .clear
        //убрать клавиатуру когда скролишь таблицу
        settingsTableView.keyboardDismissMode = .onDrag
        
        settingsTableView.estimatedSectionHeaderHeight = 10.0
        settingsTableView.sectionHeaderHeight = UITableView.automaticDimension
        
        self.view.addSubview(settingsTableView)
    
    }
    
    func setConstraints() {
        var padding = CGFloat(20)
        if !iphoneConstraints {
            padding = 90
        }
        let safeArea = view.layoutMarginsGuide
        
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // common constraints
        backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true
        
        settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding).isActive = true
        settingsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // iPhone constraints
        if iphoneConstraints {
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        }
        // iPad constraints
        else {
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        }
        
        for itemView in [backgroundImageView, settingsTableView] {
            view.bringSubviewToFront(itemView)
        }
        
    }
    
    //#################### table view delegate ##################################
    // Количество объектов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSections[section].data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
         return settingsSections.count
    }

    // Заполнение ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = settingsSections[indexPath.section].data[indexPath.row]
        switch data.type {
        case "SettingCellText":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellText", for: indexPath) as! SettingCellText
            cell.label.text = data.name
            cell.textField.text = data.value
            cell.delegate = self
            return cell
        case "SettingCellTextFieldPicker":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellTextFieldPicker", for: indexPath) as! SettingCellTextFieldPicker
            cell.textField.inputView = myPicker
            cell.textField.text = data.value
            cell.label.text = data.name
            cell.delegate = self
            return cell
        case "SettingCellSwitch":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellSwitch", for: indexPath) as! SettingCellSwitch
            cell.label.text = data.name
            let curValue = data.value == "false" ? false : true
            cell.switchItem.setOn(curValue, animated: false)
            cell.delegate = self
            return cell
        case "SettingCellImage":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellImage", for: indexPath) as! SettingCellImage
            cell.label.text = data.name
            cell.cellImage.image = UIImage(named: data.value)
            return cell
        case "SettingCellSlider":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellSlider", for: indexPath) as! SettingCellSlider
            cell.label.text = data.name
            if let minSliderValue = Float(data.pickerData[0]) {
                cell.slider.minimumValue = minSliderValue
            }
            if let maxSliderValue = Float(data.pickerData[1]) {
                cell.slider.maximumValue = maxSliderValue
            }
            if let sliderValue = Float(data.value) { cell.slider.setValue(sliderValue, animated: false)
                cell.valueLabel.text =  cell.slider.value.clean //"\(Int(cell.slider.value))"   или //cell.slider.value.clean
            }
            cell.delegate = self
            return cell
        case "SettingCellStepper":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellStepper", for: indexPath) as! SettingCellStepper
            cell.label.text = data.name
            if let minStepperValue = Double(data.pickerData[0]) {
                cell.stepper.minimumValue = minStepperValue
            }
            if let maxStepperValue = Double(data.pickerData[1]) {
                cell.stepper.maximumValue = maxStepperValue
            }
            if let stepValue = Double(data.pickerData[2]) {
                cell.stepper.stepValue = stepValue
            }
            if let stepperValue = Double(data.value) {
                cell.stepper.value = stepperValue
                //cell.valueLabel.text = "\(cell.stepper.value)"
                cell.valueLabel.text = "Аа"
                let fontSize = iphoneConstraints ? stepperValue : stepperValue + 10
                cell.valueLabel.font = UIFont(name: appFont, size: CGFloat(fontSize))
            }
            cell.delegate = self
            return cell
        case "SettingCellSegmentControl":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellSegmentControl", for: indexPath) as! SettingCellSegmentControl
            cell.label.text = data.name
            cell.segmentControl.removeAllSegments()
            for (index, item) in data.pickerData.enumerated() {
                cell.segmentControl.insertSegment(withTitle: item, at: index, animated: false)
            }
            if let segmentControlValue = Int(data.value) { cell.segmentControl.selectedSegmentIndex = segmentControlValue }
            cell.delegate = self
            return cell
            
        case "SettingCellButtons":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellButtons", for: indexPath) as! SettingCellButtons
            cell.label.text = data.name
            cell.setButtonsArray(data.pickerData)
            
            if let buttonIndex = Int(data.value) {
                cell.setSelectedButton(buttonIndex) }
            cell.delegate = self
            return cell
        case "SettingCellCollectionView":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellCollectionView", for: indexPath) as! SettingCellCollectionView
            cell.label.text = data.name
            let curTag = cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section, forRow: indexPath.row)
            collectionViewData[curTag] = SettingsCollectionViewData(type: "SettingCellCollectionView", pickerData: data.pickerData, value: data.value, section: indexPath.section, row: indexPath.row)
            return cell
        case "SettingCellCollectionViewTable":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellCollectionViewTable", for: indexPath) as! SettingCellCollectionViewTable
            cell.label.text = data.name
            let curTag = cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section, forRow: indexPath.row)
            collectionViewData[curTag] = SettingsCollectionViewData(type: "SettingCellCollectionViewTable", pickerData: data.pickerData, value: data.value, section: indexPath.section, row: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView,
                      heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let data = settingsSections[indexPath.section].data[indexPath.row]
        switch data.type {
        case "SettingCellPicker", "SettingCellImage":
            return 50
        case "SettingCellSegmentControl", "SettingCellStepper":
            return 90
        case "SettingCellSlider":
            return 90
        case "SettingCellText":
            return 60
        case "SettingCellSwitch":
            return 55
        case "SettingCellCollectionViewTable":
            return 220
        case "SettingCellCollectionView":
            if iphoneConstraints { return 116 }
            else { return 146 }
        default:
            return 40
       }
    }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellHeader") as! SettingCellHeader
        cell.label.text = settingsSections[section].name
        //cell.label.sizeToFit()
        return cell
    }
    

    func didEndEditing(onCell cell: SettingCellText) {
        if let indexPath = settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            
            
            //var dataIsValid = false
            var valueOptional: Double?
            switch data.id {
               case "questionsCount":
                   valueOptional = questionsCountIsValid(cell.textField)
               case "testMinutes":
                   valueOptional = minutesIsValid(cell.textField)
               case "mistakesCount":
                   valueOptional = mistakesCountIsValid(cell.textField)
                
               default:
                   break
               }
                if valueOptional != nil  {
                   //dataIsValid = true
                    data.value = cell.textField.text ?? ""
                    save(key: data.id, value: data.value)
                    settingsTableView.reloadData()
                   
               } else {
                cell.textField.text = data.value
               }
 
        }
    
         
    }
    

    
    func didEndEditing(onCell cell: SettingCellTextFieldPicker) {
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            data.value = cell.textField.text ?? ""
            save(key: data.id, value: data.value)
            settingsTableView.reloadData()
        }
    }
    
    func didBeginEditing(onCell cell: SettingCellTextFieldPicker) {
        if let indexPath = settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            pickerData = data.pickerData
            myPicker.becomeFirstResponder()
            myPicker.delegate = self
            myPicker.dataSource = self
            myPicker.section = indexPath.section
            myPicker.row = indexPath.row
        }
    }
    
    func switchValueChanged(onCell cell: SettingCellSwitch) {
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            data.value = String(cell.switchItem.isOn)
            save(key: data.id, value: data.value)
            
            
            // Если включена настройка "переносить остаток по времени" - то убрать функцию "раунд начинает первая команда". И наоборот:
            if data.id == "moveTime" && data.value == "true" {
                settingsSections[indexPath.section].data[indexPath.row + 1].value =  "false"
                save(key: "roundStartsFirstPlayer", value: "false")
                if let cell = settingsTableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: indexPath.section)) as? SettingCellSwitch {
                    cell.switchItem.isOn = false
                }
                //settingsTableView.reloadData()
            }
            else if data.id == "roundStartsFirstPlayer" && data.value == "true" {
                settingsSections[indexPath.section].data[indexPath.row - 1].value =  "false"
                save(key: "moveTime", value: "false")
                //settingsTableView.reloadData()
                if let cell = settingsTableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: indexPath.section)) as? SettingCellSwitch {
                    cell.switchItem.isOn = false
                }
                
            }
        }
    }
    
    func sliderValueChanged(onCell cell: SettingCellSlider) {
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            if let step = Float(data.pickerData[2]) {
                //data.value = "\(round(cell.slider.value / step) * step)"
                data.value = "\(Int(round(cell.slider.value / step) * step))"
                cell.valueLabel.text = data.value //"\(data.value.split(separator: ".")[0])" //
                save(key: data.id, value: data.value)
            }
        }
    }
    
    func stepperValueChanged(onCell cell: SettingCellStepper) {
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            data.value = "\(cell.stepper.value)"
            cell.valueLabel.text = data.value
            save(key: data.id, value: data.value)
            settingsTableView.reloadData()
        }
    }
    func segmentControlValueChanged(onCell cell: SettingCellSegmentControl) {
        print("segmentControlValueChanged")
        print(cell.segmentControl.selectedSegmentIndex)
        
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            //data.value = "\(cell.segmentControl.selectedSegmentIndex)"
            //self.save(key: data.id, value: data.value)
            let inGame = (userDefaults.object(forKey: "inGame") as? Bool) ?? false
        
            // если настройка = тип игры и есть текущая игра то предупреждение
            if data.id == "gameType" && inGame {
                //алерт - точно изменить тип игры?  начнется новая игра?
                let alert = UIAlertController(title: lang_scheme[cur_lang]?["editGameTypeAlertTitle"] as? String, message: lang_scheme[cur_lang]?["editGameTypeAlertMessage"] as? String, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default) { (_) in
                    let newValue = cell.segmentControl.selectedSegmentIndex
                    cell.segmentControl.selectedSegmentIndex = newValue == 0 ? 1 : 0
                    data.value = "\(cell.segmentControl.selectedSegmentIndex)"
                    self.save(key: data.id, value: data.value)
                })
                
                alert.addAction(UIAlertAction(title: yesTitle, style: .default) { (_) in
                    data.value = "\(cell.segmentControl.selectedSegmentIndex)"
                    self.save(key: data.id, value: data.value)
                    //настройка новой игры
                    userDefaults.set("true", forKey: "inGame")
                })
                self.present(alert, animated: false, completion: nil)
            }
            // иначе меняем тип игры
            else {
                data.value = "\(cell.segmentControl.selectedSegmentIndex)"
                self.save(key: data.id, value: data.value)
            }
        }
    }
    

    
    func pressedButtonInCell(onCell cell: SettingCellButtons) {
        if let indexPath =  settingsTableView.indexPath(for: cell) {
            let data = settingsSections[indexPath.section].data[indexPath.row]
            data.value = "\(cell.selectedButtonIndex)"
            save(key: data.id, value: data.value)
            settingsTableView.reloadData()
        }
    }
    
    // Выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        let data = settingsSections[indexPath.section].data[indexPath.row]
        
        //print(data.id)
        switch data.id {
        case "rateApp": rateApp()
        case "share":
            guard let cell = tableView.cellForRow(at: indexPath) as? SettingCellImage else { break }
            shareApp(onCell: cell)
        case "askQuestion" : showEmail()
        default: break
        }
        tableView.reloadData()
        */
    }
    
    func shareApp(onCell: SettingCellImage) {
        //print("share")
        let text = shareText + "https://apps.apple.com/app/id\(app_id)"
        let activities = [text as AnyObject]
        let activityController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        // On iPad, action sheets must be presented from a popover.
        activityController.popoverPresentationController?.sourceView =  onCell.cellImage //self.contextMenuButton
        activityController.popoverPresentationController?.sourceRect = onCell.cellImage.bounds //self.contextMenuButton.bounds
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let cellRow = myPicker.row, let cellSection = myPicker.section {
            let indexPath = IndexPath(row: cellRow, section: cellSection)
            let cell = settingsTableView.cellForRow(at: indexPath) as? SettingCellTextFieldPicker
            cell?.textField.text = pickerData[row]
        }
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[collectionView.tag]?.pickerData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let curType = collectionViewData[collectionView.tag]?.type
        switch curType {
        case "SettingCellCollectionViewTable":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCollectionViewTableCell", for: indexPath) as! SettingsCollectionViewTableCell
            let valuesArray : [String] = arrayFromStr(collectionViewData[collectionView.tag]?.value ?? "")
            cell.textLabel.text = collectionViewData[collectionView.tag]?.pickerData[indexPath.item]
            if indexPath.item < valuesArray.count {
                cell.selectedImage.image = valuesArray[indexPath.item] == "1" ? UIImage(named: "selectThemeCircleGreen") : UIImage(named: "unsel")
                cell.backView.backgroundColor = valuesArray[indexPath.item] == "1" ? UIColor(hex: "40AF4B") : UIColor(hex: "F5BF43").withAlphaComponent(0.8)
            }
            
            return cell
        case "SettingCellCollectionView":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCollectionViewCell", for: indexPath) as! SettingsCollectionViewCell
        
            let value = collectionViewData[collectionView.tag]?.value ?? "30"
            let valuesArray = collectionViewData[collectionView.tag]?.pickerData
            let selectedIndex = valuesArray?.firstIndex(of: value) ?? 0
            
            cell.textLabel.text = collectionViewData[collectionView.tag]?.pickerData[indexPath.item]
            cell.imageView.image = indexPath.item == selectedIndex ? UIImage(named: "settingsButtonSelected") : UIImage(named: "settingsButton")
            
            return cell
        default: return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curSection = collectionViewData[collectionView.tag]?.section ?? 0
        let curRow = collectionViewData[collectionView.tag]?.row ?? 0
        let curType = collectionViewData[collectionView.tag]?.type
        
        let data = settingsSections[curSection].data[curRow]
        
        switch curType {
        case "SettingCellCollectionViewTable":
            let inGame = (userDefaults.object(forKey: "inGame") as? Bool) ?? false
            // если настройка = тип игры и есть текущая игра то предупреждение
            if data.id == "roundType" && inGame {
                //алерт - точно изменить тип игры?  начнется новая игра?
                let alert = UIAlertController(title: lang_scheme[cur_lang]?["editGameTypeAlertTitle"] as? String, message: lang_scheme[cur_lang]?["editGameTypeAlertMessage"] as? String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default, handler: nil))
                alert.addAction(UIAlertAction(title: yesTitle, style: .default) { (_) in
                    let curValue = self.collectionViewData[collectionView.tag]?.value ?? ""
                    var valuesArray : [String] = arrayFromStr(curValue)
                    if valuesArray[indexPath.item] == "1" {
                        valuesArray[indexPath.item] = "0"
                    } else {
                        valuesArray[indexPath.item] = "1"
                    }
                    data.value = arrayToStr(valuesArray)
                    self.collectionViewData[collectionView.tag]?.value = data.value
                    //настройка новой игры
                    userDefaults.set("true", forKey: "inGame")
                })
                self.present(alert, animated: false, completion: nil)
            }
            else {
                let curValue = collectionViewData[collectionView.tag]?.value ?? ""
                var valuesArray : [String] = arrayFromStr(curValue)
                if valuesArray[indexPath.item] == "1" {
                    valuesArray[indexPath.item] = "0"
                } else {
                    valuesArray[indexPath.item] = "1"
                }
                data.value = arrayToStr(valuesArray)
                collectionViewData[collectionView.tag]?.value = data.value
            }
        case "SettingCellCollectionView":
            data.value = data.pickerData[indexPath.item]
            collectionViewData[collectionView.tag]?.value = data.value
        default: break
        }
        save(key: data.id, value: data.value)
        collectionView.reloadData()
    }
    
    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let curType = collectionViewData[collectionView.tag]?.type
        switch curType {
        case "SettingCellCollectionViewTable":
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(2)
            let verticalSpacing = CGFloat(2)
            let rowsCount = CGFloat(4)
            let columnsCount = CGFloat(1)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            return CGSize(width: cellWidth, height: cellHeight)
        case "SettingCellCollectionView":
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(1)
            let verticalSpacing = CGFloat(1)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(5)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = cellWidth
            //let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return CGSize(width: 0, height: 0)
        }

    }
              
    // Отступ между ячейками по Горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let curType = collectionViewData[collectionView.tag]?.type
        switch curType {
        case "SettingCellCollectionViewTable": return 2
        case "SettingCellCollectionView": return 1
        default: return 0
        }
    }
    
    // Отступ между ячейками по Вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let curType = collectionViewData[collectionView.tag]?.type
        switch curType {
        case "SettingCellCollectionViewTable": return 2
        case "SettingCellCollectionView": return 1
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let curType = collectionViewData[collectionView.tag]?.type
        switch curType {
        case "SettingCellCollectionViewTable":
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(2)
            let verticalSpacing = CGFloat(2)
            let rowsCount = CGFloat(4)
            let columnsCount = CGFloat(1)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            let totalCellWidth = cellWidth * columnsCount
            let totalHorizontalSpacing = horizontalSpacing * (columnsCount - 1)
            let totalCellHeight = cellHeight * rowsCount
            let totalVerticalSpacing = verticalSpacing * (rowsCount - 1)
            let topInset = (height - totalCellHeight - totalVerticalSpacing) / 2
            let bottomInset = topInset
            let leftInset = (width - totalCellWidth - totalHorizontalSpacing) / 2
            let rightInset = leftInset
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        case "SettingCellCollectionView":
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(1)
            let verticalSpacing = CGFloat(1)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(5)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            let totalCellWidth = cellWidth * columnsCount
            let totalHorizontalSpacing = horizontalSpacing * (columnsCount - 1)
            let totalCellHeight = cellHeight * rowsCount
            let totalVerticalSpacing = verticalSpacing * (rowsCount - 1)
            let topInset = (height - totalCellHeight - totalVerticalSpacing) / 2
            let bottomInset = topInset
            let leftInset = (width - totalCellWidth - totalHorizontalSpacing) / 2
            let rightInset = leftInset
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
            

    }

    
}
