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
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func start (_ string: String) {
        engine.mainMixerNode.removeTap(onBus: 0)
        PreviewService.shared.getAudioFile(string){ success, adress in
            if success { self.play (url: adress!) }
            else { return }
        }
        
    }
    
    func stop () {
        signal.reset()
        engine.mainMixerNode.removeTap(onBus: 0)
        player.stop()
        
    }
    
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
