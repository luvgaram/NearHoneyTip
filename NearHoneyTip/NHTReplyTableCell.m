//
//  NHTReplyTableCell.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTReply.h"
#import "NHTReplyTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NHTReplyTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithReply:(NHTReply *)reply{
    
    self.reply = reply;
    self.replyUserNickname.text = reply.replyNickname;
    self.replyDate.text = reply.replytime;
    self.replyDetail.text = reply.replyDetail;
    self.replyImage.layer.cornerRadius = 20;
    
    NSUInteger pointOfPathStart = 5;
    NSString *replyImagePath = [reply.replyProfilephoto substringFromIndex: pointOfPathStart];
    
    NSString *replyIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
    replyIconPathWhole = [replyIconPathWhole stringByAppendingString:replyImagePath];

    [self.replyImage sd_setImageWithURL:[NSURL URLWithString:replyIconPathWhole]
                             placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
