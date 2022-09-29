//
//  ArtistListView.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import SwiftUI


struct ArtistListView: View {
    
    let track:TrackViewModel?
    var playing:Bool = false
    @State var image: String = "play.circle.fill"
    @State var info: String = "play"
    
    var body: some View {
        VStack{
            HStack{
                Text(track?.title.removeParentheses() ?? " ")
                    .padding(10)
                    .foregroundColor(.blue)
                    .background(.white)

                Spacer()
                
            }
            HStack{
                Text(track?.album.title.removeParentheses() ?? " ")
                    .padding(10)
                    .foregroundColor(.blue)
                    .background(.white)
               
                Spacer()
            }
            HStack{
                Text(track?.artist.name.removeParentheses() ?? " ")
                    .padding(10)
                    .foregroundColor(.blue)
                    .background(.white)
                    
                Spacer()
            }
            
            HStack{
                if playing {
                    Image(systemName: "stop.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .onTapGesture {
                            if playing {
                                PlayerViewModel.shared.stop()
                                image = "play.circle.fill"
                                info = "play"
                            }else {
                                PlayerViewModel.shared.start(track?.preview ?? " " )
                                image = "stop.circle.fill"
                                info = "stop"
                            }
                           
                        }
                    
                }else {
                    Image(systemName: "play.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .onTapGesture {
                            if playing {
                                PlayerViewModel.shared.stop()
                                image = "play.circle.fill"
                                info = "play"
                            }else {
                                PlayerViewModel.shared.start(track?.preview ?? " " )
                                image = "stop.circle.fill"
                                info = "stop"
                            }
                           
                        }
                    
                }

                
                
                
                Text(info)
                    .foregroundColor(.white)
                
                Spacer()
            }
        
            Spacer()
        }
        
        .background(.blue)

    }
    
    
}

