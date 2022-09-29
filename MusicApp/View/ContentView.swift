//
//  ContentView.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var trackListVM = TrackListViewModel()
    @ObservedObject private var dataTap = PlayerViewModel.shared.signal
    
    @State private var currentSearch: String = "Red Hot"
    @State private var offset = CGSize.zero
    
    init(){
        trackListVM.searchByName("Red Hot".trimmedAndEscaped())
    }
     
    
    var body: some View {
        VStack {
            ZStack(alignment:.top){
                Rectangle()
                    .fill(.blue)
                    .frame(height: 200)

                TextField("Search", text: $currentSearch, onCommit: {
                    self.trackListVM.searchByName(self.currentSearch.trimmedAndEscaped())
                })
                    .font(.boldFont)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 40, leading: 10, bottom: 0, trailing: 0))
            }
            .ignoresSafeArea()
            
          
            ArtistListView(track: trackListVM.currentTrack, playing: dataTap.playing)
                .offset(x: offset.width , y: 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { gesture in
                            if offset.width > 0 {
                                PlayerViewModel.shared.stop()
                                trackListVM.previousSong()
                            }
                            else {
                                PlayerViewModel.shared.stop()
                                trackListVM.nextSong()
                            }
                            offset = CGSize.zero
                            
                        }
                )
            Spacer()
            SpectogramView(array: dataTap.audioData)
        }
        .background(.blue)
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
