//
//  customTabBarController.m
//  mapTest
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MYTabBarController.h"
#import "MYNavViewController.h"
#import "MYTabBarButton.h"
#import "UIImage+Extensions.h"
#import "HomePagesController.h"
#import "LoginViewController.h"
#import "MinePagesController.h"
#import "ECOViewController.h"
#import "TokenViewController.h"
@interface MYTabBarController ()
@property (nonatomic,strong)UIButton *currentBtn;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) MYNavViewController *loginNav;
@end

@implementation MYTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决tabBar错位问题
    self.tabBar.translucent=NO;
    [self setupAllChildVc];
    
    [self.tabBar setBackgroundImage:[UIImage createImageFromColor:[UIColor clearColor] withFrame:CGRectMake(0, 0, kMainScreenWidth, KNavBarHeight)]];
    [self.tabBar setShadowImage:[UIImage createImageFromColor:[UIColor clearColor] withFrame:CGRectMake(0, 0, kMainScreenWidth, 49)]];

}
- (void)setupAllChildVc
{
    HomePagesController *nav1 = [[HomePagesController alloc]init];
    [self addChildVcWithNav:nil WithVc:nav1 title:nil image:nil selectedImage:nil];
    
    TokenViewController *nav2 = [[TokenViewController alloc]init];
    [self addChildVcWithNav:nil WithVc:nav2 title:nil image:nil selectedImage:nil];
    
    ECOViewController *nav3 = [[ECOViewController alloc]init];
    [self addChildVcWithNav:nil WithVc:nav3 title:nil image:nil selectedImage:nil];
    
    MinePagesController *nav4 = [[MinePagesController alloc]init];
    [self addChildVcWithNav:nil WithVc:nav4 title:nil image:nil selectedImage:nil];
 
    MYTabBar *tabView = [[MYTabBar alloc] init];
    self.tabbarView = tabView;
    tabView.backgroundColor = [[SXColorScheme Instance] getColor:COLOR_TabarColor];
    
    [self setValue:tabView forKeyPath:@"tabBar"];
 
    int i = 0;
    for (UIButton *btn in tabView.subviews) {
        if ([btn isKindOfClass:[MYTabBarButton class]]) {
            [btn addTarget:self action:@selector(selectController:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [self selectController:btn];
                _firstBtn = btn;
            }
            ++i;
        }
    }
}

#pragma mark - 跳转控制器///自定义btn的选中状态
- (void)selectController:(UIButton *)btn {
    if ([btn isKindOfClass:[UIButton class]]) {
        if (self.currentBtn.selected == YES) {
            self.currentBtn.selected = NO;
            btn.selected = YES;
        }else {
            btn.selected = YES;
        }
        self.currentBtn = btn;
    }
    self.selectedIndex = btn.tag - 1000;
}
/**
 *  创建子控制器
 */

- (void)addChildVcWithNav:(UINavigationController *)nav WithVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    MYNavViewController *baseNav = [[MYNavViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:baseNav];
    
}

@end
