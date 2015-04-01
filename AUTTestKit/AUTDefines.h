//
//  AUTDefines.h
//  AUTTestKit
//
//  Created by Robert Böhnke on 01/04/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#ifndef AUTTestKit_AUTDefines_h
#define AUTTestKit_AUTDefines_h

// Allow the use of nullability attributes while keeping compatibility with
// Xcode 6.1 and 6.2 by simply definig them empty.
#if !(__has_feature(nullability))
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nonnull
#define nullable
#define null_unspecified
#define __nonnull
#define __nullable
#define __null_unspecified
#endif

#endif
