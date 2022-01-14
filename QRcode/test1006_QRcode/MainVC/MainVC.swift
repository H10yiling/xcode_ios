//
//  MainVC.swift
//  test1006_QRcode
//
//  Created by 侯懿玲 on 2021/10/6.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
        
    @IBOutlet var scanQRCodeView: UIView!
        
    var captureSession:AVCaptureSession?
    var captureVideoPreviewLayer:AVCaptureVideoPreviewLayer!
    var qrcodeString:String!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        // 判斷 AVCaptureSession 的接收器是否正在執行
        if (captureSession?.isRunning == false) {
            captureSession?.startRunning()
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        scanQRCode()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession?.stopRunning()
        }
    }
    
    @IBAction func goToMachineCheckNumber(_ sender: UIButton) {
        // 無機器驗證碼，暫不實作，改以一掃到 QR Code 就以 alert 方式跳出掃出來的結果
        
    }
    
    func scanQRCode() {
        captureSession = AVCaptureSession() // 實例化一個 AVCaptureSession 物件
        
        // 透過 AVCaptureDevice 來捕捉相機及其相關屬性
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput:AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print(error)
            return
        }
        
        // 判斷是否可以將 videoInput 加入到 captureSession
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput() // 實例化一個 AVCaptureMetadataOutput 物件
            
        // 透過 AVCaptureMetadataOutput 輸出資料
        // 判斷是否可以將 metaDataOutput 輸出到 captureSession
        if (captureSession?.canAddOutput(metaDataOutput) ?? false) {
            captureSession?.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) //執行處理 QRCode
            metaDataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417] // 設定可以處理哪些類型的條碼
        } else {
            return
        }
            
        // 用 AVCaptureVideoPreviewLayer 來呈現 AVCaptureSession 的資料
        captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        captureVideoPreviewLayer.videoGravity = .resizeAspectFill
        captureVideoPreviewLayer.frame = scanQRCodeView.layer.frame
        view.layer.addSublayer(captureVideoPreviewLayer)
        captureSession?.startRunning()
    }
        
    // 使用 AVCaptureMetadataOutput 物件辨識 QRCode
    // AVCaptureMetadataOutputObjectsDelegate 裡的委派方法 metadataOutout 會被呼叫
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            // AVMetadataMachineReadableCodeObject 是從 Output 擷取到 Barcode 的內容
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            // 將讀取到的內容轉成字串
            guard let stringValue = readableObject.stringValue else { return }
            qrcodeString = stringValue
            self.alert(message: qrcodeString)
        }
    }
}

extension MainVC {
    func alert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "關閉", style: .default) { action in
            //
        }
        alertController.addAction(closeAction)
        self.present(alertController,animated: true)
    }
}
