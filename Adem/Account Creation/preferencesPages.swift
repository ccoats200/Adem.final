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
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.dataSource = self
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

    // if you do NOT want the built-in PageControl (the "dots"), comment-out these funcs

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstVC = pageViewController.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.index(of: firstVC) else {
            return 0
        }

        return firstVCIndex
    }
}

class MyTestViewController: UIViewController {

    let myContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        return v
    }()

    var signInFlow: signInFlowViewController!
    var bottomView = preferenceNextViews()
    override func viewDidLoad() {
        super.viewDidLoad()

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
        bottomView.nextButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        
    }
    
    @objc func test() {
        //This needs to be the next page button
        //I need to remove the scroll function so that they cant scroll back
        
        print("The button is working")
    }
    
    
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
        myContainerView.topAnchor.constraint(equalTo: view.topAnchor),
        myContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        myContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
        myContainerView.heightAnchor.constraint(equalToConstant: 500.0),
        
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
