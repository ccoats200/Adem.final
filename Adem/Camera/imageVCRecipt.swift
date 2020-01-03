//
//  imageVCRecipt.swift
//  Adem
//
//  Created by Coleman Coats on 12/30/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//


import UIKit

class IVC: UIViewController {

  var image: UIImage!

  override func viewDidLoad() {
    super.viewDidLoad()

    let imageView = UIImageView(frame: view.frame)
    imageView.image = image
    view.addSubview(imageView)

    setupCloseButton() // NEW
  }

  private func setupCloseButton() {
    let closeButton = UIButton()
    view.addSubview(closeButton)

    // Stylistic features.
    closeButton.setTitle("✕", for: .normal)
    closeButton.setTitleColor(UIColor.white, for: .normal)
    closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)

    // Add a target function when the button is tapped.
    closeButton.addTarget(self, action: #selector(closeAction), for: .touchDown)

    // Constrain the button to be positioned in the top left corner (with some offset).
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
  }

  @objc private func closeAction() {
    dismiss(animated: false, completion: nil)
  }
}
