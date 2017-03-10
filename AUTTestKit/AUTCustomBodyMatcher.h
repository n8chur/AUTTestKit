//
//  AUTCustomBodyMatcher.h
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 7/21/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

@import Foundation;
@import Nocilla;

NS_ASSUME_NONNULL_BEGIN

/// Since json serializer typically don't output canonical versions of json,
/// comparing the output of two json serialized string is non-deterministic.
/// Instead, actual json should be parsed and the actual object compared
/// with the expected json dictionary.
/// The purpose of a BodyMatcher is to do exactly that but can be customized
/// if work should be done prior to parsing body (such as unzipping
/// data for example)
///
/// @param body         The actual body (NSData) as received from a sender
/// @param expectedBody The expected json (NSDictionary)
typedef BOOL(^BodyMatcher)(NSData *body, NSDictionary *expectedBody);

/// A default matcher for a JSON string
extern BodyMatcher const defaultJSONBodyMatcher;

@interface AUTCustomBodyMatcher : NSObject <LSMatcheable>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody;

- (instancetype)initWithExpectedBody:(NSDictionary *)expectedBody customBodyMatcher:(nullable BodyMatcher)bodyMatcher NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
