//
//  PostEffects.swift
//  ImgPostEffects
//
//  Created by Tianhe Wang on 2/7/18.
//  Copyright © 2018 Tianhe Wang Coorp. All rights reserved.
//

import Foundation
import UIKit

class PostEffects {
    
    // brightness: 0-1, saturation: 0-1, contrast: 0-1
    public static func BrightSaturationAndContrast(of img: UIImage, brightness: Double, saturation: Double, contrast: Double, enumZeroOneTwo: Int) -> UIImage{
        guard var rgbImg = RGBAImage(image: img) else{
            return UIImage()
        }

        for y in 0..<rgbImg.height {
            for x in 0..<rgbImg.width {
                let index = y * rgbImg.width + x
                var pixel = rgbImg.pixels[index]
                
                var finalColor = pixel
                
                // change brightness
                if(enumZeroOneTwo == 0){
                    finalColor = MathHelper.changeColor(of: pixel, with: brightness)
                }
                // change saturation
                if(enumZeroOneTwo == 1){
                    let lumColor = luminance(red: pixel.red, green: pixel.green, blue: pixel.blue)
                    finalColor = MathHelper.lerp(min: lumColor, max: finalColor, with: saturation)
                }
                // change contrast
                if(enumZeroOneTwo == 2){
                    let avgColor = Pixel(value: 127 | (127 << 8) | (127 << 16) | (255 << 24))
                    finalColor = MathHelper.lerp(min: avgColor, max: finalColor, with: contrast)
                }
                
                rgbImg.pixels[index] = finalColor
            }
        }
        
        return rgbImg.toUIImage()!
    }
    
    // Sobel kernel
    private static let sobelGx: [Int] = [1, 0, -1, 2, 0, -2, 1, 0, -1]
    private static let sobelGy: [Int] = [1, 2, 1, 0, 0, 0, -1, -2, -1]
    
    public static func ScreenSpaceEdgeDetect(img: UIImage, edgeColor: Pixel) -> UIImage{
        guard var rgbImg = RGBAImage(image: img) else{
            return UIImage()
        }
        
        var imgRes = rgbImg
        
        let pixelOffset: [Int] = [-1*rgbImg.width - 1, -1*rgbImg.width, -1*rgbImg.width+1,
                                  -1, 0, 1,
                                  rgbImg.width-1, rgbImg.width, rgbImg.width+1]
        
        for y in 1..<(rgbImg.height-1) {
            for x in 1..<(rgbImg.width-1) {
                let index = y * rgbImg.width + x
                let pixel = rgbImg.pixels[index]
                
                var finalColor: Pixel
                
                var lumColor: UInt8
                var edgeX = 0
                var edgeY = 0
                for i in 0..<9 {
                    lumColor = lum(red: rgbImg.pixels[index + pixelOffset[i]].red, green: rgbImg.pixels[index + pixelOffset[i]].green, blue: rgbImg.pixels[index + pixelOffset[i]].blue)
                    edgeX = edgeX + Int(lumColor) * sobelGx[i]
                    edgeY = edgeY + Int(lumColor) * sobelGy[i]
                }
                
                let factor = MathHelper.clamp(value: Double(abs(edgeX) + abs(edgeY)), min: 0, max: 255.0) / 255.0
                finalColor = MathHelper.lerp(min: pixel, max: edgeColor, with: factor)
                
                imgRes.pixels[index] = finalColor
            }
        }
        
        return imgRes.toUIImage()!
    }
    
    // calculate luminance of a color
    private static func lum(red: UInt8, green: UInt8, blue: UInt8) -> UInt8 {
        return UInt8(0.2125 * Double(red) + 0.7154 * Double(green) + 0.0721 * Double(blue))
    }
    
    // Pixel format of luminance of a color
    private static func luminance(red: UInt8, green: UInt8, blue: UInt8) -> Pixel{
        var pixel = Pixel(value: 0)
        let intLum = lum(red: red, green: green, blue: blue)
        pixel.red = intLum
        pixel.green = intLum
        pixel.blue = intLum
        pixel.alpha = 255
        return pixel
    }
    
   
}
