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
    
    //mytip URL
    //NSURL *tipLoad2 = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/uid=user1"];
    
    //NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    //    NSString *currentUidIdentifier = @"currentUser";
    //NSString *uid = preferences objectForKey:currentUidIdentifier;
    
    //[NSMutableString *b = init @"http://54.64.250.239:3000/tip/uid="
    //[b append uid]
    
    //NSString *currentUserNicknameIdentifier = @"currentUserNickname";
    //NSSting *nickname = [preferences setObject:@"userNickname" forKey:currentUserNicknameIdentifier];
    // NSString *currentUserProfileImageIdentifier = @"currentUserProfileImage";
    // NSString *profilePhoto = [preferences setObject:@"userProfileImage" forKey:currentUserProfileImageIdentifier];
    
    //NSStringMutable *url :@"http://54.64.250.239:3000/image/icon=";
    //[url append  icon이라는 url은 자르고 뒤에 upload_ 이하를 붙임];
    // 결과값을 저장한 후 이미지 파일 가공 (사이즈, 동그랗게 함)
    // 뷰자리에 보내줌
    
    // NSURL *tipLoad3 = [NSURL URLWith];
    
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    NSError *error = nil;
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    for(int i = 0; i < [loadedTipsArray count] ; i++){
        [self.tipCollection addTip: [loadedTipsArray objectAtIndex:[loadedTipsArray count] - (i + 1)]];
    }
}

-(void)tipsDidLoad{
    NSLog(@"world");
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];

     
    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    //NSLog(@"%@", jsonData);
    
    NSError *error = nil;
    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    for(int i = 0; i < [loadedTipsArray count] ; i++){
        [self.tipCollection addTip: [loadedTipsArray objectAtIndex:[loadedTipsArray count] - (i + 1)]];
    }
    
    NSLog(@"load end");
   // NSLog(@"%@",self.tipCollection);
};
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
