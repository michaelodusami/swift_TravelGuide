//
//  JsonLoader.swift
//  TravelGuide
//
//  Created by Tishe on 2/11/25.
//  Copyright © 2025 Michael-Andre Odusami. All rights reserved.
//

import Foundation
import SwiftUI

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

public func decodeJsonIntoArray<T: Decodable>(filename: String, fileLocation: String, as type: T.Type = T.self) -> T {
    
    var jsonData: Data?
    var fileLocationUrl: URL?
    var arrayOfStructs: T?
    
    
    // getting the file URL from either the Main Bundle Or The Document DIrectory
    if fileLocation == "Main Bundle"
    {
        let urlOfFile: URL? = Bundle.main.url(forResource: filename, withExtension: nil)
        if let mainBundleUrl = urlOfFile {
            fileLocationUrl = mainBundleUrl
        }
        else {
            print("File not found in main bundle")
        }
    }
    else
    {
        let urlofFile: URL? = documentDirectory.appendingPathComponent(filename)
        if let documentDirectoryUrl = urlofFile {
            fileLocationUrl = documentDirectoryUrl
        }
        else {
            print("File not found in document directory")
        }
    }
    
    // getting the data from the ur;
    do {
        jsonData = try Data(contentsOf: fileLocationUrl!)
    }
    catch {
        print("Unable to obtain JSON file \(filename) content!")
    }
    
    // decoding the file data into an array
    do {
        let decoder = JSONDecoder()
        arrayOfStructs = try decoder.decode(T.self, from: jsonData!)
    } catch {
        print("Unable to decode JSON file \(filename) because your Struct attribute names do not exactly match the JSON file names.")
    }
    
    return arrayOfStructs!
}

public func getImageFromUrl(url: String, filename: String) -> Image {
    
    var imageObtained = Image(filename)
    
    let headers = [
        "accept": "image/jpg, image/jpeg, image/png",
        "cache-control": "cache",
        "connection": "keep-alive",
    ]
    
    guard let imageUrl = URL(string: url) else {
        return Image(filename)
    }
    
    let request = NSMutableURLRequest(url: imageUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
        guard error == nil else {
            semaphore.signal()
            return
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
 
        // Unwrap Optional 'data' to see if it has a value
        guard let imageDataFromUrl = data else {
            semaphore.signal()
            return
        }
 
        // Convert fetched imageDataFromUrl into UIImage object
        let uiImage = UIImage(data: imageDataFromUrl)
 
        // Unwrap Optional uiImage to see if it has a value
        if let imageObtainedFromUrl = uiImage {
            // UIImage is successfully obtained. Convert it to SwiftUI Image.
            imageObtained = Image(uiImage: imageObtainedFromUrl)
        }
    }).resume()
    
    _ = semaphore.wait(timeout: .now() + 30)
    
    return imageObtained
}
