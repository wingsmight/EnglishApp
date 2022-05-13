//
//  RepeatVard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI

struct RepeatCard: View {
    @State private var isWatchingAnswer: Bool = false
    
    @Binding public var word: String
    
    
    var body: some View {
        ZStack {
            Color("RepeatCardBackgroundColor")
                .ignoresSafeArea()
            
            Header()
            
            if isWatchingAnswer {
                WatchingBody(word: $word)
            } else {
                UnwatchingBody(word: word)
            }
            
            Footer(isWatchingAnswer: $isWatchingAnswer)
        }
    }
    
    struct WatchingBody: View {
        @Binding var word: String
        
        var body: some View {
            VStack {
                WordPreview(word: word)
                
                WordInfoView(word: $word)
                
                Spacer()
            }
        }
    }
    
    struct UnwatchingBody: View {
        var word: String
        
        
        var body: some View {
            VStack {
                WordPreview(word: self.word)
                
                Spacer()
            }
        }
    }
    
    struct WordPreview: View {
        var word: String
        
        
        var body: some View {
            VStack {
                VStack {
                    Text(word)
                        .font(.largeTitle)
                    
                    Image("Speaker")
                        .resizable()
                        .frame(width: 23, height: 23)
                }
                .padding(.top, 180)
            }
        }
    }
    
    struct Header: View {
        var body: some View {
            VStack {
                HStack {
                    Text("5 из 20")
                        .font(.subheadline)
                        .padding()
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    struct Footer: View {
        @Binding var isWatchingAnswer: Bool
        
        
        var body: some View {
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        // Action
                    } label: {
                        Label("Забыл", systemImage: "arrow.turn.up.left")
                            .labelStyle(VerticalLabelStyle())
                            .foregroundColor(.secondary)
                            .padding()
                    }

                    
                    Spacer()
                    
                    Button(action: {
                       self.isWatchingAnswer.toggle()
                    }) {
                        Image(systemName: self.isWatchingAnswer ? "eye.slash" : "eye")
                            .foregroundColor(.secondary)
                            .padding()
                    }

                    Spacer()
                    
                    Button {
                        // Action
                    } label: {
                        Label("Помню", systemImage: "arrow.turn.up.right")
                            .labelStyle(VerticalLabelStyle())
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
            }
        }
    }
}

struct RepeatCard_Previews: PreviewProvider {
    static var previews: some View {
        RepeatCard(word: .constant("TestWord"))
    }
}
