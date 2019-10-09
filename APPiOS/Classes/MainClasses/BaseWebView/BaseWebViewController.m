//
//  BaseWebViewController.m
//  APPiOS
//
//  Created by liuy on 2019/1/4.
//  Copyright © 2019 shengxi. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()
{
    BOOL loadingFlag;
    UIProgressView* loadingView;
    NSTimer *loadingtimer;
}
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setLoadingView];
}

-(void)setLoadingView{
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    loadingView = [[UIProgressView alloc] initWithFrame:barFrame];
    loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    loadingView.progressTintColor = [UIColor colorWithRed:48/255.0 green:146/255.0 blue:252/255.0 alpha:1.0];
    loadingView.trackTintColor=[UIColor clearColor];
    loadingView.hidden=YES;
    [self.navigationController.navigationBar addSubview:loadingView];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [loadingView removeFromSuperview];
    [loadingtimer invalidate];
    loadingtimer=nil;
}

- (void)startLoading{
    loadingView.hidden=NO;
    loadingView.progress = 0;
    loadingFlag = false;
    loadingtimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}
- (void)stopLoading{
    loadingFlag = true;
}

-(void)timerCallback {
    if (loadingFlag) {
        if (loadingView.progress >= 1) {
            loadingView.hidden = true;
            [loadingtimer invalidate];
            loadingtimer=nil;
            [loadingView removeFromSuperview];
        }
        else {
            loadingView.progress += 0.1;
        }
    }
    else {
        loadingView.progress += 0.05;
        if (loadingView.progress >= 0.95) {
            loadingView.progress = 0.95;
        }
    }
}

@end
