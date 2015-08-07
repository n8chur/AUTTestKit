//
//  LSStubRequestDSL+AUTJSONAdditions.m
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "LSStubRequestDSL+AUTJSONAdditions.h"

@implementation LSStubRequestDSL (AUTJSONAdditions)

+ (BodyMatcher)defaultJSONBodyMatcher {
    return ^BOOL(NSData *body, NSDictionary* expectedBody) {
        // parse body into dictionary object
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:body options:0 error:&error];
        if (json == nil || error != nil) {
            return NO;
        }
        
        // compare objects
        return [json isEqualToDictionary:expectedBody];
    };
}

- (RequestWithJSONBodyMethod)withJSON {
    return ^LSStubRequestDSL *(NSDictionary *expectedBody, BodyMatcher bodyMatcher) {
        if (bodyMatcher == nil) {
            bodyMatcher = [self.class defaultJSONBodyMatcher];
            
             return self
                .withHeaders(@{ @"Content-Type": @"application/json" })
                .withBody([[AUTCustomBodyMatcher alloc] initWithExpectedBody:expectedBody customBodyMatcher:bodyMatcher]);
        } else {
            return self
                .withBody([[AUTCustomBodyMatcher alloc] initWithExpectedBody:expectedBody customBodyMatcher:bodyMatcher]);
        }
    };
}

@end
