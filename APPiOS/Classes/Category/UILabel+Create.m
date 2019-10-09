//
//  UILabel+Create.m
//  APPiOS
//
//  Created by 凌海龙 on 2018/6/11.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

+ (UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)textString withTextColor:(UIColor *)color withFont:(int)font withAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = FONT(font);
    label.textAlignment = alignment;
    label.textColor = color;
    label.text = textString;
    return label;
}

+ (UILabel *)createLabelWithText:(NSString *)textString withTextColor:(UIColor *)color withFont:(int)font withAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT(font);
    label.textAlignment = alignment;
    label.textColor = color;
    label.text = textString;
    return label;
}

@end
