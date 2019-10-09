//
//  StringOperate.m
//  CLFZS
//
//  Created by jysd on 14/12/17.
//  Copyright (c) 2014年 jysd. All rights reserved.
//

#import "XYStringOperate.h"
#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonDigest.h>
@implementation XYStringOperate



+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,MAXFLOAT));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

+ (NSString *)htmlToText:(NSString *)htmlString
{
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;"  withString:@"<"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;"  withString:@">"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@""""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&#039;"  withString:@"'"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n"  withString:@"<br>"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\t"  withString:@"    "];
    return htmlString;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8));
    return outputStr;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


+ (CGSize)getLabelSizeWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font {
    
    NSString *tmpText=text;
    UIFont *tmpFont=font;
    CGSize tmpSize=CGSizeMake(size.width, MAXFLOAT);
   
    NSDictionary *tDic=@{NSFontAttributeName:tmpFont};
    tmpSize=[tmpText boundingRectWithSize:tmpSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tDic context:nil].size;
    
    return CGSizeMake(size.width, tmpSize.height);
}

+ (CGSize)getLabelWidthWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font{
    NSString *tmpText=text;
    UIFont *tmpFont=font;
    CGSize tmpSize=CGSizeMake(MAXFLOAT, size.height);
    NSDictionary *tDic=@{NSFontAttributeName:tmpFont};
    tmpSize=[tmpText boundingRectWithSize:tmpSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tDic context:nil].size;
    return tmpSize=CGSizeMake(tmpSize.width, size.height);
}

+ (CGSize)getLabelSizeWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font paraStyle:(NSMutableParagraphStyle*)paraStyle KernSize:(CGFloat)kernSize{
    
    NSString *tmpText=text;
    UIFont *tmpFont=font;
    CGSize tmpSize=CGSizeMake(size.width, MAXFLOAT);
 
    NSDictionary *tDic=@{NSFontAttributeName:tmpFont, NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:[NSNumber numberWithFloat:kernSize]};
    tmpSize=[tmpText boundingRectWithSize:tmpSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tDic context:nil].size;
    
    return CGSizeMake(size.width, tmpSize.height);
}
//32位MD5加密方式
+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}


+(NSString *)GetRandomString:(NSString *)str lenght:(int)len{
    //10000-99999
   int randomNum= (arc4random() % 99999) + 10000;
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    
    NSString *string=[NSString stringWithFormat:@"%lld%i%@",date,randomNum,str];
    
    if(string.length>len){
        string=[string substringToIndex:len];
    }
    return string;
}
/**
 *  这里以6为参照
 *
 *  @param FontSize 6上字体大小
 *
 *  @return return 适配后字体大小
 */
+(CGFloat)GetFontSizeByScreenWithPrt:(CGFloat)FontSize{
    CGFloat tmpFontSize=FontSize;
    CGFloat DisSize=1;//每一阶梯次增加多少
    CGFloat ScreenWidth=[[UIScreen mainScreen]bounds].size.width;
    if(ScreenWidth>=320){//6系列
        tmpFontSize=tmpFontSize-DisSize;
    }
    if(ScreenWidth>=375){//6系列
        tmpFontSize=tmpFontSize+DisSize;
    }
    
    if(ScreenWidth>=414){//6Plus系列
        tmpFontSize=tmpFontSize+DisSize;
    }
    return tmpFontSize;
    
}

+(NSString *)RMBChangetoCapital:(NSString *)numstr;
{
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        }
        else if (valstr.length==1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        }
        else
        {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    }
    else
    {
        prefix=@"";
        suffix=@"";
        int flag=(int)valstr.length-2;
        NSString *head=[valstr substringToIndex:flag-1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return@"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            int indexloc=((int)ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        }
        else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }
        else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}
//金额 千分位
+ (NSString *)moneyFormat:(NSString *)money{
    NSArray *moneys = [money componentsSeparatedByString:@"."];
    if (moneys.count > 2) {
        return money;
    }
    else if (moneys.count < 2) {
        return [self stringFormatToThreeBit:money];
    }
    else {
        NSString *frontMoney = [self stringFormatToThreeBit:moneys[0]];
        if([frontMoney isEqualToString:@""]){
            frontMoney = @"0";
        }
        return [NSString stringWithFormat:@"%@.%@", frontMoney,moneys[1]];
    }
}
+ (NSString *)deletMoneyFormat:(NSString *)money{
    if(money.length){
        return money=[money stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    return money;
}
+ (NSString *)stringFormatToThreeBit:(NSString *)string{
    if (string.length <= 0) {
        return @"".mutableCopy;
    }
    
    NSString *tempRemoveD = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *stringM = [NSMutableString stringWithString:tempRemoveD];
    NSInteger n = 2;
    for (NSInteger i = tempRemoveD.length - 3; i > 0; i--) {
        n++;
        if (n == 3) {
            [stringM insertString:@"," atIndex:i];
            n = 0;
        }
    }
    return stringM;
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

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
/**
 *  文字下标
 *
 *  @param string
 *
 *  @return
 */
+(NSMutableAttributedString *)plainStringToAttributedUnits:(NSString *)string :(UIFont *)font1 :(UIFont *)font2 :(NSRange)smallRange
    {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        UIFont *font = font1;//正常字体
        UIFont *smallFont = font2;//缩小的字体
        [attString beginEditing];
        [attString addAttribute:NSFontAttributeName value:(font) range:NSMakeRange(0, string.length - 2)];
        
        [attString addAttribute:NSFontAttributeName value:(smallFont) range:smallRange];
        [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"-1" range:smallRange];
        [attString endEditing];
        return attString;
    }


+ (NSString*)getDeviceName
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}
+(NSString *)unitStringFromString:(NSString *)numberStr{
    NSString *resultStr = nil;
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:numberStr];
    NSString *devisor;
    NSString *resultUnit = @"";
    CGFloat nfloat = [numberStr floatValue];
    //0～5位数不变，6～8位数转换为**万，9-12位数转换为**亿，12位数以上转化为**万亿
    if (nfloat/100000<1) {
        devisor = @"1";
        resultUnit = @"";
    }else if(nfloat/100000000<1){
        devisor = @"10000";
        resultUnit = @"万";
    }else if(nfloat/1000000000000<1){
        devisor = @"100000000";
        resultUnit = @"亿";
    }else{
        devisor = @"1000000000000";
        resultUnit = @"万亿";
    }
    NSDecimalNumber *divisorNumber = [NSDecimalNumber decimalNumberWithString:devisor];
    NSDecimalNumber *resultDec = [decNumber decimalNumberByDividingBy:divisorNumber];
    //直接输出结果
    //resultStr = [resultDec stringValue];
    //resultStr = [NSString stringWithFormat:@"%@%@",resultStr,resultUnit];
    //这里保留两位小数，并去除多余的0
    NSString *tempStr = [NSString stringWithFormat:@"%.2f",[resultDec floatValue]];
    resultStr = [NSString stringWithFormat:@"%@%@",@([tempStr floatValue]),resultUnit];
    return resultStr;
}

@end
