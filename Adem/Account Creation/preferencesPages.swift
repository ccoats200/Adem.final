//
//  preferencesPages.swift
//  Adem
//
//  Created by Coleman Coats on 1/30/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    //var views = [UIView]()
    let pageControl = UIPageControl()
    
    
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
    
    let flavorPage = addedFoodPreference()
    let dietPage = addedFoodPreference()
    let storePage = addedFoodPreference()
    let thankYouPage = addedFoodPreference()



    var topView = preferenceProgressViews()
    var bottomView = preferenceNextViews()
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        
        // add the individual viewControllers to the pageViewController
        self.pages.append(flavorPage)
        self.pages.append(dietPage)
        self.pages.append(storePage)
        self.pages.append(thankYouPage)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        
//        // pageControl
//        self.pageControl.frame = CGRect()
//        self.pageControl.currentPageIndicatorTintColor = UIColor.ademBlue
//        self.pageControl.pageIndicatorTintColor = UIColor.ademGreen
//        self.pageControl.numberOfPages = pages.count
//        self.pageControl.currentPage = initialPage
        
        
       setUpLayout()
    }
    
    
    
    func setUpLayout() {
        //self.view.addSubview(topView)
        self.view.addSubview(bottomView)
        //self.view.addSubview(pages)
        //self.view.addSubview(self.pageControl)
        
        //self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        //self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            self.topView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            self.topView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            self.topView.heightAnchor.constraint(equalToConstant: 50),
//            self.topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.bottomView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 100),
            self.bottomView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
   
}
