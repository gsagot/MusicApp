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
    
    @State private var overText = false
    
    @State private var currentSearch: String = "Red Hot"
    @State private var offset = CGSize.zero
    
    init(){
        trackListVM.searchByName("Red Hot".trimmedAndEscaped())
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment:.top){
                Rectangle()
                    .fill(.black)
                
                HStack{
                    TextField("Search", text: $currentSearch, onCommit: {
                        self.trackListVM.searchByName(self.currentSearch.trimmedAndEscaped())
                    })
                    
                    Spacer()
                    
                    Image(systemName:"magnifyingglass")
                        .onTapGesture {
                            self.trackListVM.searchByName(self.currentSearch.trimmedAndEscaped())
                        }
                    
                }
                
            }
            .font(.mediumFont)
            .foregroundColor(.white)
            .ignoresSafeArea()
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 0))
                 
            
            ScrollView(.horizontal,showsIndicators: false ){
                HStack(spacing:20){
                    ForEach(trackListVM.tracks, id: \.id){track in
                        GeometryReader { geo in
                            
                            ArtistListView(track: track, playing: dataTap.playing)
                                .padding()
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 12), axis: (x: 0, y: 1, z: 0))
                                .frame(width: 200, height: 200)
                                
                            

                          
                            
                        }
                            .frame(width: 150, height: 200)
    
                    }
                    
                }
                
                
            }
            
            
            
            Spacer()
            
            SpectogramView(array: dataTap.audioData)
        }
        .fixedSize(horizontal: false, vertical: false)
        .background(.black)
        .onAppear(){
            PlayerViewModel.shared.clear()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
