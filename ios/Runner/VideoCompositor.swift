//
//  VideoCompositor.swift
//  Runner
//
//  Created by Joe Kletz on 30/09/2020.
//


import UIKit
import AVFoundation
//import AVKit
import Photos

class VideoCompositor {
    
    var pageTimes : [(Int, Int)]
    
    let dummyText = """
    His laugh was inside him all the time.
    I just made him happy and out it came" replied Monkey
    """
    
    var myurl: URL?
    
    let view:UIView?
    
    let storyText:StoryText
    
    init(_ view: UIView, pageTimes: [(Int, Int)],storyText:StoryText) {
        self.view = view
        self.pageTimes = pageTimes
        self.storyText = storyText
        
        print(pageTimes)
    }
    
    func composite(url:URL) {
        
        let composition = AVMutableComposition()
        //        let vidAsset = AVURLAsset(url: url as URL, options: nil)
        let vidAsset = AVAsset(url: url)
        
        print("url \(url)")
        
        // get video track
        let vtrack =  vidAsset.tracks(withMediaType: AVMediaType.video)
        //        let videoTrack: AVAssetTrack = vtrack[0]
        
        print("Video tracks \(vtrack.count)")
        //
        let playableKey = "playable"
        
        //        vidAsset.loadValuesAsynchronously(forKeys: [playableKey]) {
        //            var error: NSError? = nil
        //            let status = vidAsset.statusOfValue(forKey: playableKey, error: &error)
        //            switch status {
        //            case .loaded:
        //                print("LOADED")
        //                let vtrack =  vidAsset.tracks(withMediaType: AVMediaType.video)
        //                print("Video tracks \(vtrack.count)")
        //            case .failed:
        //                print("FAILED")
        //            case .cancelled:
        //                print("CAncelled")
        //            default:
        //                print("OTHER")
        //            }
        //        }
        
        
        
        let videoTrack: AVAssetTrack = vtrack[0]
        let vid_timerange = CMTimeRangeMake(start: CMTime.zero, duration: vidAsset.duration)
        
        print("VID SECONDS \(vid_timerange.duration.seconds)")
        
        let tr: CMTimeRange = CMTimeRange(start: CMTime.zero, duration: CMTime(seconds: 1.0, preferredTimescale: 600))
        composition.insertEmptyTimeRange(tr)
        
        let trackID:CMPersistentTrackID = CMPersistentTrackID(kCMPersistentTrackID_Invalid)
        
        
        
        if let compositionvideoTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: trackID) {
            
            do {
                try compositionvideoTrack.insertTimeRange(vid_timerange, of: videoTrack, at: CMTime.zero)
            } catch {
                print("error")
            }
            
            compositionvideoTrack.preferredTransform = videoTrack.preferredTransform
            
        } else {
            print("unable to add video track")
            return
        }
        
        
        let pageHeight : CGFloat = 550
        
        
        // Watermark Effect
        let size = videoTrack.naturalSize
        
        let imglogo = #imageLiteral(resourceName: "ArrowRight")
        let imglayer = CALayer()
        imglayer.contents = imglogo.cgImage
        imglayer.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        imglayer.opacity = 0.6
        
        // create text Layer
        
