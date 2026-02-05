//
//  addOrEditOwnwordVC.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 18.06.2025.
//

import UIKit
import CoreData

protocol addOrEditOwnwordsDelegate{
    func closeAddOrEditOwnwordVC()
}

class addOrEditOwnwordVC : UIViewController,
                UITextFieldDelegate
{
    var backgroundImageView = UIImageView()
    var cancelButton = UIButton()
    var okButton = UIButton()
    
    //var nameLabel = UILabel()
    //var nameTextField = UITextField()
	var nameLabel = UILabel()
	var nameTextField = UITextField()

    var delegate : addOrEditOwnwordsDelegate?
    var moc: NSManagedObjectContext?
    var isEditOwnwordMode = false
    var ownwords: [Ownword] = []
    var ownword: Ownword?
    
    let labelTextColor = UIColor(hex: "ffffff")
    let textFieldBackgroundColor = UIColor(hex: "ffffff").withAlphaComponent(0.2)
    let textFieldTextColor = UIColor(hex: "ffffff")
    
    //let nameMinimumSymbolsCount = 1
    //let nameMaximumSymbolsCount = 14
	let nameMinimumSymbolsCount = 1
	let nameMaximumSymbolsCount = 14

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setConstraints()
        
        moc = getContext()
        getOwnwords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = lang_scheme[cur_lang]?["addOrEditOwnwordVCTitle"] as? String ?? "navigationBar title"
        
        navigationItem.hidesBackButton = true
        self.hideKeyboardWhenTappedAround()
        
        updateInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //showNavigationBar()
    }
    
    func getOwnwords() {
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        ownwords = getEntity(type: Ownword.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
    }
    
    func updateInterface() {
        if isEditOwnwordMode {
            okButton.setTitle(saveTitle,for: .normal)
            cancelButton.setTitle(cancelTitle,for: .normal)
            navigationItem.title = lang_scheme[cur_lang]?["alertEditOwnwordTitle"] as? String ?? "navigationBar title"
            
            //nameTextField.text = ownword?.name
			nameTextField.text = ownword?.name

        }
        else {
            okButton.setTitle(addTitle,for: .normal)
            cancelButton.setTitle(cancelTitle,for: .normal)
            navigationItem.title = lang_scheme[cur_lang]?["alertAddOwnwordTitle"] as? String ?? "navigationBar title"
            
            //nameTextField.text = ""
			nameTextField.text = ""

        }
        
    }
    
    @objc func cancelButtonPressed() {
        closeController()
    }
    
    @objc func okButtonPressed() {
        okAction()
    }
    
    
    func okAction() {
        let dataIsCorrect = checkData()
        guard dataIsCorrect else { return }
        if isEditOwnwordMode {  editOwnword() }
        else { addOwnword() }
    }
    
    func editOwnword() {
        //ownword?.name  = nameTextField.text ?? ""
		ownword?.name = nameTextField.text ?? ""

        saveContext(moc: moc)
        closeController()
    }
    
    func addOwnword() {
        guard let mc = moc else { return }
        let newOwnword = Ownword(context: mc)
        let ownwordIds = ownwords.map({$0.id})
        let lastOwnwordId = ownwordIds.max() ?? 0
        newOwnword.id = lastOwnwordId + 1
        
        //newOwnword.name = nameTextField.text ?? ""
		newOwnword.name = nameTextField.text ?? ""

        saveContext(moc: moc)
        
        // добавляем в own
        var ownOwnwordsIds = (userDefaults.object(forKey: "ownOwnwordsIds") as? [Int]) ?? []
        ownOwnwordsIds.append(Int(newOwnword.id))
        userDefaults.set(ownOwnwordsIds, forKey: "ownOwnwordsIds")
        
        closeController()
    }
    
    func checkData() -> Bool {
        var fieldIsCorrect = true
        
        let textfieldsArray = [nameTextField]
        let fieldsArray = ["name"]
        let minimumSymbolsCountArray = [nameMinimumSymbolsCount]
        let maximumSymbolsCountArray = [nameMaximumSymbolsCount]

        for i in 0..<textfieldsArray.count {
            let newFieldValue = textfieldsArray[i].text ?? ""
            let oldFieldValue = ownword?.value(forKey: fieldsArray[i]) as? String ?? ""
            let allOwnwordsFieldValue = ownwords.map { ($0.value(forKey: fieldsArray[i]) as? String)?.lowercased() ?? ""}
            fieldIsCorrect = checkField(field: fieldsArray[i], newFieldValue: newFieldValue, oldFieldValue: oldFieldValue, allOwnwordsFieldValue: allOwnwordsFieldValue, fieldMinimumSymbolsCount: minimumSymbolsCountArray[i], fieldMaximumSymbolsCount: maximumSymbolsCountArray[i])
            if !fieldIsCorrect { return false }
        }
        return true
    }
    
    func checkField(field: String, newFieldValue: String, oldFieldValue: String, allOwnwordsFieldValue: [String], fieldMinimumSymbolsCount: Int, fieldMaximumSymbolsCount: Int) -> Bool {
        let addedElementTitle = lang_scheme[cur_lang]?[field] as? String ?? ""
        
        let newFieldValue = newFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let newFieldTextCount = newFieldValue.count
        
        // такое название уже есть
        if newFieldValue.lowercased() != oldFieldValue.lowercased() && allOwnwordsFieldValue.contains(newFieldValue.lowercased()) {
            var alertTitle = lang_scheme[cur_lang]?["alertIncorrectNameTitle"] as? String ?? ""
            alertTitle = alertTitle.replacingOccurrences(of: "currentTitle", with: addedElementTitle.lowercased())
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectNameMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle.lowercased()))
            showAlertOk(title: alertTitle, message: alertMessage)
            return false
        }
        // некорректное число символов
        else if newFieldTextCount < fieldMinimumSymbolsCount || newFieldTextCount > fieldMaximumSymbolsCount {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsCountMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "currentTitle", with: String(addedElementTitle))
            alertMessage = alertMessage.replacingOccurrences(of: "minimumSymbolsCount", with: String(fieldMinimumSymbolsCount))
            alertMessage = alertMessage.replacingOccurrences(of: "maximumSymbolsCount", with: String(fieldMaximumSymbolsCount))
            showAlertOk(title: alertTitle, message: alertMessage)
            return false
        }
        // нельзя использовать эти символы
        else if newFieldValue.containsCharacters(charactersString: incorrectSymblosString) {
            let alertTitle = lang_scheme[cur_lang]?["alertIncorrectSymbolsTitle"] as? String ?? ""
            var alertMessage = lang_scheme[cur_lang]?["alertIncorrectSymbolsMessage"] as? String ?? ""
            alertMessage = alertMessage.replacingOccurrences(of: "incorrectSymblosString", with: incorrectSymblosString)
            showAlertOk(title: alertTitle, message: alertMessage)
            return false
        }
        return true
    }
    
    func closeController(){
        delegate?.closeAddOrEditOwnwordVC()
        goBackVC()
    }
    
    func setAttributes() {
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.tag = 1
        self.view.addSubview(backgroundImageView)
        
        cancelButton.setTitle(cancelTitle, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = appMainColor
        cancelButton.layer.cornerRadius = 20 // for rounded corners
        cancelButton.clipsToBounds = true // for rounded corners
        //cancelButton.setTitleColor(.gray, for: .disabled)
        self.view.addSubview(cancelButton)
        
        okButton.setTitle(okTitle, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 20 // for rounded corners
        okButton.clipsToBounds = true // for rounded corners
        //okButton.setTitleColor(.gray, for: .disabled)
        okButton.backgroundColor = appMainColor
        self.view.addSubview(okButton)
        
        let fontSize: CGFloat = iphoneConstraints ? 15 : 20
        let textFieldFont =  UIFont(name: "Helvetica Neue", size: fontSize)
        let labelFont = UIFont(name: "Helvetica Neue", size: fontSize)
        
        nameLabel.font = labelFont
        nameLabel.textColor = labelTextColor
        nameLabel.textAlignment = .left
        nameLabel.text = lang_scheme[cur_lang]?["name"] as? String ?? ""
        self.view.addSubview(nameLabel)

        nameTextField.backgroundColor = textFieldBackgroundColor
        nameTextField.textColor = textFieldTextColor
        nameTextField.font = textFieldFont
        nameTextField.textAlignment = .left
        nameTextField.layer.cornerRadius = 10
        nameTextField.clipsToBounds = true
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)

    }
    
    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        //nameTextField, surnameTextField, nameLabel, surnameLabel
        for itemView in [backgroundImageView, nameTextField, nameLabel,  cancelButton, okButton] {
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        // common constraints
        backgroundImageView.widthAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 500/812).isActive = true
        
        // iPhone constraints
        if iphoneConstraints {
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            okButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
            okButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
            okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            //okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
            
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            //cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        }
        // iPad constraints
        else {
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
            
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
            okButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
            okButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
            okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            //okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
            
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
            cancelButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            //cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        }

        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: iphoneConstraints ? 16 : 26).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: iphoneConstraints ? -16 : -26).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: iphoneConstraints ? 40 : 50).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        //nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        nameTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true

        //nameTextField, surnameTextField, nameLabel, surnameLabel
        for itemView in [backgroundImageView, nameTextField, nameLabel,  cancelButton, okButton]  {
            view.bringSubviewToFront(itemView)
        }
    }
    
}
