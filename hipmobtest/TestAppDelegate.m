//
//  TestAppDelegate.m
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import "TestAppDelegate.h"

#import "TestViewController.h"

@implementation TestAppDelegate
#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[TestViewController alloc] initWithNibName:@"TestViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[TestViewController alloc] initWithNibName:@"TestViewController_iPad" bundle:nil];
    }
    // Check if ARC is enabled: if it is, don't bother with the release/retain bits
#if !__has_feature(objc_arc)
    [self.window autorelease];
    [self.viewController autorelease];
#endif
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // and, push notification registration and setup
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // see if we launched from a Hipmob push notifications
    if([launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey]){
        // came from a push
        NSDictionary * userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if([@"com.hipmob.push.NEW_MESSAGE" isEqualToString:(NSString *)[userInfo valueForKey:@"action"]]){
            [(TestViewController *)self.viewController setMessageWaitingIndicator:[(NSDictionary *)[userInfo valueForKey:@"aps"] valueForKey:@"badge"]];
        }
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)tokenValue {
    // save the token: we'll need it for the Hipmob usage later
    [(TestViewController *)self.viewController setToken:[NSData dataWithData:tokenValue]];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error in registration: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if([@"com.hipmob.push.NEW_MESSAGE" isEqualToString:(NSString *)[userInfo valueForKey:@"action"]]){
        [(TestViewController *)self.viewController setMessageWaitingIndicator:[(NSDictionary *)[userInfo valueForKey:@"aps"] valueForKey:@"badge"]];
    }
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
