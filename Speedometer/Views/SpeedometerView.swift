//
//  SpeedometerView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct SpeedometerView: View {
    // MARK: - State Properties
    @State private var inputValue: String = "15200"
    @State private var animatedValue: Double = 0
    @State private var displayValue: Double = 0
    
    var body: some View {
        VStack(spacing: 70) {
            // MARK: - Speedometer
            ZStack {
                SpeedometerBackgroundView()
                ProgressArcView(value: animatedValue)
                SpeedometerTicksView()
                ValueDisplayView(value: displayValue)
                CenterHubView()
                NeedleView(value: animatedValue)
            }
            .frame(width: 280, height: 280)
            
            // MARK: - User Input Controls
            VStack(spacing: 15) {
                TextField("Enter a number", text: $inputValue)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: handleSubmit) {
                    Text("Submit")
                        .fontWeight(.bold)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [AppColor.gradientStart, AppColor.gradientEnd]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
        .onAppear(perform: runOnboardingAnimation)
    }
    
    // MARK: - Methods
    private func handleSubmit() {
        guard let value = Double(inputValue) else { return }
        displayValue = value
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 1.0)) {
            animatedValue = min(value, 100000)
        }
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // ADDITION: Logic for the onboarding animation sequence
    private func runOnboardingAnimation() {
        Task {
            // 1. Give the UI a moment to appear
            try? await Task.sleep(for: .seconds(0.5))
            
            // 2. Animate the needle and arc to the maximum value
            withAnimation(.spring(response: 1.5, dampingFraction: 0.6, blendDuration: 1.2)) {
                animatedValue = 100000
                displayValue = 100000
            }
            
            // 3. Wait for the first animation to complete
            try? await Task.sleep(for: .seconds(1))
            
            // 4. Animate back to the initial default state
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 1.0)) {
                animatedValue = 15200
                displayValue = 15200
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SpeedometerView()
}
