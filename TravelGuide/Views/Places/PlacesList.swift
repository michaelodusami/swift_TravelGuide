//
//  PlacesList.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI



struct PlacesList: View {
    
    @State private var showAlertMessage: Bool = false
    var alertTitle: String = "Source Reference"
    var alertMessage: String = "World's Best Places to Visit data and ranking are taken from: https://travel.usnews.com"
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(places){
                    place in NavigationLink(value: place){
                        PlacesItem(place: place)
                    }
                }
            }.listStyle(.plain)
            .navigationTitle(Text("Places"))
            .navigationDestination(for: PlaceStruct.self) {place in PlacesDetail(place: place)}
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAlertMessage = true
                        
                    }){
                        Image(systemName: "info.circle")
                            .imageScale(.small)
                            .font(Font.title.weight(.light))
                    }
                }
            } // end of tool bar
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("Ok") {}
            }, message: {
                Text(alertMessage)
            })
        }
    }
}

#Preview {
    PlacesList()
}
