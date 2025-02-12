//
//  PlacesDetail.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import SwiftUI
import MapKit

fileprivate var placeCenterCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

struct PlacesDetail: View {
    
    let place: PlaceStruct
    @State private var selectedMapStyleIndex = 0
    let mapStyles = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    var body: some View {
        
        placeCenterCoordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        
        return AnyView (
            
            Form {
                Section(header: Text("Basic Information")) {
                    Text("📍 Name: \(place.placeName)")
                    Text("🌍 Country: \(place.countryName) (\(place.countryCode))")
                }
                
                Section(header: Text("Description")) {
                    Text(place.description)
                }
                
//                Section(header: Text("Country Flag"))
//                {
//                    getImageFromUrl(url: "https://flagcdn.com/w320/\(place.countryCode).png", filename: "ImageUnavailable")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(minWidth: 300, maxWidth: 320, alignment: .center)
//                }
                
                Section(header: Text("Location")) {
                    Text("🌎 Latitude: \(place.latitude)")
                    Text("🌍 Longitude: \(place.longitude)")
                }
                
                Section(header: Text("Website")) {
                    if let url = URL(string: place.websiteUrl), !place.websiteUrl.isEmpty {
                        Link("🔗 Visit Website", destination: url)
                            .foregroundColor(.blue)
                    } else {
                        Text("No website available")
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Photo")) {
                    if UIImage(named: place.photoFilename) != nil {
                        Image(place.photoFilename)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Text("No image available")
                            .foregroundColor(.gray)
                    }
                }
                Section(header: Text("Select Map Style")){
                    Picker("Select Map Style", selection: $selectedMapStyleIndex) {
                        ForEach(0 ..< mapStyles.count, id: \.self){
                            index in Text(mapStyles[index])
                        }
                    }
                    NavigationLink(destination: PlaceLocation(place: place, mapStyleIndex: selectedMapStyleIndex)){
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Place Location on Map")
                                .font(.system(size: 16))
                        }
                    }
                }
            }
            .navigationTitle(place.placeName)
        )
    }
}

struct PlaceLocation: View {
    
    let place: PlaceStruct
    let mapStyleIndex: Int
    
    @State private var mapCameraPos: MapCameraPosition = .region(
        MKCoordinateRegion(center: placeCenterCoordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    var body: some View {
        var mapStyle = MapStyle.standard
        
        switch mapStyleIndex {
        case 0:
            mapStyle = MapStyle.standard
        case 1:
            mapStyle = MapStyle.imagery     // Satellite
        case 2:
            mapStyle = MapStyle.hybrid
        case 3:
            mapStyle = MapStyle.hybrid(elevation: .realistic)   // Globe
        default:
            print("Map style is out of range!")
        }
        
        return AnyView(
            Map(position: $mapCameraPos) {
                Marker(place.placeName, coordinate: placeCenterCoordinate)
            }.mapStyle(mapStyle)
                .navigationTitle(place.placeName)
                .toolbarTitleDisplayMode(.inline)
        )
    }
}


#Preview {
    PlacesDetail(place: places[0])
}
