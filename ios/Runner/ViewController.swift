//
//  ViewController.swift
//  quickstart-ios-swift
//
//  Created by Lara Vertlberg on 09/12/2019.
//  Copyright © 2019 Lara Vertlberg. All rights reserved.
//

import UIKit
import DeepAR
import AVKit
import AVFoundation
import Flutter

enum Mode: String {
    case masks
    case effects
    case filters
}

enum RecordingMode : String {
    case photo
    case video
    case lowQualityVideo
}

enum Masks: String, CaseIterable {
    case none
    case aviators
    case bigmouth
    case dalmatian
    case bcgSeg
    case look2
    case fatify
    case flowers
    case grumpycat
    case koala
    case lion
    case mudMask
    case obama
    case pug
    case slash
    case sleepingmask
    case smallface
    case teddycigar
    case tripleface
    case twistedFace
}

enum Effects: String, CaseIterable {
    case none
    case fire
    case heart
    case blizzard
    case rain
}

enum Filters: String, CaseIterable {
    case none
    case tv80
    case drawingmanga
    case sepia
    case bleachbypass
    case realvhs
    case filmcolorperfection
}

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    // MARK: - IBOutlets -
    
    //    @IBOutlet weak var switchCameraButton: UIButton!
    
    //    @IBOutlet weak var masksButton: UIButton!
    //    @IBOutlet weak var effectsButton: UIButton!
    //    @IBOutlet weak var filtersButton: UIButton!
    
    //    @IBOutlet weak var previousButton: UIButton!
    //    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var recordActionButton: UIButton!
    
    //    @IBOutlet weak var lowQVideoButton: UIButton!
    //    @IBOutlet weak var videoButton: UIButton!
    //    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var arViewContainer: UIView!
    
    
    
    private var deepAR: DeepAR!
    private var arView: ARView!
    
    // This class handles camera interaction. Start/stop feed, check permissions etc. You can use it or you
    // can provide your own implementation
    private var cameraController: CameraController!
    
    // MARK: - Private properties -
    
    private var maskIndex: Int = 0
    private var maskPaths: [String?] {
        return Masks.allCases.map { $0.rawValue.path }
    }
    
    private var effectIndex: Int = 0
    private var effectPaths: [String?] {
        return Effects.allCases.map { $0.rawValue.path }
    }
    
    private var filterIndex: Int = 0
    private var filterPaths: [String?] {
        return Filters.allCases.map { $0.rawValue.path }
    }
    
    private var buttonModePairs: [(UIButton, Mode)] = []
    private var currentMode: Mode! {
        didSet {
            updateModeAppearance()
        }
    }
    
    private var buttonRecordingModePairs: [(UIButton, RecordingMode)] = []
    private var currentRecordingMode: RecordingMode! {
        didSet {
            updateRecordingModeAppearance()
        }
    }
    
    private var isRecordingInProcess: Bool = false
    
    
    var flutterResult:FlutterResult?
    var maskPath:String?
    
    
    let story = StoryText()
    
    var pageTurnTimer : PageTurnTimer?
    
    @IBOutlet weak var storyLabel: UILabel!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDeepARAndCamera()
        addTargets()
        
        pageTurnTimer = PageTurnTimer()
        
        //        buttonModePairs = [(masksButton, .masks), (effectsButton, .effects), (filtersButton, .filters)]
        //        buttonRecordingModePairs = [ (photoButton, RecordingMode.photo), (videoButton, RecordingMode.video), (lowQVideoButton, RecordingMode.lowQualityVideo)]
        currentMode = .masks
        //        currentRecordingMode = .photo
        
        currentRecordingMode = .video
        deepAR.switchEffect(withSlot: "masks", path: maskPath)
        
        storyLabel.text = story.currentPageText
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // sometimes UIDeviceOrientationDidChangeNotification will be delayed, so we call orientationChanged in 0.5 seconds anyway
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.orientationDidChange()
        }
    }
    
    // MARK: - Private methods -
    
    private func setupDeepARAndCamera() {
        
        self.deepAR = DeepAR()
        self.deepAR.delegate = self
        self.deepAR.setLicenseKey("8a9e4faccf2770ed93d87e4f90ae9ebb7330e30c824c4c8f43c70d242ccd967e0e0c110a57d9088b")
        
        cameraController = CameraController()
        cameraController.deepAR = self.deepAR
        
        self.arView = self.deepAR.createARView(withFrame: self.arViewContainer.frame) as! ARView
        self.arView.translatesAutoresizingMaskIntoConstraints = false
        self.arViewContainer.addSubview(self.arView)
        self.arView.leftAnchor.constraint(equalTo: self.arViewContainer.leftAnchor, constant: 0).isActive = true
        self.arView.rightAnchor.constraint(equalTo: self.arViewContainer.rightAnchor, constant: 0).isActive = true
        self.arView.topAnchor.constraint(equalTo: self.arViewContainer.topAnchor, constant: 0).isActive = true
        self.arView.bottomAnchor.constraint(equalTo: self.arViewContainer.bottomAnchor, constant: 0).isActive = true
        
        cameraController.startCamera()
    }
    
    private func addTargets() {
        //        switchCameraButton.addTarget(self, action: #selector(didTapSwitchCameraButton), for: .touchUpInside)
        recordActionButton.addTarget(self, action: #selector(didTapRecordActionButton), for: .touchUpInside)
        //        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        //        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        //        masksButton.addTarget(self, action: #selector(didTapMasksButton), for: .touchUpInside)
        //        effectsButton.addTarget(self, action: #selector(didTapEffectsButton), for: .touchUpInside)
        //        filtersButton.addTarget(self, action: #selector(didTapFiltersButton), for: .touchUpInside)
        
        
        //        photoButton.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)
        //        videoButton.addTarget(self, action: #selector(didTapVideoButton), for: .touchUpInside)
        //        lowQVideoButton.addTarget(self, action: #selector(didTapLowQVideoButton), for: .touchUpInside)
    }
    
    private func updateModeAppearance() {
        buttonModePairs.forEach { (button, mode) in
            button.isSelected = mode == currentMode
        }
    }
    
    private func updateRecordingModeAppearance() {
        buttonRecordingModePairs.forEach { (button, recordingMode) in
            button.isSelected = recordingMode == currentRecordingMode
        }
    }
    
    private func switchMode(_ path: String?) {
        
        deepAR.switchEffect(withSlot: currentMode.rawValue, path: path)
    }
    
    @objc
    private func orientationDidChange() {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else { return }
        switch orientation {
        case .landscapeLeft:
            cameraController.videoOrientation = .landscapeLeft
            break
        case .landscapeRight:
            cameraController.videoOrientation = .landscapeRight
            break
        case .portrait:
            cameraController.videoOrientation = .portrait
            break
        case .portraitUpsideDown:
            cameraController.videoOrientation = .portraitUpsideDown
        default:
            break
        }
        
    }
    
    @objc
    private func didTapSwitchCameraButton() {
        cameraController.position = cameraController.position == .back ? .front : .back
    }
    
    @objc
    private func didTapRecordActionButton() {
        //
        
        if (currentRecordingMode == RecordingMode.photo) {
            deepAR.takeScreenshot()
            return
        }
        
        if (isRecordingInProcess) {
            recordPageTurn()
            deepAR.finishVideoRecording()
            isRecordingInProcess = false
            return
        }
        
        let width: Int32 = Int32(deepAR.renderingResolution.width)
        let height: Int32 =  Int32(deepAR.renderingResolution.height)
        
        if (currentRecordingMode == RecordingMode.video) {
            //recordPageTurn()
            deepAR.startVideoRecording(withOutputWidth: width, outputHeight: height)
            isRecordingInProcess = true
            
            self.pageTurnTimer?.initialise(page: story.currentPage)
            return
        }
        
        if (currentRecordingMode == RecordingMode.lowQualityVideo) {
            let videoQuality = 0.1
            let bitrate =  1250000
            let videoSettings:[AnyHashable : AnyObject] = [
                AVVideoQualityKey : (videoQuality as AnyObject),
                AVVideoAverageBitRateKey : (bitrate as AnyObject)
            ]
            
            let frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            
            deepAR.startVideoRecording(withOutputWidth: width, outputHeight: height, subframe: frame, videoCompressionProperties: videoSettings, recordAudio: true)
            isRecordingInProcess = true
        }
        
    }
    
    //    @objc
    //    private func didTapPreviousButton() {
    //        var path: String?
    //
    //        switch currentMode! {
    //        case .effects:
    //            effectIndex = (effectIndex - 1 < 0) ? (effectPaths.count - 1) : (effectIndex - 1)
    //            path = effectPaths[effectIndex]
    //        case .masks:
    //            maskIndex = (maskIndex - 1 < 0) ? (maskPaths.count - 1) : (maskIndex - 1)
    //            path = maskPaths[maskIndex]
    //        case .filters:
    //            filterIndex = (filterIndex - 1 < 0) ? (filterPaths.count - 1) : (filterIndex - 1)
    //            path = filterPaths[filterIndex]
    //        }
    //
    //        switchMode(path)
    //    }
    //
    //    @objc
    //    private func didTapNextButton() {
    //        var path: String?
    //
    //        switch currentMode! {
    //        case .effects:
    //            effectIndex = (effectIndex + 1 > effectPaths.count - 1) ? 0 : (effectIndex + 1)
    //            path = effectPaths[effectIndex]
    //        case .masks:
    //            maskIndex = (maskIndex + 1 > maskPaths.count - 1) ? 0 : (maskIndex + 1)
    //            path = maskPaths[maskIndex]
    //        case .filters:
    //            filterIndex = (filterIndex + 1 > filterPaths.count - 1) ? 0 : (filterIndex + 1)
    //            path = filterPaths[filterIndex]
    //        }
    //
    //        switchMode(path)
    //    }
    
    private func recordPageTurn(){
        if isRecordingInProcess {
            pageTurnTimer?.turnPageTapped(newPage: story.currentPage)
        }
    }
    
    @IBAction func tappedNextPage(_ sender: Any) {
        if story.currentPage < (story.story.count - 1) {
            story.currentPage += 1
            recordPageTurn()
        }
        storyLabel.text = story.currentPageText
        
        
    }
    
    
    @IBAction func tappedPrevPage(_ sender: Any) {
        if story.currentPage > 0 {
            story.currentPage -= 1
            recordPageTurn()
        }
        storyLabel.text = story.currentPageText
        
    }
    
    
    @objc
    private func didTapMasksButton() {
        currentMode = .masks
    }
    
    @objc
    private func didTapEffectsButton() {
        currentMode = .effects
    }
    
    @objc
    private func didTapFiltersButton() {
        currentMode = .filters
    }
    
    @objc
    private func didTapPhotoButton() {
        currentRecordingMode = .photo
    }
    
    @objc
    private func didTapVideoButton() {
        currentRecordingMode = .video
    }
    
    @objc
    private func didTapLowQVideoButton() {
        currentRecordingMode = .lowQualityVideo
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
        deepAR.shutdown()
        dismiss(animated: true, completion: nil)
    }
    
    func close() {
        deepAR.shutdown()
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - ARViewDelegate -

@available(iOS 13.0, *)
extension ViewController: DeepARDelegate {
    func didFinishPreparingForVideoRecording() { }
    
    func didStartVideoRecording() { }
    
    func didFinishVideoRecording(_ videoFilePath: String!) {
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let components = videoFilePath.components(separatedBy: "/")
        guard let last = components.last else { return }
        let destination = URL(fileURLWithPath: String(format: "%@/%@", documentsDirectory, last))
        
        
        
        //        DispatchQueue.main.async {
        //          // Call the desired channel message here.
        //            self.flutterResult!(destination.absoluteString)
        //            self.close()
        //        }
        //        let file = documentsDirectory.ap
        print(documentsDirectory)
        
        
        let videoCompositor = VideoCompositor(view,pageTimes: pageTurnTimer!.couplet,storyText: story)
        videoCompositor.composite(url: URL(fileURLWithPath: videoFilePath))
        
        
        //        let playerController = AVPlayerViewController()
        //        let player = AVPlayer(url: destination)
        //        playerController.player = player
        //        present(playerController, animated: true) {
        //            player.play()
        //        }
    }
    
    func recordingFailedWithError(_ error: Error!) {}
    //
    //    func didTakeScreenshot(_ screenshot: UIImage!) {
    //        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    //
    //        let imageView = UIImageView(image: screenshot)
    //        imageView.frame = view.frame
    //        view.insertSubview(imageView, aboveSubview: arView)
    //
    //        let flashView = UIView(frame: view.frame)
    //        flashView.alpha = 0
    //        flashView.backgroundColor = .black
    //        view.insertSubview(flashView, aboveSubview: imageView)
    //
    //        UIView.animate(withDuration: 0.1, animations: {
    //            flashView.alpha = 1
    //        }) { _ in
    //            flashView.removeFromSuperview()
    //
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
    //                imageView.removeFromSuperview()
    //            }
    //        }
    //    }
    
    func didInitialize() {}
    
    func faceVisiblityDidChange(_ faceVisible: Bool) {}
}

extension String {
    var path: String? {
        print(Bundle.main.path(forResource: self, ofType: nil))
        return Bundle.main.path(forResource: self, ofType: nil)
    }
}
