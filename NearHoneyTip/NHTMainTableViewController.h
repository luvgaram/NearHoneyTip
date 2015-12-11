//
//  NHTMainTableViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/18/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ADSupport/ASIdentifierManager.h>
@class NHTTipManager;

@interface NHTMainTableViewController : UITableViewController

@property (strong, nonatomic) NHTTipManager *Q1;

@property (strong, nonatomic) NSString *sUDID;

- (void)getAdvertisingIdentifier;
@end
