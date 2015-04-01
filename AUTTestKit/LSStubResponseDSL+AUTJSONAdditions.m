//
//  LSStubResponseDSL+AUTJSONAdditions.m
//  AUTAPIClient
//
//  Created by Robert Böhnke on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#import "LSStubResponseDSL+AUTJSONAdditions.h"

@implementation LSStubResponseDSL (AUTJSONAdditions)

- (ResponseWithJSONBodyMethod)withJSON {
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
