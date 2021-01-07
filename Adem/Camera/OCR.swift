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

protocol QRScannerViewDelegate: class {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
}

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


class QRScannerView: UIView {
    
    //https://github.com/azamsharp/FirebaseML/blob/master/FirebaseML/BarCodeDetectorViewController.swift
    
    weak var delagate: QRScannerViewDelegate?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    lazy var vision = Vision.vision()
    var barcodeDetector :VisionBarcodeDetector?
    var newHome = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        doInitialSetup()
        self.barcodeDetector = vision.barcodeDetector()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        doInitialSetup()
        self.barcodeDetector = vision.barcodeDetector()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            
        if let barcodeDetector = self.barcodeDetector {
        //let visionImage = VisionImage(buffer: sampleBuffer)
            barcodeDetector.detect(in: .init(buffer: sampleBuffer)) { (barcodes, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                    }
                for barcode in barcodes! {
                    self.newHome = barcode.rawValue!
                    //This should be one time
                    //Confirm and merge lists
                    userfirebasehome.updateData([
                                                    "home" : self.newHome])
                }
            }
        }
    }
    override class var layerClass: AnyClass{
        return AVCaptureVideoPreviewLayer.self
    }
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
}


extension QRScannerView: AVCaptureVideoDataOutputSampleBufferDelegate {

    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    
    func stopScanning() {
        captureSession?.stopRunning()
        delagate?.qrScanningDidStop()
    }
    
    private func doInitialSetup() {
        clipsToBounds = true
        captureSession = AVCaptureSession()
        
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let deviceOutput = AVCaptureVideoDataOutput()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        } catch let error {
            print(error)
            return
        }
        if (captureSession?.canAddInput(videoInput) ?? false) {
            
            captureSession?.addInput(videoInput)
            captureSession?.addOutput(deviceOutput)            
        } else {
            scanningDidFail()
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        captureSession?.startRunning()
    }
    
    func scanningDidFail() {
        delagate?.qrScanningDidFail()
        captureSession = nil
    }
    func found(code: String) {
        delagate?.qrScanningSucceededWithCode(code)
        print(code)
    }
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
   
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
       stopScanning()
        
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            print("this it the home \(stringValue)")
        }
    }
}
