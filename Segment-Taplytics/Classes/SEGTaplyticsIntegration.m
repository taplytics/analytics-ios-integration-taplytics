//
//  SEGTaplyticsIntegration.m
//  
//
//  Created by William Johnson on 4/21/16.
//
//

#import "SEGTaplyticsIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>
#import <Taplytics/Taplytics.h>


@implementation SEGTaplyticsIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        self.settings = settings;

        NSString *apiKey = settings[@"apiKey"];
        [Taplytics startTaplyticsAPIKey:apiKey];
        SEGLog(@"Taplytics startTaplyticsAPIKey:%@", apiKey);
    }
    return self;
}

@end