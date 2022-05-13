//
//  SynonymListView.swift
//  EnglishApp
//
//  Created by Igoryok on 11.05.2022.
//

import SwiftUI
import WrappingHStack

struct SynonymListView: View {
    @StateObject private var api = SynonymsApi()
    @State private var synonymPairLists: [SynonymPairList] = []
    
    @Binding public var word: String
    
    
    var body: some View {
        VStack {
            if api.isLoaded {
                if !api.synonymLists.isEmpty {
                    VStack{
                        ForEach(synonymPairLists.indices, id: \.self) { i in
                            SynonymsRow(i + 1, wordPairs: synonymPairLists[i].wordPairs)
                        }
                    }
                    .onAppear() {
                        self.synonymPairLists = api.synonymLists.map { (synonyms) -> SynonymPairList in
                            var wordPairs: [WordPair] = []
                            for synonym in synonyms {
                                wordPairs.append(WordPair(synonym, synonym))
                            }
                            
                            return SynonymPairList(wordPairs: wordPairs)
                        }
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
        .task {
            await api.loadSynonyms(word: word)
        }
        .onChange(of: word, perform: { newValue in
            Task {
                await api.loadSynonyms(word: newValue)
            }
        })
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
    
    struct SynonymPairList: Decodable {
        let wordPairs: [WordPair]
    }
}
