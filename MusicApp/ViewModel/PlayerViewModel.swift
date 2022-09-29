//
//  Sample.swift
//  MusicApp
//
//  Created by Gilles Sagot on 26/09/2022.
//

import Foundation
import AVFoundation


class PlayerViewModel {
    
    static var shared = PlayerViewModel()
    
    private var engine:AVAudioEngine
    
    private  let player = AVAudioPlayerNode()
    
    let signal = SignalProcessingViewModel()
    
    private init () {
        
        engine = AVAudioEngine()
        _ = engine.mainMixerNode
        engine.prepare()
        
        do {
            try engine.start()
        } catch {
            print(error)
        }
        
        // Prevent device is not on silent and set audio sessions category to .playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    // Download mp3 then start the player if download successed
    func start (_ string: String) {
        engine.mainMixerNode.removeTap(onBus: 0)
        PreviewService.shared.getAudioFile(string){ success, adress in
            if success { self.play (url: adress!) }
            else { return }
        }
        
    }
    
    // Stop player
    func stop () {
        signal.reset()
        engine.mainMixerNode.removeTap(onBus: 0)
        player.stop()
        
    }
    
    // start player
    private func play (url:URL) {
        
        do {
            
            let audioFile = try AVAudioFile(forReading: url)
            
            let format = audioFile.processingFormat
            
            engine.attach(player)
            
            engine.connect(player, to: engine.mainMixerNode, format: format)
            
            player.scheduleFile(audioFile, at: nil, completionHandler: nil)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        // audio tap on a bus to record, monitor, and observe the output of the node
        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { (buffer, time) in
            self.processAudioData(buffer: buffer)
            
        }

        player.play()
        
    }
    
    func processAudioData(buffer: AVAudioPCMBuffer){
        
        guard let channelData = buffer.floatChannelData?[0] else {return}
        let frames = buffer.frameLength
        
        _ = signal.rms(data: channelData, frameLength: UInt(frames))
        
        
    }
    
    
    
}
