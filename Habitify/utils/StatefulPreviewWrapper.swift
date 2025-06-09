//
//  StatefulPreviewWrapper.swift
//  Habitify
//
//  Created by Tevin Omondi on 05/06/2025.
//


import SwiftUI

/// A wrapper for previewing views that require `@Binding` properties.
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
