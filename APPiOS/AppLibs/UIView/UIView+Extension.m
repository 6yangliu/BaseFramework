//
//  UIView+Extension.m
//  ForeignerChat
//
//  Created by dyy on 15-9-5.
//  Copyright (c) 2015年 dyy. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

-(void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x  = x;
    self.frame = frame;
}
-(CGFloat)x{

    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y  = y;
    self.frame = frame;
}
-(CGFloat)y{
    
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{

    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{

    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    
    return self.frame.size.height;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    
}
-(CGPoint)origin{

    return self.frame.origin;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{

    return self.frame.size;
}

-(CGFloat)centerX{

    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

-(void)setCenterY:(CGFloat)centerY{

    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{

    return self.center.y;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}
-(CGFloat)right{

    return self.frame.origin.x + self.frame.size.width;
}
-(void)setRight:(CGFloat)right{

    CGRect newframe = self.frame;
    newframe.origin.x = right - self.frame.size.width;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}
/**
 *  是否显示在屏幕当中
 */
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
/**
 *  view从xib中加载
 */
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
#pragma mark - 添加一个string的tag属性

static void *TagStrKey = &TagStrKey;
- (NSString *)tagStr
{
    return objc_getAssociatedObject(self, TagStrKey);
}

- (void)setTagStr:(NSString *)tagStr
{
    objc_setAssociatedObject(self, TagStrKey, tagStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
