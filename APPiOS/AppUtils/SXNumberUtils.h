//
//  SXNumberUtils.h
//  APPiOS
//  数据处理工具类
//  Created by liuy on 2018/5/29.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXNumberUtils : NSObject



/*
 *此方法把 NSString －－－> double
 */
+ (double)doubleValue:(NSString *)textString;



/*
 此方法把double －－－> NSString
 
 */
+ (NSString *)stringValue:(double)conversionValue;



/*
 *此方法把 NSString －－－> double (弃用)
 */
+ (double)StringChangeToDoubleForJingdu:(NSString *)textString;





/*
 此方法把double －－－> NSString(弃用)
 
 */
+ (NSString *)stringDecimalNumberWithDouble:(double)conversionValue;


/*
 *此方法把 double －－－> float
 */
+ (float)floatWithdecimalNumber:(double)num;
/*
 *此方法把 double －－－> double
 */
+ (double)doubleWithdecimalNumber:(double)num;

/*
 *此方法获取小数点的位数
 */
+(NSUInteger)getDigitFromStr:(NSString *)str;


#define deal(a,b) [SXNumberUtils notRounding:a afterPoint:b]
//format 保留几位小数 num 元数据 (向下取整 防止四舍五入)
+(NSString *)notRounding:(double)price afterPoint:(NSUInteger)position;

//成交量优化
+(NSString *)volFormat:(NSString *)volStr;
@end
