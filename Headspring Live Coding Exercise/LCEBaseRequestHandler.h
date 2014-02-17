//
//  LCEBaseRequestHandler.h
//  Headspring Live Coding Exercise
//
//  Created by Adam Proschek on 2/17/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCERequestDelegate <NSObject>

- (void)requestEndedWithData:(id)data forRequest:(NSString *)requestURL;

@end

@interface LCEBaseRequestHandler : NSObject

@property (nonatomic, weak) NSObject<LCERequestDelegate> *delegate;
@property (nonatomic, strong) NSString *requestString;

+ (NSString *)baseURL;
- (void)sendRequestWithString:(NSString *)requestURLString;
- (void)requestDidFinishWithData:(id)data;
- (void)sendRequest;

@end
