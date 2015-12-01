//
//  NHTDetailViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTDetailViewController.h"
#import "NHTTip.h"

@interface NHTDetailViewController ()

@end

@implementation NHTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.selectedTip){
        self.storeName.title = self.selectedTip.storeName;
        self.tipImage.image = self.selectedTip.tipImage;
        self.tipDetails.text = self.selectedTip.tipDetails;
        self.userProfileImage.image = self.selectedTip.userProfileImg;
        self.userProfileImage.layer.cornerRadius = 25;
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
