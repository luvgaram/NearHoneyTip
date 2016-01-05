//
//  NHTReplyManager.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 6..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTReplyManager.h"
#import "NHTReply.h"

@implementation NHTReplyManager

- (NSArray *) replyDidLoad:(NSString *)tid {
    NSMutableArray *repliesArray = [[NSMutableArray alloc] init];
    
    NSString *baseURL = @"http://54.64.250.239:3000/reply/_id=";
    baseURL = [baseURL stringByAppendingString:tid];
    
    NSURL *replyURL = [NSURL URLWithString: baseURL];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:replyURL];
    
    if (jsonData) {
        NSError *error = nil;
        NSArray *loadedRepliesArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        NSUInteger replyCount = loadedRepliesArray.count;
        
        NSLog(@"replyCount: %d", replyCount);
        
        for (int i = 0; i < replyCount; i++){
            NSDictionary *rawReply = loadedRepliesArray[i];
            NHTReply *newReply = [[NHTReply alloc] init];
            newReply.replyId = [rawReply objectForKey:@"_id"];
            newReply.replyTipId = [rawReply objectForKey:@"tid"];
            newReply.replyUserId = [rawReply objectForKey:@"uid"];
            newReply.replyDetail = [rawReply objectForKey:@"detail"];
            newReply.replyNickname = [rawReply objectForKey:@"nickname"];
            newReply.replyProfilephoto = [rawReply objectForKey:@"profilephoto"];
            newReply.replytime = [rawReply objectForKey:@"time"];
            
            [repliesArray insertObject:newReply atIndex:0];
        }
    }
    NSLog(@"load end");
    return repliesArray;
}

@end
