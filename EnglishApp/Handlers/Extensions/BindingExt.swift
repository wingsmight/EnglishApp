//
//  BindingExt.swift
//  EnglishApp
//
//  Created by Igoryok on 11.05.2022.
//

import SwiftUI

extension Binding {
    func didSet(_ closure: @escaping (Value) -> ()) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                closure($0)
            }
        )
    }
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
         Binding(
             get: { self.wrappedValue },
             set: { newValue in
                 self.wrappedValue = newValue
                 handler(newValue)
             }
         )
     }
}
