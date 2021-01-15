//
//  OCR.swift
//  Adem
//
//  Created by Coleman Coats on 12/30/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Firebase
import MLKit
import CoreVideo



class camVC: UIViewController {

    //http://www.goldsborough.me/swift/ios/app/ml/2018/12/10/20-49-02-using_the_google_cloud_vision_api_for_ocr_in_swift/
    var captureSession: AVCaptureSession!
    var tapRecognizer: UITapGestureRecognizer!
    var capturePhotoOutput: AVCapturePhotoOutput!
    var readyImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupTapRecognizer()
        setupPhotoOutput()
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    
        captureSession.startRunning()
        setupCloseButton()
    }
    
    private func setupPhotoOutput() {
      capturePhotoOutput = AVCapturePhotoOutput()
      capturePhotoOutput.isHighResolutionCaptureEnabled = true
      captureSession.addOutput(capturePhotoOutput!)
    }
    
    private func setupTapRecognizer() {
      tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
      tapRecognizer?.numberOfTapsRequired = 1
      tapRecognizer?.numberOfTouchesRequired = 1
      view.addGestureRecognizer(tapRecognizer!)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
      if sender.state == .ended {
        capturePhoto()
      }
    }
    
    private func setupCloseButton() {
      let closeButton = UIButton()
      view.addSubview(closeButton)

      // Stylistic features.
      closeButton.setTitle("✕", for: .normal)
      closeButton.setTitleColor(UIColor.white, for: .normal)
      closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)

      // Add a target function when the button is tapped.
      closeButton.addTarget(self, action: #selector(cameraViewClose), for: .touchDown)

      // Constrain the button to be positioned in the top left corner (with some offset).
      closeButton.translatesAutoresizingMaskIntoConstraints = false
      closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
    @objc func cameraViewClose() {
        self.dismiss(animated: true, completion: nil)
    }

  

  override func viewWillDisappear(_ animated: Bool) {
    captureSession.stopRunning()
  }

    private func setupCamera() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        var input: AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
            
        } catch {
            fatalError("Error configuring capture device: \(error)")
        }
        captureSession = AVCaptureSession()
        captureSession.addInput(input)

        // Setup the preview view.
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
    
  }
}

extension camVC : AVCapturePhotoCaptureDelegate {
    
    private func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput?.capturePhoto(with: photoSettings, delegate: self)
        
    }

  func photoOutput(_ output: AVCapturePhotoOutput,
                   didFinishProcessingPhoto photo: AVCapturePhoto,
                   error: Error?) {
    guard error == nil else {
      fatalError("Failed to capture photo: \(String(describing: error))")
    }
    guard let imageData = photo.fileDataRepresentation() else {
      fatalError("Failed to convert pixel buffer")
    }
    guard let image = UIImage(data: imageData) else {
      fatalError("Failed to convert image data to UIImage")
    }
    readyImage = image
    //createAccount.addTarget(self, action: #selector(handelNext), for: .touchUpInside)
    
    let productImageCaptured = IVC()
    //self.navigationController?.pushViewController(signUpInfo, animated: true)
    productImageCaptured.image = readyImage
    
    productImageCaptured.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    self.present(productImageCaptured, animated: true, completion: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender)
      if let imageViewController = segue.destination as? IVC {
        imageViewController.image = readyImage
      }
    }
}


