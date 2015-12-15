//
//  NHTAlarmsTableCell.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 14..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTAlarmsTableCell : UITableViewCell

@property(strong, nonatomic) NHTTip* tip;

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;

@property (weak, nonatomic) IBOutlet UILabel *tipNewTime;

- (void)setCellWithTip:(NSDictionary*)tip;

@end
