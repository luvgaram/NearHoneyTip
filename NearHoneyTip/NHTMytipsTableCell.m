//
//  NHTMytipsTableCell.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 9..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTMytipsTableCell.h"
#import "NHTTip.h"

@implementation NHTMytipsTableCell

- (void)setCellWithTip:(NHTTip*)tip{
    self.tip = tip;
    self.tipImage.image = self.tip.tipImage;
    self.tipDetails.text = self.tip.tipDetails;
    self.userProfileImage.layer.cornerRadius = 16;
    self.userProfileImage.image = self.tip.userProfileImg;
    self.userNickname.text = self.tip.userNickname;
}


- (void)awakeFromNib {
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//     Configure the view for the selected state
//}

@end

