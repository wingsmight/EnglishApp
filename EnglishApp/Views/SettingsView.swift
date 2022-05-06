//
//  SettingsView.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct SettingsView: View {
    @State var isSettingsTabShowing = false
    
    
    var body: some View {
        NavigationLink(destination: SettingsTab()) {
            Image(systemName: "gearshape")
                .font(.title)
                .foregroundColor(.secondary)
                .padding()
                .background(NavigationLink(destination: SettingsTab(), isActive: $isSettingsTabShowing) {
                    EmptyView()
                })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
