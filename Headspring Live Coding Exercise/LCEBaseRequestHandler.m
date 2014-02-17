//
//  LCEBaseRequestHandler.m
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "LCEBaseRequestHandler.h"

@implementation LCEBaseRequestHandler

+ (NSString *)baseURL
{
    return @"http://headspring-rest.herokuapp.com/";

}

- (void)sendRequestWithString:(NSString *)requestURLString
{
    NSURL *requestURL  = [NSURL URLWithString:requestURLString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestDidFinishWithData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failure");
    }];
    [operation start];
}

- (void)requestDidFinishWithData:(id)results
{
//    Empty - Define for children
}

- (void)sendRequest
{
//    Empty - Define for children
}

@end
