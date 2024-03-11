//
//  ContentView.swift
//  ColorRange
//
//  Created by Leonardo on 14/09/23.
//

import SwiftUI

struct ContentView: View {
    let numbers: [Double] = [1.0, 2.5, 3.0, 4.5, 5.0, 10]
    let customGreen = Color(red: 0.682, green: 0.820, blue: 0.373)
    let customRed = Color(red: 0.922, green: 0.471, blue: 0.373)
    
    var body: some View {
        VStack {
            ForEach(numbers, id: \.self) { number in
                Text("\(number)")
                    .background(getCustomColor(value: number))
            }
        }
    }
    
    func getRatio(value: Double) -> Double {
        let maxVal = numbers.max() ?? 1.0
        let minVal = numbers.min() ?? 0.0
        let range = maxVal - minVal
        
        return (value - minVal) / range
    }
    
    func getCustomColor(value: Double) -> Color {
        let maxVal = numbers.max() ?? 1.0
        let minVal = numbers.min() ?? 0.0
        let range = maxVal - minVal
        
        let normalizedValue = (value - minVal) / range
        
        let red1 = getRGBA(color: customRed).red * (1 - normalizedValue)
        let green1 = getRGBA(color: customRed).green * (1 - normalizedValue)
        let blue1 = getRGBA(color: customRed).blue * (1 - normalizedValue)
        
        let red2 = getRGBA(color: customGreen).red * normalizedValue
        let green2 = getRGBA(color: customGreen).green * normalizedValue
        let blue2 = getRGBA(color: customGreen).blue * normalizedValue
        
        return Color(red: red1 + red2, green: green1 + green2, blue: blue1 + blue2)
    }
    
    func getRGBA(color: Color) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

extension UIColor {
    convenience init(_ color: Color) {
        let scanner = Scanner(string: color.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        
        scanner.scanHexInt64(&hexNumber)
        
        let red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
        let green = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
        let blue = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
        let alpha = CGFloat(hexNumber & 0x000000FF) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#Preview {
    ContentView()
}

