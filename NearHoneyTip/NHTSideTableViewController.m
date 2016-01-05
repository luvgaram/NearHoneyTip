//
//  NHTSideTableViewController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTSideTableViewController.h"
#import "NHTTip.h"
#import "NHTMyTipsController.h"
#import "NHTProfileController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface NHTSideTableViewController ()


@end

@implementation NHTSideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *uid;
    NSString *nickname;
    NSString *profilephoto;
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    
    if ([preferences objectForKey:uidIdentifier] != nil) {
        uid = [preferences objectForKey:uidIdentifier];
        nickname = [preferences objectForKey:@"userNickname"];
        profilephoto = [preferences objectForKey:@"userProfileImagePath"];
        
        _userNickname.text = nickname;
        
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        
        NSUInteger pointOfPathStart = 5;
        NSString *tipImagePath = [profilephoto substringFromIndex: pointOfPathStart];
        
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:tipImagePath];
        [self.userProfile sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                                 placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
        
        NSLog(@"profilephoto: %@", 	profilephoto);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelWrite:(id)sender {
    NSLog(@"%@", self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
