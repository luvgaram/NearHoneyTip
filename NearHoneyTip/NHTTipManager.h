//
//  NHTTipManager.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NHTTipCollection;

@interface NHTTipManager : NSObject

@property(strong, nonatomic) NHTTipCollection *tipCollection;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property(nonatomic, strong) NSArray *loadedTips;

-(id)init;
-(void)tipsDidLoad;
-(void)tipsDidLoadWithSearchResults:(NSArray*)searchedArray;
-(void)mytipsDidLoad;

-(NSInteger)countOfTipCollection;
-(NSObject*)objectAtIndex:(NSUInteger)index;
//-(BOOL)containsTip:(NSDictionary*)newTip;

-(void)removeAllTips;
- (void)updateFilteredContentForTipStoreName:(NSString *)tipStoreName;




@end
