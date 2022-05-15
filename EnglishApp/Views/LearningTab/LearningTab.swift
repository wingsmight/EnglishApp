//
//  LearningTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearningTab: View {
    @Binding public var learningWordPairs: [WordPair]
    @Binding public var learnedWordPairs: [WordPair]
    @Binding public var pushedWordPairs: [WordPair]
    public let saveAction: () -> Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if learningWordPairs.isEmpty {
                    Spacer()
                    
                    Text("Добавьте слова из словаря\nдля начала изучения 💡")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(filteredWordPairs, id: \.self) { wordPair in
                            LearningWordPairRow(wordPair: wordPair, pushedWordPairs: $pushedWordPairs, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .animation(Animation.easeInOut(duration: 0.3), value: filteredWordPairs)
            .navigationBarTitle("На изучении")
            .navigationBarHidden(true)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
    
    struct LearningWordPairRow: View {
        public let wordPair: WordPair
        @Binding public var pushedWordPairs: [WordPair]
        @Binding public var learnedWordPairs: [WordPair]
        @Binding public var learningWordPairs: [WordPair]
        
        @State private var isPushed: Bool
        
        
        init(wordPair: WordPair, pushedWordPairs: Binding<[WordPair]>, learnedWordPairs: Binding<[WordPair]>, learningWordPairs: Binding<[WordPair]>) {
            self.wordPair = wordPair
            self._pushedWordPairs = pushedWordPairs
            self._learnedWordPairs = learnedWordPairs
            self._learningWordPairs = learningWordPairs
            
            self.isPushed = pushedWordPairs.wrappedValue.contains(wordPair)
        }

        
        var body: some View {
            HStack {
                WordPairRow(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
                
                Spacer()
                
                MoveWordPairToPushButton(isEnabled: $isPushed)
                    .onChanged(of: isPushed) { newValue in
                        if newValue {
                            pushedWordPairs.append(wordPair)
                        } else {
                            pushedWordPairs.removeAll(where: { $0 == wordPair })
                        }
                    }
                
                ToggleLearnedWordButton(wordPair: wordPair, learnedWordPairs: $learnedWordPairs)
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
    
    
    private var filteredWordPairs: [WordPair] {
        pushedWordPairs + learningWordPairs.filter( { !pushedWordPairs.contains($0) } )
    }
}

//struct LearningTab_Previews: PreviewProvider {
//    static var previews: some View {
//        LearningTab(learningWordPairs: <#Binding<[WordPair]>#>, pushedWordPairs: <#Binding<[WordPair]>#>, saveAction: <#() -> Void#>)
//    }
//}
