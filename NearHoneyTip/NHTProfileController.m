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
    
    
    //Deligate
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    NSLog(@"******* UserDefault: %@",uidIdentifier);

    if([preferences objectForKey:uidIdentifier] != nil) {
        uid = [preferences objectForKey:uidIdentifier];
        nickname = [preferences objectForKey:@"userNickname"];
        profilephoto = [preferences objectForKey:@"userProfileImagePath"];
        
        
        NSLog(@"******* userNickname: %@",nickname);
        NSLog(@"******* userProfileImagePath: %@",profilephoto);
    }
    
    
    
    NSString *urlString =@"http://54.64.250.239:3000/tip/uid=";
    NSURL *url = [NSURL URLWithString:urlString];
    urlString = [urlString stringByAppendingString:@"&include_rts=true"];
    url = [NSURL URLWithString:urlString];
    

    
    //show mytip
    NSString *uidNumber = @"1";
    NSString *includeRTs = @"true";
    urlString = [NSString stringWithFormat:@"http://54.64.250.239:3000/tip/uid=%@&include_rts=%@", uidNumber, includeRTs];
    url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    
    if (loadedTipsArray.count > 0){
        NSDictionary *Dic = loadedTipsArray[0];
        //nickname
        const NSString *userNickname = [Dic objectForKey: @"nickname"];
        _userNickname.text = userNickname;
   
    }
    
  
    
    
    
    // profile image
    //1) one line code (sample)
    //    _userProfile.image =[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://54.64.250.239:3000/image/icon=profilephoto1.png"]]];
    
    // 2)
    NSString *profileStringUrl =@"http://54.64.250.239:3000/image/icon=";
    NSURL *userProfileUrl = [NSURL URLWithString:profileStringUrl];
    profileStringUrl = [urlString stringByAppendingString:@"&include_rts=true"];
    userProfileUrl = [NSURL URLWithString:urlString];
    
    NSString *profileImageName = @"profilephoto1.png";
    NSString *includeRTs2 = @"true";
    urlString = [NSString stringWithFormat:@"http://54.64.250.239:3000/image/icon=%@&include_rts=%@", profileImageName, includeRTs2];
    userProfileUrl = [NSURL URLWithString:urlString];
    
    //    NSLog(@"url: %@",url); //http://54.64.250.239:3000/image/icon=profilephoto2.png&include_rts=true
    
    NSData *imageData = [NSData dataWithContentsOfURL:userProfileUrl];
    
        NSLog(@"imageData: %@",imageData);
    _userProfile.image = [UIImage imageWithData:imageData];
    
    
    //3) editing....(NSData -> NS Array -> NSDic)
    
    //    NSArray *loadedTipsArray2 = [NSJSONSerialization JSONObjectWithData:imageData options:0 error:&error];
    //    NSDictionary *Dic2 = loadedTipsArray2[0];
    //    const NSString *profilephoto = [Dic2 objectForKey: @"profilephoto"]; //icon/profilephoto2.png
    //    _userProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[profilephoto objectAtIndex:0]]]]];
    

    
    
    
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
