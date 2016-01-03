//
//  NHTMytipsTableCell.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 9..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTMytipsTableCell.h"
#import "NHTTip.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NHTMytipsTableCell

- (void)setCellWithUserTip:(NHTTip*)tip{
    NSLog(@"mytip: %@", tip.tipDetails);
    self.tip = tip;
    
    NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
    tipImagePathWhole = [tipImagePathWhole stringByAppendingString:self.tip.tipImage];
    [self.tipImage sd_setImageWithURL:[NSURL URLWithString:tipImagePathWhole]
                     placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.storeName.text = self.tip.storeName;
    
    //self.tipDetails.font = [UIFont fontWithName:@"Apple SD Gothic Neo SemiBold" size:100];//it doesn't work
    self.tipDetails.text = self.tip.tipDetails;
    self.userProfileImage.layer.cornerRadius = 16;
    //    self.userProfileImage.image = self.tip.userProfileImg;
    
    NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
    tipIconPathWhole = [tipIconPathWhole stringByAppendingString:self.tip.userProfileImg];
    [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                             placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.userNickname.text = self.tip.userNickname;
    self.tipNewTime.text = self.tip.tipDate;
}

- (void)setCellWithTip:(NHTTip*)tip{
//    self.tip = tip;
//    self.tipImage.image = self.tip.tipImage;
//    self.tipDetails.text = self.tip.tipDetails;
//    self.userProfileImage.layer.cornerRadius = 16;
//    self.userProfileImage.image = self.tip.userProfileImg;
//    self.userNickname.text = self.tip.userNickname;
    
    self.tip = tip;
    
    // modified by ej
    //    self.tipImage.image = self.tip.tipImage;
    
    NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
    tipImagePathWhole = [tipImagePathWhole stringByAppendingString:self.tip.tipImage];
    [self.tipImage sd_setImageWithURL:[NSURL URLWithString:tipImagePathWhole]
                     placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.storeName.text = self.tip.storeName;
    self.tipDetails.text = self.tip.tipDetails;
    self.userProfileImage.layer.cornerRadius = 16;
    //    self.userProfileImage.image = self.tip.userProfileImg;
    
    NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
    tipIconPathWhole = [tipIconPathWhole stringByAppendingString:self.tip.userProfileImg];
    [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                             placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.userNickname.text = self.tip.userNickname;
    self.tipNewTime.text = self.tip.tipDate;
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

