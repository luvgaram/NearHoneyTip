//
//  NHTTipCollection.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NHTTip;

@interface NHTTipCollection : NSObject

@property(strong, nonatomic) NSMutableArray* tips;

-(id) init;
-(void) addTip: (NSDictionary*) tip;
-(NSInteger)countOfTips;
-(NSObject*)objectAtIndex:(NSUInteger)index;
@end
