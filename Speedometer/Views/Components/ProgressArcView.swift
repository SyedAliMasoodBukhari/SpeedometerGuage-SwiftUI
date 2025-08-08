//
//  ProgressArcView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct ProgressArcView: View {
    let value: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(AppColor.mutedColor),
                    style: StrokeStyle(lineWidth: 5)
                )
                .frame(width: 335, height: 335)
                .shadow(color: Color.black.opacity(0.5), radius: 5)
            Circle()
                .stroke(
                    Color(AppColor.mutedColor),
                    style: StrokeStyle(lineWidth: 12)
                )
            ProgressArcShape(value: value)
                .stroke(
                    Color(AppColor.primary),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .frame(width: 340, height: 340)
                .animation(.easeInOut(duration: 0.7), value: value)
        }
        
    }
}

private struct ProgressArcShape: Shape {
    var value: Double
    
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startAngle = Angle(degrees: SpeedometerViewModel.startAngle)
        let endAngle = Angle(degrees: SpeedometerViewModel.valueToAngle(value))
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(startAngle.degrees - 90),
            endAngle: .degrees(endAngle.degrees - 90),
            clockwise: false
        )
        
        return path
    }
}


