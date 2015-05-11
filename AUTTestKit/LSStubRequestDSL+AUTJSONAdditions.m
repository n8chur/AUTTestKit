//
//  LSStubRequestDSL+AUTJSONAdditions.m
//  AUTTestKit
//
//  Created by Robert Böhnke on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "LSStubRequestDSL+AUTJSONAdditions.h"

#pragma mark - AUTCustomBodyMatcher

@interface AUTCustomBodyMatcher : NSObject <LSMatcheable>

@property (nonatomic) id expectedBody;
@property (nonatomic, copy) BodyMatcher bodyMatcher;

@end

@implementation AUTCustomBodyMatcher

- (instancetype)initWithExpectedBody:(id)body customBodyMatcher:(BodyMatcher)bodyMatcher {
    self = [super init];
    
    if (self) {
        _expectedBody = body;
        _bodyMatcher  = bodyMatcher;
    }
    return self;
}

- (LSMatcher *)matcher {
    // LSMatcher protocol is not exposed publicly so cast is needed
    return (id)self;
}

- (BOOL)matchesData:(NSData *)data {
    // pass the actual data and the expected body to custom body matcher block
    return self.bodyMatcher(data, self.expectedBody);
}

@end

#pragma mark - LSStubRequestDSL

@implementation LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON {
    return ^(id body, BodyMatcher bodyMatcher) {
        if (bodyMatcher == nil) {
            bodyMatcher = ^BOOL(NSData *body, NSDictionary* expectedBody) {
                // parse body into dictionary object
                NSError *error = nil;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:body options:0 error:&error];
                if (json == nil || error != nil) {
                    return NO;
                }
                
                // compare objects
                return [json isEqualToDictionary:expectedBody];
            };
            
             return self
                .withHeaders(@{ @"Content-Type": @"application/json" })
                .withBody([[AUTCustomBodyMatcher alloc] initWithExpectedBody:body customBodyMatcher:bodyMatcher]);
        } else {
            return self
                .withBody([[AUTCustomBodyMatcher alloc] initWithExpectedBody:body customBodyMatcher:bodyMatcher]);
        }
    };
}

@end
