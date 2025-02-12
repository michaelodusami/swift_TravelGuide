//
//  AttractionsView.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI

struct AttractionsView: View {
    
    
    let attractions : [String: String] = ["ColosseumAttraction": "Collosseum", "EiffelTowerAttraction": "Eiffel Tower", "StatueOfLibertyAttraction": "Statue Of Liberty"]
    
    @State var favoriteAttraction: String = ""
    @State var showSurvey: Bool = false
    @State private var backgroundColor = Color.gray.opacity(0.1)
    
    var body: some View {
        
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    
                    Button("Quick Survey"){
                        showSurvey = true
                    }.actionSheet(isPresented: $showSurvey, content: {surveySheet})
                    
                    Spacer()
                    
                    Text("Change Background Color")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .contextMenu {
                            Button(action: {        // Context Menu Item 1
                                backgroundColor = Color(red: 1.0, green: 1.0, blue: 240/255)
                            }) {
                                Image(systemName: "triangle")
                                Text("Ivory")
                            }
                            Button(action: {        // Context Menu Item 2
                                backgroundColor = Color.gray.opacity(0.1)
                            }) {
                                Image(systemName: "heart")
                                Text("Light Gray")
                            }
                            Button(action: {        // Context Menu Item 3
                                backgroundColor = Color(red: 250/255, green: 240/255, blue: 230/255)
                            }) {
                                Image(systemName: "star")
                                Text("Linen")
                            }
                            Button(action: {        // Context Menu Item 4
                                backgroundColor = Color(red: 253/255, green: 245/255, blue: 230/255)
                            }) {
                                Image(systemName: "diamond")
                                Text("Old Lace")
                            }
                            Button(action: {        // Context Menu Item 5
                                backgroundColor = Color(red: 255/255, green: 239/255, blue: 213/255)
                            }) {
                                Image(systemName: "hexagon")
                                Text("Papaya Whip")
                            }
                        }
                }
                Divider()
                Text("Attractions")
                    .padding(.top, 10)
                    .font(.title)
                Text("Favorite Attraction: \(favoriteAttraction)")
                    .font(.subheadline).opacity(favoriteAttraction.isEmpty ? 0 : 1)
                List {
                    ForEach(attractions.sorted(by: {$0.key < $1.key}), id: \.key) {key, value in
                        AttractionItem(text: value, imageName: key)
                    }
                }
            }.padding()
        }
    }
    
    var surveySheet: ActionSheet {
        ActionSheet(
            title: Text("Quick Survey"),
            message: Text("Which Attraction Do You Like the Best?"),
            buttons: [
                .default(Text("Colosseum")) {
                    favoriteAttraction = "Colosseum!"
                    showSurvey = false
                },
                .default(Text("Statue of Liberty")) {
                    favoriteAttraction = "Statue of Liberty!"
                    showSurvey = false
                },
                .default(Text("Eiffel Tower")) {
                    favoriteAttraction = "Eiffel Tower!"
                    showSurvey = false
                },
                .destructive(Text("None of Them")) {
                    favoriteAttraction = ""
                    showSurvey = false
                },
                .cancel() {
                    showSurvey = false
                }
        ])
    }
}

#Preview {
    AttractionsView()
}
