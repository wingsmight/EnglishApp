//
//  UrlExt.swift
//  EnglishApp
//
//  Created by Igoryok on 07.05.2022.
//

import Foundation

extension URL {
    private static let COMPANY_NAME = "wingsmight"
    
    
    static func getStoredData(fileName: String) -> URL {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? COMPANY_NAME
        let subDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        try? FileManager.default.createDirectory(at: subDirectory, withIntermediateDirectories: true, attributes: nil)
        return subDirectory.appendingPathComponent(fileName + ".json")
    }
}
