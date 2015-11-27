//
//  NHTBasicModel.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 27..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHTBasicModel : NSObject

- (NSDate *)convertDateStringToNSDate:(NSString*)dateString;
- (NSArray *)convertJsonToArray:(NSString *)json;
- (NSDictionary *)convertJsonToDict:(NSString *)json;

@end
