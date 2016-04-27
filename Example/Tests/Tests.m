//
//  Segment-TaplyticsTests.m
//  Segment-TaplyticsTests
//
//  Created by wcjohnson11 on 04/25/2016.
//  Copyright (c) 2016 wcjohnson11. All rights reserved.
//

// https://github.com/Specta/Specta

SpecBegin(InitialSpecs)

describe(@"SEGTaplyticsIntegrationFactory", ^{
    it(@"factory creates integration with empty settings", ^{
        SEGTaplyticsIntegration *integration = [[SEGTaplyticsIntegrationFactory instance] createWithSettings:@{
        } forAnalytics:nil];
        
        expect(integration.settings).to.equal(@{});
    });
});

describe(@"SEGTaplyticsIntegrationFactory", ^{
    it(@"factory creates integration with basic settings", ^{
        SEGTaplyticsIntegration *integration = [[SEGTaplyticsIntegrationFactory instance] createWithSettings:@{
            @"apiKey" : @"foo"
        } forAnalytics:nil];
        
        expect(integration.settings).to.equal(@{ @"apiKey" : @"foo" });
    });
});

describe(@"SEGTaplyticsIntegration", ^{
    __block Class mockTaplytics;
    __block SEGTaplyticsIntegration *integration;
    
    beforeEach(^{
        mockTaplytics = mockClass([Taplytics class]);
        integration = [[SEGTaplyticsIntegration alloc] initWithSettings:@{} andTaplytics:mockTaplytics];
    });
    
    it(@"reset", ^{
        [integration reset];
        
        [verify(mockTaplytics) resetUser:nil];
    });
});

SpecEnd

