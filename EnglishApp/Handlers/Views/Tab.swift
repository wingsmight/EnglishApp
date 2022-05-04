//
//  Tab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct Tab {
    private let DEFAULT_ICON_SIZE : Float = 25
    private let DEFAULT_SELECT_COLOR = Color(UIColor.label)
    private let INACTIVE_COLOR = Color("inactiveTabColor")
    
    
    private var iconName : String
    private var iconSize : Float
    private var selectedColor : Color
    
    
    init(_ iconName : String) {
        self.iconName = iconName
        iconSize = DEFAULT_ICON_SIZE
        selectedColor = DEFAULT_SELECT_COLOR
    }
    init(iconName : String, iconSize : Float) {
        self.init(iconName)
        
        self.iconSize = iconSize
    }
    init(iconName : String, iconSize : Float, selectedColor : Color) {
        self.init(iconName: iconName, iconSize: iconSize)
        
        self.selectedColor = selectedColor
    }
    
    
    public var IconName : String {
        get { iconName }
    }
    public var IconSize : Float {
        get { iconSize }
    }
    public var SelectedColor : Color {
        get { selectedColor }
    }
    public var InactiveColor : Color {
        get { INACTIVE_COLOR }
    }
}
