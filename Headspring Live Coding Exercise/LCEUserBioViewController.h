//
//  LCEUserBioViewController.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCEUserBioRequestHandler.h"
#import "LCEUserSkillsRequestHandler.h"

@class LCEUser;

typedef enum ShowSkillsState : NSInteger ShowSkillsState;
enum ShowSkillsState : NSInteger
{
    SkillsShowing,
    SkillsHidden
};

@interface LCEUserBioViewController : UIViewController <LCERequestDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) LCEUser *user;
@property (strong, nonatomic) IBOutlet UILabel *userIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userAgeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userSexLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
