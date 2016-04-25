//
//  SEGTaplytics.h
//  
//
//  Created by William Johnson on 4/21/16.
//
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import <Taplytics/Taplytics.h>


@interface SEGTaplyticsIntegration : NSObject <SEGIntegration>

@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, strong) Taplytics *taplytics;

- (instancetype)initWithSettings:(NSDictionary *)settings;

@end