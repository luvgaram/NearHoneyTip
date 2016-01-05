//
//  NHTSearchResultsTableViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 1/5/16.
//  Copyright © 2016 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NHTTipManager;

@interface NHTSearchResultsTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NHTTipManager *Q1;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
