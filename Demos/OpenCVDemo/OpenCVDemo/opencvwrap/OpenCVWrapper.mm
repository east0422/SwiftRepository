//
//  OpenCVWrapper.mm
//  OpenCVDemo
//
//  Created by dfang on 2017-10-26.
//  Copyright © 2017年 com.east. All rights reserved.
//
#undef NO
#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import <UIKit/UIKit.h>
#import "ImageUtils.h"

@implementation OpenCVWrapper

static Boolean savePhotosSuccess = false;

+ (UIImage *)detectAndDrawWithBase64: (NSString *)base64 {
    return [self detectAndDrawWithImage:[ImageUtils imageFromBase64:base64]];
}

+ (UIImage *)detectAndDrawWithImage:(UIImage *)image {
    cv::Mat cvMat = [ImageUtils cvMatFromUIImage:image];
    cv::CascadeClassifier cascade;
    cascade.load([[[NSBundle mainBundle] pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"] UTF8String]);
    return [self detectAndDraw:cvMat andCascade:cascade];
}

+ (UIImage *)dectectAndDrawWithImagePath: (NSString *)imagePath andXmlPath:(NSString *)xmlPath {
    // 加载分类器
    cv::CascadeClassifier cascade;
    cascade.load([xmlPath UTF8String]);
    // 读取图片
    cv::Mat srcImage = cv::imread([imagePath UTF8String]);
    
    return [self detectAndDraw:srcImage andCascade:cascade];
}

+ (UIImage *)detectAndDraw:(cv::Mat)srcImage andCascade:(cv::CascadeClassifier &)cascade {
    cv::Mat dstImage = srcImage.clone();
    cv::Mat grayImage;
    grayImage.create(srcImage.size(), srcImage.type());
    cvtColor(srcImage, grayImage, CV_BGR2GRAY); // 生成灰度图，提高检测效率
    
    // 定义7种颜色用于标记人脸
    cv::Scalar colors[] =  {
        CV_RGB(0, 0, 255),
        CV_RGB(0, 128, 255),
        CV_RGB(0, 255, 255),
        CV_RGB(0, 255, 0),
        CV_RGB(255, 128, 0),
        CV_RGB(255, 255, 0),
        CV_RGB(255, 0, 0),
        CV_RGB(255, 0, 255)
    };
    
    // 检测
    std::vector<cv::Rect> faces;
    // 分类器对象调用
    cascade.detectMultiScale(grayImage, faces);
    for (int i = 0; i < faces.size(); i++) {
//        cv::Point center;
//        center.x = cvRound(faces[i].x + faces[i].width * 0.5);
//        center.y = cvRound(faces[i].y + faces[i].height * 0.5);
//        int radius = cvRound((faces[i].width + faces[i].height) * 0.25);
//        circle(dstImage, center, radius, colors[i % 8]);
        cv::Point ptUL = cv::Point(faces[i].x, faces[i].y);
        cv::Point ptDR = cv::Point(faces[i].x + faces[i].width, faces[i].y + faces[i].height);
        rectangle(dstImage, ptUL, ptDR, colors[i % 8]);
    }
    return [ImageUtils imageFromCVMat:dstImage];
}

+ (NSMutableArray *)detectEye: (UIImage *)image {
    cv::Mat cvMat = [ImageUtils cvMatFromUIImage:image];
    cv::CascadeClassifier cascade;
    cascade.load([[[NSBundle mainBundle] pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"] UTF8String]);
    
    cv::Mat grayImage;
    grayImage.create(cvMat.size(), cvMat.type());
    cvtColor(cvMat, grayImage, CV_BGR2GRAY); // 生成灰度图，提高检测效率
    
    // 检测
    std::vector<cv::Rect> faces;
    // 分类器对象调用
    cascade.detectMultiScale(grayImage, faces);
    
    CGImageRef sourceImageRef = [image CGImage];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < faces.size(); i++) {
        CGRect cropRect = CGRectMake(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, cropRect);
        [images addObject:[UIImage imageWithCGImage:newImageRef]];
        CGImageRelease(newImageRef);
    }
    return images;
}

+ (NSMutableArray *)detectEyeWithHongmo: (UIImage *)image {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    return images;
}

@end
