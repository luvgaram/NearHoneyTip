//
//  NHTReplyViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTReplyViewController.h"
#import "NHTReply.h"
#import "NHTReplyTableCell.h"
#import "NHTReplyManager.h"

@interface NHTReplyViewController ()

@end

@implementation NHTReplyViewController
NSURLResponse *replResponse;
NSString *replId;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"replyView: %d", [self.NHTRepliesArray count]);
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    replId = [preferences objectForKey:uidIdentifier];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromReply" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}


- (IBAction)sendReply:(id)sender {
    if (self.replyText.text != nil) {
        NHTReply *newReply = [[NHTReply alloc] init];
        newReply.replyTipId = self.NHTReplyTipId;
        newReply.replyUserId = replId;
        newReply.replyDetail = self.replyText.text;
        
        [self postReply:newReply];
    }
}

- (void)postReply: (NHTReply *)reply {
    NSLog(@"start post reply");
    
    NSDictionary* replyDictionary = @{@"tid" : reply.replyTipId, @"uid" : reply.replyUserId, @"detail" : reply.replyDetail};

    NSData* jsondata = [NSJSONSerialization dataWithJSONObject:replyDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    if (jsondata){
        NSString* URLForReply = @"http://54.64.250.239:3000/reply";
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLForReply] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsondata];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        [connection start];
        
        [self connection:connection didReceiveResponse:replResponse];
        NSLog(@"connection end");
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)replResponse {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) replResponse;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    if (code == 200) {
        self.replyText.text = nil;
        NHTReplyManager *replyManager = [[NHTReplyManager alloc] init];
        self.NHTRepliesArray = nil;
        self.NHTRepliesArray = [replyManager replyDidLoad:self.NHTReplyTipId];
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count: %d", [self.NHTRepliesArray count]);
    return [self.NHTRepliesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"replyCell";
    NHTReplyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NHTReplyTableCell alloc] init];
    }
    [cell setCellWithReply:self.NHTRepliesArray[indexPath.row]];
    
    NSLog(@"cell: %@", cell);
    
    return cell;
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
