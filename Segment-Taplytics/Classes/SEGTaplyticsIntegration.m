//
//  SEGTaplyticsIntegration.m
//  
//
//  Created by William Johnson on 4/21/16.
//
//

#import "SEGTaplyticsIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>


@implementation SEGTaplyticsIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        self.settings = settings;
        NSString *apiKey = [settings objectForKey:@"apiKey"];
        self.taplytics = [Taplytics startTaplyticsAPIKey:apiKey];
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
        } else if ([revenueProperty isKindOfClass:[NSNumber class]]) {
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
        NSString *value = [SEGTaplyticsIntegration extractValue:payload.properties withKey:@"value"];
        NSNumber *revenue = [SEGTaplyticsIntegration extractRevenue:payload.properties withKey:@"revenue"];
        if (value) {
            [Taplytics logEvent: payload.event value: [value doubleValue] metaData: payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ value:%@ parameters:%@]", payload.event, payload.value, payload.properties);
        }
        if (revenue) {
            [Taplytics logRevenue: payload.event revenue: [revenue doubleValue] metaData: payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logRevenue:%@ revenue:%@ parameters:%@]", payload.event, revenue, payload.properties);
        }
        if (!value && !revenue) {
            [Taplytics logEvent:payload.event
                          parameters:payload.properties];
            SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ parameters:%@]", payload.event, payload.properties);
        }
    }];
}

- (void)reset
{
    [self flush];
    
    [Taplytics resetUser];
    SEGLog(@"[[Taplytics sharedInstance] resetUser]");
}