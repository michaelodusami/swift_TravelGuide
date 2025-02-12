//
//  AttractionItem.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct AttractionItem: View {
    let text: String
    let imageName: String
    var body: some View {
        
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay( // Optional: Add a subtle border
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black.opacity(0.5), lineWidth: 2)
                )
                .shadow(radius: 5)
                .frame(width: 300, height: 200)
                
            Text(text)
                .font(.headline)
        }.padding()
        
    }
}

#Preview {
    AttractionItem(text: "Colosseum", imageName: "ColosseumAttraction")
}
