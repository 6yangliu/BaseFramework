//
//  BaseNavViewController.m
//  mapTest
//
//  Created by youwei-hjc on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MYNavViewController.h"
#import "UIImage+Extensions.h"
#import "UIBarButtonItem+ext.h"

@interface MYNavViewController ()

@end

@implementation MYNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    id UIBarBackground = [[NSClassFromString(@"_UIBarBackground") alloc] init];
//      去除navigation bar 底部的黑线
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIBarBackground class]]) {
                UIView *imageView=(UIView *)obj;
                imageView.hidden=YES;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
    //手势滑动返回
    _isPanBack=YES;
    self.interactivePopGestureRecognizer.delegate = self;
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //获取系统手势的target数组
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    //获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    id gestureRecognizerTarget = [_targets firstObject];
    //获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //通过前面的打印，我们从控制台获取出来它的方法签名。
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)popLastVc
{
    [self popViewControllerAnimated:YES];
}
#pragma mark-UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue]&&_isPanBack;
}


@end
