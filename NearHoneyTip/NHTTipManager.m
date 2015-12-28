//
//  NHTTipManager.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTTipManager.h"
#import "NHTTipCollection.h"

@implementation NHTTipManager
-(id)init{
    self = [super init];
    if(self){
        NSLog(@"i want to go");
        self.tipCollection = [[NHTTipCollection alloc] init];
    }
    return self;
}

-(void)mytipsDidLoad{
    //    NSURL *tipLoad2 = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/uid=user1"];
    
    NSString *urlString =@"http://54.64.250.239:3000/tip/uid=";
    NSURL *url = [NSURL URLWithString:urlString];
    urlString = [urlString stringByAppendingString:@"&include_rts=true"];
    url = [NSURL URLWithString:urlString];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    
    if ([preferences objectForKey:uidIdentifier] != nil) {
        NSString *uid = [preferences objectForKey:uidIdentifier];
        NSString *includeRTs = @"true";
        urlString = [NSString stringWithFormat:@"http://54.64.250.239:3000/tip/uid=%@&include_rts=%@", uid, includeRTs];
        url = [NSURL URLWithString:urlString];
        
        NSError *error = nil;
        
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        for(int i = 0; i < [loadedTipsArray count] ; i++){
            [self.tipCollection addTip: [loadedTipsArray objectAtIndex:[loadedTipsArray count] - (i + 1)]];
        }
    }
    
}

-(void)tipsDidLoad{
    NSLog(@"world");
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];

    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    //NSLog(@"%@", jsonData);
    
    NSError *error = nil;
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //NSLog(@"%@", loadedTipsArray);
    for(int i = 0; i < [loadedTipsArray count] ; i++){
        [self.tipCollection addTip: [loadedTipsArray objectAtIndex:[loadedTipsArray count] - (i + 1)]];
    }
    
    NSLog(@"load end");
   // NSLog(@"%@",self.tipCollection);
};

- (void)removeAllTips{
    [self.tipCollection.tips removeAllObjects];
}
/* 
 //tipDidReload
 위와 같은 방식으로 loadedTipsArray를 만든다.
 loadedTipsArray.count > tipcollection.count 일 경우 addtip
*/

/*
-(BOOL)containsTip:(NSDictionary*)newTip{
    NSString *newTipId = [newTip objectForKey:@"_id"];
    return [self.tipCollection containsTip:newTipId];
    
}
 */

-(NSInteger)countOfTipCollection{
    if(self.tipCollection){
        return [self.tipCollection countOfTips];
    }
    
    return -1;
};


-(NSObject*)objectAtIndex:(NSUInteger)index{
    return [self.tipCollection objectAtIndex:index];
}

@end
