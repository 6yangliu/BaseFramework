//
//  UIView+Extension.h
//  ForeignerChat
//
//  Created by dyy on 15-9-5.
//  Copyright (c) 2015年 dyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat bottom;


/** tag */
@property (nonatomic, copy) NSString *tagStr;
/**
 *  是否显示在屏幕当中
 *
 *  @return d
 */
- (BOOL)isShowingOnKeyWindow;

/**
 *  view从xib中加载
 *
 *  @return view
 */
+ (instancetype)viewFromXib;


@end
