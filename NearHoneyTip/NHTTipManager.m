//
//  NHTTipManager.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTTipManager.h"
#import "NHTTipCollection.h"
#import "NHTTip.h"

@implementation NHTTipManager{
    NSUserDefaults *preferences;
}
-(id)init{
    self = [super init];
    if(self){
        NSLog(@"i want to go");
        self.tipCollection = [[NHTTipCollection alloc] init];
        self.searchResults = [[NSMutableArray alloc] init];
        self.loadedTips = [[NSArray alloc] init];
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
        
        NSLog(@"my tip numbers: %d", [loadedTipsArray count]);
        
        for(int i = 0; i < [loadedTipsArray count] ; i++){
            [self.tipCollection addMyTip: [loadedTipsArray objectAtIndex: i]];
            //for inverse : [loadedTipsArray count] - (i + 1)
            
            NSLog(@"mytipsDidload: %@", [loadedTipsArray objectAtIndex: i]);
        }
    }
    
}

-(void)tipsDidLoad{
    NSLog(@"world");
    preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *uidIdentifier = @"UserDefault";
    NSString *userLatitudeIdentifier = @"UserLocationLatitude";
    NSString *userLongitudeIdentifier = @"UserLocationLongitude";
    
    NSString *baseURL = @"http://54.64.250.239:3000/tip/lat=";
    
    
    NSString *latitude = [[NSString alloc] initWithFormat: @"%@" ,[preferences objectForKey: userLatitudeIdentifier]];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%@",[preferences objectForKey:userLongitudeIdentifier] ] ;
    baseURL = [baseURL stringByAppendingString:latitude];
    baseURL = [baseURL stringByAppendingString:@"&long="];
    baseURL = [baseURL stringByAppendingString:longitude];
    baseURL = [baseURL stringByAppendingString:@"&sid="];
    baseURL = [baseURL stringByAppendingString:[preferences objectForKey:uidIdentifier]];
    baseURL = [baseURL stringByAppendingString:@"&dis=100000"];
    
    NSURL *tipLoad = [NSURL URLWithString: baseURL];

    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    //NSLog(@"%@", jsonData);
    
    if(jsonData){
        NSError *error = nil;
        NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        NSLog(@"count : %lu", loadedTipsArray.count);
       // NSLog(@"%@", loadedTipsArray);
        NSUInteger tipCount = loadedTipsArray.count;
        //NSUInteger curreuntIndex = tipCount;
        for(int i = 0; i < tipCount ; i++){
            //curreuntIndex = tipCount - (i + 1);
            //??서버에서 어떤 순서로 보내주지??
            [self.tipCollection addTip: [loadedTipsArray objectAtIndex: i]];
        }
        
        self.loadedTips = loadedTipsArray;
    }
    NSLog(@"load end");
   // NSLog(@"%@",self.tipCollection);

};

-(void)tipsDidLoadWithSearchResults:(NSArray*)searchedArray{
    
    [self removeAllTips];
    NSUInteger tipCount = searchedArray.count;
    //NSUInteger curreuntIndex = tipCount;
    
    NSLog(@"count: %u",tipCount);
    for(int i = 0; i < tipCount ; i++){
        //curreuntIndex = tipCount - (i + 1);
        //??서버에서 어떤 순서로 보내주지??
        [self.tipCollection addTip: [searchedArray objectAtIndex: i]];
    }
}



- (void)removeAllTips{
    [self.tipCollection.tips removeAllObjects];
}


- (NSInteger)countOfTipCollection{
    if(self.tipCollection){
        return [self.tipCollection countOfTips];
    }
    return -1;
};



-(NSObject*)objectAtIndex:(NSUInteger)index{
    return [self.tipCollection objectAtIndex:index];
}

- (void)updateFilteredContentForTipStoreName:(NSString *)tipStoreName
{
    NSLog(@"LOG 2 :%@", tipStoreName);

    if (tipStoreName == nil) {
        
        // If empty the search results are the same as the original data
        self.searchResults = [self.tipCollection.tips mutableCopy];
        NSLog(@"LOG !!!!!");

    } else {
        
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        
        for (NSDictionary *tip in self.loadedTips) {
            if ([tip[@"storename"] containsString:tipStoreName]) {
                
                
                [searchResults addObject:tip];
            }
            
            self.searchResults = searchResults;
        }
        
    }
}

- (NSDictionary*)dictionaryAtIndex:(NSUInteger)index{
    return (NSDictionary*) [self.tipCollection objectAtIndex:index];
}

@end
