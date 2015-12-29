//
//  NHTTipCollection.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTTipCollection.h"
#import "NHTTip.h"

@implementation NHTTipCollection
-(id) init{
    self = [super init];
    if(self){
        self.tips = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) addTip: (NSDictionary*) tip{
    
    NHTTip* tipNew = [[NHTTip alloc] init];
    
    tipNew.tipId = [tip objectForKey:@"_id"];
    //NSLog(@"!String: %@",tipNew.tipId);
    NSArray *tipImageFile = [tip objectForKey:@"file"];
    //NSLog(@"###STRing: %@",tipImageFile);
    NSDictionary *tipImagePathDictionary = tipImageFile[0];
    NSString *tipImagePathString = [tipImagePathDictionary objectForKey:@"path"];
    NSUInteger pointOfPathStart = 5;
    NSString *tipImagePath = [tipImagePathString substringFromIndex: pointOfPathStart];
    
    // modified by ej
    tipNew.tipImage = tipImagePath;
    
    tipNew.storeName =  [tip valueForKey:@"storename"];
    tipNew.tipDetails = [tip valueForKey:@"tipdetail"];
    
    NSString *userProfileImageString = [tip objectForKey:@"profilephoto"];
    NSString *userProfileImagePath = [userProfileImageString substringFromIndex:pointOfPathStart];
    
    // modified by ej
    tipNew.userProfileImg = userProfileImagePath;
    
    tipNew.userNickname = [tip valueForKey:@"nickname"];
    tipNew.tipDate = [tip valueForKey: @"date"];
    
   // NSLog(@"THE added tip: %@", tipNew);
    tipNew.likeInteger = [tip valueForKey:@"like"];
    NSLog(@"like array: %@", tipNew.likeInteger);
    tipNew.replies = [tip valueForKey:@"reply"];
    tipNew.isLiked = [tip valueForKey:@"isliked"];
    tipNew.distance = [tip valueForKey: @"dis"];
    
    //NSLog(@"%@",tipNew.distance);
    /* //legacy : likes array 받을 때
    if(tipNew.likes){
        tipNew.likeInteger = [tipNew.likes count];
    } else {
        tipNew.likeInteger = 0;
    }
     */
    
    if(tipNew.replies){
        tipNew.replyInteger = [tipNew.replies count];
    } else { //방어용
        tipNew.replyInteger = 0;
    }
    [self.tips addObject:tipNew];
}

/*
-(BOOL)containsTip:(NSString*)newTipID{
 
     //tips 안에 tip_id들과 비교합니다.
     
 
    //return [self.tips containsObject:]
    return YES;
}
*/

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
