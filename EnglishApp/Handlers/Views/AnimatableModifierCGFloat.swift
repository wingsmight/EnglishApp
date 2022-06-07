//
//  AnimatableModifierDouble.swift
//  EnglishApp
//
//  Created by Igoryok on 07.06.2022.
//

import SwiftUI

struct AnimatableModifierCGFloat: AnimatableModifier {
    var targetValue: CGFloat
    
    private var isCompleted = false

    // SwiftUI gradually varies it from old value to the new value
    var animatableData: CGFloat {
        didSet {
            checkIfFinished()
        }
    }

    var completion: () -> ()

    // Re-created every time the control argument changes
    init(bindedValue: CGFloat, completion: @escaping () -> ()) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        targetValue = bindedValue
        
        isCompleted = false
        
        print("init")
    }

    mutating func checkIfFinished() -> () {
        //print("Current value: \(animatableData)")
        if animatableData == targetValue && !isCompleted {
            //if animatableData.isEqual(to: targetValue) {
//            DispatchQueue.main.async {
//                if isCompleted {
//                    self.isCompleted = true
//
//                    self.completion()
//                }
//            }
//
            self.isCompleted = true
            
            self.completion()
            
            print("checkIfFinished true")
        }
    }

    // Called after each gradual change in animatableData to allow the
    // modifier to animate
    func body(content: Content) -> some View {
        // content is the view on which .modifier is applied
        content
        // We don't want the system also to
        // implicitly animate default system animatons it each time we set it. It will also cancel
        // out other implicit animations now present on the content.
            .animation(nil, value: targetValue)
    }
}
