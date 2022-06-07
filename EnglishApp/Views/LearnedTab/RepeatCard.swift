//
//  RepeatVard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI

struct RepeatCard: View {
    private let fillColorBorder: CGFloat = 130
    private let effectBorder: CGFloat = 150
    private let swipeAwayBorder: CGFloat = 1500
    private let rotationDegrees: CGFloat = 40
    private let heightTight: CGFloat = 0.1
    private let widthTight: CGFloat = 1.0
    private let swipeOutDuration: CGFloat = 0.75
    
    
    @Binding public var wordPair: WordPair
    public var onForgotten: (WordPair) -> Void
    public var onRemebered: (WordPair) -> Void
    
    @State private var index: Int = 0
    @State private var isWatchingAnswer: Bool = false
    @State private var offset = CGSize.zero
    @State private var isOriginalWordShowing = false
    @State private var isSwipedOut = false
    
    
    var body: some View {
        ZStack {
            backgroundColor
                .cornerRadius(20)
            
            if isWatchingAnswer {
                WatchingBody(wordPair: $wordPair, isOriginalWordShowing: $isOriginalWordShowing)
            } else {
                UnwatchingBody(word: isOriginalWordShowing ? $wordPair.Original : $wordPair.Translation)
            }
            
            Footer(isWatchingAnswer: $isWatchingAnswer, swipeCard: swipeCard)
        }
        .offset(x: isSwipedOut ? -swipeAwayBorder : offset.width * widthTight,
                y: isSwipedOut ? -swipeAwayBorder : offset.height * heightTight)
        .rotationEffect(.degrees(Double(offset.width / rotationDegrees)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    swipeCard(width: offset.width)
                }
        )
        .animation(Animation.easeInOut(duration: 0.5), value: offset)
        .onAppear() {
            isOriginalWordShowing = Bool.random()
        }
        .zIndex(Double(index))
    }
    
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -swipeAwayBorder...(-effectBorder):
            print("\(wordPair) forgotten")
            onForgotten(wordPair)
            
            swipeOut(to: -swipeAwayBorder)
        case effectBorder...swipeAwayBorder:
            print("\(wordPair) remembered")
            onRemebered(wordPair)
            
            swipeOut(to: swipeAwayBorder)
        default:
            offset = .zero
        }
    }
    private func swipeOut(to width: CGFloat) {
        withAnimation(Animation.easeInOut(duration: swipeOutDuration)) {
            offset = CGSize(width: width, height: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isOriginalWordShowing.toggle()
            index -= 1
            withAnimation(Animation.easeInOut(duration: swipeOutDuration)) {
                offset = CGSize(width: 0, height: 0)
            }
        }
    }
    private var backgroundColor: Color {
        switch offset.width {
        case -swipeAwayBorder...(-fillColorBorder):
            return Color("AppAmber")
        case fillColorBorder...swipeAwayBorder:
            return Color("AppGreen")
        default:
            return Color("RepeatCardBackgroundColor")
        }
    }
    
    
    struct WatchingBody: View {
        @Binding var wordPair: WordPair
        @Binding var isOriginalWordShowing: Bool
        
        
        var body: some View {
            VStack {
                WordPreview(word: isOriginalWordShowing ? $wordPair.Original : $wordPair.Translation)
                
                WordInfoView(word: isOriginalWordShowing ? $wordPair.Translation : $wordPair.Original, wordPair: $wordPair)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
    }
    
    struct UnwatchingBody: View {
        @Binding var word: String
        
        
        var body: some View {
            VStack {
                WordPreview(word: $word)
                
                Spacer()
            }
        }
    }
    
    struct WordPreview: View {
        @Binding var word: String
        
        
        var body: some View {
            VStack {
                VStack {
                    Text(word)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    WordSpeakerView(word: $word)
                        .foregroundColor(.black)
                }
                .padding(.top, 180)
            }
        }
    }
    
    struct Footer: View {
        @Binding public var isWatchingAnswer: Bool
        public var swipeCard: (CGFloat) -> Void
        
        
        var body: some View {
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        swipeCard(-1500)
                    } label: {
                        Label("Забыл", systemImage: "arrow.turn.up.left")
                            .labelStyle(VerticalLabelStyle())
                            .foregroundColor(.gray)
                            .padding()
                    }

                    
                    Spacer()
                    
                    Button(action: {
                       self.isWatchingAnswer.toggle()
                    }) {
                        Image(systemName: self.isWatchingAnswer ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding()
                    }

                    Spacer()
                    
                    Button {
                        swipeCard(1500)
                    } label: {
                        Label("Помню", systemImage: "arrow.turn.up.right")
                            .labelStyle(VerticalLabelStyle())
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
        }
    }
}

struct RepeatCard_Previews: PreviewProvider {
    static var previews: some View {
        RepeatCard(wordPair: .constant(WordPair("Word", "Слово"))) { _ in
            
        } onRemebered: { _ in
            
        }
        .preferredColorScheme(.dark)
    }
}
