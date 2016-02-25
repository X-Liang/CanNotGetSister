//
//  UIImage+ImageTools.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "UIImage+ImageTools.h"

@implementation UIImage (ImageTools)

- (UIImage *)shapeImageTopAreaInTargetSize:(CGSize)targetSize {
    
    //// 获得图片最顶部区域
    //// YES -> 不透明
    //UIGraphicsBeginImageContextWithOptions(topic.pictureContentFrame.size, YES, 0.f);
    //// 将获得图像绘制到图形上下文
    //[image drawAtPoint:CGPointZero];   // 从(0,0)点开始绘制
    //CGFloat width = topic.pictureContentFrame.size.width;
    //CGFloat height = width * image.size.height / image.size.width;
    //[image drawInRect:CGRectMake(0, 0, width,height)];
    //// 获得图片
    //self.contentImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //// 关闭上下文
    //UIGraphicsEndImageContext();
    
    
    // 开启图像上下文
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, 0.f);
    /** 绘制截取的核心操作*/
    CGFloat height = targetSize.width * self.size.height / self.size.width; // 等比缩小到指定区域的宽度
    // 将图片绘制到指定区域的宽度及等比缩小后的高度形成的矩形中, 因为只获得 targetSize 中的图片内容, 所以会截取顶部区域
    [self drawInRect:CGRectMake(0, 0, targetSize.width, height)];
    // 获取图片
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return targetImage;
}

- (UIImage *)circlyImage {
    // 开启透明的图像上下文
    // YES -> 不透明, NO -> 透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
    
    // 获得当前图像上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 添加圆
    CGRect circlyRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, circlyRect);
    // 根据圆形裁剪, 之后绘制的内容都会被裁剪
    CGContextClip(context);
    // 将图片绘制
    [self drawInRect:circlyRect];
    
    // 获得生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
