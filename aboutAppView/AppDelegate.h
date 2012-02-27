//
//  AppDelegate.h
//  aboutAppView
//
//  Created by azu on 02/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class AboutAppTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AboutAppTableViewController *viewController;

@property(nonatomic, retain) UINavigationController *navigationController;
@end