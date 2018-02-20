# Introduction
A demo Swift App intended to demonstrate basic skills of swift programming and XCode.

The App is about adding post-effects to different images. You can choose 4 different filter: Brightness, Saturation, Contrast, EdgeDetection. For the first 3 filter, it is easy to understand by changing the properties of image. For EdgeDetection, it mainly outlines potential edges on the image according to the change of color. I implemented it by convolution, using [Sobel operator](https://en.wikipedia.org/wiki/Sobel_operator) to calculate the differece among a pixel and its adjcent pixels(3x3 square, 8 adjcent pixels in total).

# Usage Instruction
This project is developed in Swift 3.0 & XCode 8.1. But I believe it can also be compatible with higher version.

To run this App, simply run "ImgPostEffects.xcodeproj" file(in the root folder) in XCode. And build->run on the simulator.

# Challenges
* **Where to change pixels of an image**. When displaying an image, Swift has a "UIImage" type to show it on the screen. But you cannot get color of pixels directly from it. To get pixel color, UIImage must be redraw to a CGImage. That's why RGBAImage class offers a pixel array and conversion between RGBAImage & UIImage.
* **Data type of color**. Originally, I wrote this post effects in GLSL/CG where has a strict defination about data type(fixed, float, half, etc.) and the color ranges from 0 to 1. However, the color here ranges from 0 to 255. It may cause accuracy problem that is why I bring many data type conversion in the code.
* **Math helper**. Shadering language offers many great math function like clamp, floor, lerp to be easily used. But I haven't found some great math function that fits my need(mainly data type fit). Thus I write them on my own.

# Future
Obviously, this project can be improved by many ways and I may make these changes in the futrue
* **Speed**. Most of image processing works should be done by GPU, which supports parallel calculation better. My algorithm is running on CPU though, when it needs to process large images, it slows down a lot. I found a great framework, [Metal 2](https://developer.apple.com/metal/) that can be used to assign these works to GPU.
* **Data type conversion/Math function**. Currently, there are many redundant data conversion in my code and that may be caused by not familiar Swift language. In the future I may use some math framework in Swift and hope it can increase the readability and potentially improve the performance.

# Screenshots
![Original](https://github.com/milanow/ImagePostEffects/blob/master/ImgPostEffects/ScreenShots/Original.png)
![EdgeDetection](https://github.com/milanow/ImagePostEffects/blob/master/ImgPostEffects/ScreenShots/EdgeDetection.png)
