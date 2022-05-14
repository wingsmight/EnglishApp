//
//  ToggleCircleImage.swift
//  EnglishApp
//
//  Created by Igoryok on 05.05.2022.
//

import SwiftUI

struct ToggleCircleImage: View {
    @Binding var isEnabled: Bool
    
    var image: Image
    var enabledColor: Color
    
    
    var body: some View {
        Button {
            self.isEnabled.toggle()
        } label: {
            ZStack {
                if isEnabled {
                    Circle()
                        .foregroundColor(enabledColor)
                        .frame(width: 33, height: 33)
                } else {
                    
                }
                
                image
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .buttonStyle(.plain)
        .frame(width: 30, height: 30)
    }
}

struct ToggleCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ToggleCircleImage(isEnabled: .constant(true), image: Image("Checkmark"), enabledColor: Color("AppGreen"))
    }
}
