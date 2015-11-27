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

/* view tag number
 (assign it view-orderly: top to bottom, left to right)
 100 - tipImage
 1 - storeName
 2 - tipDetails
 3 - userProfileImg
 4 - userNickname
 5 - tipDate
 6 - userBadge
 7 - likeButton
 8 - commentButton
 */

@property (strong, nonatomic) UIImage *tipImage;
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *tipDetails;
@property (strong, nonatomic) UIImage *userProfileImg;
@property (strong, nonatomic) NSString *userNickname;
@property (strong, nonatomic) NSString *tipDate;
@property (strong, nonatomic) UIImage *userBadge;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *commentButton;


@end
