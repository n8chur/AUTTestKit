//
//  SPTExampleGroup+AUTNocillaAdditions.h
//  AUTAPIClient
//
//  Created by Robert Böhnke on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

//#import <Specta/SPTExampleGroup.h>

// It's a private class so we need to redeclare it here.
@interface SPTExampleGroup : NSObject

@end

/// Loading this category will automatically start Nocilla stubs before all
/// specs run, clear them before each spec is run and stop them after all specs
/// have run.
@interface SPTExampleGroup (AUTNocillaAdditions)

@end
