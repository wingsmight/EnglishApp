//
//  Translation.swift
//  EnglishApp
//
//  Created by Igoryok on 30.06.2022.
//

import Foundation

class TranslationApi {
    static let url = "https://translate.api.cloud.yandex.net/translate/v2/translate"
    static let folderId = "b1ghdoa4bn03qp2jlmvu"
    static let apiKey = "AQVN03Qd4FO2tAoaSLJO5tzJXQL1QrUvLU_CrFsL"
    
    public static func translate(_ text: String, to language: Language, onCompleted: @escaping (String) -> Void) {
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let jsonData = try? JSONSerialization.data(withJSONObject: ["targetLanguageCode": language.short,
                                                                    "texts": [text],
                                                                    "folderId": folderId])
        request.httpBody = jsonData
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Api-Key \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data else { return }
            let response = String(data: data, encoding: .utf8)!
            
            let result = parse(response)
            onCompleted(result)
        })

        task.resume()
    }
    
    private static func parse(_ response: String) -> String {
        let data = response.data(using: .utf8)!

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let j = json as? [String : AnyObject] else {
                return ""
            }

            guard let str = j["translations"] as? [AnyObject] else {
                return ""
            }

            guard let value = str[0] as? [String : String] else {
                return ""
            }

            guard let text = value["text"] else {
                return ""
            }
            
            return String(text)
        } catch {
            return ""
        }
    }
}
