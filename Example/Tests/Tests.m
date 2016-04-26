//
//  Segment-TaplyticsTests.m
//  Segment-TaplyticsTests
//
//  Created by wcjohnson11 on 04/25/2016.
//  Copyright (c) 2016 wcjohnson11. All rights reserved.
//

// https://github.com/Specta/Specta
//
#import "SEGPayloadBuilder.h"

SpecBegin(InitialSpecs)

describe(@"Taplytics Integration", ^{
    __block SEGTaplyticsIntegration *integration;
    __block Taplytics *taplytics;

    beforeEach(^{
        taplytics = mock([Taplytics class]);

        integration = [[SEGTaplyticsIntegration alloc] initWithSettings:@{

        } andTaplytics:taplytics];
    });
    
});

describe(@"these will fail", ^{

    it(@"can do maths", ^{
        expect(1).to.equal(2);
    });

    it(@"can read", ^{
        expect(@"number").to.equal(@"string");
    });
    
    it(@"will wait for 10 seconds and fail", ^{
        waitUntil(^(DoneCallback done) {
        
        });
    });
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^{
        waitUntil(^(DoneCallback done) {
            done();
        });
    });
});

SpecEnd

