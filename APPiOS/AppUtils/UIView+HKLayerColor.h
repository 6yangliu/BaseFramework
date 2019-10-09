//
//  UIView+HKLayerColor.h
//  APPiOS
//
//  Created by liuy on 2018/11/22.
//  Copyright © 2018 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HKLayerColor)

//绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColorWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
