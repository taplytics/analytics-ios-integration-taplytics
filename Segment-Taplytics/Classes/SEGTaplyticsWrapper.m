#import "SEGTaplyticsWrapper.h"
#import <Taplytics/Taplytics.h>

@implementation SEGTaplyticsWrapper

- (instancetype)initWithSettings:(NSString *)apiKey options:(NSDictionary *) settings
{
    if (self = [super init]) {
        [Taplytics startTapltyicsAPIKey:apiKey options:@{settings}];
    }
    return self;
}

- (void)logEvent:(NSString *)event value:(NSNumber *)eventValue metaData:(NSDictionary *)eventProps
{
	[Taplytics logEvent: event value: eventValue metaData: eventProps];
}

- (void)Revenue:(NSString *)event revenue:(NSNumber *)eventRevenue metaData:(NSDictionary *)eventProps
{
	[Taplytics logRevenue: event revenue: eventRevenue metaData: eventProps];
}

- (void)resetUser
{
    [Taplytics resetUser];
}


@end