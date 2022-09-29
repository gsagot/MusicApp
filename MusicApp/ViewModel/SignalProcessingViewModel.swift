//
//  SignalProcessing.swift
//  MusicApp
//
//  Created by Gilles Sagot on 26/09/2022.
//

import Foundation
import Accelerate


class SignalProcessingViewModel : ObservableObject{
    
    @Published var audioData = [Float](repeating: 0.01, count: 4)
    
    @Published var playing:Bool = false
   
    func rms(data: UnsafeMutablePointer<Float>, frameLength: UInt) -> Float {
        
        var val : Float = 0
        vDSP_measqv(data, 1, &val, frameLength)
        
        DispatchQueue.main.async {
            self.playing = true
            self.audioData.append(val)
            self.audioData.removeFirst()
        }
    
        return val
    }
    
    func reset(){
        self.playing = false
        audioData = [Float](repeating: 0.01, count: 4)
    }
    

}
