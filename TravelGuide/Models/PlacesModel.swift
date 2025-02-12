//
//  PlacesModel.swift
//  TravelGuide
//
//  Created by Tishe on 2/11/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import Foundation

struct PlaceStruct: Codable, Identifiable, Hashable {
    var id: Int
    var placeName: String
    var countryName: String
    var countryCode: String
    var description: String
    var photoFilename: String
    var websiteUrl: String
    var latitude: Double
    var longitude: Double
}
