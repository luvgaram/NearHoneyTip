//
//  NHTProfileController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHTProfileController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userProfile;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;

- (IBAction)back:(id)sender;

@end
