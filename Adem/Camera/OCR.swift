//
//  OCR.swift
//  Adem
//
//  Created by Coleman Coats on 12/30/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import MLKit

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


class camAddHouseView: UIView {
    
    
    //https://stackoverflow.com/questions/28487146/how-to-add-live-camera-preview-to-uiview
    
    var previewView : UIView!
    var boxView:UIView!
        let myButton: UIButton = UIButton()

        //Camera Capture requiered properties
        var videoDataOutput: AVCaptureVideoDataOutput!
        var videoDataOutputQueue: DispatchQueue!
        var previewLayer:AVCaptureVideoPreviewLayer!
        var captureDevice : AVCaptureDevice!
        let session = AVCaptureSession()

    override init(frame: CGRect) {
      super.init(frame: frame)
            previewView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.size.width,
                                               height: UIScreen.main.bounds.size.height))
            previewView.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(previewView)

            //Add a view on top of the cameras' view
            boxView = UIView(frame: self.frame)

            myButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
            myButton.backgroundColor = UIColor.red
            myButton.layer.masksToBounds = true
            myButton.setTitle("press me", for: .normal)
            myButton.setTitleColor(UIColor.white, for: .normal)
            myButton.layer.cornerRadius = 20.0
            myButton.layer.position = CGPoint(x: self.frame.width/2, y:200)
            myButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: .touchUpInside)

        self.addSubview(boxView)
            self.addSubview(myButton)

            self.setupAVCapture()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shouldAutorotate: Bool {
            if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
            UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
            UIDevice.current.orientation == UIDeviceOrientation.unknown) {
                return false
            }
            else {
                return true
            }
        }

        @objc func onClickMyButton(sender: UIButton){
            print("button pressed")
        }
    }


    // AVCaptureVideoDataOutputSampleBufferDelegate protocol and related methods
    extension camAddHouseView:  AVCaptureVideoDataOutputSampleBufferDelegate{
         func setupAVCapture(){
            session.sessionPreset = AVCaptureSession.Preset.vga640x480
            guard let device = AVCaptureDevice
            .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                     for: .video,
                     position: AVCaptureDevice.Position.back) else {
                                return
            }
            captureDevice = device
            beginSession()
        }

        func beginSession(){
            var deviceInput: AVCaptureDeviceInput!

            do {
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
                guard deviceInput != nil else {
                    print("error: cant get deviceInput")
                    return
                }

                if self.session.canAddInput(deviceInput){
                    self.session.addInput(deviceInput)
                }

                videoDataOutput = AVCaptureVideoDataOutput()
                videoDataOutput.alwaysDiscardsLateVideoFrames=true
                videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
                videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

                if session.canAddOutput(self.videoDataOutput){
                    session.addOutput(self.videoDataOutput)
                }

                videoDataOutput.connection(with: .video)?.isEnabled = true

                previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect

                let rootLayer :CALayer = self.previewView.layer
                rootLayer.masksToBounds=true
                previewLayer.frame = rootLayer.bounds
                rootLayer.addSublayer(self.previewLayer)
                session.startRunning()
            } catch let error as NSError {
                deviceInput = nil
                print("error: \(error.localizedDescription)")
            }
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            // do stuff here
        }

        // clean up AVCapture
        func stopCamera(){
            session.stopRunning()
        }
    }
