//
//  ArtistListView.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import SwiftUI


struct ArtistListView: View {
    
    let track:TrackViewModel?
    
    var body: some View {
        VStack{
            HStack{
                Text(track?.title ?? " ")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
            HStack{
                Text(track?.album.title ?? " ")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
            HStack{
                Text(track?.artist.name ?? " ")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
        
            Spacer()
        }

        .onTapGesture {
            PlayerViewModel.shared.start(track?.preview ?? " " )
        }
        .background(.blue)

    }
    
    
}

