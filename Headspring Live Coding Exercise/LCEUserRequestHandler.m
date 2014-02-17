//
//  LCEUserRequestHandler.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEUserRequestHandler.h"
#import "LCEUser.h"

@implementation LCEUserRequestHandler

+ (LCEUserRequestHandler *)userRequestHandlerForSender:(NSObject <LCERequestDelegate> *)sender
{
    LCEUserRequestHandler *handler = [LCEUserRequestHandler alloc];
    handler.delegate = sender;
    handler.requestString = [NSString stringWithFormat:@"%@users", [self baseURL]];
    
    return handler;
}

- (void)requestDidFinishWithData:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *allUsers = [[NSMutableArray alloc] init];
        
        for (NSString *key in data)
        {
            NSArray *users = [data valueForKey:key];
            for (NSString *userInfo in users)
            {
                LCEUser *user = [[LCEUser alloc] init];
                user.userId = userInfo;
                [allUsers addObject:user];
            }
        }
        
        [self.delegate requestEndedWithData:allUsers forRequest:self.requestString];
    }
}

- (void)sendRequest
{
    [self sendRequestWithString:self.requestString];
}

@end
