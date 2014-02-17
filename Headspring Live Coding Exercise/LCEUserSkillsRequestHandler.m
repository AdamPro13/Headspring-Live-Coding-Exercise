//
//  LCEUserSkillsRequestHandler.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEUserSkillsRequestHandler.h"
#import "LCEUser.h"

@implementation LCEUserSkillsRequestHandler

+ (LCEUserSkillsRequestHandler *)skillsRequestHandlerForSender:(NSObject <LCERequestDelegate> *)sender forUser:(LCEUser *)user
{
    LCEUserSkillsRequestHandler *handler = [LCEUserSkillsRequestHandler alloc];
    handler.delegate = sender;
    handler.requestString = [NSString stringWithFormat:@"%@users/user/%@/skills", [self baseURL], user.userId];
    handler.user = user;
    
    return handler;
}

- (void)requestDidFinishWithData:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *skills = [[NSMutableArray alloc] init];
        
        for (NSString *key in data)
        {
            NSDictionary *skillsDictionary = [data valueForKey:key];
            for (NSString *skillKey in skillsDictionary)
            {
                [skills addObject:[skillsDictionary valueForKey:skillKey]];
            }
        }
        
        self.user.skills = skills;
        
        [self.delegate requestEndedWithData:skills forRequest:@"skills"];
    }
}

- (void)sendRequest
{
    [self sendRequestWithString:self.requestString];
}

@end
