//
//  MKJChatTableViewCell.m
//  纯代码气泡聊天
//
//  Created by 宓珂璟 on 16/6/3.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "MKJChatTableViewCell.h"

@implementation MKJChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.layer.cornerRadius = 18.0f;
        self.headImageView.layer.borderWidth = 1.0f;
        self.headImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.headImageView];
        
        self.backView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = FONT(13);
        [self.backView addSubview:self.contentLabel];
        
        self.contentView.backgroundColor = BIGER_GRAY_COLOR;
    }
    return self;
}

- (void)refreshCell:(MKJChatModel *)model
{
    // 首先计算文本宽度和高度
    CGRect rec = [model.msg boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
    // 气泡
    UIImage *image = nil;
    // 模拟左边
    if (!model.isRight)
    {
        // 当输入只有一个行的时候高度就是20多一点
        self.headImageView.frame = CGRectMake(10, rec.size.height - 18, 36, 36);
        self.backView.frame = CGRectMake(46, 10, rec.size.width + 20, rec.size.height + 20);
        image = IMAGENAMED(@"trade_chat_left");
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.leftUserAvtar] placeholderImage:[UIImage imageNamed:@"personalCenterIconAvatar"]];
    }
    else // 模拟右边
    {
        self.headImageView.frame = CGRectMake(kMainScreenWidth - 60, rec.size.height - 18, 36, 36);
        self.backView.frame = CGRectMake(kMainScreenWidth - 60 - rec.size.width - 16, 10, rec.size.width + 20, rec.size.height + 20);
        image = IMAGENAMED(@"trade_chat_right");
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.rightUserAvtar] placeholderImage:[UIImage imageNamed:@"personalCenterIconAvatar"]];
    }
    
    // 拉伸图片 参数1 代表从左侧到指定像素禁止拉伸，该像素之后拉伸，参数2 代表从上面到指定像素禁止拉伸，该像素以下就拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height * 0.6];
    self.backView.image = image;
    // 文本内容的frame
    self.contentLabel.frame = CGRectMake(model.isRight ? FitCount(7) : FitCount(11) , 10, rec.size.width, rec.size.height);
    
    if (!model.isRight)
    {
        self.headImageView.frame = CGRectMake(10, FitCount(12), 36, 36);
        self.contentLabel.textColor = BIGER_TITLE_COLOR;
    }
    else // 模拟右边
    {
        self.headImageView.frame = CGRectMake(kMainScreenWidth - 60 + 7, FitCount(12), 36, 36);
        self.contentLabel.textColor = WHITE_COLOR;
    }
    
    self.contentLabel.text = model.msg;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
