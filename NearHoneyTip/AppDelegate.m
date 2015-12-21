//
//  AppDelegate.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/4/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSUserDefaults *preferences;
NSURLResponse *response;
NSMutableData *data;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //NSLog(@"hi!!!!: " );
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self setUserDefault];
    return YES;
}

- (void)setUserDefault{
    
    NSLog(@"start set uuid");
    preferences = [NSUserDefaults standardUserDefaults];
    //[preferences removeObjectForKey:@"UserDefault"];
    NSString *uidIdentifier = @"UserDefault";
    
    if([preferences objectForKey:uidIdentifier] == nil) {
        
        [self getAdvertisingIdentifier];
        [preferences setObject:self.sUDID forKey: uidIdentifier];
        [self postUid: self.sUDID];
        const BOOL didSave = [preferences synchronize];
        NSLog(@"save result : %hhd", didSave);
    }
    
    NSLog(@"uuid: %@", [preferences objectForKey:uidIdentifier]);
}


-(void) getAdvertisingIdentifier {
   // NSLog(@"log1 " );
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
   // NSLog(@"log 1.25 : %@", ASIdentifierManagerClass);
    id identity = [[ASIdentifierManagerClass alloc] init];
    NSLog(@"log 1.5 : %@",identity);
    if (ASIdentifierManagerClass) {
        NSLog(@"log2 " );
        id identifierManager = [ASIdentifierManagerClass sharedManager];
        if ([ASIdentifierManagerClass instancesRespondToSelector:@selector(advertisingIdentifier)]) {
            NSLog(@"log3 " );
            id adID = [identifierManager performSelector:@selector(advertisingIdentifier)];
            self.sUDID = [adID performSelector:@selector(UUIDString)]; // you can use this sUDID as an alternative to UDID
            NSLog(@"log4 %@ ", self.sUDID );
            
        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)recievedData {
    [data appendData:recievedData];
//    NSArray *loadedTipsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *user = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
//    NSLog(@"user: %lu", (unsigned long)loadedTipsArray.count);
    NSLog(@"user: %@", user);
    
//    if (loadedTipsArray != NULL) {
    if (user != NULL) {
//        NSDictionary* user = loadedTipsArray[0];

        NSLog(@"usernickname: %@, profilephoto: %@", [user objectForKey:@"nickname"], [user objectForKey:@"profilephoto"]);
        
        [preferences setObject:[user objectForKey:@"nickname"] forKey:@"userNickname"];
        [preferences setObject:[user objectForKey:@"profilephoto"] forKey:@"userProfileImagePath"];
        [preferences synchronize];
        
    }
}

- (void)postUid:(NSString*)postUid {
    
    // modified by ej
    
    NSDictionary* uidDictionary = @{@"uid" : postUid};
    
    NSData* jsondata = [NSJSONSerialization dataWithJSONObject:uidDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    if (jsondata){
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.64.250.239:3000/users"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsondata];
        
        NSLog(@"start posting uid");
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self];
        [connection start];
        
        [self connection:connection didReceiveResponse:response];
        [self connection:connection didReceiveData:data];
        
        NSLog(@"connection end");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "org.nhnnext.NearHoneyTip" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NearHoneyTip" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NearHoneyTip.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
