//
//  NHTButtonTapPost.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/22/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTButtonTapPost.h"
//#import "NHTMainViewController.h"


@implementation NHTButtonTapPost{
    NSUserDefaults *preferences;
    NSURLResponse *response;
}

-(void)postLikeChangeMethod:(NSString*)methodString Tip:(NSString*)tipId{
    NSLog(@"start post Plus Like ");
    NSString *uidIdentifier = @"UserDefault";
    
    preferences = [NSUserDefaults standardUserDefaults];
    NSDictionary* uidDictionary = @{@"like" : [preferences objectForKey:uidIdentifier]};
    
    NSData* jsondata = [NSJSONSerialization dataWithJSONObject:uidDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    if (jsondata){
        
        NSString* URLWithTipId = @"http://54.64.250.239:3000/like/_id=";
        URLWithTipId = [URLWithTipId stringByAppendingString: tipId];
        
        NSLog(@"URL : %@", URLWithTipId);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLWithTipId] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:methodString];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsondata];
        
        NSLog(@"start posting Like Change");
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        [connection start];
        
        [self connection:connection didReceiveResponse:response];
        //[self connection:connection didReceiveData:data];
        
        
        
        NSLog(@"connection end");
        
      
    }
    
    
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    //NHTMainViewController *forRefresh = [[NHTMainViewController alloc]init];
    //[forRefresh getLatestTips];
   
    // data = [[NSMutableData alloc] init];
}

@end
