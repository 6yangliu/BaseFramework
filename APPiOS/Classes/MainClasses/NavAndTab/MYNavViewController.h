//
//  BaseNavViewController.h
//  mapTest
//
//  Created by youwei-hjc on 15/10/28.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavViewController : UINavigationController<UIGestureRecognizerDelegate>


@property (nonatomic, assign) BOOL isPanBack;//是否开启手势返回
@end
