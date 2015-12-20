//
//  NHTProfileController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTProfileController.h"

@interface NHTProfileController ()

@end

@implementation NHTProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//deprecated -> ?
-(IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//- (IBAction)saveTip:(id)sender {
//    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"ib_addphoto"], 1.0);
//    
//    if (_chosenImage) {
//        data = UIImageJPEGRepresentation(_chosenImage, 1.0);
//        NSDictionary *tipDictionary = @{ @"storeName":_storeName.text,
//                                         @"detail":_detail.text,
//                                         @"imageData":data
//                                         };
//        [self postTip:tipDictionary];
//        NSLog(@"saving tip for %@", _storeName);
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//    } else {
//        NSLog(@"no image");
//    }
//}

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
