//
//  NHTReplyTableCell.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTReply;

@interface NHTReplyTableCell : UITableViewCell

@property(strong, nonatomic) NHTReply *reply;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;

@property (weak, nonatomic) IBOutlet UILabel *replyUserNickname;
@property (weak, nonatomic) IBOutlet UILabel *replyDate;
@property (weak, nonatomic) IBOutlet UILabel *replyDetail;

- (void)setCellWithReply:(NHTReply *)reply;

@end
