//
//  SEGPayloadBuilder.h
//  Segment-Taplytics
//
//  Created by William Johnson on 4/25/16.
//  Copyright © 2016 wcjohnson11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGAnalytics.h>

@interface SEGPayloadBuilder : NSObject

+ (SEGTrackPayload *)track:(NSString *)event;

+ (SEGTrackPayload *)track:(NSString *)event withProperties:(NSDictionary *)properties;

+ (SEGIdentifyPayload *)identify:(NSString *)userId;

+ (SEGIdentifyPayload *)identify:(NSString *)userId withTraits:(NSDictionary *)traits;

@end
