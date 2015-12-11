//
//  NHTMainTableCell.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainTableCell.h"
#import "NHTTip.h"

@implementation NHTMainTableCell

- (void)setCellWithTip:(NHTTip*)tip{
    self.tip = tip;
    self.tipImage.image = self.tip.tipImage;
    self.storeName.text = self.tip.storeName;
    self.tipDetails.text = self.tip.tipDetails;
    self.userProfileImage.layer.cornerRadius = 16;
    self.userProfileImage.image = self.tip.userProfileImg;
    self.userNickname.text = self.tip.userNickname;
    self.tipDate.text = self.tip.tipDate;
}

@end
