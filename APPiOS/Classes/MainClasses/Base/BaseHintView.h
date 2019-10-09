//
//  BaseHintView.h
//  APPiOS
//
//  Created by 凌海龙 on 2018/6/12.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHintView : UIView

@property (nonatomic, strong) UIButton *sureButton;

- (void)initWithTitleString:(NSString *)titleString withHintString:(NSString *)hintString;

@end
