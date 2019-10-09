//
//  HMTabBarButton.m
//  
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MYTabBarButton.h"

@implementation MYTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[[SXColorScheme Instance] getColor: COLOR_FuTextColor]  forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor whiteColor];
    // 设置文字字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:10];
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
     return CGRectMake(self.frame.size.width/2 - 24/2, 5, 24, 24);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 3, self.frame.size.width,12);
}
- (void)setHighlighted:(BOOL)highlighted
{
}

@end
