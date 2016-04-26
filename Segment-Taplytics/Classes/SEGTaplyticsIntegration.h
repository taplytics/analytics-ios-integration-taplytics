//
//  SEGTaplyticsIntegration.h
//  
//
//  Created by William Johnson on 4/21/16.
//
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>


@interface SEGTaplyticsIntegration : NSObject <SEGIntegration>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;

@end