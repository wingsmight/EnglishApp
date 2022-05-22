//
//  LearningTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearningTab: View {
    @Binding public var wordPairs: [WordPair]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if wordPairs.learningOnly.isEmpty {
                    Spacer()
                    
                    Text("Добавьте слова из словаря\nдля начала изучения 💡")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach($wordPairs, id: \.self) { wordPair in
                            if wordPair.wrappedValue.isPushed {
                                LearningWordPairRow(wordPair: wordPair)
                            }
                        }
                        ForEach($wordPairs, id: \.self) { wordPair in
                            if wordPair.wrappedValue.state == .learning {
                                LearningWordPairRow(wordPair: wordPair)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .animation(Animation.easeInOut(duration: 0.3), value: wordPairs)
            .navigationBarTitle("На изучении")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack) 
    }
    
    
    struct LearningWordPairRow: View {
        @Binding public var wordPair: WordPair
        
        @State private var isPushed: Bool = false
        
        
        init(wordPair: Binding<WordPair>) {
            self._wordPair = wordPair
            self.isPushed = wordPair.wrappedValue.isPushed
        }

        
        var body: some View {
            HStack {
                WordPairRow(wordPair: $wordPair)
                
                Spacer()
                
                MoveWordPairToPushButton(isEnabled: $isPushed)
                    .onChanged(of: isPushed) { newValue in
                        wordPair.isPushed = newValue
                    }
                
                ToggleLearnedWordButton(wordPair: Binding<WordPair?>($wordPair))
            }
        }
        
        struct MoveWordPairToPushButton: View {
            @Binding var isEnabled: Bool
            
            
            var body: some View {
                Button {
                    isEnabled.toggle()
                } label: {
                    Image(systemName: isEnabled ? "play.fill" : "play")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 22)
                        .padding(.horizontal, 5)
                        .foregroundColor(isEnabled ? Color("AppGreen") : .primary)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    struct Header: View {
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    SettingsView()
                }
            }
        }
    }
}

//struct LearningTab_Previews: PreviewProvider {
//    static var previews: some View {
//        LearningTab(learningWordPairs: <#Binding<[WordPair]>#>, pushedWordPairs: <#Binding<[WordPair]>#>, saveAction: <#() -> Void#>)
//    }
//}
