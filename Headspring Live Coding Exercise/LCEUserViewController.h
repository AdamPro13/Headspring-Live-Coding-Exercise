//
//  LCEUserViewController.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCEUserRequestHandler.h"

@class LCEUser;

@interface LCEUserViewController : UITableViewController <LCERequestDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *searchData;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@property (weak, nonatomic) LCEUser *selectedUser;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) LCEUserRequestHandler *handler;

@end
