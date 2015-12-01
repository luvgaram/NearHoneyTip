//
//  NHTDetailViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTDetailViewController.h"

@interface NHTDetailViewController ()

@end

@implementation NHTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    if(self.selectedTip){
        self.storeName.title = [[self.selectedTip viewWithTag:1] text];
        self.tipImage.image = [[self.selectedTip viewWithTag: 100] image];
        self.tipDetails.text = [[self.selectedTip viewWithTag:2] text];
        self.userProfileImage.image = [[self.selectedTip viewWithTag: 3] image];
        self.userProfileImage.layer.cornerRadius = 25;
        self.userNickname.text = [[self.selectedTip viewWithTag:4] text];
        self.tipDate.text = [[self.selectedTip viewWithTag:5] text];
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
