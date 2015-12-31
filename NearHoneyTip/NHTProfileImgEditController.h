//
//  NHTProfileImgEditController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHTProfileImgEditController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *editedImage;
@property (weak, nonatomic) IBOutlet UIImageView *editedProfileImage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelWrite;

- (IBAction)saveTip:(id)sender;
@end



