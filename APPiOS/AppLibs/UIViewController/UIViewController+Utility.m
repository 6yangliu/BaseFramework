//
//  UIViewController+Utility.m
//  CaiGuanJia
//
//  Created by 天 on 2017/6/27.
//  Copyright © 2017年 tianyingxinxi. All rights reserved.

//

#import "UIViewController+Utility.h"
#import "SXToolsMacro.h"


#define NAVIGATION_CUSTOM_VIEW 1025



@implementation UIViewController (Utility)







#pragma mark 加载数据

-(void)loadData{
    NSLog(@"子类需要重写loadData");
}


-(void)addTitleView:(NSString *)title{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    label.text=title;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView=label;
}

- (void)BuildNavigationBackTitle{
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"返回"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    backButton.tintColor = [UIColor clearColor];
    
    self.navigationItem.backBarButtonItem = backButton;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}


- (void)BuildNavigationBackImage{
    UIImage *img = [UIImage imageNamed:@"back_button"];
    UIButton *LeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [LeftButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    [LeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:LeftButton];
}


// 页面Push
- (void)pushStoryboardWithName:(NSString *)storyboardName withIdentifier:(NSString *)Identifier{ 
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *ViewController = [story instantiateViewControllerWithIdentifier:Identifier];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
}

- (void)pushStoryboardWithName:(NSString *)storyboardName andViewControllerTitle:(NSString*)title withIdentifier:(NSString *)Identifier{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *ViewController = [story instantiateViewControllerWithIdentifier:Identifier];
    ViewController.title = title;
    
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
}




#if 0 //老版本正则表达式.
//验证手机号码
- (BOOL)validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#else
//验证手机号码
- (BOOL)validateMobile:(NSString *)mobileNum{
    if (mobileNum.length != 11){
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        return YES;
    }
    else{
        return NO;
    }
    
}
#endif

// //        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"密码输入格式错误" message:@"请输入6-16位只包括数字和英文字母的密码" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//        [alertView show];
//请输入6-16位只包括数字和英文字母的密码
- (BOOL)validatePassWord:(NSString  *)pwd{
    NSString *Regex = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    BOOL result=[Test evaluateWithObject:pwd];
    if (!result) {
        return NO;
    }
    return YES ;
}

//验证邮箱
- (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
//身份证号
// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}



//Web图片自适应手机版本
- (void)javascripForWebView:(UIWebView *)webView{
    
    //此处禁止编辑
    NSString* javascript = [NSString stringWithFormat:
                            @"var script = document.createElement('script');"
                            "script.type = 'text/javascript';"
                            "script.text = \"function ResizeImages() { "
                            "var myimg,oldwidth;"
                            "var maxwidth = %f;" // UIWebView中显示的图片宽度
                            "for(i=0;i <document.images.length;i++){"
                            "myimg = document.images[i];"
                            "if(myimg.width > maxwidth){"
                            "oldwidth = myimg.width;"
                            "myimg.width = maxwidth;"
                            "}"
                            "}"
                            "}\";"
                            "document.getElementsByTagName('head')[0].appendChild(script);",kScreen_width-15];
    
    
    [webView stringByEvaluatingJavaScriptFromString:javascript];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}


@end
