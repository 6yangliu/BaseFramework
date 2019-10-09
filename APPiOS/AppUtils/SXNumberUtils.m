//
//  SXNumberUtils.m
//  APPiOS
//
//  Created by liuy on 2018/5/29.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "SXNumberUtils.h"

@implementation SXNumberUtils



+ (NSDecimalNumber *)decimalNumber:(double)num {
    NSString *numString = [NSString stringWithFormat:@"%lf", num];
    return [NSDecimalNumber decimalNumberWithString:numString];
}

/*
 *此方法把 NSString －－－> double
 */
+ (double)StringChangeToDoubleForJingdu:(NSString *)textString
{
    if (textString == nil || [textString isEqualToString:@""]) {
        return 0.0;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return  [[formatter numberFromString:textString]doubleValue];
    
}
/*
 此方法把double －－－> NSString
 
 */
+ (NSString *)stringValue:(double)conversionValue
{
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
/*
 *此方法把 NSString －－－> double
 */
+ (double)doubleValue:(NSString *)textString
{
    if (textString == nil || [textString isEqualToString:@""]) {
        return 0.0;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return  [[formatter numberFromString:textString]doubleValue];
    
}


/*
 此方法把double －－－> NSString
 
 */
+ (NSString *)stringDecimalNumberWithDouble:(double)conversionValue
{
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


/*
 *此方法把 double －－－> float
 */
+ (float)floatWithdecimalNumber:(double)num {
    return [[self decimalNumber:num] floatValue];
}
/*
 *此方法把 double －－－> double
 */
+ (double)doubleWithdecimalNumber:(double)num {
    return [[self decimalNumber:num] doubleValue];
}
/*
 *此方法获取小数点的位数
 */
+(NSUInteger)getDigitFromStr:(NSString *)str{
    NSRange range =  [str rangeOfString:@"." options:NSBackwardsSearch];//从最后面查找
    
    if(range.location==NSNotFound){
        return 0;
    }
    
    return str.length-range.location-1;
}

+(NSString *)notRounding:(double)price afterPoint:(NSUInteger)position{
    NSNumber *number = @(price);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = position;
    NSLog(@"%@",[formatter stringFromNumber:number]);
    NSString *result=[formatter stringFromNumber:number];
    if(result.length)//为了防止 .00 的情况出现
    {
        if([result hasPrefix:@"."]){
            result=[NSString stringWithFormat:@"0%@",result];
        }
    }
    return result;
}

//成交量优化
+(NSString *)volFormat:(NSString *)volStr{
    double vol =[self doubleValue:volStr];
    
    if(vol<100.00){
        return [NSString stringWithFormat:@"%.2f",vol];
    }
    if(vol>=100&&vol<100000){
        return [NSString stringWithFormat:@"%.2fK",vol/1000.00];
    }
    if(vol>=100000&&vol<100000000){
        return [NSString stringWithFormat:@"%.2fM",vol/1000000.00];
    }
    if(vol>=100000000&&vol<100000000000){
        return [NSString stringWithFormat:@"%.2fB",vol/1000000000.00];
    }
    return [NSString stringWithFormat:@"%.2f",vol];
}

@end
