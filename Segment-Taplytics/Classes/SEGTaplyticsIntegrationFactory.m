//
//  SEGTaplyticsIntegrationFactory.m
//  
//
//  Created by William Johnson on 4/25/16.
//
//

#import "SEGTaplyticsIntegrationFactory.h"
#import "SEGTaplyticsIntegration.h"
#import <Taplytics/Taplytics.h>

@implementation SEGTaplyticsIntegrationFactory

+ (id)instance
{
    static dispatch_once_t once;
    static SEGTaplyticsIntegration *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGTaplyticsIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"Taplytics";
}

@end