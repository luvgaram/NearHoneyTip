//
//  NHTSearchResultsTableViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 1/5/16.
//  Copyright © 2016 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NHTTipManager;


@interface NHTSearchResultsTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) NHTTipManager *Q1;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) UISearchBar* searchBar;

@property (weak, nonatomic) IBOutlet UILabel *searchString;

- (IBAction)goBackToMain:(id)sender;



-(void)goBackToMain;
@end
