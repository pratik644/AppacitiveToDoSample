//
//  AppDelegate.m
//  Let's Do
//
//  Created by Pratik on 15-05-14.
//  Copyright (c) 2014 appacitive. All rights reserved.
//

#import "AppDelegate.h"
#import <Appacitive/AppacitiveSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Appacitive registerAPIKey:@"YOUR_API_KEY" useLiveEnvironment:NO];
    [[APLogger sharedLogger] enableLogging:YES];
    [[APLogger sharedLogger] enableVerboseMode:YES];
    return YES;
}

@end
