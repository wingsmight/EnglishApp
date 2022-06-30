//
//  TestSettingsView.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct TestSettingsTab: View {
    @AppStorage("isReversedTranslation") private var isReversedTranslation: Bool = true
    
    
    var body: some View {
        VStack {
            List {
                KeyValueText("Последние выученные", "20 слов")
                KeyValueText("Ранее выученные", "15 слов")
                KeyValueText("Повтор забытых (раз)", "3")
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
