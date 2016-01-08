//
//  NHTSearchedCellTableViewCell.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 1/5/16.
//  Copyright © 2016 Mamamoo. All rights reserved.
//

#import "NHTSearchedCellTableViewCell.h"
#import "NHTTip.h"
#import "NHTButtonTapPost.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NHTSearchedCellTableViewCell


- (void)setCellWithTip:(NHTTip*)tip{
    
    self.postManager = [[NHTButtonTapPost alloc] init];
    self.tip = tip;
    
    // modified by ej
    //    self.tipImage.image = self.tip.tipImage;
    
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
    self.tipDate.text = self.tip.tipDate;
    
    NSString *distanceWithKm = [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.distance];
    distanceWithKm = [distanceWithKm stringByAppendingString:@" m"];
    
}



@end
