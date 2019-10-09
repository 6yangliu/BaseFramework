//
//  UIImage+UIImageScale.m
//  AppleDP
//
//  Created by ly on 15/4/10.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "UIImage+UIImageScale.h"
@implementation UIImage(UIImageScale)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//缩放
- (UIImage *)scaleImageToScale:(float)scaleSize;

{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
//图片自动压缩
-(UIImage *)AutoScaleimage{
    CGRect mainScreenSize=[UIScreen mainScreen].bounds;
    CGFloat radio=0;
    if(self.size.width>=self.size.height){//宽大于高
        if(self.size.width>mainScreenSize.size.width*2){//小于屏幕就不缩放
            radio=1.0*(mainScreenSize.size.width*2)/self.size.width;
        }
        return [self scaleToSize:CGSizeMake(self.size.width*radio, self.size.height*radio)];
        
    }else{//宽小于高
        if(self.size.height>mainScreenSize.size.height*2){//小于屏幕就不缩放
            radio=1.0*(mainScreenSize.size.height*2)/self.size.height;
        }
        return [self scaleToSize:CGSizeMake(self.size.width*radio, self.size.height*radio)];
    }
    return self;
}


@end
