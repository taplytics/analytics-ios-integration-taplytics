//
//  SEGTaplyticsIntegration.h
//  
//
//  Created by William Johnson on 4/21/16.
//
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import <Taplytics/Taplytics.h>
#import <SEGTaplyticsWrapper.h>


@interface SEGTaplyticsIntegration : NSObject <SEGIntegration>

@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, strong) Taplytics *taplytics;

- (instancetype)initWithSettings:(NSDictionary *)settings;

- (instancetype)initWithSettings:(NSDictionary *)settings andTaplytics:(Taplytics *)taplytics;

@end