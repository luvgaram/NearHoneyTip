//
//  NHTSideTableViewController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTSideTableViewController : UITableViewController

@property (strong, nonatomic) NHTTip *selectedTip;


@property (weak, nonatomic) IBOutlet UIImageView *userProfile;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;


- (IBAction)showMyTips:(id)sender;
- (IBAction)showAlarm:(id)sender;
- (IBAction)setProfile:(id)sender;



@end
