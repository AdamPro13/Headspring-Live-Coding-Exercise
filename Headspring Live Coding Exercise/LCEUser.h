//
//  LCEUser.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCEUser : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSMutableArray *skills;

@end
