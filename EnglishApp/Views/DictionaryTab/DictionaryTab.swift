//
//  DictionaryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI


struct DictionaryTab: View {
    @State var word: String = ""
    
    private let categories: [LearningCategory] = [
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon0", titleText: "ТОП 100", headlineText: "для начинающих", backgroundColor: Color("AppGreen")),
            wordPairs: [WordPair("Test 0", "Тест 0"), WordPair("Test 1", "Тест 1")]),
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon1", titleText: "ТОП 1000", headlineText: "средний уровень", backgroundColor: Color("AppCyan")),
            wordPairs: [WordPair("Test 0", "Тест 0"), WordPair("Test 1", "Тест 1")]),
        LearningCategory(
            label: LearningCategory.Label(iconName: "CategoryIcon2", titleText: "ТОП 3000", headlineText: "прогрессивный уровнь", backgroundColor: Color("AppAmber")),
            wordPairs: [WordPair("Test 0", "Тест 0"), WordPair("Test 1", "Тест 1")]),
    ]
    
    var body: some View {
        VStack {
            Header()
            LanguagePair()
                .padding()
            WordInput(word: $word)
                .padding()
            
            ForEach(categories, id: \.Label.TitleText) { category in
                CategoryView(data: category)
                    .padding(.vertical, 4.0)
                    .padding(.horizontal)
            }
            
            Spacer()
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
        var body: some View {
            HStack {
                Spacer()
                Spacer()
                Text("Английский")
                Spacer()
                Image(systemName: "arrow.left.arrow.right")
                    
                Spacer()
                Text("Русский")
                Spacer()
                Spacer()
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
                .font(.title2)
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 32) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 22, height: 22)
                        
                        Image("Speaker")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                    .padding()
                }
            }
        }
    }

    struct CategoryView: View {
        var data: LearningCategory
        
        
        var body: some View {
            NavigationLink(destination: CategoryWordsTab(wordPairs: data.WordPairs)) {
                ZStack {
                    HStack {
                        Image(data.Label.IconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80.0, height: 80.0)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text(data.Label.TitleText)
                                .font(.title)
                                .foregroundColor(.white)
                            Text(data.Label.HeadlineText)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
                .frame(height: 85)
                .background(data.Label.BackgroundColor)
            .cornerRadius(10)
            }
        }
    }
}

struct DictionaryTab_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryTab()
    }
}
