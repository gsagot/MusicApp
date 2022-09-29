//
//  ArtistViewModel.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import Foundation


class TrackListViewModel:ObservableObject {
    
    
    private var tracks = [TrackViewModel]()
    
    private var i = Int.zero
    
    @Published var currentTrack: TrackViewModel?
    

    func searchByName (_ name: String) {
        
        if name.isEmpty {
            return
        }
        
        i = 0

        DeezerService.shared.getTrack(search: name) { result,data in
            switch result {
            case true :
                print("ok")
                DispatchQueue.main.async {
                    self.tracks = (data!.data.map(TrackViewModel.init))
                    self.currentTrack = self.tracks.first
                }
                
            case false :
                print("Error loading data")
                
            }
            
        }
        
    }
    
    func nextSong () {
        guard i < tracks.count - 1 else {return}
        i += 1
        currentTrack = tracks[i]
    }
    
    func previousSong () {
        guard i > 0 else {return}
        i -= 1
        currentTrack = tracks[i]
    }
    
    
    
}


struct TrackViewModel {
    
    let track : Track
    
    var id : Int { track.id }
    
    var link : String { track.link }
    
    var title : String { track.title }
    
    var preview : String { track.preview}
    
    var album : Album { track.album }
    
    var artist : Artist { track.artist }
    
    
}
