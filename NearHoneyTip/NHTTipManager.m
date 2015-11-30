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
        self.tipCollection = [NHTTipCollection alloc];
    }
    return self;
}

-(void)tipsDidLoad{
    NSLog(@"world");
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    NSLog(@"%@", jsonData);
    
    NSError *error = nil;
    
    [self.tipCollection initWithJSONSerialization:[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error]];
    
    NSLog(@"%@",self.tipCollection);
};

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
