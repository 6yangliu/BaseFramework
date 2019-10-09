//
//  XYButton.m
//  AppleDP
//
//  Created by ly on 15/8/19.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "XYButton.h"

@protocol XYButton <NSObject>


@end

@implementation XYButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        _orignalbgColor=[UIColor clearColor];
    }
    return self;
}

/**
 *  重写系统setBackgroundColor方法
 *
 *  @param backgroundColor backgroundColor
 */
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    [super setBackgroundColor:backgroundColor];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_touchedColor){
         _touchedColor= HKUIColorFromRGB(0xE0E9FF, 0.12);
    }
    self.adjustsImageWhenHighlighted=NO;
    
    if(self.clickStyle==XYButtonClickStyle1){
        self.alpha=0.6;
    }else if (self.clickStyle==XYButtonClickStyle2){
        self.backgroundColor= _touchedColor;
    }
    
    [super touchesBegan:touches withEvent:event];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performBlock:^{
        if(self.clickStyle==XYButtonClickStyle1){
             self.alpha=1;
        }else if (self.clickStyle==XYButtonClickStyle2){
            self.backgroundColor= _orignalbgColor;
        }
        
    } afterDelay:0.1];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:( UIEvent *)event{
    if(self.clickStyle==XYButtonClickStyle1){
        self.alpha=1;
    }else if (self.clickStyle==XYButtonClickStyle2){
        self.backgroundColor=_orignalbgColor;
    }
    [super touchesCancelled:touches withEvent:event];
}


- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}


@end
