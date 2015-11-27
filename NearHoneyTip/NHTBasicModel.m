//
//  NHTBasicModel.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 27..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTBasicModel.h"

@implementation NHTBasicModel

- (NSDictionary *)convertJsonToDict:(NSString *)json {
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:nil];
    
    return dictionary;
}

- (NSArray *)convertJsonToArray:(NSString *)json {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    return array;
}

- (NSDate *)convertDateStringToNSDate:(NSString*) dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yy-MM-dd HH:mm";
    NSDate *date = [dateFormat dateFromString:dateString];
    
    return date;
}

@end
