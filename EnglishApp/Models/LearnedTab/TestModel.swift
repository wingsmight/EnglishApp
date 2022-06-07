//
//  TestModel.swift
//  EnglishApp
//
//  Created by Igoryok on 30.05.2022.
//

import Foundation

class TestModel: ObservableObject {
    private let lastLearnedWordCount = 20
    private let learnedWordCount = 15
    

    @Published public var testWordPairs: [WordPair] = [] // all words
    @Published public var currentWordIndex: Int = 0
    
    @Published private var lastLearnedWordPairs: [WordPair] // 20 top learned except of forgotten words
    @Published private var learnedWordPairs: [WordPair] // 15 learned after top except of forgotten words
    @Published private var forgottenWordPairs: [WordPair] // all forgotten words
    @Published private var appWordPairs: [WordPair] // all words in app
    @Published private var passedWordPairs: [WordPair] = [] // passed in current session words
    
    
    init(wordPairs: [WordPair]) {
        self.appWordPairs = wordPairs
        
        self.lastLearnedWordPairs = Array(wordPairs.learnedOnly
            .sorted(by: { $0.ChangingDate > $1.ChangingDate })
            .prefix(lastLearnedWordCount))
        self.learnedWordPairs = Array(wordPairs.learnedOnly
            .sorted(by: { $0.ChangingDate > $1.ChangingDate })
            .dropFirst(lastLearnedWordCount)
            .prefix(learnedWordCount))
        self.forgottenWordPairs = wordPairs.forgottenOnly
        
        testWordPairs = lastLearnedWordPairs + learnedWordPairs + forgottenWordPairs
    }
    
    
    public func shuffle() {
        testWordPairs.shuffle()
    }
    public func remember(_ word: WordPair) {
        passedWordPairs.append(word)
        
        pass(word)
    }
    public func forget(_ word: WordPair) {
        if let wordIndex = appWordPairs.firstIndex(of: word) {
            appWordPairs[wordIndex].State = .forgotten
        }
        
        pass(word)
    }
    public func updateView() {
        objectWillChange.send()
    }
    
    private func pass(_ word: WordPair) {
        currentWordIndex += 1
        if currentWordIndex >= testWordPairs.count {
            currentWordIndex = 0
            
            guard let lastWord = testWordPairs.last else {
                return
            }
            
            shuffle()
            
            if let lastWordIndex = testWordPairs.firstIndex(of: lastWord) {
                testWordPairs.swapAt(lastWordIndex, testWordPairs.count - 1)
            }
        }
    }
}

