//
//  AppDelegate.m
//  aboutAppView
//
//  Created by azu on 02/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

#import "AboutAppTableViewController.h"
#import "LicenseWebViewController.h"

@interface AppDelegate ()

- (void)showMailComposeView;

- (void)pushWebView;

@end

@implementation AppDelegate {
@private
    UINavigationController *navigationController_;
}


@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController = navigationController_;


- (void)dealloc {
    [_window release];
    [_viewController release];
    [navigationController_ release], navigationController_ = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Section Names
    NSArray *sectionTitles = [NSArray arrayWithObjects:@"About App", @"Other", nil];

// make data for each section
    NSString *appNameString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *) kCFBundleNameKey];
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *) kCFBundleVersionKey];
    NSArray *section1;
    section1 = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                                              @"App Name", kCellTextKey,
                                              appNameString, kCellDetailTextKey,
                                              nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:
                                              @"Version", kCellTextKey,
                                              versionString, kCellDetailTextKey,
                                              nil],
                            nil];
    NSArray *section2;
    section2 = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                                              @"License", kCellTextKey,
                                              Block_copy(^(NSIndexPath *indexPath) {
                                                  [self pushWebView];
                                              }), @"block",
                                              [NSNumber
                                                  numberWithInteger:UITableViewCellAccessoryDetailDisclosureButton],
                                              kCellAccessoryType,
                                              nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:
                                              @"Question?", kCellTextKey,
                                              Block_copy(^{
                                                  [self showMailComposeView];
                                              }), @"block",
                                              @"mail", kCellAccessoryType,
                                              nil],
                            nil];
    NSArray *sections = [NSArray arrayWithObjects:section1, section2, nil];


    self.viewController = [[[AboutAppTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    self.viewController.dataSource = sections;
    self.viewController.sectionTitles = sectionTitles;
    // Navigation Controller
    self.navigationController = [[[UINavigationController alloc]
                                                          initWithRootViewController:self.viewController] autorelease];
    // window
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - MFMailComposeViewController Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result
        error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - for Blocks method
- (void)showMailComposeView {
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    NSArray *toRecipients = [NSArray arrayWithObject:@"mail@example.com"];
    [mailController setSubject:@"Mail Support"];
    [mailController setToRecipients:toRecipients];
    mailController.mailComposeDelegate = self;

    if ([MFMailComposeViewController canSendMail]){
        [self.navigationController presentModalViewController:mailController animated:YES];
    }

    [mailController release], mailController = nil;
}

- (void)pushWebView {
    LicenseWebViewController *webViewController;
    webViewController = [[LicenseWebViewController alloc] init];

    NSString *path = [[NSBundle mainBundle]
                                pathForResource:@"license" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest
        requestWithURL:[NSURL fileURLWithPath:path]];
    [self.navigationController
        pushViewController:webViewController animated:YES];
    //move -> load
    [webViewController.webView loadRequest:request];
    [webViewController release], webViewController = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */

}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */

}

@end

