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

@property (strong, nonatomic) NSString *tipId;
@property (strong, nonatomic) NSString *tipImage;
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *tipDetails;
@property (strong, nonatomic) NSString *userProfileImg;
@property (strong, nonatomic) NSString *userNickname;
@property (strong, nonatomic) NSString *tipDate;
@property (strong, nonatomic) UIImage *userBadge;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *commentButton;


@end
