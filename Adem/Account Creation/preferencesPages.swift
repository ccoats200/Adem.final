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

//MARK: Second attempt at flow
class signInFlowViewControllerTwo: UIPageViewController {
    
    var pages = [UIViewController]()

    let flavorPage = addedFlavorPreferences()
    let dietPage = addedDietPreferencesTwo()
    let storePage = addedStorePreferencesTwo()
    let thankYouPage = thankYouPreferences()
    //let thankYouPage = circleTest()

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
    

    var currentPage = 0
    var prog: Float = 0.00
    
    func sendForward() {
            currentPage+=1
            signInFlow.setViewControllers([signInFlow.pages[currentPage]], direction: .forward, animated: true, completion: nil)
            
            if prog < Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1)) {
                prog += (Float((signInFlow.pages.count-1)/(signInFlow.pages.count-1))/Float((signInFlow.pages.count-1)))
                print(prog)
                bottomView.pBar.progress = prog
            }
            
            //MARK: Capture the time of the tap
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let time = dateFormatter.string(from: Date())
            print(time)
            
            print("The button is working on page \(currentPage)")
    }
    
    @objc func sendUserToNextScreen() {

        if currentPage < ((signInFlow.pages.count)-1) {
            sendForward()
        } else {
            sendToHomeScreen()
        }
    }
    
        
    func sendToHomeScreen() {
        
        let listController = tabBar()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = listController
        appDelegate.window?.makeKeyAndVisible()
        //self.dismiss(animated: true, completion: nil)
        print("There are no more pages \(currentPage)")
        
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
