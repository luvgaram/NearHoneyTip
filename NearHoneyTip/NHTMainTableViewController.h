//
//  NHTMainTableViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/18/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTMainTableViewController : UITableViewController

@property (strong, nonatomic) IBOutletCollection(NHTTip) NSArray *tips;

@end
