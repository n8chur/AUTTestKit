//
//  LSStubRequestDSL+AUTJSONAdditionsSpec.m
//  AUTTestKit
//
//  Created by Sylvain Rebaud on 7/21/15.
//  Copyright (c) 2015 Automatic. All rights reserved.
//

@import Specta;
@import Nocilla;
@import Expecta;
@import AUTTestKit;

#import "AUTExtObjC.h"

SpecBegin(LSStubRequestDSL_AUTJSONAdditions)

describe(@"when both data are equal", ^{
    it(@"should match", ^{
        let matcher = defaultJSONBodyMatcher;
        expect(matcher).notTo.beNil();
        
        let body = [@"{\"foo\":\"bar\", \"bar\":\"foo\"}" dataUsingEncoding:NSUTF8StringEncoding];
        expect(matcher(body, @{ @"foo": @"bar", @"bar": @"foo" })).to.beTruthy();
        expect(matcher(body, @{ @"bar": @"foo", @"foo": @"bar" })).to.beTruthy();
    });
});

describe(@"when both data are different", ^{
    it(@"should not match", ^{
        let matcher = defaultJSONBodyMatcher;
        expect(matcher).notTo.beNil();
        
        let body = [@"{\"foobar\":\"bar\", \"barfoo\":\"foo\"}" dataUsingEncoding:NSUTF8StringEncoding];
        expect(matcher(body, @{ @"foo": @"bar", @"bar": @"foo" })).to.beFalsy();
    });
});

SpecEnd
