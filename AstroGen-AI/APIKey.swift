//
//  APIKey.swift
//  AstroGen-AI
//
//  Created by Aman Purohit on 2024-04-14.
//

import Foundation

enum APIKey{
    static var `default`: String{
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info",ofType:"pList")
        else{
            fatalError("Couldn't find file 'GenerativeAI-Info.pList'. ")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_kEY") as? String else{
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_"){
            fatalError(
            "Follow the instruction at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        return value
    }
}
