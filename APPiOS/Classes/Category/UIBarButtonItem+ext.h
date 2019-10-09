//
//  UIBarButtonItem+ext.h
//  AJJ-Measure
//
//  Created by ifuwo on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ext)

//创建一个button，并添加点击事件
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//创建一个button，添加点击事件，并控制button的字体大小
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action withFont:(CGFloat )font;

//创建一个button，并添加点击事件
- (instancetype)initWithImage:(NSString *)image target:(id)target action:(SEL)action;

@end
