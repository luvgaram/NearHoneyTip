//
//  NHTTipCollection.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTTipCollection.h"

@implementation NHTTipCollection

-(id)initWithJSONSerialization:(NSArray*)JSONs{
    self = [super init];
    if (self) {
        self.tips = [[NSMutableArray alloc] init];
        [self.tips addObjectsFromArray:JSONs];
    }
    return self;
}

-(NSInteger)countOfTips{
    if(self.tips){
        return [self.tips count];
    }
    return -1;
}

-(NSObject*)objectAtIndex:(NSUInteger)index{
    return [self.tips objectAtIndex:index];
}

@end
