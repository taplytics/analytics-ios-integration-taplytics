SpecBegin(InitialSpecs);

describe(@"SEGTaplyticsIntegrationFactory", ^{
    it(@"factory creates integration with empty settings", ^{
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

    it(@"track", ^{
        SEGTrackPayload *payload = [[SEGTrackPayload alloc] initWithEvent:@"Foo" properties:@{} context:@{} integrations:@{}];

        [integration track:payload];

        [verify(mockTaplytics) logEvent:@"Foo" value:nil metaData:@{}];
    });
});

SpecEnd
