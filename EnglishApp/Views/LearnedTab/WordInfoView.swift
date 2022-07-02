//
//  WordInfoView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI


struct WordInfoView: View {
    @State private var selectedOption: Option = .examples
    
    @Binding public var word: String
    @Binding public var wordLanguage: Language
    @Binding public var wordPair: WordPair
    
    
    var body: some View {
        VStack {
            TranslatedWordView(originalWord: $word)
            
            WordDetailPicker(selectedOption: $selectedOption)
            
            switch selectedOption {
            case .synonyms:
                SynonymListView(word: $wordPair.Original, originalLanguage: $wordLanguage)
            case .examples:
                ExampleListView(word: $wordPair.Original, originalLanguage: $wordLanguage)
            }
        }
        .padding(.leading)
    }
    
    struct WordDetailPicker: View {
        @Binding public var selectedOption: Option
        
        
        var body: some View {
            HStack {
                Picker(selection: $selectedOption, label: EmptyView()) {
                    ForEach(Option.allCases, id: \.self) { option in
                        Text(option.localizedName)
                            .tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .fixedSize()

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    struct TranslatedWordView: View {
        @Binding public var originalWord: String
        
        
        var body: some View {
            HStack {
                Text(originalWord)
                    .font(.title2)
                    .padding()
                
                Spacer()
            }
        }
    }
    
    enum Option: String, CaseIterable, Equatable {
        case synonyms = "Синонимы"
        case examples = "Примеры"
        
        
        var description: String {
            return self.rawValue
        }
        var localizedName: LocalizedStringKey {
            LocalizedStringKey(rawValue)
        }
    }
}

struct WordInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WordInfoView(word: .constant("Apple"), wordLanguage: .constant(.english), wordPair: .constant(WordPair("Apple", "Яблоко")))
    }
}
