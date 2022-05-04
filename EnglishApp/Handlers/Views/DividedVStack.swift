//
//  DividedVStack.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI
import ViewExtractor

struct DividedVStack: View {
    private let views: [AnyView]
    private var spacing: CGFloat = 0
    private var alignment: HorizontalAlignment = .center
    
    
    // For 2 or more views
    init<Views>(alignment: HorizontalAlignment = .center, spacing: CGFloat = 0, @ViewBuilder content: TupleContent<Views>) {
        self.alignment = alignment
        self.spacing = spacing
        views = ViewExtractor.getViews(from: content)
    }
    // For 0 or 1 view
    init<Content: View>(alignment: HorizontalAlignment = .center, spacing: CGFloat = 0, @ViewBuilder content: NormalContent<Content>) {
        self.alignment = alignment
        self.spacing = spacing
        views = ViewExtractor.getViews(from: content)
    }

    
    var body: some View {
        VStack(alignment: self.alignment, spacing: self.spacing) {
            ForEach(views.indices) { index in
                if index != 0 {
                    Divider()
                }
                
                views[index]
            }
        }
    }
}

struct DividedVStack_Previews: PreviewProvider {
    static var previews: some View {
        DividedVStack(spacing: 5) {
            Text("Hello")
            Text("World")
        }
    }
}
