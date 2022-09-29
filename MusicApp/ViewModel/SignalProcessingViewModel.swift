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
   
    func rms(data: UnsafeMutablePointer<Float>, frameLength: UInt) -> Float {
        
        var val : Float = 0
        vDSP_measqv(data, 1, &val, frameLength)
        
        DispatchQueue.main.async {
            self.audioData.append(val)
            self.audioData.removeFirst()
        }
        
        return val
    }
    
    func reset(){
        audioData = [Float](repeating: 0.01, count: 4)
    }
}
