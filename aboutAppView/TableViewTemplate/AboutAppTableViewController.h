//
//  AboutAppTableViewController.h
//  aboutAppView
//
//  Created by azu on 02/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kViewKey = @"viewKey";
static NSString *kCellTextKey = @"cellTextKey";
static NSString *kCellDetailTextKey = @"cellDetailTextKey";
static NSString *kCellAccessoryType = @"cellAccessoryType";
static NSString *kDidSelectBlock = @"kDidSelectBlock";
@interface AboutAppTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *dataSource_;
    NSArray *sectionTitles_;

}

@property(nonatomic, retain) NSArray *dataSource;
@property(nonatomic, retain) NSArray *sectionTitles;


@end
