//
//  NHTMainViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/15/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainViewController.h"
#import "NHTDetailViewController.h"
#import "NHTReplyViewController.h"
#import "NHTTipManager.h"
#import "NHTMainTableCell.h"
#import "NHTSearchResultsTableViewController.h"
#import "NHTMapViewController.h"
#import "NHTReply.h"
#import "NHTTip.h"
#import "NHTReplyManager.h"

@interface NHTMainViewController (){
    NHTSearchResultsTableViewController *vc;
}

@end

@implementation NHTMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"HEIGHT : %f",self.tableView.bounds.size.height);
    self.refreshManager = [[UIRefreshControl alloc] init];
    self.refreshManager.backgroundColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
    
    [self.tableView addSubview: self.refreshManager];
    [self.refreshManager addTarget:self action:@selector(getLatestTips)forControlEvents:UIControlEventValueChanged];

    self.Q1 = [[NHTTipManager alloc]init];
   [self.Q1 tipsDidLoad];
    
    UIButton *newPost = [[self view] viewWithTag:123];
    newPost.layer.cornerRadius = (newPost.layer.bounds.size.width / 1.75);
    
    self.tipLoadingProgressBar.hidden = YES;
    
    
    //self.searchController.delegate = self;
    /*
     UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"NHTSearch"];
     */
   UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"NHTSearch"];
    //searchResultsController.hidesBarsOnTap = YES;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    
    
    /* //let it be
    self.searchbarContainer = [[UIView alloc] initWithFrame:self.searchController.searchBar.frame];
   [self.searchbarContainer addSubview:self.searchController.searchBar];
    */
    
    
    //Use the current view controller to update the search results.
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    
    //self.searchController.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //self.navigationItem.titleView =  self.searchController.searchBar;
    //searchResultsController.navigationItem.titleView = self.searchController.searchBar;
   
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,
                                                       self.searchController.searchBar.frame.origin.y,
                                                       self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.tintColor = [[UIColor alloc]initWithRed: 230.0/255.0 green:126.0/255.0 blue:35.0/255.0 alpha:1];
    //[self.view addSubview: self.searchController.searchBar];
    
    //self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
    
    // It is usually good to set the presentation context.
    self.searchController.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
