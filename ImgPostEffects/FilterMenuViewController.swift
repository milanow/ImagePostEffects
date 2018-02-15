//
//  FilterMenuViewController.swift
//  ImgPostEffects
//
//  Created by Tianhe Wang on 2/10/18.
//  Copyright © 2018 Tianhe Wang Coorp. All rights reserved.
//

import UIKit

class FilterMenuViewController: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onBrightnessChanged(_ sender: Any) {
        let newImg = PostEffects.BrightSaturationAndContrast(of: imageView.image!, brightness: 0.5, saturation: 1.0, contrast: 1.0, enumZeroOneTwo: 0)
        
        imageView.image = newImg
        
    }
    @IBAction func onSaturationChanged(_ sender: Any) {
        let newImg = PostEffects.BrightSaturationAndContrast(of: imageView.image!, brightness: 1.0, saturation: 0.5, contrast: 1.0, enumZeroOneTwo: 1)
        imageView.image = newImg

    }
    @IBAction func onContrastChanged(_ sender: Any) {
        let newImg = PostEffects.BrightSaturationAndContrast(of: imageView.image!, brightness: 1.0, saturation: 1.0, contrast: 0.5, enumZeroOneTwo: 2)
        imageView.image = newImg

    }
    @IBAction func onEdgeDetection(_ sender: Any) {
        let blackColor = Pixel(value: 0 | (255 << 24))
        let newImg = PostEffects.ScreenSpaceEdgeDetect(img: imageView.image!, edgeColor: blackColor)
        imageView.image = newImg
    }
}
