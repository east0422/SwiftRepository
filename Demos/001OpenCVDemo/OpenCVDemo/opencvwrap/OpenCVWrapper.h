//
//  OpenCVWrapper.h
//  OpenCVDemo
//
//  Created by dfang on 2017-10-26.
//  Copyright © 2017年 com.east. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface OpenCVWrapper : NSObject

+ (UIImage *)detectAndDrawWithBase64: (NSString *)base64;

+ (UIImage *)detectAndDrawWithImage: (UIImage *)image;

+ (UIImage *)dectectAndDrawWithImagePath: (NSString *)imagePath andXmlPath: (NSString *)xmlPath;

+ (NSMutableArray *)detectEye: (UIImage *)image;

+ (NSMutableArray *)detectEyeWithHongmo: (UIImage *)image;

@end
