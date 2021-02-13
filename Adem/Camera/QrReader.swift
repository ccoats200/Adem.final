//
//  QrReader.swift
//  Adem
//
//  Created by Coleman Coats on 11/16/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
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

class QRScannerView: UIView {
    //This is running before it should
    //https://github.com/azamsharp/FirebaseML/blob/master/FirebaseML/BarCodeDetectorViewController.swift
    
    weak var delagate: QRScannerViewDelegate?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    lazy var vision = Vision.vision()
    var barcodeDetector : VisionBarcodeDetector?
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
                    //Scanning is working the update is not
                    print(barcode.rawValue!)
                    self.newHome = barcode.rawValue!
                    //This should be one time
                    //Confirm and merge lists
                    defaults.set(barcode.rawValue!, forKey: "listId")
                    userfirebaseHomeSettings.updateData([
                                                    "listId" : barcode.rawValue!])
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
