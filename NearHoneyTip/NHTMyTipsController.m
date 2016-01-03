//
//  NHTMyTipsController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTMyTipsController.h"
#import "NHTTip.h"
#import "NHTDetailViewController.h"
#import "NHTTipManager.h"
#import "NHTMytipsTableCell.h"

@interface NHTMyTipsController ()


@end

@implementation NHTMyTipsController
NSString *prefUid;
NSString *prefNickname;
NSString *prefProfilephoto;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Q1 = [[NHTTipManager alloc]init];
    [self.Q1 mytipsDidLoad];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    prefUid = [preferences objectForKey:@"UserDefault"];
    prefNickname = [preferences objectForKey:@"userNickname"];
    prefProfilephoto = [preferences objectForKey:@"userProfileImagePath"];
    NSLog(@"userViewDidLoad: %@", prefUid);
    NSLog(@"userViewDidLoad: %@", prefNickname);
    NSLog(@"my tip Q1: %@", self.Q1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"the number of cell : %ld", (long)[self.Q1 countOfTipCollection] );
    return [self.Q1 countOfTipCollection];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MytipCell";
    NHTMytipsTableCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    NSLog(@"FOR CELL%@",[self.Q1 objectAtIndex:indexPath.row]);
    //if([[[self.Q1 objectAtIndex:indexPath.row] class] isKindOfClass: [NSDictionary class]]){
    
    NSLog(@"myTip indexPath.row: %d", indexPath.row);
    
    NHTTip *tip = [self.Q1 objectAtIndex:indexPath.row];

    NHTTip *newTip = tip;
    newTip.userNickname = prefNickname;
    newTip.userProfileImg = prefProfilephoto;
    
    NSLog(@"my newTip: %@", newTip.storeName);
    NSLog(@"my newTip: %@", newTip.userNickname);
    
    [cell setCellWithUserTip:newTip];
    //};
    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapCell:)];
    
    cell.gestureRecognizers = [[NSArray alloc] initWithObjects:tapCellForTipDetail, nil];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
