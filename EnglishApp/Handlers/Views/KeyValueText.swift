//
//  KeyValueView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI


struct KeyValueView<Content>: View where Content: View {
    private let key: Text
    private let value: Content
    
    
    init(_ key: Text, @ViewBuilder value: () -> Content) {
      self.key = key
      self.value = value()
    }
    
    var body: some View {
        HStack {
            key
            
            Spacer()
            
            value
        }
    }
}

struct KeyValueText: View {
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
    private static let exampleKey = KeyValueText.Pair("Key", "Value")
    
    
    static var previews: some View {
        KeyValueText(exampleKey)
    }
}
