//
//  AboutAppTableViewController.m
//  aboutAppView
//
//  Created by azu on 02/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "AboutAppTableViewController.h"
#import "CustomCellBackground.h"


@interface AboutAppTableViewController ()

- (void)_updateNavigationItemAnimated:(BOOL)animated;

- (void)_updateToolbarItemsAnimated:(BOOL)animated;

- (void)_updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end

@implementation AboutAppTableViewController

@synthesize dataSource = dataSource_;
@synthesize sectionTitles = sectionTitles_;


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self){
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Update Navigation
    [self _updateNavigationItemAnimated:animated];
    [self _updateToolbarItemsAnimated:animated];

    // deselect cell
    NSIndexPath *indexPath;
    indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

    //  update visible cells
    for (UITableViewCell *cell in [self.tableView visibleCells]){
        [self _updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//--------------------------------------------------------------//
#pragma mark -- ViewOutlets Update --
//--------------------------------------------------------------//

- (void)_updateNavigationItemAnimated:(BOOL)animated {
}

- (void)_updateToolbarItemsAnimated:(BOOL)animated {
    // Show Navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)_updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    // left text
    cell.textLabel.text = [[[self.dataSource objectAtIndex:(NSUInteger) indexPath.section] objectAtIndex:indexPath.row]
                                             valueForKey:kCellTextKey];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    // right text
    cell.detailTextLabel.text = [[[self.dataSource objectAtIndex:(NSUInteger) indexPath.section]
                                                   objectAtIndex:indexPath.row]
                                                   valueForKey:kCellDetailTextKey];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    // cell accessoryType
    id accessoryType = [[[self.dataSource
        objectAtIndex:(NSUInteger) indexPath.section]
        objectAtIndex:indexPath.row]
        valueForKey:kCellAccessoryType];

    if (accessoryType){
        if ([accessoryType isKindOfClass:[NSNumber class]]){
            cell.accessoryType = (UITableViewCellAccessoryType) [accessoryType integerValue];
        } else if ([accessoryType isKindOfClass:[NSString class]]){
            // cell accessoryMail
            if ([accessoryType isEqual:@"mail"]){
                UIImage *mailImage = [UIImage imageNamed:@"mail_icon.png"];
                UIImageView *mailImageView = [[UIImageView alloc] initWithImage:mailImage];
                mailImageView.frame = CGRectMake(0, 0, 50, 50);
                cell.accessoryView = mailImageView;
                [mailImageView release], mailImageView = nil;
            }
        }

    }
}



//--------------------------------------------------------------//
#pragma mark -- UITableViewDataSource --
//--------------------------------------------------------------//
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitles objectAtIndex:section];
}

// Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}
// Section -> Row
- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section {

    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // get Cells
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (!cell){
        cell = [[[UITableViewCell alloc]
                                  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableCell"]
                                  autorelease];
        cell.backgroundView = [[[CustomCellBackground alloc] init] autorelease];

        cell.selectedBackgroundView = [[[CustomCellBackground alloc] init] autorelease];
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        cell.detailTextLabel.highlightedTextColor = [UIColor blueColor];
    }
    UIView *view = [[[self.dataSource objectAtIndex:(NSUInteger) indexPath.section] objectAtIndex:indexPath.row]
                                      valueForKey:kViewKey];
    if (view){
        [cell.contentView addSubview:view];
    }

    [self _updateCell:cell atIndexPath:indexPath];

    return cell;
}

//--------------------------------------------------------------//
#pragma mark -- UITableViewDelegate --
//--------------------------------------------------------------//

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    void (^block)(NSIndexPath *);
    block = [[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]
                               objectForKey:kDidSelectBlock];
    if (block){
        block(indexPath);
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [dataSource_ release], dataSource_ = nil;
    [sectionTitles_ release], sectionTitles_ = nil;
    [super dealloc];
}
@end
