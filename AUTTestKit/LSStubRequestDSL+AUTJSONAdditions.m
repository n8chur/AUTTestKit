//
//  LSStubRequestDSL+AUTJSONAdditions.m
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"

#import "LSStubRequestDSL+AUTJSONAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON {
    return ^ LSStubRequestDSL * (NSDictionary *expectedBody, BodyMatcher _Nullable bodyMatcher) {
        NSParameterAssert(expectedBody != nil);
        
        let withBody = self.withBody([[AUTCustomBodyMatcher alloc] initWithExpectedBody:expectedBody customBodyMatcher:bodyMatcher]);

        if (bodyMatcher != nil) return withBody;
        
        return withBody.withHeaders(@{ @"Content-Type": @"application/json" });
    };
}

@end

NS_ASSUME_NONNULL_END
