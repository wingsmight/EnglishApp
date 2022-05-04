//
//  VerticalLabelStyle.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import Foundation
import SwiftUI


struct VerticalLabelStyle: LabelStyle {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass

  func makeBody(configuration: Configuration) -> some View {
      VStack {
        configuration.icon
        configuration.title
      }
  }
}
