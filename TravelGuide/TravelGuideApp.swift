//
//  TravelGuideApp.swift
//  TravelGuide
//
//  Created by Tishe on 2/11/25.
//

import SwiftUI

@main
struct TravelGuideApp: App {
    
    init(){
        loadDataFiles()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
