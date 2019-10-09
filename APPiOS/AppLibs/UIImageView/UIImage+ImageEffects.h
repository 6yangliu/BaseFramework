//
//  UIImage+ImageEffects.h
//  Inkling
//
//  Created by Aaron Pang on 3/26/14.
//  Copyright (c) 2014 Inkling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)
- (UIImage *)applyDiyEffect;
- (UIImage *)applySubtleEffect;
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
//图片裁剪成圆形
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;
+ (instancetype)imageWithImage:(UIImage *)oldImage border:(CGFloat)border borderColor:(UIColor *)color;
+ (instancetype)imageWithImage1:(UIImage *)img ;
+ (instancetype)imageWithBackImage:(UIImage *)img;
//解决拍照图片旋转
- (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 * 圆形图片
 */
- (UIImage *)circleImage;
@end
