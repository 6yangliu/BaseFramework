//
//  UIButton+ImageTitleSpacing.h
//  SellerProject
//
//  Created by 李海军 on 16/7/22.
//  Copyright © 2016年 Shanghai kewenmaigeli Industrial Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HJButtonEdgeInsetsStyle) {
    
    HJButtonEdgeInsetsStyleTop,        // image在上，label在下
    HJButtonEdgeInsetsStyleLeft,       // image在左，label在右
    HJButtonEdgeInsetsStyleBottom,     // image在下，label在上
    HJButtonEdgeInsetsStyleRight       // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

- (void)layoutButtonWithEdgeInsetsStyle:(HJButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
