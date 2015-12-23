//
//  NHTWebViewController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 23..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTWebViewController.h"
#import "NHTDetailViewController.h"
#import "NHTTip.h"

@interface NHTWebViewController ()

@end

@implementation NHTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *name = @"starbucks";
    NSString *includeRTs = @"true";
    
    // NSString *storeName = storeName.title;
    // NSLog(@"DetailstoreName : %@", storeName);
    
    //1)
    NSString *mapUrl = @"http://map.naver.com/?query=";
    
    NSURL * mapFullUrl = [NSURL URLWithString:mapUrl];
    //    mapUrl = [mapUrl stringByAppendingString:@"&include_rts=true"];
    
    
    mapUrl = [NSString stringWithFormat:@"http://map.naver.com/?query=%@&include_rts=%@", name, includeRTs];
    
    NSLog(@"mapUrl222: %@", mapUrl);
    
    mapFullUrl = [NSURL URLWithString:mapUrl];
    
    //    mapFullUrl = [NSURL URLWithString:mapFullUrl];
    NSLog(@"mapUrl111 : %@", mapFullUrl);
    
    //    mapFullUrl = [mapFullUrl stringByAppendingString:name];
    
    //     NSLog(@"mapFullUrl : %@", mapFullUrl);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:mapFullUrl];
    
    [_myPage loadRequest:request];
    
    
    
    //2)웹뷰연결
    //    NSURL * naverMapUrl =[NSURL URLWithString:@"http://map.naver.com"];
    
    //    NSLog(@"naverMapUrl : %@", naverMapUrl);
    //
    //    NSURL * naverMapUrl =[NSURL URLWithString:@"http://map.naver.com/?query=starbucks"];
    
    //    NSLog(@"naverMapUrl : %@", naverMapUrl);
    
    //
    //    NSURLRequest * request = [NSURLRequest requestWithURL:naverMapUrl];
    //
    //    [_myPage loadRequest:request];
    //
    
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
