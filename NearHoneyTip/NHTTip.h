//
//  NHTTip.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NHTTip : NSObject


//@property(strong,nonatomic) NSString *name;
@property NSUInteger likeInteger;
@property (strong, nonatomic) NSString *tipId;
@property (strong, nonatomic) NSString *tipImage;
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *tipDetails;
@property (strong, nonatomic) NSString *userProfileImg;
@property (strong, nonatomic) NSString *userNickname;
@property (strong, nonatomic) NSString *tipDate;
@property (strong, nonatomic) UIImage *userBadge;
//@property (strong, nonatomic) NSArray *likes;
@property (strong, nonatomic) NSArray *replies;
@property (readwrite, nonatomic) BOOL isLiked;
//@property (readwrite, nonatomic) NSUInteger likeInteger;
@property (readwrite, nonatomic) NSUInteger replyInteger;
@property (readwrite, nonatomic) NSUInteger distance;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

- (void)setValue:(id)value
 forUndefinedKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@end
