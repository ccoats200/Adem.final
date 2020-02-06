//
//  circularProgressBar.swift
//  Adem
//
//  Created by Coleman Coats on 10/6/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class circleTest: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        let center = view.center
        
        //http://www.math.com/tables/geometry/circles.htm
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 100,
                                        startAngle: (-CGFloat.pi/2),//((3/2) * CGFloat.pi),//(-CGFloat.pi/2),
                                        endAngle: (2 * CGFloat.pi),//((5/3) * CGFloat.pi),//(/2 * CGFloat.pi),
                                        clockwise: true)
        
        
        circleTrackLayer.path = circularPath.cgPath
        
        
        
        
        circleShapeLayer.path = circularPath.cgPath
        

        view.layer.addSublayer(circleTrackLayer)
        view.layer.addSublayer(circleShapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    let circleShapeLayer: CAShapeLayer = {
        
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.ademRed.cgColor
        shape.lineWidth = 5
        shape.strokeEnd = 0
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = .round
        
        return shape
    }()
    
    //Create track
    let circleTrackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.strokeColor = UIColor.ademGreen.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        return trackLayer
    }()
    
    let welcomeView: UIView = {
        var welcomeView = UIView()
        welcomeView.backgroundColor = UIColor.red
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        return welcomeView
    }()
    
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
        welcome.text = "Thank you!"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.ademBlue
        welcome.font = UIFont(name:"HelveticaNeue", size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()

    let strokeEndKey = "strokeEnd"
    let circKey = "circleShapeLayerKey"
    
    @objc private func handleTap() {
        print("attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: strokeEndKey)
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        circleShapeLayer.add(basicAnimation, forKey: circKey)
        setUpConstraint()
    }
    
    
    private func setUpConstraint() {
        
        view.addSubview(welcomeView)
        view.addSubview(welcomeLabel)
        
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            
            welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeView.widthAnchor.constraint(equalToConstant: 125),
            welcomeView.heightAnchor.constraint(equalToConstant: 75),
        
            welcomeLabel.centerYAnchor.constraint(equalTo: welcomeView.centerYAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: welcomeView.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalToConstant: 125),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 75),
    ])
   
}
}
