//
//  HMTabBar.h
//  
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTabBarButton.h"

@class MYTabBar;

@interface MYTabBar : UITabBar
@property (nonatomic, strong) MYTabBarButton *tabBtn01;
@property (nonatomic, strong) MYTabBarButton *tabBtn02;
@property (nonatomic, strong) MYTabBarButton *tabBtn03;
@property (nonatomic, strong) MYTabBarButton *tabBtn04;
@end
