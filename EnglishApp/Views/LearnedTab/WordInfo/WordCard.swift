//
//  WordCard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI


struct WordCard: View {
    var wordPair: WordPair
    
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
            }
            
            VStack {
                OriginalWordBlock(word: .constant(wordPair.Original))
                    .padding(.top, 100)
                WordInfoView(word: .constant(wordPair.Translation))
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    struct OriginalWordBlock: View {
        @Binding var word: String
        
        
        var body: some View {
            HStack {
                Text(word)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                WordControlPanel(word: $word)
                    .padding()
            }
        }
    }
    
    struct Header: View { 
        @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
        
        
        var body: some View {
            HStack {
                Spacer()
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct WordCard_Previews: PreviewProvider {
    private static let wordPair = WordPair("Bag", "Сумка")
    static var previews: some View {
        WordCard(wordPair: wordPair)
    }
}
