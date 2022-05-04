//
//  RepeatingFinish.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct RepeatingFinish: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Good job! 👍🏻")
                    .font(.title)
                    .padding()
                Text("Вы повторили все слова")
            }
            
            VStack {
                Spacer()
                
                Button {
                    // Action
                } label: {
                    Text("Продолжить")
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .green))
                .padding()
            }
        }
    }
}

struct RepeatingFinish_Previews: PreviewProvider {
    static var previews: some View {
        RepeatingFinish()
    }
}
