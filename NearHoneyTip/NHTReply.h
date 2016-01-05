//
//  NHTReply.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NHTReply : NSObject

@property (strong, nonatomic) NSString *replyId;
@property (strong, nonatomic) NSString *replyTipId;
@property (strong, nonatomic) NSString *replyUserId;
@property (strong, nonatomic) NSString *replyNickname;
@property (strong, nonatomic) NSString *replyProfilephoto;
@property (strong, nonatomic) NSString *replyDetail;
@property (strong, nonatomic) NSString *replytime;

@end
