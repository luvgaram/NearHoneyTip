//
//  NHTDetailViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTDetailViewController : UIViewController

@property (strong, nonatomic) NHTTip *selectedTip;

@property (weak, nonatomic) IBOutlet UINavigationItem *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *tipDate;
@property (weak, nonatomic) IBOutlet UIImageView *userBadge;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commentButton;


@end
