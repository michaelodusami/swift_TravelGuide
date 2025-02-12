//
//  PlacesItem.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct PlacesItem: View {
    
    var place: PlaceStruct
    
    var body: some View {
        HStack {
            Image(place.photoFilename)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading) {
                HStack {
                    Text(place.placeName + ", " + place.countryName)
                        .font(.subheadline)
                }
                
                Text(place.description).lineLimit(2)
                    .font(.caption)
                
            }
        }.padding()
    }
}

#Preview {
    PlacesItem(place: places[0])
}
