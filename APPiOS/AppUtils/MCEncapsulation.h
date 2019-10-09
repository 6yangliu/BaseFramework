//
//  MCEncapsulation.h
//  MarryCloud
//
//  Created by kedll iOS on 2017/3/13.
//  Copyright © 2017年 kedll iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCEncapsulation : NSObject

//创建label的快捷方法
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment color:(UIColor *)fontColor;
//创建button的快捷方法
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalBgImg:(NSString *)normalBgImgName highLightedBgImg:(NSString *)highLightedBgImgName target:(id)target action:(SEL)action;
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBgImg:(NSString *)normalBgImgName target:(id)target action:(SEL)action;
//创建image的快捷方法
+ (UIImageView *)createImageViewWithFrame:(CGRect)cg AndImageName:(NSString *)name;
//创建UITextView的快捷方法
+ (UITextView *)createTextViewWithFrame:(CGRect)frame textFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)fontColor userInteractionEnabled:(BOOL)userInteractionEnabled;

+ (void)labelWidthFitWithTextStr:(NSString *)textStr AndLabel:(UILabel *)label AndHeight:(CGFloat)height AndWidth:(CGFloat)width;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)validatePassword:(NSString *)passWord;
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;
+ (NSString *)getCurrentDateWithTimeInterval:(NSString *)timeInterval;
+ (NSString *)getNowTimeTimestamp;
+ (NSString *)getCurrentDateAngTime;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;
+ (NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;
+ (NSString *)typeForImageData:(NSData *)data;
+ (NSString *)getLastUpdateTime:(NSString *)timeChuo;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)countdownDaysWithTimeInterval:(NSString *)TInterval;
+ (BOOL) checkCardNo:(NSString *) cardNo;
+(NSString*)encodeString:(NSString*)unencodedString;
@end
