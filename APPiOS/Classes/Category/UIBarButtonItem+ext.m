//
//  UIBarButtonItem+ext.m
//  AJJ-Measure
//
//  Created by ifuwo on 16/12/26.
//
//

#import "UIBarButtonItem+ext.h"

@implementation UIBarButtonItem (ext)

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    
    CGFloat titleFont = 15;  // 字体大小
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:titleFont]} context:nil].size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:titleFont]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

- (instancetype)initWithImage:(NSString *)image target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:IMAGENAMED(image) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action withFont:(CGFloat )font
{
    
//    CGFloat titleFont = 18;  // 字体大小
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

@end
