//
//  LCEUserBioViewController.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEUserBioViewController.h"
#import "LCEUser.h"

@interface LCEUserBioViewController ()

@property ShowSkillsState skillsState;

@end

@implementation LCEUserBioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    LCEUserBioRequestHandler *handler = [LCEUserBioRequestHandler userBioRequestHandlerForSender:self forUser:self.user];
    [handler sendRequest];
    [self refreshLabelsForUser];
    self.skillsState = SkillsHidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestEndedWithData:(id)data forRequest:(NSString *)requestURL
{
    if ([requestURL isEqualToString:@"bio"])
    {
        [self refreshLabelsForUser];
    }
    else if ([requestURL isEqualToString:@"skills"])
    {
        [self.tableView reloadData];
    }
}

- (void)refreshLabelsForUser
{
    self.userIdLabel.text = [self.user userId];
    self.userNameLabel.text = [self.user name];
    self.userAgeLabel.text = [self.user age];
    self.userSexLabel.text = [self.user sex];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self skillsState] == SkillsShowing)
    {
        return [[self.user skills] count] + 1;
    }
    else
    {
        return 1; // For "click to show skills" cell
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([self skillsState] == SkillsShowing)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Hide...";
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell setUserInteractionEnabled:YES];
        }
        else
        {
            NSString *indentedSkillText = [NSString stringWithFormat:@"   %@", [[self.user skills] objectAtIndex:indexPath.row - 1]];
            cell.textLabel.text = indentedSkillText;
            [cell setUserInteractionEnabled:NO];
        }
    }
    else if ([self skillsState] == SkillsHidden)
    {
        cell.textLabel.text = @"Expand...";
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setUserInteractionEnabled:YES];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if ([self skillsState] == SkillsHidden)
    {
        self.skillsState = SkillsShowing;
        
        if ([self.user skills] == nil)
        {
            LCEUserSkillsRequestHandler *handler = [LCEUserSkillsRequestHandler skillsRequestHandlerForSender:self forUser:self.user];
            [handler sendRequest];
        }
        
        [[self tableView] reloadData];
    }
    else if ([self skillsState] == SkillsShowing)
    {
        self.skillsState = SkillsHidden;
        [[self tableView] reloadData];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0)
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
        [UIView setAnimationDuration:0.3];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
}

@end
