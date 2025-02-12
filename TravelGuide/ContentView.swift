//
//  ContentView.swift
//  TravelGuide
//
//  Created by Tishe on 2/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            Tab("Places", systemImage: "globe.americas"){
                PlacesView()
            }
            Tab("Attractions", systemImage: "heart"){
                AttractionsView()
            }
        }
    
    }
}

#Preview {
    ContentView()
}
