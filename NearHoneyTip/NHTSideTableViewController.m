//
//  NHTSideTableViewController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTSideTableViewController.h"
#import "NHTTip.h"
#import "NHTMyTipsController.h"
#import "NHTAlarmsController.h"
#import "NHTProfileController.h"



@interface NHTSideTableViewController ()


@end

@implementation NHTSideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(self.selectedTip){
        self.userProfile.image = self.selectedTip.userProfileImg;
        self.userProfile.layer.cornerRadius = 25;
        self.userNickname.text = self.selectedTip.userNickname;
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)showMyTips:(id)sender{
    NHTMyTipsController * showMyTipsButton = [[NHTMyTipsController alloc]initWithNibName:nil bundle: nil];
//    NHTMyTipsController *showMyTipsButton = (NHTMyTipsController *)[self.storyboard instantiateViewControllerWithIdentifier:@"myTips"];
  
    showMyTipsButton.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:showMyTipsButton animated:YES completion:nil];
 //    NSLog(@"click the button well");
    

} 
  
- (IBAction)showAlarm:(id)sender{
    NHTAlarmsController * showMyAlarmButton = [[NHTAlarmsController alloc]initWithNibName:nil bundle: nil];

    showMyAlarmButton.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:showMyAlarmButton animated:YES completion:nil];

}
- (IBAction)setProfile:(id)sender{
    NHTProfileController * setMyProfileButton = [[NHTProfileController alloc]initWithNibName:nil bundle: nil];
    
    setMyProfileButton.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:setMyProfileButton animated:YES completion:nil];

}




#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 5;
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//        static NSString *CellIdentifier = @"Cell";

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userProfileCell", @"userNicknameCell", @"myTipCell", @"AlarmCell", @"setProfileCell" forIndexPath:indexPath];

//    UITableViewCell *cell = [tableView registerClass:  forCellReuseIdentifier :@"userProfileCell" forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userProfileCell" forIndexPath:indexPath];

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userNicknameCell" forIndexPath:indexPath];
//    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"myTipCell" forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmCell" forIndexPath:indexPath];
//    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"setProfileCell" forIndexPath:indexPath];
//    
    
//    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(userProfileCell:)];
//    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(AlarmCell:)];
    
//    cell.gestureRecognizers = [[NSArray alloc] initWithObjects:tapCellForTipDetail, nil];
//
//    return cell;
//}


//- (void) didTapCell:(UITapGestureRecognizer *) recognizer{
//    NSLog(@"#####1%@", recognizer);
//    [self showTipDetail:recognizer];
//}
//- (IBAction)showTipDetail:(id)sender {
//    NSLog(@"#####2%@", sender);
//    [self performSegueWithIdentifier:@"showTipDetail" sender:sender];
//}

//- (void) didTapuserProfileCell:(UITapGestureRecognizer *) recognizer{
//    NSLog(@"#####1%@", recognizer);
//    [self showMyTips:recognizer];
//
//- (IBAction)showMyTips:(id)sender {
//    [self performSegueWithIdentifier:@"showMyTips" sender:sender];




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
