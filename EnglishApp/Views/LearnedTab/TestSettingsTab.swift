//
//  TestSettingsView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct TestSettingsTab: View {
    @State private var isReversedTranslation: Bool = true
    
    
    var body: some View {
        VStack {
            List {
                KeyValueView("Последние выученные", "20 слов")
                KeyValueView("Ранее выученные", "15 слов")
                KeyValueView("Повтор забытых (раз)", "3")
                Toggle("Обратный перевод в тесте", isOn: $isReversedTranslation)
            }
            .listStyle(.inset)
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            
            Spacer()
        }
        .navigationTitle("Настройки")
    }
}

struct TestSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TestSettingsTab()
    }
}
