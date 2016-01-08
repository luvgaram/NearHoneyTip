//
//  NHTSearchResultsTableViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 1/5/16.
//  Copyright © 2016 Mamamoo. All rights reserved.
//

#import "NHTSearchResultsTableViewController.h"
#import "NHTDetailViewController.h"
#import "NHTTipManager.h"
#import "NHTSearchedCellTableViewCell.h"

@interface NHTSearchResultsTableViewController ()

@end

@implementation NHTSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Q1 = [[NHTTipManager alloc]init];
    UITableView *myTableView = [self.view viewWithTag:123];
    
    UITapGestureRecognizer *resignKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(resignKeyboard)];
    
    [myTableView addGestureRecognizer: resignKeyBoard];
    
    
}
-(void) resignKeyboard{
    [self.tableView resignFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"log2222");
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromSearch" object:nil];
}

- (IBAction)goBackToMain:(id)sender {
    NSLog(@"log111111");
    [self viewWillDisappear:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@" TIP Count : %u", [self.Q1 countOfTipCollection]);
    if ([self.Q1 countOfTipCollection] > 0) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"찾는 꿀팁이 이것밖에 없네용 = 3=";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"how many? %u", [self.Q1 countOfTipCollection]);
    return [self.Q1 countOfTipCollection];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"searchCell";
    NHTSearchedCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSLog(@"lala");
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:nil options:nil];
        for (id eachObject in nib) {
            if ([eachObject isKindOfClass:[NHTSearchedCellTableViewCell class]]) {
                cell = eachObject;
                break;
            }
        }
    }
    

    NSLog(@"FOR Searched CELL%@",[self.Q1 objectAtIndex:indexPath.row]);
    //if([[[self.Q1 objectAtIndex:indexPath.row] class] isKindOfClass: [NSDictionary class]]){
    
    NSDictionary *tip = [self.Q1 objectAtIndex:indexPath.row];
    [cell setCellWithTip:tip];
    NSLog(@"FOR Sesarched cell, fin");
    
    //};;
    UITapGestureRecognizer *tapCellForTipDetail = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(didTapCell:)];
    
    cell.gestureRecognizers = [[NSArray alloc] initWithObjects:tapCellForTipDetail, nil];
    
    return cell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancle - backFromSearch");
    [self.navigationController popViewControllerAnimated:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"backFromSearch" object:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"#####3-1%@", sender);
    if ([segue.identifier isEqual:@"showSearchTipDetail"]) {
        
        NHTDetailViewController *tipDetailController = (NHTDetailViewController *)segue.destinationViewController;
        
               
        NSLog(@"#####3-2%@", sender);
        NSLog(@"####sender target? %@",[sender view]);
        NHTSearchedCellTableViewCell *tipCell = [sender view];
        [self.navigationController setNavigationBarHidden:NO animated:nil];
        [tipDetailController.navigationController setNavigationBarHidden:NO animated:nil];
        

        if(tipCell){
            if(tipCell.tip){
                NSLog(@"this is tip %@", tipCell.tip);
                tipDetailController.tip = tipCell.tip;
                
            }
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postNofiticationToMainView) name:@"backFromDetail" object:nil];
        
    }
}


-(void) postNofiticationToMainView{
      [[NSNotificationCenter defaultCenter] postNotificationName: @"backFromSearch" object:nil];
}

- (void) didTapCell:(UITapGestureRecognizer *) recognizer{
    
    NSLog(@"#####1%@", recognizer);
    [self showTipDetail:recognizer];
}
- (IBAction)showTipDetail:(id)sender {
    NSLog(@"#####2%@", sender);
    [self performSegueWithIdentifier:@"showSearchTipDetail" sender:sender];
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
