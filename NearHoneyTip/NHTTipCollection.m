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
  //  NSLog(@"!String: %@",tipNew.tipId);
    NSArray *tipImageFile = [tip objectForKey:@"file"];
   // NSLog(@"###STRing: %@",tipImageFile);
    NSDictionary *tipImagePathDictionary = tipImageFile[0];
    NSString *tipImagePathString = [tipImagePathDictionary objectForKey:@"path"];
    NSUInteger pointOfPathStart = 5;
    NSString *tipImagePath = [tipImagePathString substringFromIndex: pointOfPathStart];
    
    // modified by ej
    tipNew.tipImage = tipImagePath;
    
//    NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
//    tipImagePathWhole = [tipImagePathWhole stringByAppendingString:tipImagePath];
//    NSURL *tipImageLoadURL = [NSURL URLWithString:tipImagePathWhole];
//    NSError *errorTipImage = nil;
//    NSData *tipImageLoadData = [NSData dataWithContentsOfURL:tipImageLoadURL options:0 error: &errorTipImage];
//    UIImage     *tipimageLoad = [UIImage imageWithData:tipImageLoadData];
//    tipNew.tipImage = tipimageLoad;
    
    tipNew.storeName =  [tip valueForKey:@"storename"];
    tipNew.tipDetails = [tip valueForKey:@"tipdetail"];
    
    NSString *userProfileImageString = [tip objectForKey:@"profilephoto"];
    NSString *userProfileImagePath = [userProfileImageString substringFromIndex:pointOfPathStart];
    
    // modified by ej
    tipNew.userProfileImg = userProfileImagePath;
    
//    NSString *userProflieImagePathWhole = @"http://54.64.250.239:3000/image/icon=";
//    userProflieImagePathWhole = [userProflieImagePathWhole stringByAppendingString:userProfileImagePath];
//    NSURL *userProfileImageLoadURL = [NSURL URLWithString:userProflieImagePathWhole];
//    NSError *errorUserProfileImage = nil;
//    NSData *userProflieImageLoadData = [NSData dataWithContentsOfURL:userProfileImageLoadURL options:0 error: &errorUserProfileImage];
//    UIImage *userProfileImageLoad = [UIImage imageWithData:userProflieImageLoadData];
//    tipNew.userProfileImg = userProfileImageLoad;
    
    tipNew.userNickname = [tip valueForKey:@"nickname"];
    tipNew.tipDate = [tip valueForKey: @"date"];
    
   // NSLog(@"THE added tip: %@", tipNew);
    tipNew.likes = [tip valueForKey:@"like"];
    NSLog(@"like array: %@", tipNew.likes);
    tipNew.replies = [tip valueForKey:@"reply"];
    
    tipNew.isLiked = NO;
    if(tipNew.likes){
        tipNew.likeInteger = [tipNew.likes count];
    } else {
        tipNew.likeInteger = 0;
    }
    if(tipNew.replies){
        tipNew.replyInteger = [tipNew.replies count];
    } else {
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
