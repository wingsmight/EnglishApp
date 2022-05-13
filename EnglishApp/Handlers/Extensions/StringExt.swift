//
//  StringExt.swift
//  EnglishApp
//
//  Created by Igoryok on 07.05.2022.
//

import Foundation


extension String {
    func sliceMultipleTimes(from: String, to: String) -> [String] {
        components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
    func getHtml() async throws -> String {
        let fullHtmlString: String
        do {
            guard let url = URL(string: self) else {
                throw UrlError.notValidUrl
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            fullHtmlString = String(decoding: data, as: UTF8.self)
        } catch {
            throw HtmlRequestError.nonParsableContent
        }
        
        return fullHtmlString
    }
}
