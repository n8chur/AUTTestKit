//
//  LSStubRequestDSL+AUTJSONAdditions.h
//  AUTTestKit
//
//  Created by Robert Böhnke on 01/04/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

#import <Nocilla/Nocilla.h>

typedef LSStubRequestDSL *(^RequestWithJSONBodyMethod)(id);

@interface LSStubRequestDSL (AUTJSONAdditions)

- (RequestWithJSONBodyMethod)withJSON;

@end
