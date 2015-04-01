//
//  LSStubResponseDSL+AUTJSONAdditions.h
//  AUTAPIClient
//
//  Created by Robert Böhnke on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#import <Nocilla/Nocilla.h>

typedef LSStubResponseDSL *(^ResponseWithJSONBodyMethod)(id);

@interface LSStubResponseDSL (AUTJSONAdditions)

- (ResponseWithJSONBodyMethod)withJSON;

@end
