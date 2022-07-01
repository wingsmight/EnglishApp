//
//  SynonymListView.swift
//  EnglishApp
//
//  Created by Igoryok on 11.05.2022.
//

import SwiftUI
import WrappingHStack

struct SynonymListView: View {
    @Binding public var word: String
    
    @StateObject private var api = SynonymsApi()
    @StateObject private var model = SynonymListModel()
    
    
    var body: some View {
        VStack {
            if api.isLoaded {
                if !api.synonymLists.isEmpty {
                    VStack{
                        ForEach(model.pairLists.indices, id: \.self) { i in
                            SynonymsRow(i + 1, wordPairs: model.pairLists[i].wordPairs)
                        }
                    }
                    .onAppear() {
                        model.getSynonyms(synonymLists: api.synonymLists)
                    }
                } else {
                    Text("Дополнительные переводы отсутствуют")
                        .font(.subheadline)
                        .padding()
                }
            } else {
                ProgressView()
                    .padding()
            }
        }
        .task(id: word) {
            await api.loadSynonyms(word: word)
        }
    }
    
    
    struct SynonymsRow: View {
        private var number: Int
        private var wordPairs: [WordPair]
        
        
        internal init(_ number: Int, wordPairs: [WordPair]) {
            self.number = number
            self.wordPairs = wordPairs
        }
        
        
        var body: some View {
            VStack {
                HStack {
                    Text(number.description)
                        .font(Font.body)
                        .foregroundColor(.secondary)

                    WrappingHStack(0..<wordPairs.count, id:\.self) {
                        Text(wordPairs[$0].Original)
                            .padding(.trailing, 3)
                    }

                    Spacer()
                }
                .padding()

                HStack {
                    WrappingHStack(0..<wordPairs.count, id: \.self) {
                        Text(wordPairs[$0].Translation + ($0 != wordPairs.count - 1 ? "," : ""))
                    }
                    
                    Spacer()
                }
                .padding(.leading)
            }
        }
    }
}
