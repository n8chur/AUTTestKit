//
//  SPTExampleGroup+AUTNocillaAdditions.m
//  AUTAPIClient
//
//  Created by Robert Böhnke on 24/02/15.
//  Copyright (c) 2015 Automatic Labs. All rights reserved.
//

#import <objc/runtime.h>
@import Nocilla;

#import "SPTExampleGroup+AUTNocillaAdditions.h"

@interface SPTExampleGroup (Private)

- (void)runBeforeAllHooks:(NSString *)compiledName;

- (void)runAfterEachHooks:(NSString *)compiledName;

- (void)runAfterAllHooks:(NSString *)compiledName;

@end

static void AUTSwapSelectors(SEL old, SEL new) {
    Method original, swizzled;
    original = class_getInstanceMethod(SPTExampleGroup.class, old);
    swizzled = class_getInstanceMethod(SPTExampleGroup.class, new);

    if (original != NULL) {
        method_exchangeImplementations(original, swizzled);
    }
}

@implementation SPTExampleGroup (AUTNocillaAdditions)

+ (void)load {
    AUTSwapSelectors(@selector(runBeforeAllHooks:), @selector(aut_runBeforeAllHooks:));
    AUTSwapSelectors(@selector(runAfterEachHooks:), @selector(aut_runAfterEachHooks:));
    AUTSwapSelectors(@selector(runAfterAllHooks:), @selector(aut_runAfterAllHooks:));
}

- (void)aut_runBeforeAllHooks:(NSString *)compiledName {
    [self aut_runBeforeAllHooks:compiledName];

    [LSNocilla.sharedInstance start];
}

- (void)aut_runAfterEachHooks:(NSString *)compiledName {
    [self aut_runAfterEachHooks:compiledName];

    [LSNocilla.sharedInstance clearStubs];
}

- (void)aut_runAfterAllHooks:(NSString *)compiledName {
    [self aut_runAfterAllHooks:compiledName];

    [LSNocilla.sharedInstance stop];
}

@end
