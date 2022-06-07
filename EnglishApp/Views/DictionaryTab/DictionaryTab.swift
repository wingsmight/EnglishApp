//
//  DictionaryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI
import AVFoundation


struct DictionaryTab: View {
    @ObservedObject public var model: DictionaryTabModel
    
    @State private var inputWord: String = ""
    @State private var translatedWord: String? = nil
    @State private var gainedWordPair: WordPair? = nil
    @State private var inputLanguage: Language = .english
    @State private var outputLanguage: Language = .russian
    @EnvironmentObject private var wordPairStore: WordPairStore
    
    
    var body: some View {
        NavigationView {
            ScrollView([]) {
                Header()
                
                LanguagePair(inputLanguage: $inputLanguage, outputLanguage: $outputLanguage)
                    .padding()
                
                WordInput(word: $inputWord)
                    .padding()
                
                if inputWord.isEmpty {
                    ForEach(model.categories, id: \.label.TitleText) { category in
                        CategoryView(data: category, wordPairs: $wordPairStore.wordPairs)
                            .padding(.vertical, 4.0)
                            .padding(.horizontal)
                    }
                } else {
                    ZStack {
                        VStack {
                            WordInfoView(word: /*TODO: Translate($inputWord)*/$inputWord, wordPair: .constant(WordPair(inputWord, inputWord)))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                WordControlPanel(wordPair: $gainedWordPair)
                                    .padding(.horizontal)
                                    .disabled(gainedWordPair == nil)
                                
                                Spacer()
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationBarTitle("Словарь")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
    
    struct Header: View {
        var body: some View {
            ZStack {
                Label("Logo", systemImage: "heart.fill")
                    .font(.title)
                
                HStack {
                    Spacer()
                    SettingsView()
                }
            }
        }
    }

    struct LanguagePair: View {
        @State private var isPairChanged = false
        
        @Binding public var inputLanguage: Language
        @Binding public var outputLanguage: Language
        
        
        var body: some View {
            HStack {
                Text(inputLanguage.localizedName)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    let savedInputLanguage = inputLanguage
                    inputLanguage = outputLanguage
                    outputLanguage = savedInputLanguage
                    
                    isPairChanged.toggle()
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .rotationEffect(.degrees(isPairChanged ? 180 : 0))
                        .animation(.easeInOut, value: isPairChanged)
                }
                .buttonStyle(.plain)
                
                Text(outputLanguage.localizedName)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.title3)
        }
    }

    struct WordInput: View {
        @Binding var word: String
        
        var body: some View {
            ZStack {
                TextField("Текст", text: $word)
                    .padding()
                    .frame(height: 110)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .font(.title)
                
                HStack {
                    Spacer()
                    
                    if !word.isEmpty {
                        VStack(spacing: 32) {
                            Button {
                                word = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                            }
                            .buttonStyle(.plain)
                            
                            WordSpeakerView(word: $word)
                        }
                        .padding()
                    }
                }
            }
        }
    }

    struct CategoryView: View {
        @ObservedObject public var data: LearningCategory
        @Binding public var wordPairs: [WordPair]
        
        
        var body: some View {
            NavigationLink(destination: CategoryWordsTab(categoryLabel: data.label.TitleText, categoryWordPairs: $data.wordPairs, wordPairs: $wordPairs)) {
                ZStack {
                    HStack {
                        Image(data.label.IconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80.0, height: 80.0)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text(data.label.TitleText)
                                .font(.title)
                                .foregroundColor(.white)
                            Text(data.label.HeadlineText)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
                .frame(height: 85)
                .background(data.label.BackgroundColor)
                .cornerRadius(10)
            }
            .isDetailLink(false)
        }
    }
}

//struct DictionaryTab_Previews: PreviewProvider {
//    static var previews: some View {
//        DictionaryTab()
//    }
//}
