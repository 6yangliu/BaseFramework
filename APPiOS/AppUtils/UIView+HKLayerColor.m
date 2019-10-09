//
//  UIView+HKLayerColor.m
//  APPiOS
//
//  Created by liuy on 2018/11/22.
//  Copyright © 2018 shengxi. All rights reserved.
//

#import "UIView+HKLayerColor.h"

@implementation UIView (HKLayerColor)


//绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColorWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.layer.bounds;
    
    
    if(fromColor&&toColor){
        gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    }
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    return gradientLayer;
}


@end
