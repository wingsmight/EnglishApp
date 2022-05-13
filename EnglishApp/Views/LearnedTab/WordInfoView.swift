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
            
            switch selectedOption {
            case .synonyms:
                SynonymListView(word: $word)
            case .examples:
                ExampleListView(word: $word)
            }
        }
        .padding(.leading)
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
        WordInfoView(word: .constant("Apple"))
    }
}
