//
//  LSStubResponseDSL+AUTJSONAdditions.m
//  AUTAPIClient
//
//  Created by Sylvain Rebaud on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "LSStubResponseDSL+AUTJSONAdditions.h"

@implementation LSStubResponseDSL (AUTJSONAdditions)

- (ResponseWithJSONBodyMethod)withJSON {
    return ^(id body) {
        NSError *error;
        let data = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
        NSAssert(data != nil, @"Could not serialize %@, received error: %@", body, error);

        return self
            .withHeaders(@{ @"Content-Type": @"application/json" })
            .withBody(data);
    };
}

- (ResponseWithJSONBodyMethod)withJSONString {
    return ^(NSString *body) {
        NSParameterAssert([body isKindOfClass:NSString.class]);
        
        let data = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSAssert(data != nil, @"Could not convert %@ to data", body);
        
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSAssert(jsonObj != nil, @"Invalid JSON string %@, received error: %@", body, error);
        
        return self
            .withHeaders(@{ @"Content-Type": @"application/json" })
            .withBody(data);
    };
}

@end
