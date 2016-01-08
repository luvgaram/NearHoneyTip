//
//  NHTMytipsTableCell.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 9..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;
@class NHTButtonTapPost;

@interface NHTMytipsTableCell : UITableViewCell

@property(strong, nonatomic) NHTTip* tip;
@property(strong, nonatomic) NHTButtonTapPost *postManager;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;

@property (weak, nonatomic) IBOutlet UIImageView *userBadge;
@property (weak, nonatomic) IBOutlet UILabel *tipNewTime;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

- (void)setCellWithUserTip:(NHTTip*)tip;

@end

