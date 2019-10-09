//
//  UIWindow+Extensions.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extensions)
/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)wh_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)wh_currentViewController;
@end
