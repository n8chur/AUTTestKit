//
//  AUTCustomBodyMatcher.m
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 7/21/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import "AUTCustomBodyMatcher.h"
#import "LSStubRequestDSL+AUTJSONAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@interface AUTCustomBodyMatcher ()

@property (nonatomic) NSDictionary *expectedBody;
@property (nonatomic, copy) BodyMatcher bodyMatcher;

@end

@implementation AUTCustomBodyMatcher

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Use the designated initializer instead" userInfo:nil];
}

- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody {
    NSParameterAssert(expectedBody != nil);

    return [self initWithExpectedBody:expectedBody customBodyMatcher:[LSStubRequestDSL defaultJSONBodyMatcher]];
}
- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody customBodyMatcher:(BodyMatcher)bodyMatcher {
    NSParameterAssert(expectedBody != nil);

    self = [super init];
    
    if (self) {
        _expectedBody = expectedBody;
        _bodyMatcher  = [bodyMatcher copy];
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

NS_ASSUME_NONNULL_END
