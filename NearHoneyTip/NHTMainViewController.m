//
//  NHTMainViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 12/15/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainViewController.h"
#import "NHTDetailViewController.h"
#import "NHTTipManager.h"
#import "NHTMainTableCell.h"

@interface NHTMainViewController ()

@end

@implementation NHTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"HEIGHT : %f",self.tableView.bounds.size.height);
    self.refreshManager = [[UIRefreshControl alloc] init];
    self.refreshManager.backgroundColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
    
    //
    [self.tableView addSubview: self.refreshManager];
    [self.refreshManager addTarget:self action:@selector(getLatestTips)forControlEvents:UIControlEventValueChanged];
    
    self.Q1 = [[NHTTipManager alloc]init];
    [self.Q1 tipsDidLoad];
    
    UIButton *newPost = [[self view] viewWithTag:123];
    newPost.layer.cornerRadius = 25;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath){
        return self.tableView.bounds.size.height / 4;
    }
    
    return 150;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self refleshScrollViewDidEndDragging:scrollView];
}
- (void)refleshScrollViewDidEndDragging:(UIScrollView *)refreshManager
{
    CGFloat minOffsetToTriggerRefresh = 50.0f;
    if (refreshManager.contentOffset.y <= -minOffsetToTriggerRefresh) {
        [self.refreshManager sendActionsForControlEvents:UIControlEventValueChanged];
    }
}



- (void)getLatestTips{
    NSLog(@"start to refresh");
    [self.Q1 removeAllTips];
    [self.Q1 tipsDidLoad];
    
    [self.tableView reloadData];
    
    if (self.refreshManager) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshManager.attributedTitle = attributedTitle;
        
        [self.refreshManager endRefreshing];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];
     NSLog(@"end to refresh");
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"the number of cell : %ld", (long)[self.Q1 countOfTipCollection] );
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
        messageLabel.font = [UIFont fontWithName:nil size:20];
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
    if([segue.identifier isEqual:@"showTipDetail"]){
        
        NSLog(@"#####3-2%@", sender);
        NSLog(@"####sender target? %@",[sender view]);
        NHTMainTableCell *tipCell = [sender view];
        
       
        
        if(tipCell){
            NHTDetailViewController *tipDetailController = (NHTDetailViewController *)segue.destinationViewController;
            if(tipCell.tip){
                
                
                NSLog(@"this is tip %@", tipCell.tip);
            
                tipDetailController.tip = tipCell.tip;
            }
        }
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
