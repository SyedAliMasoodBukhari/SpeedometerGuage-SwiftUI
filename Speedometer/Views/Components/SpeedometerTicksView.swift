//
//  SpeedometerTicksView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct SpeedometerTicksView: View {
    private let ticks = SpeedometerViewModel.ticks
    private let tickLabelOffset: CGFloat = 20
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(ticks) { tick in
                    // We'll subtract half the width from the radius for edge alignment
                    let radius = 175 - tickLabelOffset
                    TickLabel(
                        label: tick.label,
                        angle: tick.angle,
                        baseRadius: radius,
                        geometrySize: geometry.size
                    )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

private struct TickLabel: View {
    let label: String
    let angle: Double
    let baseRadius: CGFloat
    let geometrySize: CGSize
    @State private var textWidth: CGFloat = 0
    var body: some View {
        Text(label)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { size in
                if abs(size.width - textWidth) > 0.1 {
                    textWidth = size.width
                }
            }
            .position(
                x: geometrySize.width/2 + cos(Angle(degrees: angle - 90).radians) * (baseRadius - textWidth/2),
                y: geometrySize.height/2 + sin(Angle(degrees: angle - 90).radians) * (baseRadius - textWidth/2) - 4
            )
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
