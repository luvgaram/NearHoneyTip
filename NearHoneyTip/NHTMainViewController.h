//
//  NHTMainViewController.h
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/15/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHTTipManager;

@interface NHTMainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, UISearchResultsUpdating,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *tipLoadingProgressBar;
@property (strong,nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UIRefreshControl *refreshManager;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NHTTipManager *Q1;


- (void)refleshScrollViewDidEndDragging:(UIScrollView *)refreshManager;
- (void)getLatestTips;
- (void)shouldNewTipReload;

-(void) setupSearchBar;
@end
