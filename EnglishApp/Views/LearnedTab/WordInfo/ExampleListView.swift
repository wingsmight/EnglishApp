//
//  ExampleListView.swift
//  EnglishApp
//
//  Created by Igoryok on 11.05.2022.
//

import SwiftUI

struct ExampleListView: View {
    @StateObject private var api = ExamplesApi()
    
    @Binding public var word: String
    
    
    var body: some View {
        VStack {
            if api.isLoaded {
                if !api.examples.isEmpty {
                    ForEach(api.examples.indices, id: \.self) { i in
                        ExampleRow(i + 1, sentence: api.examples[i])
                    }
                } else {
                    Text("Примеры отсутствуют")
                        .font(.subheadline)
                        .padding()
                }
            } else {
                ProgressView()
                    .padding()
            }
        }
        .task(id: word) {
            await api.loadExamples(word: word)
        }
    }
    
    
    struct ExampleRow: View {
        private var number: Int
        private var sentence: String
        
        
        internal init(_ number: Int, sentence: String) {
            self.number = number
            self.sentence = sentence
        }
        
        
        var body: some View {
            HStack {
                Text(number.description)
                    .font(Font.body)
                    .foregroundColor(.secondary)

                Text(sentence)
                    .padding(.trailing, 3)

                Spacer()
            }
            .padding()
        }
    }
}
