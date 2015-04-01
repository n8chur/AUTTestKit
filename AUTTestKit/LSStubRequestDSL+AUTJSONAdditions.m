//
//  LSStubRequestDSL+AUTJSONAdditions.m
//  AUTTestKit
//
//  Created by Robert Böhnke on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "LSStubRequestDSL+AUTJSONAdditions.h"

@implementation LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON {
    return ^(id body) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];

        NSAssert(data != nil, @"Could not serialize %@, received error: %@", body, error.localizedDescription);

        return self
            .withHeaders(@{ @"Content-Type": @"application/json" })
            .withBody(data);
    };
}

@end
