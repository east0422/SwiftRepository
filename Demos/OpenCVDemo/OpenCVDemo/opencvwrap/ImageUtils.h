//
//  ImageUtils.h
//  OpenCVDemo
//
//  Created by dfang on 2017-10-30.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>

@interface ImageUtils: NSObject

/**
 Convert base64 to UIImage

 @param base64 type is string
 @return UIImage
 */
+ (UIImage *)imageFromBase64:(NSString *)base64;

/**
 Convert CVMat to UIIMage
 
 @param cvMat type is cv::Mat
 @return UIImage
 */
+ (UIImage *)imageFromCVMat:(cv::Mat)cvMat;

/**
 Convert UIImage to CVMat

 @param image type is UIImage
 @return cvMat
 */
+ (cv::Mat)cvMatFromUIImage:(UIImage *)image;

/**
 Convert UIImage to gray CVMat

 @param image type is UIMage
 @return cvMat
 */
+ (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;

@end
