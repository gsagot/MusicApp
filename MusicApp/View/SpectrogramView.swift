//
//  SpectrogramView.swift
//  MusicApp
//
//  Created by Gilles Sagot on 27/09/2022.
//

import SwiftUI

struct SpectogramView: View {
    
    var array = [Float]()
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 5){

                ForEach(array, id: \.self ){ i in
                    
                    Rectangle()
                        .fill(.white)
                        .frame(height: 1)
                        .scaleEffect(x:1,
                                     y:CGFloat(i) * 1000,
                                     anchor:UnitPoint(x: 1, y: 1) )
                    
                }
                
            }
            
        }
        .background(.black)
  
    }
    
    
    
}


struct SpectogramView_Previews: PreviewProvider {
    static var previews: some View {
        SpectogramView()
    }
}
