//
//  ValueDisplayView.swift
//  Speedometer
//
//  Created by Syed Ali Masood Bukhari on 08/08/2025.
//

import SwiftUI

struct ValueDisplayView: View {
    let value: Double
    
    var body: some View {
        Text(SpeedometerViewModel.formatValue(value))
            .font(.title)
            .foregroundColor(AppColor.primary)
            .bold()
            .offset(y: 100)
    }
}
