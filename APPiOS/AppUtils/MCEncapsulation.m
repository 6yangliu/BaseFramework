//
//  MCEncapsulation.m
//  MarryCloud
//
//  Created by kedll iOS on 2017/3/13.
//  Copyright © 2017年 kedll iOS. All rights reserved.
//

#import "MCEncapsulation.h"

@implementation MCEncapsulation
+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment color:(UIColor *)fontColor{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = font;
    label.textAlignment = textAlignment;
    label.textColor = fontColor;
    return label;
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalBgImg:(NSString *)normalBgImgName highLightedBgImg:(NSString *)highLightedBgImgName target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:normalBgImgName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highLightedBgImgName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBgImg:(NSString *)normalBgImgName target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:normalBgImgName] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

+ (UITextView *)createTextViewWithFrame:(CGRect)frame textFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)fontColor userInteractionEnabled:(BOOL)userInteractionEnabled {
    UITextView *textView = [[UITextView alloc]initWithFrame:frame];
    textView.font = font;
    textView.textAlignment = textAlignment;
    textView.textColor = fontColor;
    textView.userInteractionEnabled = userInteractionEnabled;
                            
    return textView;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)cg AndImageName:(NSString *)name{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:cg];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:name];
    return imageV;
}

/**
 让label的宽度随着文字的多少去自适应
 
 @param textStr 文字
 @param label 目标label
 @param height 与目标label的高度保持一致
 @param width 一次加多少pt的宽度，可自行调整
 */
+ (void)labelWidthFitWithTextStr:(NSString *)textStr AndLabel:(UILabel *)label AndHeight:(CGFloat)height AndWidth:(CGFloat)width{
    CGSize titleSize = [textStr sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:label.font.fontName size:label.font.pointSize]}];
    titleSize.height = height;
    titleSize.width += width;
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, titleSize.width, titleSize.height);
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,148,150,151,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,145,152,155,156,176,185,186
     * 电信：133,1349,153，170,177,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|4[578]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,147,148,150,151,157,158,159,178,182,183,184,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[23478]|4[78])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,176,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56]|4[5])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,177,180,181,189
     */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }else{
        return NO;
    }
}

//密码 6-12位英文数字
+ (BOOL) validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


/**
 把字典数据转换成jsondata
 @param dict 目标字典
 @return jsondata
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//图片大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    UIGraphicsBeginImageContext(newsize);
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/*
 把时间戳转换为当前时间字符串
 此方法有局限性：时间的格式是yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentDateWithTimeInterval:(NSString *)timeInterval{
    NSTimeInterval time=[[timeInterval substringToIndex:10] doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//获取当前时间戳
+(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

//获取当前的时间
+(NSString *)getCurrentDateAngTime{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];//以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [forMatter stringFromDate:dateNow];
    NSLog(@"这是转换后的时间%@",dateStr);
    return dateStr;
}

//身份证号（存在缺陷）
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18){
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

//把字符串的某些位转换成*号
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght{
    NSString *newStr = originalStr;
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return newStr;
}


/**
 判断图片是什么格式

 @param data 图片的data数据流
 @return 类型的字符串
 */
+ (NSString *)typeForImageData:(NSData *)data{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
            
        case 0x89:
            return @"image/png";
            
        case 0x47:
            return @"image/gif";
            
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

+ (NSString *)getLastUpdateTime:(NSString *)timeChuo{
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    //转换传值的时间戳
    NSTimeInterval ValueTime=[[timeChuo substringToIndex:10] doubleValue];
    // 时间差
    NSTimeInterval time = currentTime - ValueTime;
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];
}

+ (NSString *)countdownDaysWithTimeInterval:(NSString *)TInterval{
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    //转换传值的时间戳
    NSTimeInterval ValueTime=[[TInterval substringToIndex:10] doubleValue];
    // 时间差
    NSTimeInterval time = ValueTime - currentTime;
    NSInteger days = time/3600/24;
    return [NSString stringWithFormat:@"%ld",(long)days];
}

// JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//验证银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

@end
