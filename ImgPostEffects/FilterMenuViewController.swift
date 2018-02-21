//
//  FilterMenuViewController.swift
//  ImgPostEffects
//
//  Created by Tianhe Wang on 2/10/18.
//  Copyright © 2018 Tianhe Wang Coorp. All rights reserved.
//

import UIKit

class FilterMenuViewController: UIView {
    
    var imgprops: [Double] = [1.0, 1.0, 1.0]
    var lastSelect = 4

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var viewController: ViewController!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var propertiesSlider: UISlider!
    
    @IBAction func onBrightnessChanged(_ sender: Any) {
        lastSelect = 0
        changeProps()
    }
    
    @IBAction func onSaturationChanged(_ sender: Any) {
        lastSelect = 1
        changeProps()
    }
    
    @IBAction func onContrastChanged(_ sender: Any) {
        lastSelect = 2
        changeProps()
    }
    
    @IBAction func onEdgeDetection(_ sender: Any) {
        lastSelect = 3
        let blackColor = Pixel(value: 0 | (255 << 24))
        let newImg = PostEffects.ScreenSpaceEdgeDetect(img: imageView.image!, edgeColor: blackColor)
        imageView.image = newImg
    }
    
    @IBAction func onSliderChanged(_ sender: Any) {
        if lastSelect >= 3 {
            return
        }
        changeProps()
        
    }
    
    private func changeProps(){
        imgprops[lastSelect] = Double(propertiesSlider.value)
        let newImg = PostEffects.BrightSaturationAndContrast(of: viewController.originalImage, brightness:         imgprops[0]
            , saturation: imgprops[1], contrast: imgprops[2], enumZeroOneTwo: lastSelect)
        
        imageView.image = newImg
    }
}
