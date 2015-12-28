//
//  NHTButtonTapPost.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/22/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHTButtonTapPost : NSObject


-(void)postLikeChangeMethod:(NSString*)methodString Tip:(NSString*)tipId;
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

@end
