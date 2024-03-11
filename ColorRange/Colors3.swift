//
//  Colors3.swift
//  ColorRange
//
//  Created by Leonardo on 14/09/23.
//

import SwiftUI

struct Colors3: View {
    let numbers: [Double] = [1.0, 2.5, 3.0, 4.5, 5.0]
    let customGreen = Color(red: 0.2, green: 0.8, blue: 0.2)
    let customRed = Color(red: 0.8, green: 0.2, blue: 0.2)
    let customBlue = Color(red: 0.2, green: 0.2, blue: 0.8)
    
    var body: some View {
        VStack {
            ForEach(numbers, id: \.self) { number in
                Text("\(number)")
                    .background(color(value: number))
            }
        }
    }
    
    func color(value: Double) -> Color {
        let customGreen = Color(red: 0.682, green: 0.820, blue: 0.373)
        let customRed = Color(red: 0.922, green: 0.471, blue: 0.373)
        let customYellow = Color(red: 0.969, green: 0.894, blue: 0.306)
        
        let maxVal = numbers.max() ?? 1.0
        let minVal = numbers.min() ?? 0.0
        let range = maxVal - minVal
        
        var ratio: Double = (value - minVal) / range
        
        if ratio < 0.5 {
            let adjustedRatio = ratio * 2
            return blendTwoColors(customGreen, customYellow, ratio: adjustedRatio)
        } else {
            let adjustedRatio = (ratio - 0.5) * 2
            return blendTwoColors(customYellow, customRed, ratio: adjustedRatio)
        }
        
    }
    
    func blendTwoColors(_ color1: Color, _ color2: Color, ratio: Double) -> Color {
        // Aquí puedes usar la lógica para mezclar dos colores
        // Este es un ejemplo simple, puedes ajustarlo según tus necesidades
        let red1 = getRGBA(color: color1).red * (1 - ratio)
        let green1 = getRGBA(color: color1).green * (1 - ratio)
        let blue1 = getRGBA(color: color1).blue * (1 - ratio)
        
        let red2 = getRGBA(color: color2).red * ratio
        let green2 = getRGBA(color: color2).green * ratio
        let blue2 = getRGBA(color: color2).blue * ratio
        
        return Color(red: red1 + red2, green: green1 + green2, blue: blue1 + blue2)
    }
    
    func getRGBA(color: Color) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

#Preview {
    Colors3()
}

