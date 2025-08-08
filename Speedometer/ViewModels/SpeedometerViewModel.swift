import SwiftUI
import Observation

@Observable
class SpeedometerViewModel {
    
    struct Tick: Identifiable {
        let id = UUID()
        let value: Double
        let label: String
        let angle: Double
    }
    
    static let startAngle: Double = -115
    static let endAngle: Double = 115
    static let totalAngle: Double = endAngle - startAngle
    static let ticks: [Tick] = generateTicks()
    
    private static func generateTicks() -> [Tick] {
        let values: [(Double, String)] = [
            (0, "0"),
            (1000, "1k"),
            (5000, "5k"),
            (10000, "10k"),
            (25000, "25k"),
            (50000, "50k"),
            (100000, "100k+")
        ]
        let totalTicks = values.count
        let step = totalAngle / Double(totalTicks - 1)
        
        return values.enumerated().map { index, entry in
            let angle = startAngle + (Double(index) * step)
            return Tick(value: entry.0, label: entry.1, angle: angle)
        }
    }
    
    /// Converts an input value to a rotation angle by interpolating between the defined ticks.
    static func valueToAngle(_ value: Double) -> Double {
        let cappedValue = min(value, 100000)
        
        guard let (lowerTick, upperTick) = findSurroundingTicks(for: cappedValue) else {
            return startAngle // if out of bounds
        }
        
        // If the value matches a tick exactly, return its angle
        if cappedValue == lowerTick.value { return lowerTick.angle }
        
        // Calculate the percentage of the value within its segment
        let valueRange = upperTick.value - lowerTick.value
        let valueFraction = (cappedValue - lowerTick.value) / valueRange
        
        // Interpolate the angle based on that percentage
        let angleRange = upperTick.angle - lowerTick.angle
        let interpolatedAngle = lowerTick.angle + (valueFraction * angleRange)
        
        return interpolatedAngle
    }
    
    /// Converts an input value to a progress value (0.0 to 1.0) for the arc.
    static func valueToProgress(_ value: Double) -> CGFloat {
        let angle = valueToAngle(value)
        return CGFloat((angle - startAngle) / totalAngle)
    }
    
    /// Finds the two ticks that a given value falls between.
    private static func findSurroundingTicks(for value: Double) -> (Tick, Tick)? {
        for i in 0..<(ticks.count - 1) {
            if (value >= ticks[i].value && value <= ticks[i+1].value) {
                return (ticks[i], ticks[i+1])
            }
        }
        return nil
    }
    
    /// Formats the number for display (e.g., 15200 -> "15.2k").
    static func formatValue(_ value: Double) -> String {
        if value >= 1000000 {
            return String(format: "%.1fM", value / 1000000)
        } else if value >= 1000 {
            return String(format: "%.1fk", value / 1000)
        } else {
            return String(format: "%.0f", value)
        }
    }
}
