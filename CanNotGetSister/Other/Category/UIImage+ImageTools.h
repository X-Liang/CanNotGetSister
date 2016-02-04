//
//  UIImage+ImageTools.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageTools)
/**
 * 从图片最顶部截取指定大小的 image
 */
- (UIImage *)shapeImageTopAreaInTargetSize:(CGSize)targetSize;
@end
