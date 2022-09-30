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
        
        HStack{
            ZStack (alignment:.bottom){
                
                // Cover in background
                HStack{
                    AsyncImage(url: URL(string: track!.album.cover ) ){ phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()

                        case .failure(_):
                            Image(systemName: "questionmark")
                                .symbolVariant(.circle)
                                .font(.largeTitle)
                        default:
                            ProgressView()
                        }
                        
                        Spacer()
                    }
                    
                }
                
                VStack{
                    // Title
          
                        Text(track?.title.removeParentheses() ?? " ")
                            .bold()

                        Text(track?.album.title.removeParentheses() ?? " ")
                 
                        Text(track?.artist.name.removeParentheses() ?? " ")
                            

                }
                .padding(10)
                .foregroundColor(.black)
                .background(.white)
                

            }
            
        }
        .background(.gray)
        .onTapGesture {
            PlayerViewModel.shared.start(track!.preview)
            
        }

        
    }
    
    
}

/*
 
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
 */
