//
//  NHTProfileController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTProfileController.h"
#import "NHTTip.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NHTProfileController ()

@end

@implementation NHTProfileController

NSString *userId;
NSString *userNickname;
NSString *userProfilePhoto;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Deligate
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    NSLog(@"******* UserDefault: %@",uidIdentifier);


    
    if([preferences objectForKey:uidIdentifier] != nil) {
        userId = [preferences objectForKey:uidIdentifier];
        userNickname = [preferences objectForKey:@"userNickname"];
        userProfilePhoto = [preferences objectForKey:@"userProfileImagePath"];
        
        NSLog(@"******* userNickname: %@", userNickname);
        NSLog(@"******* userProfileImagePath: %@",userProfilePhoto);
        
        _userNickname.text = userNickname;
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:userProfilePhoto];
        [_userProfile sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                        placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    }
}

- (IBAction)cancelWrite:(id)sender {
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
