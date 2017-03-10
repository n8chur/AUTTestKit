//
//  AUTCustomBodyMatcher.m
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 7/21/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "AUTExtObjC.h"
#import "AUTCustomBodyMatcher.h"

#import "LSStubRequestDSL+AUTJSONAdditions.h"

NS_ASSUME_NONNULL_BEGIN

BodyMatcher const defaultJSONBodyMatcher = ^(NSData *body, NSDictionary *expectedBody) {
    // Parse body into dictionary object
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:body options:0 error:&error];
    if (json == nil || ![json isKindOfClass:NSDictionary.class]) return NO;
    
    // compare objects
    return [json isEqualToDictionary:expectedBody];
};

@interface AUTCustomBodyMatcher ()

@property (nonatomic, copy) NSDictionary *expectedBody;
@property (nonatomic, copy) BodyMatcher bodyMatcher;

@end

@implementation AUTCustomBodyMatcher

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody {
    AUTAssertNotNil(expectedBody);

    return [self initWithExpectedBody:expectedBody customBodyMatcher:nil];
}

- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody customBodyMatcher:(nullable BodyMatcher)bodyMatcher {
    AUTAssertNotNil(expectedBody);

    self = [super init];

    _expectedBody = expectedBody;
    _bodyMatcher = AUTNotNil([bodyMatcher ?: defaultJSONBodyMatcher copy]);

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

NS_ASSUME_NONNULL_END
