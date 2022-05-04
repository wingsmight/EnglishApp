//
//  WordInfoView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI
import WrappingHStack


struct WordInfoView: View {
    @State private var selectedOption: Option = .translation
    private var wordPairs: [[WordPair]]
    
    
    internal init(wordPairs: [[WordPair]]) {
        self.wordPairs = wordPairs
    }
    
    
    var body: some View {
        VStack {
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

            ForEach(0..<wordPairs.count) { i in
                SubTranslationList(i + 1, wordPairs: wordPairs[i])
            }
        }
        .padding(.leading)
    }
    
    struct SubTranslationList: View {
        private var number: Int
        private var wordPairs: [WordPair]
        
        
        internal init(_ number: Int, wordPairs: [WordPair]) {
            self.number = number
            self.wordPairs = wordPairs
        }
        
        
        var body: some View {
            if wordPairs.count > 0 {
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
            } else {
                Text("Дополнительные переводы отсутствуют")
                    .font(.subheadline)
                    .padding()
            }
        }
    }
    
    enum Option: String, CaseIterable, Equatable {
        case translation = "Перевод"
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
    private static let exampleWordPairs: [[WordPair]] = [
        [WordPair(original: "сумка", translation: "handbag"), WordPair(original: "чехол", translation: "case"), WordPair(original: "сумочка", translation: "case")],
        [WordPair(original: "мешок", translation: "pouch"), WordPair(original: "пакет", translation: "package"), WordPair(original: "чемодан", translation: "suitcase"), WordPair(original: "пакетик", translation: "packet"),  WordPair(original: "пакетик", translation: "packet"), WordPair(original: "пакетик", translation: "packet")],
    ]
    
    
    static var previews: some View {
        WordInfoView(wordPairs: exampleWordPairs)
    }
}
