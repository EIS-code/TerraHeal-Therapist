//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import Photos


public protocol QRScannerCodeDelegate: class {

    func qrScanner(_ controller: UIViewController, scanDidComplete result: String)
    func qrScannerDidFail(_ controller: UIViewController,  error: String)
    func qrScannerDidCancel(_ controller: UIViewController)
}


class ScanVC: BaseVC,AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationBarDelegate {

    var squareView: SquareView? = nil
    public weak var delegate: QRScannerCodeDelegate?
    @IBOutlet weak var btnScan: UIButton!

    //Default Properties
    private let bottomSpace: CGFloat = 80.0
    private let spaceFactor: CGFloat = 16.0
    private let devicePosition: AVCaptureDevice.Position = .back
    private var delCnt: Int = 0

    //This is for adding delay so user will get sufficient time for align QR within frame
    private let delayCount: Int = 1

    //Initialise CaptureDevice
    lazy var defaultDevice: AVCaptureDevice? = {
        if let device = AVCaptureDevice.default(for: .video) {
            return device
        }
        return nil
    }()

    //Initialise front CaptureDevice
    lazy var frontDevice: AVCaptureDevice? = {
        if #available(iOS 10, *) {
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                return device
            }
        } else {
            for device in AVCaptureDevice.devices(for: .video) {
                if device.position == .front { return device }
            }
        }
        return nil
    }()

    //Initialise AVCaptureInput with defaultDevice
    lazy var defaultCaptureInput: AVCaptureInput? = {
        if let captureDevice = defaultDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    //Initialise AVCaptureInput with frontDevice
    lazy var frontCaptureInput: AVCaptureInput?  = {
        if let captureDevice = frontDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    lazy var dataOutput = AVCaptureMetadataOutput()

    //Initialise capture session
    lazy var captureSession = AVCaptureSession()

    //Initialise videoPreviewLayer with capture session
    lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.cornerRadius = 10.0
        return layer
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }


    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("SwiftQRScanner deallocating...")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationTitle(title: "SCAN_TITLE".localized())
    }
    //MARK: Life cycle methods
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Currently only "Portraint" mode is supported
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        delCnt = 0
        print("\(#function)")
        prepareQRScannerView(self.view)
        startScanningQRCode()

    }

    /* This calls up methods which makes code ready for scan codes.
     - parameter view: UIView in which you want to add scanner.
     */

    func prepareQRScannerView(_ view: UIView) {
        setupCaptureSession(devicePosition) //Default device capture position is rear
        addViedoPreviewLayer(view)
        createCornerFrame()
        self.view.bringSubviewToFront(self.vwNavigationBar)
        self.view.bringSubviewToFront(self.btnScan)
        print("\(#function)")
    }

    //Creates corner rectagle frame with green coloe(default color)
    func createCornerFrame() {
        let width: CGFloat = 200.0
        let height: CGFloat = 200.0

        let rect = CGRect.init(
            origin: CGPoint.init(
                x: self.view.frame.midX - width/2,
                y: self.view.frame.midY - (width+bottomSpace)/2),
            size: CGSize.init(width: width, height: height))
        self.squareView = SquareView(frame: rect)
        if let squareView = squareView {
            self.view.backgroundColor = .white //UIColor(white: 0.0, alpha: 0.5)
            squareView.autoresizingMask = UIView.AutoresizingMask(rawValue: UInt(0.0))
            self.view.addSubview(squareView)

            addMaskLayerToVideoPreviewLayerAndAddText(rect: rect)
        }

    }

    func addMaskLayerToVideoPreviewLayerAndAddText(rect: CGRect) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        let path = UIBezierPath(rect: rect)
        path.append(UIBezierPath(rect: view.bounds))
        maskLayer.path = path.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        view.layer.insertSublayer(maskLayer, above: videoPreviewLayer)

        let noteText = CATextLayer()
        noteText.fontSize = 18.0
        noteText.string = "Align QR code within frame to scan"
        noteText.alignmentMode = CATextLayerAlignmentMode.center
        noteText.contentsScale = UIScreen.main.scale
        noteText.frame = CGRect(x: spaceFactor, y: rect.origin.y + rect.size.height + 30, width: view.frame.size.width - (2.0 * spaceFactor), height: 22)
        noteText.foregroundColor = UIColor.white.cgColor
        view.layer.insertSublayer(noteText, above: maskLayer)
    }




    private func getCurrentInput() -> AVCaptureDeviceInput? {
        if let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput {
            return currentInput
        }
        return nil
    }

    @objc func dismissVC() {
        self.popVC()
        delegate?.qrScannerDidCancel(self)
    }

    //MARK: - Setup and start capturing session

    @IBAction func btnScanTapped(_ sender: Any) {
        delegate?.qrScanner(self, scanDidComplete: "ABV")
    }
    open func startScanningQRCode() {
        if captureSession.isRunning { return }
        captureSession.startRunning()
    }
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    private func setupCaptureSession(_ devicePostion: AVCaptureDevice.Position) {
        if captureSession.isRunning { return }

        switch devicePosition {
        case .front:
            if let frontDeviceInput = frontCaptureInput {
                if !captureSession.canAddInput(frontDeviceInput) {
                    delegate?.qrScannerDidFail(self, error: "Failed to add Input")
                    self.popVC()
                    return
                }
                captureSession.addInput(frontDeviceInput)
            }
            break
        case .back, .unspecified :
            if let defaultDeviceInput = defaultCaptureInput {
                if !captureSession.canAddInput(defaultDeviceInput) {
                    delegate?.qrScannerDidFail(self, error: "Failed to add Input")
                    self.popVC()
                    return
                }
                captureSession.addInput(defaultDeviceInput)
            }
            break
        default: print("Do nothing")
        }

        if !captureSession.canAddOutput(dataOutput) {
            delegate?.qrScannerDidFail(self, error: "Failed to add Output")
            self.popVC()
            return
        }
        captureSession.addOutput(dataOutput)
        dataOutput.metadataObjectTypes = dataOutput.availableMetadataObjectTypes
        dataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }

    //Inserts layer to view
    private func addViedoPreviewLayer(_ view: UIView) {
        videoPreviewLayer.frame = CGRect(x:view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height - bottomSpace)
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
    }

    // This method get called when Scanning gets complete
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        for data in metadataObjects {
            let transformed = videoPreviewLayer.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                if view.bounds.contains(unwraped.bounds) {
                    delCnt = delCnt + 1
                    if delCnt > delayCount {
                        if let unwrapedStringValue = unwraped.stringValue {
                            delegate?.qrScanner(self, scanDidComplete: unwrapedStringValue)
                        } else {
                            delegate?.qrScannerDidFail(self, error: "Empty string found")
                        }
                        captureSession.stopRunning()
                        self.popVC()
                    }
                }
            }
        }
    }
}
