//
//  LCEUserRequestHandler.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCEBaseRequestHandler.h"

@interface LCEUserRequestHandler : LCEBaseRequestHandler

+ (LCEUserRequestHandler *)userRequestHandlerForSender:(NSObject <LCERequestDelegate> *)sender;

@end
