//
//  LearningTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearningTab: View {
    @EnvironmentObject private var wordPairStore: WordPairStore
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var localNotificationManager = LocalNotificationManager()
    @State private var editMode: EditMode = .inactive
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header(editMode: $editMode)
                
                if wordPairStore.wordPairs.learningOnly.isEmpty {
                    Spacer()
                    
                    Text("Добавьте слова из словаря\nдля начала изучения 💡")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach($wordPairStore.wordPairs.sorted(by: { $0.wrappedValue.ChangingDate < $1.wrappedValue.ChangingDate }),
                                id: \.id) { wordPair in
                            if wordPair.wrappedValue.IsPushed {
                                LearningWordPairRow(wordPair: wordPair)
                            }
                        }
                        .onMove(perform: movePushedWords)
                        .onDelete(perform: removeWord)
                        
                        ForEach($wordPairStore.wordPairs.sorted(by: { $0.wrappedValue.ChangingDate < $1.wrappedValue.ChangingDate }),
                                id: \.id) { wordPair in
                            if wordPair.wrappedValue.State == .learning && !wordPair.wrappedValue.IsPushed {
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
            .animation(Animation.easeInOut(duration: 0.3), value: wordPairStore.wordPairs.pushedOnly)
            .animation(Animation.easeInOut(duration: 0.3), value: wordPairStore.wordPairs.learningOnly)
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
        wordPairStore.wordPairs.move(fromOffsets: source, toOffset: destination)
    }
    func moveLearningWords(from source: IndexSet, to destination: Int) {
        wordPairStore.wordPairs.move(fromOffsets: source, toOffset: destination)
    }
    func removeWord(at offsets: IndexSet) {
        for offset in offsets{
            if let index = wordPairStore.wordPairs.firstIndex(of: wordPairStore.wordPairs[offset]) {
                wordPairStore.wordPairs[index].IsPushed = false
                wordPairStore.wordPairs[index].State = .none
            }
        }
    }
    func loadLearnedWordsFromNotification() {
        if let pushedWordsData = LocalNotificationManager.pushedWordsData {
            if let pushedWordPairs = try? JSONDecoder().decode([WordPair].self, from: pushedWordsData) {
                for (i, _) in wordPairStore.wordPairs.enumerated() {
                    if pushedWordPairs.contains(wordPairStore.wordPairs[i]) {
                        wordPairStore.wordPairs[i].IsPushed = false
                        wordPairStore.wordPairs[i].State = .learned
                    }
                }
            }
            LocalNotificationManager.pushedWordsData = nil
        }
    }
    func scheduleNotifications() {
        localNotificationManager.pushedWordPairs = wordPairStore.wordPairs.pushedOnly
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
            self.isPushed = wordPair.wrappedValue.IsPushed
        }

        
        var body: some View {
            HStack {
                WordPairRow(wordPair: $wordPair)
                
                Spacer()
                
                NotificationToggle(isEnabled: $wordPair.IsPushed)
                
                ToggleLearnedWordButton(wordPair: Binding<WordPair?>($wordPair))
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

                    SettingsButtonView()
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
