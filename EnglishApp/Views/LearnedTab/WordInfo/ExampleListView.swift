//
//  ExampleListView.swift
//  EnglishApp
//
//  Created by Igoryok on 11.05.2022.
//

import SwiftUI

struct ExampleListView: View {
    @Binding public var word: String
    
    @StateObject private var api = ExamplesApi()
    @StateObject private var model = ExampleListModel()
    
    
    var body: some View {
        VStack {
            if api.isLoaded {
                if !api.examples.isEmpty {
                    VStack {
                        ForEach(model.examplePairs.indices, id: \.self) { i in
                            ExampleRow(number: i + 1, examplePair: model.examplePairs[i])
                        }
                    }
                    .onAppear() {
                        model.getExamplePairs(api.examples)
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
        public var number: Int
        public var examplePair: WordPair
        
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(number.description)
                        .font(Font.body)
                        .foregroundColor(.secondary)

                    Text(examplePair.Original)
                        .padding(.trailing, 3)

                    Spacer()
                }
                .padding(.horizontal, 3)
                
                Text(examplePair.Translation)
                    .padding(.leading, 20)
            }
            .padding()
        }
    }
}
