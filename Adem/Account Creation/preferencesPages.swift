//
//  preferencesPages.swift
//  Adem
//
//  Created by Coleman Coats on 1/30/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class signInFlowViewController: UIPageViewController {
    
    var pages = [UIViewController]()

    let flavorPage = addedFoodPreference()
    let dietPage = addedFoodPreference()
    let storePage = addedFoodPreference()
    let thankYouPage = addedFoodPreference()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


//    var topView = preferenceProgressViews()
//    var bottomView = preferenceNextViews()
    
    let colors: [UIColor] = [
        .red,
        .green,
        .blue,
        .purple,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "please2"
          
        //MARK: Remove data source to stop scroll
//        self.dataSource = self
        self.dataSource = nil
        self.delegate = nil
        
        let initialPage = 0
        
        
        // add the individual viewControllers to the pageViewController
//        self.pages.append(flavorPage)
//        self.pages.append(dietPage)
//        self.pages.append(storePage)
//        self.pages.append(thankYouPage)
        
        for i in 0..<colors.count {
            let vc = addedFoodPreference()
            //vc. = "Page: \(i)"
            vc.view.backgroundColor = colors[i]
            pages.append(vc)
        }
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        setUpLayout()
    }
    
    
    
    func setUpLayout() {
        //self.view.addSubview(topView)
//        self.view.addSubview(bottomView)
        //self.view.addSubview(pages)
        //self.view.addSubview(self.pageControl)
        
        //self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        //self.topView.translatesAutoresizingMaskIntoConstraints = false
//        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            self.topView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            self.topView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            self.topView.heightAnchor.constraint(equalToConstant: 50),
//            self.topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            
//            self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            self.bottomView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            self.bottomView.heightAnchor.constraint(equalToConstant: 100),
//            self.bottomView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                //self.pageControl.currentPage = viewControllerIndex
            }
        }
    }

}

extension signInFlowViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
}


extension signInFlowViewController: UIPageViewControllerDelegate {

    //MARK: if you do NOT want the built-in PageControl (the "dots"), comment-out these funcs
    //FIXME: get the next button working here?
    
    /*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstVC = pageViewController.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else {
            return 0
        }

        return firstVCIndex
    }
 */
    
}

class MyTestViewController: UIViewController {

    let myContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        return v
    }()

    var signInFlow = signInFlowViewController()
    var bottomView = preferenceNextViews()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = UIColor.white
//        self.navigationController?.navigationItem.leftBarButtonItem = button1

        //self.title = "please1"
        // add myContainerView
        view.addSubview(myContainerView)
        myContainerView.addSubview(bottomView)

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        // constrain it - here I am setting it to
        //  40-pts top, leading and trailing
        //  and 200-pts height
        setUpConstraint()

        // instantiate MyPageViewController and add it as a Child View Controller
        signInFlow = signInFlowViewController()
        addChild(signInFlow)

        // we need to re-size the page view controller's view to fit our container view
        signInFlow.view.translatesAutoresizingMaskIntoConstraints = false

        // add the page VC's view to our container view
        myContainerView.addSubview(signInFlow.view)
        //myContainerView.addSubview(bottomView)

        setUpSignConstraint()
       
        signInFlow.didMove(toParent: self)
        
        //MARK: Buttons
        setUpButton()
    }
    
    
    
    private func setUpButton() {
        bottomView.nextButton.addTarget(self, action: #selector(sendUserToNextScreen), for: .touchUpInside)
    }
    
//    let button1 = UIBarButtonItem(image: UIImage(named: "account"), style: .plain, target: self, action: #selector(testReverse))
    
    var currentPage = 0
    var prog: Float = 0.00
    
    @objc func sendUserToNextScreen() {
        //This needs to be the next page button
        //I need to remove the scroll function so that they cant scroll back
        
        if currentPage < ((signInFlow.pages.count)-1) {
        currentPage+=1
        
        signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .forward, animated: true, completion: nil)
            
            if prog < Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1)) {
                prog += (Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1))/Float((signInFlow.pages.count-1)))
                print(prog)
                bottomView.pBar.progress = prog
            }
            print("The button is working on page \(currentPage)")
        } else { print("There are no more pages \(currentPage)") }
    }
    
    @objc func testReverse() {
           //This needs to be the next page button
           //I need to remove the scroll function so that they cant scroll back
           
           if currentPage < ((signInFlow.pages.count)-1) {
           currentPage-=1
           
           signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .reverse, animated: true, completion: nil)
               print("The button is working on page \(currentPage)")
           } else { print("There are no more pages \(currentPage)") }
       }
    
    
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
        myContainerView.topAnchor.constraint(equalTo: view.topAnchor),
        myContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        myContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
        myContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        bottomView.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor),
        bottomView.widthAnchor.constraint(equalTo: myContainerView.widthAnchor),
        bottomView.heightAnchor.constraint(equalToConstant: 100),
        bottomView.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor),
        ])
        
    }
    
    private func setUpSignConstraint() {
         // constrain it to all 4 sides
               NSLayoutConstraint.activate([
                   
                   signInFlow.view.topAnchor.constraint(equalTo: myContainerView.topAnchor),
                   signInFlow.view.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor, constant: -100),
                   signInFlow.view.leadingAnchor.constraint(equalTo: myContainerView.leadingAnchor),
                   signInFlow.view.trailingAnchor.constraint(equalTo: myContainerView.trailingAnchor),
                   
               ])
    }
}


