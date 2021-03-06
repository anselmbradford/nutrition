//
//  NTAppDelegate.m
//  Nutrition Tracker
//
//  Created by Application Developer on 12-12-07.
//  Copyright (c) 2012 Alex Chesser. All rights reserved.
//

#import "NTAppDelegate.h"

@implementation NTAppDelegate
@synthesize addFilter = _addFilter;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.databaseName = @"nutrition_fts3.sqlite";
    self.addFilter = @"";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    NSLog(@"%@",self.databasePath);
      
    self.database = [[FMDatabase alloc] initWithPath:self.databasePath];
    
    return YES;
}

-(NSArray *)getQuery: (NSString *) sql{
    [self.database open];
    sql = @"select * from nut_denorm;";
    FMResultSet *results = [self.database executeQuery:sql];
    NSLog(@"%@",self.database);
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:nil];
    while([results next])
    {
        NSLog(@"Results");
        [arr addObject:[results resultDictionary]];
    }
    [self.database close];
    return arr;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
