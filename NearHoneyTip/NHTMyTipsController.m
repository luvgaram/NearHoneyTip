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
#import "NHTMainTableCell.h"

@interface NHTMyTipsController ()


@end

@implementation NHTMyTipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Q1 = [[NHTTipManager alloc]init];
    [self.Q1 tipsDidLoad];

//    if(self.selectedTip){
//        self.userProfile.image = self.selectedTip.userProfileImg;
//    }
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
#warning Incomplete implementation, return the number of rows
    return [self.Q1 countOfTipCollection];
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    NHTMainTableCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
//    NSLog(@"FOR CELL%@",[self.Q1 objectAtIndex:indexPath.row]);
//    //if([[[self.Q1 objectAtIndex:indexPath.row] class] isKindOfClass: [NSDictionary class]]){
//    NSDictionary *tip = [self.Q1 objectAtIndex:indexPath.row];
//    
//    [cell setCellWithTip:tip];
//    //};
//    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapCell:)];
//    
//    cell.gestureRecognizers = [[NSArray alloc] initWithObjects:tapCellForTipDetail, nil];
//    
//    return cell;
//}

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"List" forIndexPath:indexPath];
//
//    UIImageView * userImage = (UIImage *)[cell viewWithTag:200];
//
//    
//    // Configure the cell...
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
   // Recipe *recipe = [recipes objectAtIndex:indexPath.row];
    
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:recipe.imageFile];
//    
//    UILabel *userNickNameLabel = (UILabel *)[cell viewWithTag:101];
//    recipeNameLabel.text = recipe.name;
//    
//    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
//    recipeDetailLabel.text = recipe.detail;
//    
//    return cell;
    
    
//}


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