//MARK: Second attempt at flow
class signInFlowViewControllerTwo: UIPageViewController {
    
    var pages = [UIViewController]()

    let flavorPage = addedFlavorPreferences()
    let dietPage = addedDietPreferencesTwo()
    let storePage = addedStorePreferencesTwo()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let colors: [UIColor] = [
        .purple,
        .green
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "please2"
          
        //MARK: Remove data source to stop scroll
//        self.dataSource = self
        self.dataSource = nil
        self.delegate = nil
        
        let initialPage = 0
        
        
        // add the individual viewControllers to the pageViewController
//        self.pages.append(flavorPage)
//        self.pages.append(dietPage)
//        self.pages.append(storePage)
//        self.pages.append(thankYouPage)
        
        for i in 0..<colors.count {
            flavorPage.view.backgroundColor = colors[i]
          
            pages.append(flavorPage)
            pages.append(dietPage)
            pages.append(storePage)
        }
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                //self.pageControl.currentPage = viewControllerIndex
            }
        }
    }

}

extension signInFlowViewControllerTwo: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
}


extension signInFlowViewControllerTwo: UIPageViewControllerDelegate {

    //MARK: if you do NOT want the built-in PageControl (the "dots"), comment-out these funcs
    //FIXME: get the next button working here?
    
    /*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstVC = pageViewController.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else {
            return 0
        }

        return firstVCIndex
    }
 */
    
}

class userFlowViewControllerTwo: UIViewController {

    let myContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        return v
    }()

    var signInFlow = signInFlowViewControllerTwo()
    var bottomView = preferenceNextViews()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = UIColor.white

        view.addSubview(myContainerView)
        myContainerView.addSubview(bottomView)

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        // constrain it - here I am setting it to
        //  40-pts top, leading and trailing
        //  and 200-pts height
        setUpConstraint()

        // instantiate MyPageViewController and add it as a Child View Controller
        signInFlow = signInFlowViewControllerTwo()
        addChild(signInFlow)

        // we need to re-size the page view controller's view to fit our container view
        signInFlow.view.translatesAutoresizingMaskIntoConstraints = false

        // add the page VC's view to our container view
        myContainerView.addSubview(signInFlow.view)
        //myContainerView.addSubview(bottomView)

        setUpSignConstraint()
       
        signInFlow.didMove(toParent: self)
        
        //MARK: Buttons
        setUpButton()
    }
    
    
    
    private func setUpButton() {
        bottomView.nextButton.addTarget(self, action: #selector(sendUserToNextScreen), for: .touchUpInside)
    }
    

    var currentPage = 0
    var prog: Float = 0.00
    
    @objc func sendUserToNextScreen() {
        //This needs to be the next page button
        //I need to remove the scroll function so that they cant scroll back
        
        if currentPage < ((signInFlow.pages.count)-1) {
        currentPage+=1
        
        signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .forward, animated: true, completion: nil)
            
            if prog < Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1)) {
                prog += (Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1))/Float((signInFlow.pages.count-1)))
                print(prog)
                bottomView.pBar.progress = prog
            }
            print("The button is working on page \(currentPage)")
        } else { print("There are no more pages \(currentPage)") }
    }
    
    @objc func testReverse() {
           //This needs to be the next page button
           //I need to remove the scroll function so that they cant scroll back
           
           if currentPage < ((signInFlow.pages.count)-1) {
           currentPage-=1
           
           signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .reverse, animated: true, completion: nil)
               print("The button is working on page \(currentPage)")
           } else { print("There are no more pages \(currentPage)") }
       }
    
    
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
        
        myContainerView.topAnchor.constraint(equalTo: view.topAnchor),
        myContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        myContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
        myContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        bottomView.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor),
        bottomView.widthAnchor.constraint(equalTo: myContainerView.widthAnchor),
        bottomView.heightAnchor.constraint(equalToConstant: 100),
        bottomView.centerXAnchor.constraint(equalTo: myContainerView.centerXAnchor),
        ])
        
    }
    
    private func setUpSignConstraint() {
         // constrain it to all 4 sides
               NSLayoutConstraint.activate([
                   
                   signInFlow.view.topAnchor.constraint(equalTo: myContainerView.topAnchor),
                   signInFlow.view.bottomAnchor.constraint(equalTo: myContainerView.bottomAnchor, constant: -100),
                   signInFlow.view.leadingAnchor.constraint(equalTo: myContainerView.leadingAnchor),
                   signInFlow.view.trailingAnchor.constraint(equalTo: myContainerView.trailingAnchor),
                   
               ])
    }
}
