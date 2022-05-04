//
//  KeyValueView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI


struct KeyValueView: View {
    private var pair: Pair
    
    
    init(_ pair: Pair) {
        self.pair = pair
    }
    init(_ key: String, _ value: String) {
        self.pair = Pair(key, value)
    }
    
    
    var body: some View {
        HStack {
            Text(pair.key)
            
            Spacer()
            
            Text(pair.value)
                .bold()
        }
    }
    
    
    internal struct Pair {
        var key: String
        var value: String
        
        
        internal init(_ key: String, _ value: String) {
            self.key = key
            self.value = value
        }
    }
}

struct KeyValueView_Previews: PreviewProvider {
    private static let exampleKey = KeyValueView.Pair("Key", "Value")
    
    
    static var previews: some View {
        KeyValueView(exampleKey)
    }
}
