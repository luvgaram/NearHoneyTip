//
//  NHTProfileController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTProfileController.h"
#import "NHTTip.h"

@interface NHTProfileController ()

@end

@implementation NHTProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString =@"http://54.64.250.239:3000/tip/uid=";
    NSURL *url = [NSURL URLWithString:urlString];
    urlString = [urlString stringByAppendingString:@"&include_rts=true"];
    url = [NSURL URLWithString:urlString];
    
    
    NSString *uidNumber = @"1";
    NSString *includeRTs = @"true";
    urlString = [NSString stringWithFormat:@"http://54.64.250.239:3000/tip/uid=%@&include_rts=%@", uidNumber, includeRTs];
    url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSDictionary *Dic = loadedTipsArray[0];
    const NSString *userNickname = [Dic objectForKey: @"nickname"];
    
    _userNickname.text = userNickname;
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
