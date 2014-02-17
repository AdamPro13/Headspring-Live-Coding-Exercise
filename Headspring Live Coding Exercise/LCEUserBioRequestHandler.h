//
//  LCEUserBioRequestHandler.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEBaseRequestHandler.h"
#import "LCEUser.h"

@interface LCEUserBioRequestHandler : LCEBaseRequestHandler

@property (nonatomic, weak) LCEUser *user;

+ (LCEUserBioRequestHandler *)userBioRequestHandlerForSender:(NSObject <LCERequestDelegate> *)sender forUser:(LCEUser *)user;

@end
