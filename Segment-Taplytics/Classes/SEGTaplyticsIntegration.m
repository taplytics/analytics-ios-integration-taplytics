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
        NSString *apiKey = [settings objectForKey:@"apiKey"];
        [Taplytics startTaplyticsAPIKey:apiKey];
    }
    return self;
}

- (instancetype)initWithSettings:(NSDictionary *)settings andTaplytics:(Taplytics *)taplytics
{
    if (self = [super init]) {
        self.settings = settings;
        self.taplytics = taplytics;
    }
    return self;
}

+ (NSNumber *)extractValue:(NSDictionary *)dictionary withKey:(NSString *)valueKey
{
    id valueProperty = nil;
    
    for (NSString *key in dictionary.allKeys) {
        if ([key caseInsensitiveCompare:valueKey] == NSOrderedSame) {
            valueProperty = dictionary[key];
            break;
        }
    }
    
    if (valueProperty) {
        if ([valueProperty isKindOfClass:[NSString class]]) {
            // Format the value.
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            return [formatter numberFromString:valueProperty];
        } else if ([valueProperty isKindOfClass:[NSNumber class]]) {
            return valueProperty;
        }
    }
    return nil;
}

+ (NSNumber *)extractRevenue:(NSDictionary *)dictionary withKey:(NSString *)revenueKey
{
    id revenueProperty = nil;
    
    for (NSString *key in dictionary.allKeys) {
        if ([key caseInsensitiveCompare:revenueKey] == NSOrderedSame) {
            revenueProperty = dictionary[key];
            break;
        }
    }
    
    if (revenueProperty) {
        if ([revenueProperty isKindOfClass:[NSString class]]) {
            // Format the revenue.
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            return [formatter numberFromString:revenueProperty];
        } else if ([revenueProperty isKindOfClass:[NSNumber class]]) {
            return revenueProperty;
        }
    }
    return nil;
}

- (void)track:(SEGTrackPayload *)payload
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        // Revenue & value tracking
        NSNumber *value = [SEGTaplyticsIntegration extractValue:payload.properties withKey:@"value"];
        NSNumber *revenue = [SEGTaplyticsIntegration extractRevenue:payload.properties withKey:@"revenue"];
        if (value) {
            [Taplytics logEvent: payload.event value: value metaData: payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ value:%@ parameters:%@]", payload.event, value, payload.properties);
        }
        if (revenue) {
            [Taplytics logRevenue: payload.event revenue: revenue metaData: payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logRevenue:%@ revenue:%@ parameters:%@]", payload.event, revenue, payload.properties);
        }
        if (!value && !revenue) {
            [Taplytics logEvent:payload.event value:nil metaData:payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ value:nil metaData:%@]", payload.event, payload.properties);
        }
    }];
}

- (void)reset
{
    [self flush];
    
    [Taplytics resetUser:^{
      SEGLog(@"Taplytics resetUser");
    }];
}

@end
