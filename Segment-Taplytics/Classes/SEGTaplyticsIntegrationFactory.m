//
//  SEGTaplyticsIntegrationFactory.m
//  
//
//  Created by William Johnson on 4/25/16.
//
//

#import "SEGTaplyticsIntegrationFactory.h"
#import "SEGTaplyticsIntegration.h"

@implementation SEGTaplyticsIntegrationFactory

+ (instancetype)instance
{
    static dispatch_once_t once;
    static SEGTaplyticsIntegrationFactory *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
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