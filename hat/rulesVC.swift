//
//  rulesVC.swift
//  hat
//
//  Created by Alisa Potapova on 01.12.2025.
//


import UIKit

class rulesVC: UIViewController, UIPageViewControllerDataSource {
    
    let userDefaults = UserDefaults.standard
    var iphoneConstraints = false
    
    var rateButton = UIButton()
    var askButton = UIButton()
    var backgroundImg = UIImageView()
    
    var pageViewController: UIPageViewController?
    
    var pageImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = (1...rulesPagesCount).map { "rules\($0)_\(cur_lang)" }
        
        setBackButton()
        setAttributes()
        setConstraints()
    
        createPageViewController()
        setupPageControl()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hideNavigationBar()
        // цвет и шрифт навигационной панели
        navigationController?.setNavigationBar(backgroundColor: navigationBarBackgroundColor) //navigationBarBackgroundColor
        // название контроллера
        navigationItem.title = (lang_scheme[cur_lang]?["rulesVCTitle"] as? String ?? "navigationBar title").uppercased()
    }
    
    override func backButtonPressed() {
        //some action here
        
        goBackTo(backToMenu: false)
    }
    
    func setAttributes() {
        
        iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        
        
        backgroundImg.contentMode = .scaleAspectFit
        backgroundImg.image = UIImage(named: "background") //background
        self.view.addSubview(backgroundImg)
        
        
        rateButton.addTarget(self, action: #selector(rateButtonPressed), for: .touchUpInside)
        rateButton.contentMode = .scaleAspectFit
        rateButton.setBackgroundImage(UIImage(named: "rateAppButton_\(cur_lang)"), for: .normal)
        rateButton.setTitle("", for: .normal)
        self.view.addSubview(rateButton)
        
        askButton.addTarget(self, action: #selector(askButtonPressed), for: .touchUpInside)
        askButton.contentMode = .scaleAspectFit
        askButton.setBackgroundImage(UIImage(named: "askButton_\(cur_lang)"), for: .normal)
        askButton.setTitle("", for: .normal)
        self.view.addSubview(askButton)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        self.didReceiveMemoryWarning()
    }
    
    
    @objc func rateButtonPressed(_ sender: Any) {
        if withParentalGate {
            UserDefaults.standard.set("fromRateApp", forKey: "fromView")
            showPopupVC("parentalGateVC")
        } else {
            rateApp()
        }
    }
    
    @objc func askButtonPressed(_ sender: Any) {
        if withParentalGate {
            UserDefaults.standard.set("fromAskQuestion", forKey: "fromView")
            showPopupVC("parentalGateVC")
        } else {
            showEmail()
        }
    }
    
    
    
    func createPageViewController()
    {
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        
        pageController.dataSource = self
        
        if pageImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
        
        pageViewController = pageController
        
        
        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        
        let safeArea = view.layoutMarginsGuide
        pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController!.view.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        pageViewController!.view.bottomAnchor.constraint(equalTo: rateButton.topAnchor, constant: -20).isActive = true
        pageViewController!.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageViewController!.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.bringSubviewToFront(pageViewController!.view)
        
        /*
        let iphoneConstraints = UIDevice.current.userInterfaceIdiom == .phone
        let coef: CGFloat = iphoneConstraints ? 0.25 : 0.18
        pageViewController!.view.frame = CGRect(x:0, y:30, width: self.view.frame.width, height: self.view.frame.height - self.view.frame.height*coef )
        
        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        view.bringSubviewToFront(pageViewController!.view)
         */
    }
    
    func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = rulesAllPagesCircleColor
        appearance.currentPageIndicatorTintColor = rulesCurrentPageCircleColor
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentController = viewController as! rulesPageVC
        if contentController.pageIndex > 0 {
            return getItemController(contentController.pageIndex-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentController = viewController as! rulesPageVC
        if contentController.pageIndex+1 < pageImages.count {
            return getItemController(contentController.pageIndex+1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func currentControllerIndex() -> Int {
        let pageContentViewController = self.currentController()
        if let controller = pageContentViewController as? rulesPageVC {
            return controller.pageIndex
        }
        return -1
    }
    
    func currentController() -> UIViewController? {
        if (self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        return nil
    }
    
    func getItemController(_ itemIndex: Int) -> rulesPageVC? {
        if itemIndex < pageImages.count {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "rulesPageVC") as! rulesPageVC
            pageContentViewController.pageIndex = itemIndex
            pageContentViewController.imageFile = "rules" + "\(itemIndex + 1)"
            return pageContentViewController
        }
        return nil
    }

    func setConstraints() {
        let safeArea = view.layoutMarginsGuide
        
        backgroundImg.translatesAutoresizingMaskIntoConstraints = false
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        askButton.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImg.widthAnchor.constraint(equalTo: backgroundImg.heightAnchor, multiplier: 500.0/812.0).isActive = true
        
        rateButton.widthAnchor.constraint(equalTo: rateButton.heightAnchor, multiplier: 248.0/52.0).isActive = true
        rateButton.bottomAnchor.constraint(equalTo: askButton.topAnchor, constant: -10).isActive = true
        rateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        askButton.widthAnchor.constraint(equalTo: askButton.heightAnchor, multiplier: 248.0/52.0).isActive = true
        askButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        askButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        if iphoneConstraints {
            
            backgroundImg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundImg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

            rateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248.0/375.0*widthCoefiPhone).isActive = true
            askButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248.0/375.0*widthCoefiPhone).isActive = true

        } else {
            
            backgroundImg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundImg.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundImg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            rateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248.0/500.0*widthCoefiPad).isActive = true
            askButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 248.0/500.0*widthCoefiPad).isActive = true
   
        }
        
        
        for itemView in [backgroundImg, rateButton, askButton] {
            view.bringSubviewToFront(itemView)
        }
    }
        
}
