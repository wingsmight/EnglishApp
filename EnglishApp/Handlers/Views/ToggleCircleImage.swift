//
//  ToggleCircleImage.swift
//  EnglishApp
//
//  Created by Igoryok on 05.05.2022.
//

import SwiftUI

struct ToggleCircleImage: View {
    @Binding public var isEnabled: Bool
    public var image: Image
    public var enabledColor: Color
    public var onTap: (Bool) -> Void
    
    
    var body: some View {
        Button {
            self.isEnabled.toggle()
            
            onTap(self.isEnabled)
        } label: {
            ZStack {
                if self.isEnabled {
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
        ToggleCircleImage(isEnabled: .constant(true), image: Image("Checkmark"), enabledColor: Color("AppGreen")) { newValue in
            
        }
    }
}
