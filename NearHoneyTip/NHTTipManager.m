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

-(void)tipsDidLoad{
    NSLog(@"world");
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    NSLog(@"%@", jsonData);
    
    NSError *error = nil;
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    for(int i = 0; i < [loadedTipsArray count] ; i++){
        [self.tipCollection addTip: [loadedTipsArray objectAtIndex:i]];
    }
    
   // NSLog(@"%@",self.tipCollection);
};
/* 
 //tipDidReload
 위와 같은 방식으로 loadedTipsArray를 만든다.
 loadedTipsArray.count > tipcollection.count 일 경우 addtip
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
