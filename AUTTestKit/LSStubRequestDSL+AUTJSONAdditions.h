//
//  LSStubRequestDSL+AUTJSONAdditions.h
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

@import Nocilla;

#import "AUTCustomBodyMatcher.h"

NS_ASSUME_NONNULL_BEGIN

/// A method that returns the result of invoking
/// BodyMatcher block with the actual body and the expected one.
///
/// @param expectedBody The expected json (NSDictionary)
/// @param matcher      A BodyMatcher block that returns YES if a body matches
///                     the expected body.
typedef LSStubRequestDSL * _Nonnull (^RequestWithJSONBodyMethod)(NSDictionary * expectedBody, BodyMatcher _Nullable matcher);

@interface LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON;

@end

NS_ASSUME_NONNULL_END
