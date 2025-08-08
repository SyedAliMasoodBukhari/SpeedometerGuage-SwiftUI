//
//  AppContainerView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct AppContainerView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [AppColor.gradientStart, AppColor.gradientEnd]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
//             Foreground container
            VStack {
                Text("Speedometer")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding()
                RoundedRectangle(cornerRadius: 32)
                    .fill(AppColor.mutedColor.opacity(0.1))
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(AppColor.mutedColor.opacity(0.2), lineWidth: 1)
                    )
                    .padding()
            }
            
            SpeedometerView()
            
        }
    }
}

#Preview {
    AppContainerView()
}
