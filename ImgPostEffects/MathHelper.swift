//
//  MathHelper.swift
//  ImgPostEffects
//
//  Created by Tianhe Wang on 2/14/18.
//  Copyright © 2018 Tianhe Wang Coorp. All rights reserved.
//

import Foundation

class MathHelper {
    public static func clamp(value: Double, min: Double, max: Double) -> Double {
        return Swift.min(Swift.max(value, Swift.min(min, max)), Swift.max(min, max))
    }
    
    public static func lerp(min: Pixel, max: Pixel, with coefficient: Double) -> Pixel{
        var pixel = Pixel(value: 0)
        pixel.red = UInt8(clamp(value: Double(min.red) * (1 - coefficient) + Double(max.red) * coefficient, min: 0, max: 255.0))
        pixel.green = UInt8(clamp(value: Double(min.green) * (1 - coefficient) + Double(max.green) * coefficient, min: 0, max: 255.0))
        pixel.blue = UInt8(clamp(value: Double(min.blue) * (1 - coefficient) + Double(max.blue) * coefficient, min: 0, max: 255.0))
        pixel.alpha = UInt8(clamp(value: Double(min.alpha) * (1 - coefficient) + Double(max.alpha) * coefficient, min: 0, max: 255.0))
        return pixel
    }
    
    public static func changeColor(of color: Pixel, with modifier: Double) -> Pixel {
        var finalColor = color
        finalColor.red = UInt8(clamp(value: Double(finalColor.red) * modifier, min: 0, max: 255))
        finalColor.green = UInt8(clamp(value: Double(finalColor.green) * modifier, min: 0, max: 255))
        finalColor.blue = UInt8(clamp(value: Double(finalColor.blue) * modifier, min: 0, max: 255))
        // only change color not alpha channel
        return finalColor
    }
    
    public static func max(_ n1: Double, _ n2: Double) -> Double{
        if n1 > n2 { return n1 }
        else { return n2 }
    }
}
