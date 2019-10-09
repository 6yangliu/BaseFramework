//
//  UIImage+Extensions.h
//  YHB_Prj
//
//  Created by 周鹏祖 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)
/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)zz_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)zz_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)zz_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

/**
 *  调整图片size到一半
 */
+ (UIImage*)zz_resizableHalfImage:(NSString *)name;

//通过颜色来生成一个纯色图片
+ (UIImage *)createImageFromColor:(UIColor *)color withFrame:(CGRect)frame;

// 画虚线
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView;


+(UIImage*)imageWithColor:(UIColor*) color;

@end
