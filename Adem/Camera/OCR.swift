//
//  OCR.swift
//  Adem
//
//  Created by Coleman Coats on 12/30/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import AVFoundation


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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    captureSession.startRunning()
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
      fatalError("Error configuring capture device: \(error)");
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
    
    let signUpInfo = IVC()
    //self.navigationController?.pushViewController(signUpInfo, animated: true)
    signUpInfo.image = readyImage
    self.present(signUpInfo, animated: true, completion: nil)
  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender)
      if let imageViewController = segue.destination as? IVC {
        imageViewController.image = readyImage
      }
    }
}
