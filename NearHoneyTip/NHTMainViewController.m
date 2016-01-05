//
//  NHTMainViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/15/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainViewController.h"
#import "NHTDetailViewController.h"
#import "NHTReplyTableViewController.h"
#import "NHTTipManager.h"
#import "NHTMainTableCell.h"
#import "NHTMapViewController.h"
#import "NHTReply.h"
#import "NHTTip.h"

@interface NHTMainViewController (){
     NSArray *searchResults;
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
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:self];
    // Use the current view controller to update the search results.
    searchController.searchResultsUpdater = self;
    // Install the search bar as the table header.
    self.navigationItem.titleView = searchController.searchBar;
    // It is usually good to set the presentation context.
    self.definesPresentationContext = YES;
   
    
}

/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
*/

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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [self.Q1 countOfTipCollection];
    }
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
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
       [cell setCellWithTip:[searchResults objectAtIndex:indexPath.row]];
    } else {
        NSDictionary *tip = [self.Q1 objectAtIndex:indexPath.row];
        [cell setCellWithTip:tip];
    }
   
    
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
        } /* //wil be deleted
           else if (targetCell){
            NHTMainTableCell * cell = (NHTMainTableCell*)targetCell;
            if(cell.tip){
                NSLog(@"this is tip %@", cell.tip);
                tipDetailController.tip = cell.tip;
            }
        }
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLatestTips) name:@"backFromDetail" object:nil];
        
    } else if ([segue.identifier isEqualToString:@"newTip"]) {
       
        self.tipLoadingProgressBar.hidden = NO;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldNewTipReload) name:@"backFromWrite" object:nil];
        
    } else if ([segue.identifier isEqualToString:@"showNearMap"]) {
        NHTMapViewController *mapViewController = (NHTMapViewController *)segue.destinationViewController;
        mapViewController.tipCollection = self.Q1.tipCollection;
    } else if ([segue.identifier isEqualToString:@"showRepliesFromMain"]) {
        NSString *tipID = [sender valueForKey:@"stringTag"];
        [self loadReply:tipID];
        
        NHTReplyTableViewController *replyController = (NHTReplyTableViewController *)segue.destinationViewController;
        replyController.NHTReplies = [self loadReply:tipID];
        
    }
}

- (NSArray *)loadReply:(NSString *)tid{
    NSMutableArray *repliesArray = [[NSMutableArray alloc] init];
    
    NSString *baseURL = @"http://54.64.250.239:3000/reply/_id=";
    baseURL = [baseURL stringByAppendingString:tid];
    
    NSURL *replyURL = [NSURL URLWithString: baseURL];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:replyURL];
    
    if (jsonData) {
        NSError *error = nil;
        NSArray *loadedRepliesArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        NSUInteger replyCount = loadedRepliesArray.count;
        
        NSLog(@"replyCount: %d", replyCount);
        
        for (int i = 0; i < replyCount; i++){
            NSDictionary *rawReply = loadedRepliesArray[i];
            NHTReply *newReply = [[NHTReply alloc] init];
            newReply.replyId = [rawReply objectForKey:@"_id"];
            newReply.replyTipId = [rawReply objectForKey:@"tid"];
            newReply.replyUserId = [rawReply objectForKey:@"uid"];
            newReply.replyDetail = [rawReply objectForKey:@"detail"];
            newReply.replyNickname = [rawReply objectForKey:@"nickname"];
            newReply.replyProfilephoto = [rawReply objectForKey:@"profilephoto"];
            newReply.replytime = [rawReply objectForKey:@"time"];
            
            [repliesArray addObject:newReply];
        }
    }
    NSLog(@"load end");
    return repliesArray;
};


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


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [self.Q1 filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
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
