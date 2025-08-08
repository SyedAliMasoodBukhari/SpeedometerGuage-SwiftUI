//
//  View+Offset.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

extension View {
    func offset(_ offset: @escaping () -> CGSize) -> some View {
        modifier(DynamicOffset(offset: offset))
    }
}

struct DynamicOffset: ViewModifier {
    let offset: () -> CGSize
    func body(content: Content) -> some View {
        content.offset(offset())
    }
}
