//
//  NHTSearchedCellTableViewCell.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 1/5/16.
//  Copyright © 2016 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHTTip;
@class NHTButtonTapPost;

@interface NHTSearchedCellTableViewCell : UITableViewCell
@property(strong, nonatomic) NHTTip* tip;
@property(strong, nonatomic) NHTButtonTapPost *postManager;

@property (weak, nonatomic) IBOutlet UIImageView *tipImage;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *tipDate;
@property (weak, nonatomic) IBOutlet UIImageView *userBadge;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *distance;


- (void)setCellWithTip:(NSDictionary*)tip;

@end
