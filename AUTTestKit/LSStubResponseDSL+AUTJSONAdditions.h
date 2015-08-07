//
//  LSStubResponseDSL+AUTJSONAdditions.h
//  AUTAPIClient
//
//  Created by Sylvain Rebaud on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

@import Nocilla;

typedef LSStubResponseDSL *(^ResponseWithJSONBodyMethod)(id);

@interface LSStubResponseDSL (AUTJSONAdditions)

- (ResponseWithJSONBodyMethod)withJSON;

@end
