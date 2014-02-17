//
//  LCEUserBioRequestHandler.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEUserBioRequestHandler.h"

@implementation LCEUserBioRequestHandler

+ (LCEUserBioRequestHandler *)userBioRequestHandlerForSender:(NSObject <LCERequestDelegate> *)sender forUser:(LCEUser *)user
{
    LCEUserBioRequestHandler *handler = [LCEUserBioRequestHandler alloc];
    handler.delegate = sender;
    handler.requestString = [NSString stringWithFormat:@"%@users/user/%@/bio", [self baseURL], user.userId];
    handler.user = user;
    
    return handler;
}

- (void)requestDidFinishWithData:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        for (NSString *key in data)
        {
            if ([key isEqualToString:@"bio"])
            {
                NSDictionary *userBioInfo = [data valueForKey:key];
                
                self.user.name = [userBioInfo valueForKey:@"name"];
                self.user.age = [userBioInfo valueForKey:@"age"];
                self.user.sex = [userBioInfo valueForKey:@"sex"];
            }
        }
        
        [self.delegate requestEndedWithData:self.user forRequest:@"bio"];
    }
}

- (void)sendRequest
{
    [self sendRequestWithString:self.requestString];
}

@end
