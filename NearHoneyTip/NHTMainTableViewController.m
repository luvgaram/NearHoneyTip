//
//  NHTMainTableViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/18/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainTableViewController.h"

@interface NHTMainTableViewController ()

@end

@implementation NHTMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *tipLoad = [NSURL URLWithString:@"http://54.64.250.239:3000/tip/all"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:tipLoad];
    NSLog(@"%@", jsonData);
    
    NSError *error = nil;
    
    self.tips = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSLog(@"%@",self.tips);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.tips count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    NSDictionary *tip = [self.tips objectAtIndex:indexPath.row];
    
    /* view tag number 
        (assign it view-orderly: top to bottom, left to right)
        0 - tipImage
        1 - storeName
        2 - tipDetails
        3 - userProfileImg
        4 - userNickname
        5 - tipDate
        6 - userBadge
        7 - likeButton
        8 - commentButton
     */
    
    UIImageView *tipImage = (UIImageView *)[cell viewWithTag:0];
    tipImage.image =[tip objectForKey:@"file.name"];
    UILabel *storeName = (UILabel *)[cell viewWithTag:1];
    storeName.text = [tip valueForKey:@"storename"];
    UITextView *tipDetails = (UITextView *)[cell viewWithTag:2];
    tipDetails.text = [tip valueForKey:@"tipdetail"];
    UIImageView *userProfileImg = (UIImageView *)[cell viewWithTag:3];
    //userProfileImg.image = [tip valueForKey: @"profilePhoto"];
    UILabel *userNickname = (UILabel *)[cell viewWithTag:4];
    userNickname.text = [tip valueForKey:@"nickname"];
    UILabel *tipDate = (UILabel *)[cell viewWithTag:5];
    tipDate.text = [tip valueForKey: @"date"];

    
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
