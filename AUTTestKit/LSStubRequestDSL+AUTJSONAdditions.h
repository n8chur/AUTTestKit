//
//  LSStubRequestDSL+AUTJSONAdditions.h
//  AUTTestKit
//
//  Created by Robert Böhnke on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import <Nocilla/Nocilla.h>

/// Since json serializer typically don't output canonical versions of json,
/// comparing the output of two json serialized string is non-deterministic.
/// Instead, actual json should be parsed and the actual object compared
/// with the expected json dictionary.
/// The purpose of a BodyMatcher is to do exactly that but can be customized
/// if additional work must be done prior to parsing body (such as unzipping
/// data for example)
///
/// body (NSData): the actual body as sent by the sender
/// expectedBody (NSDictionary): the expected json dictionary as defined in a spec
typedef BOOL(^BodyMatcher)(NSData *body, NSDictionary *expectedBody);

/// A method that returns the result of invoking
/// BodyMatcher block with the actual body and the expected one.
///
/// expectedBody (NSDictionary): JSON expected object
/// matcher (BodyMatcher): a block that can decide whether a body matches the expected body
typedef LSStubRequestDSL *(^RequestWithJSONBodyMethod)(NSDictionary *expectedBody, BodyMatcher matcher);

@interface LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON;

@end