        let backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: pageHeight)
        
        let titleLayerHeight = size.height / 6
        let titleLayer = CATextLayer()
        titleLayer.backgroundColor = UIColor.white.cgColor
        titleLayer.string = dummyText
        titleLayer.font = UIFont(name: "Helvetica", size: 56)
        titleLayer.foregroundColor = UIColor.black.cgColor
        titleLayer.shadowOpacity = 0.5
        titleLayer.alignmentMode = CATextLayerAlignmentMode.left
        titleLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: pageHeight)
        titleLayer.isWrapped = true
        titleLayer.fontSize = 70
        titleLayer.shadowOpacity = 0
        titleLayer.bounds.size.width = size.width - 70
        titleLayer.bounds.size.height = pageHeight - 70
        
        
        let videolayer = CALayer()
        videolayer.frame = CGRect(x: 0, y: pageHeight, width: size.width, height: size.height - 100)
        
        let parentlayer = CALayer()
        parentlayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        parentlayer.addSublayer(backgroundLayer)
        //        parentlayer.addSublayer(titleLayer)
        parentlayer.addSublayer(videolayer)
        
        createTextLayers(parentLayer: parentlayer,pageHeight: pageHeight,size: size)
        
        
        //        let animation = CABasicAnimation(keyPath: "opacity")
        //        animation.fromValue = 1
        //        animation.toValue = 0
        //        animation.duration = 3
        //        animation.beginTime = CFTimeInterval(floatLiteral: 3.5)//CFTimeInterval(exactly: 5)!//AVCoreAnimationBeginTimeAtZero//
        //        titleLayer.add(animation, forKey: "opacity")
        
        
        //        parentlayer.addSublayer(imglayer)
        
        
        let layercomposition = AVMutableVideoComposition()
        layercomposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        layercomposition.renderSize = size
        layercomposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videolayer, in: parentlayer)
        
        
        // instruction for watermark
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: composition.duration)
        
        
        let videotrack = composition.tracks(withMediaType: AVMediaType.video)[0] as AVAssetTrack
        
        let layerinstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videotrack)
        instruction.layerInstructions = NSArray(object: layerinstruction) as [AnyObject] as! [AVVideoCompositionLayerInstruction]
        layercomposition.instructions = NSArray(object: instruction) as [AnyObject] as! [AVVideoCompositionInstructionProtocol]
        
        //  create new file to receive data
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        let movieFilePath = docsDir.appendingPathComponent("result.mov")
        let movieDestinationUrl = NSURL(fileURLWithPath: movieFilePath)
        
        // use AVAssetExportSession to export video
        let assetExport = AVAssetExportSession(asset: composition, presetName:AVAssetExportPresetHighestQuality)
        assetExport?.outputFileType = AVFileType.mov
        assetExport?.videoComposition = layercomposition
        
        // Check exist and remove old file
        FileManager.default.removeItemIfExisted(movieDestinationUrl as URL)
        
        assetExport?.outputURL = movieDestinationUrl as URL
        assetExport?.exportAsynchronously(completionHandler: {
            switch assetExport!.status {
            case AVAssetExportSession.Status.failed:
                print("failed")
                print(assetExport?.error ?? "unknown error")
            case AVAssetExportSession.Status.cancelled:
                print("cancelled")
                print(assetExport?.error ?? "unknown error")
            default:
                print("Movie complete")
                
                self.myurl = movieDestinationUrl as URL
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: movieDestinationUrl as URL)
                }) { saved, error in
                    if saved {
                        print("Saved")
                    }
                }
                
                self.playVideo()
                
            }
        }
        )
    }
    
    func playVideo() {
        let player = AVPlayer(url: myurl!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view!.bounds
        self.view!.layer.addSublayer(playerLayer)
        player.play()
        print("playing...")
    }
    
    
    //U can add another white layer that fades in a second before
    
    func createTextLayers(parentLayer:CALayer, pageHeight : CGFloat, size : CGSize) {
        
        
        for page in pageTimes {
            
            let animationParentLayer = CALayer()
            animationParentLayer.opacity = 0
            
            animationParentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: pageHeight)
            
            let titleLayer = CATextLayer()
//            titleLayer.string = storyText.story[page.0]// page.0 - get from story text array
            
//            titleLayer.frame = animationParentLayer.frame//CGRect(x: 0, y: 0, width: size.width, height: pageHeight)
//            titleLayer.font = UIFont(name: "Helvetica", size: 56)
//            titleLayer.foregroundColor = UIColor.black.cgColor
//            titleLayer.backgroundColor = UIColor.white.cgColor
//            titleLayer.opacity = 0
            
            titleLayer.backgroundColor = UIColor.white.cgColor
            titleLayer.string = "STORY PAGE \(page.0)"//storyText.story[page.0]
            titleLayer.font = UIFont(name: "Helvetica", size: 56)
            titleLayer.foregroundColor = UIColor.black.cgColor
            titleLayer.shadowOpacity = 0.5
            titleLayer.alignmentMode = CATextLayerAlignmentMode.left
            titleLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: pageHeight)
            titleLayer.isWrapped = true
            titleLayer.fontSize = 70
            titleLayer.shadowOpacity = 0
            titleLayer.bounds.size.width = size.width - 70
            titleLayer.bounds.size.height = pageHeight - 70
            
            animationParentLayer.addSublayer(titleLayer)
            parentLayer.addSublayer(animationParentLayer)
            
//            parentLayer.insertSublayer(animationParentLayer, at: 1)
            
            //Fade in animation
            
            var startTime : Double = 0;
            for item in pageTimes {
                if item.0 < page.0 {
                    startTime += Double(item.1)
                }
            }
            
            let startTimeMilliseconds = startTime / 1000
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            animation.beginTime = CFTimeInterval(floatLiteral: startTimeMilliseconds)//CFTimeInterval(exactly: 5)!//AVCoreAnimationBeginTimeAtZero//
            animation.fillMode = CAMediaTimingFillMode.forwards;
            animation.isRemovedOnCompletion = false
            //animation.autoreverses  = true
            animationParentLayer.add(animation, forKey: "opacity")

            
            //Fade out animation
            
            var outTime : Double = 0;
            for item in pageTimes {
                if item.0 <= page.0 {
                    outTime += Double(item.1)
                }
            }
            
            let outTimeMilliseconds = outTime / 1000 - 1
            
            let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadeOutAnimation.fromValue = 1
            fadeOutAnimation.toValue = 0
            fadeOutAnimation.duration = 1
            fadeOutAnimation.beginTime = CFTimeInterval(floatLiteral: outTimeMilliseconds)//CFTimeInterval(exactly: 5)!//AVCoreAnimationBeginTimeAtZero//
            fadeOutAnimation.fillMode = CAMediaTimingFillMode.forwards;
            fadeOutAnimation.isRemovedOnCompletion = false
            
            //titleLayer.add(fadeOutAnimation, forKey: "opacity")
            
//            let fadeInAndOut = CAAnimationGroup()
//            fadeInAndOut.animations = [animation, fadeOutAnimation]
//            fadeInAndOut.duration = 8
//            fadeInAndOut.fillMode = CAMediaTimingFillMode.forwards;
//            fadeInAndOut.isRemovedOnCompletion = false
//            titleLayer.add(fadeInAndOut, forKey: nil)
            
            print("PAGE \(page.0) IN \(startTimeMilliseconds) OUT \(outTimeMilliseconds) LAYER \(parentLayer.sublayers)")
        }
        
    }
}

extension FileManager {
    func removeItemIfExisted(_ url:URL) -> Void {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
            }
            catch {
                print("Failed to delete file")
            }
        }
    }
}
