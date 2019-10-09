//
//  UIImage+UIImageScale.h
//  AppleDP
//
//  Created by ly on 15/4/10.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)scaleImageToScale:(float)scaleSize;
-(UIImage *)AutoScaleimage;
@end
