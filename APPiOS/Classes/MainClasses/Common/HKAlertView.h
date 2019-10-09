//
//  HKAlertView.h
//  AppleDP
//  弹出框
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewTouchAction)(NSInteger index);

@interface HKAlertView : UIView<CAAnimationDelegate>
{
    NSString *titleStr;
    NSString *msgStr;
    NSString *cancelButtonTitleStr;
    NSString *otherButtonTitleStr;
    
    AlertViewTouchAction touchblock;
    
    UIButton *_backView;
    UILabel *titleLabel;
    UILabel *msgLabel;
    UITextField *textField;
    UIButton *cancleBtn;
    UIButton *otherBtn;
}


-(instancetype)initWithTarget:(id)target title:(NSString *)title Message:(NSString *)msg cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle :(AlertViewTouchAction)block;

-(void)show;
@end
