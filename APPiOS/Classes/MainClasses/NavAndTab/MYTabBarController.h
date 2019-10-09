//
//  customTabBarController.h
//  mapTest
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTabBar.h"

@interface MYTabBarController : UITabBarController

@property (nonatomic,strong) MYTabBar *tabbarView;

- (void)selectController:(UIButton *)btn;

@end
