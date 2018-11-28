//
//  VignetteFilter.swift
//  02Drawing
//
//  Created by dfang on 2018-11-27.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class VignetterFilter: CIFilter {
    var inputImage: CIImage?
    var inputPercentage: NSNumber? = 1.0
    
    override var outputImage: CIImage? {
        return self.makeOutputImage()
    }
    
    private func makeOutputImage() -> CIImage? {
        guard let inputImage = self.inputImage else { return nil}
        guard let inputPercentage = self.inputPercentage else { return nil}
        let extent = inputImage.extent
        // get filter names
        // let filters = CIFilter.filterNames(inCategory: nil)
        // print(filters)
        let grad = CIFilter.init(name: "CIRadialGradient")
        let center = CIVector.init(x: extent.width/2.0, y: extent.height/2.0)
        let smallerDimension = min(extent.width, extent.height)
        let largerDimension = max(extent.width, extent.height)
        grad?.setValue(center, forKey: kCIInputCenterKey)
        grad?.setValue(smallerDimension/2.0 * CGFloat.init(truncating:inputPercentage), forKey: "inputRadius0")
        grad?.setValue(largerDimension/2.0, forKey: "inputRadius1")
        let blend = CIFilter.init(name: "CIBlendWithMask")
        blend?.setValue(inputImage, forKey: kCIInputImageKey)
        blend?.setValue(grad?.outputImage, forKey: kCIInputMaskImageKey)
        return blend?.outputImage
    }
    
}
