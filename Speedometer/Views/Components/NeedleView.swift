//
//  NeedleView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct NeedleView: View {
    let value: Double
    
    var body: some View {
        Rectangle()
            .fill(AppColor.primary)
            .frame(width: 5, height: 120)
            .cornerRadius(10)
            .offset(y: -60)
            .rotationEffect(.degrees(SpeedometerViewModel.valueToAngle(value)))
            .animation(.easeInOut(duration: 0.7), value: SpeedometerViewModel.valueToAngle(value))
    }
}

struct CenterHubView: View {
    var body: some View {
        Circle()
            .fill(Color(hex: "101820"))
            .frame(width: 60, height: 60)
            .shadow(color: Color.black.opacity(0.4), radius: 4, x: -1.5, y: 3)
    }
}
