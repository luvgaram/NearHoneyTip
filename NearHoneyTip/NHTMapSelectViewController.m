//
//  NHTMapSelectViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 2..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTMapSelectViewController.h"

@interface NHTMapSelectViewController ()

@end

@implementation NHTMapSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)cancelMap:(id)sender {
    NSLog(@"cancelMap");
}

- (IBAction)saveTip:(id)sender {
    NSLog(@"saveTip");
}

@end
