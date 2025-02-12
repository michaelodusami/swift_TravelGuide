//
//  GlobalData.swift
//  TravelGuide
//
//  Created by Tishe on 2/12/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import Foundation

var places: [PlaceStruct] = []

public func loadDataFiles()
{
    places = decodeJsonIntoArray(filename: "PlacesData.json", fileLocation: "Main Bundle")
   
}
