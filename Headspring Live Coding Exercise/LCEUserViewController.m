//
//  LCEUserViewController.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEUserViewController.h"
#import "LCEUser.h"
#import "LCEUserBioRequestHandler.h"
#import "LCEUserCell.h"

@interface LCEUserViewController ()

@end

@implementation LCEUserViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    self.handler = [LCEUserRequestHandler userRequestHandlerForSender:self];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    searchBar.delegate = self;
    searchBar.showsScopeBar= YES;
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.searchResultsTableView.rowHeight = 70;
    
    searchDisplayController.searchResultsTableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = searchBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    LCEUserRequestHandler *handler = [LCEUserRequestHandler userRequestHandlerForSender:self];
    [handler sendRequest];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
    [self refresh:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [self.users count];
    }
    else
    {
        return [searchData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LCEUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[LCEUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (tableView == self.tableView)
    {
        cell.user = [self.users objectAtIndex:indexPath.row];
        cell.textLabel.text = [cell.user userId];
    }
    else // From search bar
    {
        cell.user = [searchData objectAtIndex:indexPath.row];
        cell.textLabel.text = [cell.user userId];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    [self performSegueWithIdentifier:@"UserSelection" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (0.5*M_PI), 0.0, 0.7, 0.4);
        rotation.m34 = 1.0/ -600;
        
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.5];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
}

#pragma mark - Request delegate

- (void)requestEndedWithData:(id)data forRequest:(NSString *)requestURL
{
    self.users = data;
    [self.tableView reloadData];
}

#pragma mark - Search bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

#pragma mark - Search display delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text];
    
    return YES;
}

#pragma mark - Helper methods

- (void)refresh:(id)sender
{
    [self.handler sendRequest];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)filterContentForSearchText:(NSString *)searchText
{
    [searchData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.userId contains[c] %@", searchText];
    searchData = [NSMutableArray arrayWithArray:[self.users filteredArrayUsingPredicate:predicate]];
}

#pragma mark - View controller delegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LCEUserBioRequestHandler *destination = segue.destinationViewController;
    destination.user = [((LCEUserCell *)sender) user];
}

@end
