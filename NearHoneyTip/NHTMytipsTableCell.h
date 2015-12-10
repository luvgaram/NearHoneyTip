//
//  NHTMytipsTableCell.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 9..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTMytipsTableCell : UITableViewCell

@property(strong, nonatomic) NHTTip* tip;

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *StoreName;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;

@property (weak, nonatomic) IBOutlet UIImageView *userBadge;
@property (weak, nonatomic) IBOutlet UILabel *tipNewTime;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


- (void)setCellWithTip:(NSDictionary*)tip;
@end

