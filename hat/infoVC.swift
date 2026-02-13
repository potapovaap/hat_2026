//
//  infoVC.swift
//  hat
//
//  Created by Alisa Potapova on 09.02.2026.
//

//
//  settingsVC.swift
//  navAppProject
//
//  Created by Alisa Potapova on 07.10.2020.
//  Copyright © 2020 Alisa Potapova. All rights reserved.
//


/*
import UIKit

var infoSections =
[
    SettingsSection(name: "Настройки игры",
        data: [
            SettingsSectionData(id: "rateApp", name: "Оставить отзыв", value: "settingsStar", type: "SettingCellImage"),
            SettingsSectionData(id: "askQuestion", name: "Задать вопрос", value: "settingsMail", type: "SettingCellImage"),
            SettingsSectionData(id: "appRules", name: "Правила игры", value: "settingsAppRules", type: "SettingCellImage"),
            SettingsSectionData(id: "share", name: "Поделиться", value: "settingsShare", type: "SettingCellImage"),
            SettingsSectionData(id: "appVersion", name: "Версия приложения: \(currentAppVersion)", value: "settingsAppVersion", type: "SettingCellImage"),
        ])
]

class infoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var iphoneConstraints = false
    
    var infoTableView = UITableView(frame: CGRect.zero, style: .grouped)
    var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        setAttributes()
        setConstraints()
        
        getSettings()
        infoTableView.reloadData()
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
        
        infoTableView.register(SettingCellImage.self, forCellReuseIdentifier: "SettingCellImage")
        
        infoTableView.separatorStyle = .singleLine
        infoTableView.separatorColor = .white
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.backgroundColor = .clear
        
        //infoTableView.estimatedRowHeight = 200.0
        //infoTableView.rowHeight = UITableView.automaticDimension
        
        //убрать клавиатуру когда скролишь таблицу
        infoTableView.keyboardDismissMode = .onDrag
        
        infoTableView.estimatedSectionHeaderHeight = 10.0
        infoTableView.sectionHeaderHeight = UITableView.automaticDimension
        
        self.view.addSubview(infoTableView)
    
    }
    
    func setConstraints() {
        var padding = CGFloat(20)
        if !iphoneConstraints {
            padding = 90
        }
        let safeArea = view.layoutMarginsGuide
        
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // common constraints
        backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true
        
        infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding).isActive = true
        infoTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
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
        
        for itemView in [backgroundImageView, infoTableView] {
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
        case "SettingCellImage":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellImage", for: indexPath) as! SettingCellImage
            cell.label.text = data.name
            cell.cellImage.image = UIImage(named: data.value)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCellHeader") as! SettingCellHeader
        cell.label.text = settingsSections[section].name
        return cell
    }
    

    
    // Выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = settingsSections[indexPath.section].data[indexPath.row]

        switch data.id {
        case "rateApp": rateApp()
        case "askQuestion" : showEmail()
        case "appRules": goNextVC("rulesVC")
        case "share":
            guard let cell = tableView.cellForRow(at: indexPath) as? SettingCellImage else { break }
            shareApp(onCell: cell)
        default: break
        }
        tableView.reloadData()
        
    }
    
    func shareApp(onCell: SettingCellImage) {
        let text = shareText + "https://apps.apple.com/app/id\(app_id)"
        let activities = [text as AnyObject]
        let activityController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        // On iPad, action sheets must be presented from a popover.
        activityController.popoverPresentationController?.sourceView =  onCell.cellImage //self.contextMenuButton
        activityController.popoverPresentationController?.sourceRect = onCell.cellImage.bounds //self.contextMenuButton.bounds
        self.present(activityController, animated: true, completion: nil)
    }
    
    
}

*/
