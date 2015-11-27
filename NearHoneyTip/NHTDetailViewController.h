//
//  NHTDetailViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHTDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *selectedTip;

/* view tag number
 (assign it view-orderly: top to bottom, left to right)
 100 - tipImage
 1 - storeName
 2 - tipDetails
 3 - userProfileImg
 4 - userNickname
 5 - tipDate
 6 - userBadge
 7 - likeButton
 8 - commentButton
 */
@property (weak, nonatomic) IBOutlet UINavigationItem *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UITextView *tipDetails;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImg;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *tipDate;
@property (weak, nonatomic) IBOutlet UIImageView *userBadge;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commentButton;


@end