//   self.searchController.obscuresBackgroundDuringPresentation = NO;
  
    
 
    self.navigationItem.titleView =  self.searchController.searchBar;
 
    vc = (NHTSearchResultsTableViewController *)searchResultsController.visibleViewController;
    
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    vc.searchString.text = searchController.searchBar.text;
    NSString *searchString = self.searchController.searchBar.text;
    NSLog(@"LOG 1 :%@", searchString);
    
    [self.Q1 updateFilteredContentForTipStoreName:searchString];
   
    if (self.searchController.searchResultsController) {
      
        
         NSLog(@"LOG 3 ");
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
        
        // Present SearchResultsTableViewController as the topViewController
//       NHTSearchResultsTableViewController *vc = (NHTSearchResultsTableViewController *)navController.visibleViewController;

        
    
        [vc.Q1 tipsDidLoadWithSearchResults: self.Q1.searchResults];
        
        
        // And reload the tableView with the new data
        [vc.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLatestTips) name:@"backFromSearch" object:nil];
      
    }
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath){
        return self.tableView.bounds.size.height / 4;
    }
    
    return 150;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self refleshScrollViewDidEndDragging:scrollView];
}
- (void)refleshScrollViewDidEndDragging:(UIScrollView *)refreshManager {
    CGFloat minOffsetToTriggerRefresh = 50.0f;
    if (refreshManager.contentOffset.y <= -minOffsetToTriggerRefresh) {
        NSLog(@"USER refresh");
        [self.refreshManager sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)getLatestTips {
    NSLog(@"start to refresh");
    [self.Q1 removeAllTips];
    [self.Q1 tipsDidLoad];
    
    [self.tableView reloadData];
    
    if (self.refreshManager) {
        NSLog(@"@yes");
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshManager.attributedTitle = attributedTitle;
        
        [self.refreshManager endRefreshing];
    }
    NSLog(@"end to refresh");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"the number of cell : %ld", (long)[self.Q1 countOfTipCollection] );
    
        return [self.Q1 countOfTipCollection];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.Q1 countOfTipCollection] > 0) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"꿀팁 없다 '~'\n당신이 일빠로 꿀팁을 올려보는 건 어때요 ?0?";
        messageLabel.textColor = [[UIColor alloc]initWithRed: 230.0/255.0 green:126.0/255.0 blue:35.0/255.0 alpha:1];
        messageLabel.numberOfLines = 2;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:nil size:17];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NHTMainTableCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    NSLog(@"FOR CELL%@",[self.Q1 objectAtIndex:indexPath.row]);
    //if([[[self.Q1 objectAtIndex:indexPath.row] class] isKindOfClass: [NSDictionary class]]){
    
    
   
    NSDictionary *tip = [self.Q1 objectAtIndex:indexPath.row];
    [cell setCellWithTip:tip];
    

    //};
    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapCell:)];
    
    cell.gestureRecognizers = [[NSArray alloc] initWithObjects:tapCellForTipDetail, nil];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"#####3-1%@", sender);
    if ([segue.identifier isEqual:@"showTipDetail"]) {
        NHTDetailViewController *tipDetailController = (NHTDetailViewController *)segue.destinationViewController;

        NSLog(@"#####3-2%@", sender);
        NSLog(@"####sender target? %@",[sender view]);
        NHTMainTableCell *tipCell = [sender view];

        if(tipCell){
            if(tipCell.tip){
                NSLog(@"this is tip %@", tipCell.tip);
                tipDetailController.tip = tipCell.tip;
            }           
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLatestTips) name:@"backFromDetail" object:nil];
        
    } else if ([segue.identifier isEqualToString:@"newTip"]) {
       
        self.tipLoadingProgressBar.hidden = NO;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldNewTipReload) name:@"backFromWrite" object:nil];
        
    } else if ([segue.identifier isEqualToString:@"showNearMap"]) {
        NHTMapViewController *mapViewController = (NHTMapViewController *)segue.destinationViewController;
        mapViewController.tipCollection = self.Q1.tipCollection;
    } else if ([segue.identifier isEqualToString:@"showRepliesFromMain"]) {
        NSString *tipID = [sender valueForKey:@"stringTag"];
        
        NHTReplyViewController *replyController = (NHTReplyViewController *)segue.destinationViewController;
        
        NHTReplyManager* replyManager = [[NHTReplyManager alloc] init];
        replyController.NHTRepliesArray = [replyManager replyDidLoad:tipID];
        replyController.NHTReplyTipId = tipID;
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLatestTips) name:@"backFromReply" object:nil];
    }
}

-(void) shouldNewTipReload{
    
    [self.tipLoadingProgressBar setProgress:0.4 animated:YES];
    NSLog(@"start to refresh");
    [self.Q1 removeAllTips];
     [self.tipLoadingProgressBar setProgress:0.6 animated:YES];
    [self.Q1 tipsDidLoad];
    [self.tipLoadingProgressBar setProgress:0.8 animated:YES];
    [self.tableView reloadData];
    
    [self.tipLoadingProgressBar setProgress:1.0 animated:YES];
    
    NSLog(@"end of refresh");
    if(self.tipLoadingProgressBar.progress == 1.0){
        self.tipLoadingProgressBar.hidden = YES;
    }
    
}
- (void) didTapCell:(UITapGestureRecognizer *) recognizer{
    
    NSLog(@"#####1%@", recognizer);
    [self showTipDetail:recognizer];
}
- (IBAction)showTipDetail:(id)sender {
    NSLog(@"#####2%@", sender);
    [self performSegueWithIdentifier:@"showTipDetail" sender:sender];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
