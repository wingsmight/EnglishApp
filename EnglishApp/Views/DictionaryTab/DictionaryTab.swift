//
//  DictionaryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI
import AVFoundation


struct DictionaryTab: View {
    @Binding public var wordPairs: [WordPair]
    
    @State private var inputWord: String = ""
    @State private var translatedWord: String? = nil
    @State private var gainedWordPair: WordPair? = nil
    @State private var inputLanguage: Language = .english
    @State private var outputLanguage: Language = .russian
    @State private var categories: [LearningCategory] = [
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon0", titleText: "ТОП 100", headlineText: "для начинающих", backgroundColor: Color("AppGreen")),
            wordPairs: [WordPair("Test 0", "Тест 0"), WordPair("Test 1", "Тест 1")],
            generalWordPairs: $wordPairs
        ),
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon1", titleText: "ТОП 1000", headlineText: "средний уровень", backgroundColor: Color("AppCyan")),
            wordPairs: [WordPair("Test 10", "Тест 10"), WordPair("Test 11", "Тест 11")],
            generalWordPairs: $wordPairs
        ),
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon2", titleText: "ТОП 3000", headlineText: "прогрессивный уровнь", backgroundColor: Color("AppAmber")),
            wordPairs: [WordPair("Test 20", "Тест 20"), WordPair("Test 21", "Тест 21")],
            generalWordPairs: $wordPairs
        ),
    ]

    
    var body: some View {
        NavigationView {
            ScrollView([]) {
                Header()
                
                LanguagePair(inputLanguage: $inputLanguage, outputLanguage: $outputLanguage)
                    .padding()
                
                WordInput(word: $inputWord)
                    .padding()
                
                if inputWord.isEmpty {
                    ForEach(DictionaryTab.categories, id: \.label.TitleText) { category in
                        CategoryView(data: category)
                            .padding(.vertical, 4.0)
                            .padding(.horizontal)
                    }
                } else {
                    ZStack {
                        VStack {
                            WordInfoView(word: $inputWord)
                            
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
        
        
        var body: some View {
            NavigationLink(destination: CategoryWordsTab(categoryLabel: data.label.TitleText, wordPairs: $data.wordPairs)) {
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
        }
    }
}

//struct DictionaryTab_Previews: PreviewProvider {
//    static var previews: some View {
//        DictionaryTab()
//    }
//}
