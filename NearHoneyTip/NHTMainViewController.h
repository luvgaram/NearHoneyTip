//
//  NHTMainViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/15/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHTTipManager;

@interface NHTMainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UIProgressView *tipLoadingProgressBar;
@property (weak, nonatomic) IBOutlet UIView *searchbarContainer;

@property (strong,nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UIRefreshControl *refreshManager;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NHTTipManager *Q1;


- (void)refleshScrollViewDidEndDragging:(UIScrollView *)refreshManager;
- (void)getLatestTips;
- (void)shouldNewTipReload;


@end
