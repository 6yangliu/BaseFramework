//
//  UIView+Extensions.h
//  YHB_Prj
//
//  Created by 周鹏祖 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WHGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);
@interface UIView (Extensions)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat cornerRadius;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/** 
 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量
 */

+ (instancetype)viewFromXib;

/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(WHGestureActionBlock)block;

/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(WHGestureActionBlock)block;

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)screenshotWithHigh:(BOOL)isHigh;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *
 *  @return 截图
 */
- (UIImage *)screenshot:(CGFloat)maxWidth isHigh:(BOOL)isHigh;


@end
