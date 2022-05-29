//
//  LearningTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearningTab: View {
    @Binding public var wordPairs: [WordPair]
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var localNotificationManager = LocalNotificationManager()
    @State var editMode: EditMode = .inactive
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header(editMode: $editMode)
                
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
                        .onMove(perform: movePushedWords)
                        .onDelete(perform: removeWord)
                        ForEach($wordPairs, id: \.self) { wordPair in
                            if wordPair.wrappedValue.state == .learning && !wordPair.wrappedValue.isPushed {
                                LearningWordPairRow(wordPair: wordPair)
                            }
                        }
                        .onMove(perform: moveLearningWords)
                        .onDelete(perform: removeWord)
                    }
                    .environment(\.editMode, $editMode)
                    .listStyle(.plain)
                }
            }
            .animation(Animation.easeInOut(duration: 0.3), value: wordPairs.pushedOnly)
            .animation(Animation.easeInOut(duration: 0.3), value: wordPairs.learningOnly)
            .animation(.spring(), value: editMode)
            .navigationBarTitle("На изучении")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { newPhase in
            print(newPhase)
            if newPhase == .active {
                loadLearnedWordsFromNotification()
            } else if newPhase == .background {
                scheduleNotifications()
            }
        }
    }
    
    func movePushedWords(from source: IndexSet, to destination: Int) {
        wordPairs.move(fromOffsets: source, toOffset: destination)
    }
    func moveLearningWords(from source: IndexSet, to destination: Int) {
        wordPairs.move(fromOffsets: source, toOffset: destination)
    }
    func removeWord(at offsets: IndexSet) {
        for offset in offsets{
            if let index = wordPairs.firstIndex(of: wordPairs[offset]) {
                wordPairs[index].isPushed = false
                wordPairs[index].state = .none
            }
        }
    }
    func loadLearnedWordsFromNotification() {
        if let pushedWordsData = LocalNotificationManager.pushedWordsData {
            if let pushedWordPairs = try? JSONDecoder().decode([WordPair].self, from: pushedWordsData) {
                for (i, _) in wordPairs.enumerated() {
                    if pushedWordPairs.contains(wordPairs[i]) {
                        wordPairs[i].isPushed = false
                        wordPairs[i].state = .learned
                    }
                }
            }
            LocalNotificationManager.pushedWordsData = nil
        }
    }
    func scheduleNotifications() {
        localNotificationManager.pushedWordPairs = wordPairs.pushedOnly
        localNotificationManager.askUserPermission() { (granted, error) in
            if granted == true && error == nil {
                localNotificationManager.repeatPushedWordPairs()
            } else { }
        }
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
                
                MoveWordPairToPushButton(isEnabled: $wordPair.isPushed)
                
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
        @Binding public var editMode: EditMode
        
        
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    
                    EditButton(editMode: $editMode)

                    SettingsView()
                }
            }
        }
        
        struct EditButton: View {
            @Binding public var editMode: EditMode
            
            
            var body: some View {
                Button {
                    editMode.toggle()
                } label: {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding()
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
