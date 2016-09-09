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
        self.taplyticsClass = [Taplytics class];

        NSMutableDictionary *options = 	[[NSMutableDictionary alloc] init];
        [options setValue:[self delayLoad] forKey:@"delayLoad"];
        [options setValue:[self shakeMenu] forKey:@"shakeMenu"];
        [options setValue:[self pushSandbox] forKey:@"pushSandbox"];
        [options setValue:[self taplyticsOptionSessionBackgroundTime] forKey:@"sessionBackgroundTime"];
        
        [self.taplyticsClass startTaplyticsAPIKey:apiKey options:settings];
        SEGLog(@"[[Taplytics startTaplyticsAPIKey:%@ options:%@]]", apiKey, settings);
    }
    return self;
}

- (instancetype)initWithSettings:(NSDictionary *)settings andTaplytics:(Class)taplyticsClass
{
    if (self = [super init]) {
        self.settings = settings;
        self.taplyticsClass = taplyticsClass;
    }
    return self;
}

+ (NSDictionary *)map:(NSDictionary *)dictionary withAttributes:(NSArray *)attributes
{
    NSMutableDictionary *mapped = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSMutableDictionary *customData = [NSMutableDictionary dictionaryWithDictionary:@{}];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *original, NSString *new, BOOL *stop) {
        if (![attributes containsObject:original]) {
            id data = mapped[original];
            [mapped removeObjectForKey:original];
            [customData setObject:data forKey:original];
        }
    }];
    
    if(customData.count) {
        [mapped setObject:customData forKey:@"customData"];
    }
    
    return [mapped copy];
}



- (void)identify:(SEGIdentifyPayload *)payload
{
    NSArray *taplyticsAttributes = @[@"user_id", @"name", @"firstName", @"lastName", @"email", @"age", @"gender", @"avatarUrl"];
    
    NSMutableDictionary *mutablePayload = [NSMutableDictionary dictionaryWithDictionary:payload.traits];
    [mutablePayload setValue:payload.userId forKey:@"user_id"];
    
    NSDictionary *mappedTraits = [SEGTaplyticsIntegration map:mutablePayload withAttributes:taplyticsAttributes];
    [self.taplyticsClass setUserAttributes: mappedTraits];
    SEGLog(@"[[Taplytics sharedInstance] setUserAttributes:%@]", mappedTraits);
    
    
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
    NSMutableDictionary *mutablePayload = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
    
    NSNumber *revenue = [SEGTaplyticsIntegration extractRevenue:payload.properties withKey:@"revenue"];
    if (revenue) {
        [mutablePayload removeObjectForKey:@"revenue"];
        
        [self.taplyticsClass logRevenue: payload.event revenue: revenue metaData: mutablePayload];
        SEGLog(@"[[Taplytics sharedInstance] logRevenue:%@ revenue:%@ parameters:%@]", payload.event, revenue, mutablePayload);
        return;
    }

    NSNumber *value = [SEGTaplyticsIntegration extractValue:payload.properties withKey:@"value"];
    if (value) {
        [mutablePayload removeObjectForKey:@"value"];
        
        [self.taplyticsClass logEvent: payload.event value: value metaData: mutablePayload];
        SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ value:%@ parameters:%@]", payload.event, value, mutablePayload);
        return;
    }
    
    [self.taplyticsClass logEvent:payload.event value:nil metaData:payload.properties];
    SEGLog(@"[[Taplytics sharedInstance] logEvent:%@ value:nil metaData:%@]", payload.event, payload.properties);
}

- (void)reset
{
    SEGLog(@"Taplytics resetUser");
    [self.taplyticsClass resetUser:nil];
}

- (NSString *)apiKey
{
    return self.settings[@"apiKey"];
}

- (NSNumber *)delayLoad
{
    return (NSNumber *)[self.settings objectForKey:@"delayLoad"];
}

- (NSNumber *)taplyticsOptionSessionBackgroundTime
{
    return (NSNumber *)[self.settings objectForKey:@"sessionMinutes"];
}

- (NSNumber *)shakeMenu
{
    return (NSNumber *)[self.settings objectForKey:@"shakeMenu"];
}

- (NSNumber *)pushSandbox
{
    return (NSNumber *)[self.settings objectForKey:@"pushSandbox"];
}

@end
