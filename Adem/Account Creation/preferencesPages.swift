//
//  preferencesPages.swift
//  Adem
//
//  Created by Coleman Coats on 1/30/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAnalytics

class signUpUserFlow: UIPageViewController {
    
    var pages = [UIViewController]()

    let dietPage = addedDietPreferencesTwo()
    let flavorPage = addedFlavorPreferences()
    let storePage = addedStorePreferencesTwo()
    let thankYouPage = thankYouPreferences()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let colors: [UIColor] = [
        .purple,
        .green,
        .blue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationItem.title = "please2"
          
        //MARK: Remove data source to stop scroll
//        self.dataSource = self
        self.dataSource = nil
        self.delegate = nil
        
        let initialPage = 0
        pages.append(dietPage)
        pages.append(flavorPage)
        pages.append(storePage)
        pages.append(thankYouPage)
        
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

extension signUpUserFlow: UIPageViewControllerDataSource {

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


extension signUpUserFlow: UIPageViewControllerDelegate {

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

class userCreation: UIViewController {

    var signInFlow = signUpUserFlow()
    var bottomView = preferenceNextViews()
    var currentPage = 0
    var prog: Float = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        // instantiate MyPageViewController and add it as a Child View Controller
        signInFlow = signUpUserFlow()
        addChild(signInFlow)
        // we need to re-size the page view controller's view to fit our container view
        signInFlow.view.translatesAutoresizingMaskIntoConstraints = false
        // add the page VC's view to our container view
        view.addSubview(signInFlow.view)
        setUpConstraint()
        signInFlow.didMove(toParent: self)
        //FIXME: needs to be include the first count
        bottomView.pBar.progress = prog
        //MARK: Buttons
        setUpButton()
    }
    
    private func setUpButton() {
        bottomView.nextButton.largeNextButton.addTarget(self, action: #selector(sendUserToNextScreen), for: .touchUpInside)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.ademBlue.cgColor,UIColor.ademGreen.cgColor]
        //Top left
        gradient.startPoint = CGPoint(x: 0, y: 0)
        //Top right
        gradient.endPoint = CGPoint(x: 1, y: 1)
        //bottomView.nextButton.layer.addSublayer(gradient)
    }
    
    func sendForward() {
        currentPage+=1
        signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .forward, animated: true, completion: nil)
        
        if prog < Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1)) {
            prog += (Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1))/Float((signInFlow.pages.count-1)))
            bottomView.pBar.progress = prog
        }
    }
    
    @objc func sendUserToNextScreen() {
        if currentPage < ((signInFlow.pages.count)-1) {
            sendForward()
        } else {
            sendToListScreen()
        }
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

            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            signInFlow.view.topAnchor.constraint(equalTo: view.topAnchor),
            signInFlow.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            signInFlow.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInFlow.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
