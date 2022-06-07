//
//  TestView.swift
//  EnglishApp
//
//  Created by Igoryok on 30.05.2022.
//

import SwiftUI

struct TestView: View {
    @StateObject public var model: TestModel
    
    
    init(model: @autoclosure @escaping () -> TestModel) {
        _model = StateObject(wrappedValue: model())
    }
    
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach($model.testWordPairs) { wordPair in
                    RepeatCard(wordPair: wordPair,
                               onForgotten: model.forget,
                               onRemebered: model.remember)
                }
            }
            
            Header(currentNumber: $model.currentWordIndex, count: model.testWordPairs.count)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            model.shuffle()
        }
    }
    
    
    struct Header: View {
        @Binding public var currentNumber: Int
        public var count: Int
        
        
        var body: some View {
            VStack {
                HStack {
                    Counter(currentIndex: $currentNumber, count: count)
                    
                    Spacer()
                    
                    CloseNavigationButton()
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        
        
        struct Counter: View {
            @Binding public var currentIndex: Int
            public var count: Int
            
            
            var body: some View {
                Text("\(currentIndex + 1) из \(count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(model: TestModel(wordPairs: [WordPair("Apple", "Яблоко")]))
    }
}
