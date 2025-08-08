//
//  SpeedometerBackgroundView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct SpeedometerBackgroundView: View {
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [AppColor.gradientStart, AppColor.gradientEnd]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 330, height: 330)
    }
}
