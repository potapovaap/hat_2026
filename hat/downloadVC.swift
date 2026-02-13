//
//  downloadVC.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 25.08.2025.
//


import UIKit
import StoreKit
import CoreData


// меняем additionalVars downloadButtonPressed getParams showInfo // setAttributes setConstraints 
class downloadVC: UIViewController, DownloadDelegate {
    
    var downloadButton = UIButton()
    var closeButton = UIButton()
    var restoreButton = UIButton()
    
    var waitingView = UIView()
    var waitingLabel = UILabel()
    
    var iphoneConstraints = false
    
    weak var iapDelegate: IAPManagerDelegate?
    var skProducts = [SKProduct]()
    var restored =  [String]()
    var purchased =  [String]()
    
    var section: Section?
    var sections = [Section]()
    var moc: NSManagedObjectContext?
    
    // additionalVars
    var fullImageView = UIImageView()
    
    
    let restoringMessage = lang_scheme[cur_lang]?["restoringMessage"] as? String ?? ""
    let loadingMessage = lang_scheme[cur_lang]?["loadingMessage"] as? String ?? ""
    let errorTitle = lang_scheme[cur_lang]?["errorTitle"] as? String ?? ""
    let errorMessage = lang_scheme[cur_lang]?["errorMessage"] as? String ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setConstraints()
        getParams()
        showInfo()
        fetchProducts()
    }

    
    func getParams() {
        moc = getContext()
        let selectedSectionId = userDefaults.integer(forKey: "selectedSectionId")
        let predicate1 = NSPredicate(format: "id = %d", selectedSectionId)
        section = getEntity(type: Section.self, moc: moc, predicates: [predicate1]).first
        
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        sections = getEntity(type: Section.self, moc: moc, sortdDescriptors: [sortdDescriptor])
        
        /*
         
         */
    }
    
    func showInfo() {
        
    }

    
    func setAttributes() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        closeButton.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        
        
        //downloadButton.setBackgroundImage(UIImage(named: "downloadButton_\(cur_lang)"), for: .normal)
        //restoreButton.setBackgroundImage(UIImage(named: "restorePurchaseButton_\(cur_lang)"), for: .normal)
        
        fullImageView.image = UIImage(named: "fullVersion_\(cur_lang)")
        downloadButton.setBackgroundImage(UIImage(named: "downloadButton"), for: .normal)
        restoreButton.setBackgroundImage(UIImage(named: "restorePurchaseButton"), for: .normal)
        
        downloadButton.setTitle("", for: .normal)
        restoreButton.setTitle("", for: .normal)
        closeButton.setTitle("", for: .normal)
        
        waitingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.addSubview(waitingView)
        self.view.addSubview(waitingLabel)
        waitingView.isHidden = true
        waitingLabel.isHidden = true
        waitingLabel.textColor = .white
        
        self.view.addSubview(fullImageView)
        self.view.addSubview(downloadButton)
        self.view.addSubview(closeButton)
        self.view.addSubview(restoreButton)
        
        
        fullImageView.contentMode = .scaleAspectFit
        
        downloadButton.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        downloadButton.contentMode = .scaleAspectFit
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.contentMode = .scaleAspectFit
        
        restoreButton.addTarget(self, action: #selector(restoreButtonPressed), for: .touchUpInside)
        restoreButton.contentMode = .scaleAspectFit
    }
    
    //###############################################################################################################
            @objc func restoreButtonPressed() {
                waitingView.isHidden = false
                waitingLabel.isHidden = false
                waitingLabel.text = restoringMessage
                restorePurchase()
            }
            
            @objc func closeButtonPressed() {
                self.dismiss(animated: false, completion: nil)
            }
            
            @objc func tryFreeVersionButtonPressed() {
                self.dismiss(animated: true, completion: nil)
                iapDelegate?.trySectionForFree()
            }
            
            @objc func getAllSectionsButtonPressed() {
                waitingView.isHidden = false
                waitingLabel.isHidden = false
                waitingLabel.text = loadingMessage
                let prodId = bundle_id + ".allSections"

                addPayment(productId: prodId)
            }
    
            @objc func downloadButtonPressed() {
                if withParentalGate {
                    openParentalGate()
                } else {
                    showInAppWindow()
                }
            }
    
            func openParentalGate() {
                UserDefaults.standard.set("fromDownload", forKey: "fromView")
                if let parVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "parentalGateVC") as? parentalGateVC {
                    parVC.downloadDelegate = self

                    addChild(parVC)
                    self.view.addSubview(parVC.view)
                    parVC.didMove(toParent: self)
                }
            }
    
            func showInAppWindow() {
                self.waitingView.isHidden = false
                self.waitingLabel.isHidden = false
                self.waitingLabel.text = loadingMessage
                
                //one in app
                self.addPayment(productId: product_id)
                
                /*
                //many in apps
                if let prodId = self.section?.product_id { self.addPayment(productId: prodId) }
                else {
                    self.waitingView.isHidden = true
                    self.waitingLabel.isHidden = true
                    self.waitingLabel.text = ""
                    showAlertOk(title: errorTitle, message: errorMessage)
                }
                */
            }
            

    
    //###############################################################################################################
    
    func setConstraints() {
        
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        let safeArea = view.layoutMarginsGuide

        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        waitingLabel.translatesAutoresizingMaskIntoConstraints = false
        waitingView.translatesAutoresizingMaskIntoConstraints = false
        
        waitingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        waitingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        waitingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        waitingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        waitingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        waitingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        fullImageView.widthAnchor.constraint(equalTo: fullImageView.heightAnchor, multiplier: 500.0/812.0).isActive = true
        
        downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadButton.widthAnchor.constraint(equalTo: downloadButton.heightAnchor, multiplier: 316/52).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: restoreButton.topAnchor, constant: -10).isActive = true
        
        restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreButton.widthAnchor.constraint(equalTo: restoreButton.heightAnchor, multiplier: 316/52).isActive = true
        restoreButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        
        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 64/56).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0.0).isActive = true
        

        if iphoneConstraints {
            fullImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            fullImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            downloadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 316/375*0.9).isActive = true
            restoreButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 316/375*0.9).isActive = true
        
            closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 64/375*0.7).isActive = true
        } else {
            fullImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            fullImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            fullImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            
            downloadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 316/500*widthCoefiPad).isActive = true
            restoreButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 316/500*widthCoefiPad).isActive = true
            
            closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 64/500*0.7).isActive = true
        }
        
        for itemView in [fullImageView, downloadButton, restoreButton, closeButton, waitingView, waitingLabel] {
            view.bringSubviewToFront(itemView)
        }
    }
}

