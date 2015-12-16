//
//  NHTDetailViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTDetailViewController.h"
#import "NHTTip.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NHTDetailViewController ()

@end

@implementation NHTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.selectedTip){
        self.storeName.title = self.selectedTip.storeName;
        
        // modified by ej
//        self.tipImage.image = self.selectedTip.tipImage;
        
        NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
        tipImagePathWhole = [tipImagePathWhole stringByAppendingString:self.selectedTip.tipImage];
        [self.tipImage sd_setImageWithURL:[NSURL URLWithString:tipImagePathWhole]
                         placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
        
        self.tipDetails.text = self.selectedTip.tipDetails;
        
//        self.userProfileImage.image = self.selectedTip.userProfileImg;
        
        self.userProfileImage.layer.cornerRadius = 25;
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:self.selectedTip.userProfileImg];
        [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                                 placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];

        self.userNickname.text = self.selectedTip.userNickname;
        self.tipDate.text = self.selectedTip.tipDate;
        //userBadge
        //likeButton
        //commentButton
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
