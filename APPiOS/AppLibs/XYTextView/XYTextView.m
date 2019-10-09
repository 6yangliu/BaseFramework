//
//  XYTextView.m
//  AppleDP
//
//  Created by ly on 15/6/16.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "XYTextView.h"

@implementation XYTextView
@synthesize m_textView,palceholder;
- (instancetype)initWithFrame:(CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)startCreate{
    CGRect tmpRC=CGRectMake(0, 0, self.width, self.height);
    m_textView=[[UITextView alloc] initWithFrame:tmpRC];
    m_textView.layer.borderWidth=1;
    m_textView.layer.cornerRadius=2;
    m_textView.textColor=[UIColor blackColor];
    m_textView.font=[UIFont fontWithName:@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:14]];
    m_textView.layer.borderColor=[UIColor colorWithRed:206.0f/255.0f green:206.0f/255.0f blue:206.0f/255.0f alpha:1.0f].CGColor;
    m_textView.delegate=self;
    [self addSubview:m_textView];
    
    m_palceholderTV=[[UITextView alloc] initWithFrame:m_textView.bounds];
    m_palceholderTV.userInteractionEnabled=NO;
    m_palceholderTV.textColor=[UIColor lightGrayColor];
    m_palceholderTV.font=[UIFont fontWithName:@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:14]];
    m_palceholderTV.backgroundColor=[UIColor clearColor];
    m_palceholderTV.text=palceholder;
    [m_textView addSubview:m_palceholderTV];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, m_textView.bottom)];
}
#pragma mark-UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView==m_textView){
        if(textView.text.length==0){
            m_palceholderTV.text=@"";
        }
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(textView==m_textView){
        if(textView.text.length==0){
            m_palceholderTV.text=self.palceholder;
        }
    }
}
-(void)setPalceholder:(NSString *)palceholder{
    if(palceholder){
        if(m_textView.text.length){
            palceholder=@"";
        }
        m_palceholderTV.text=palceholder;
    }
    
}
@end
