// //
// //  SEGPayloadBuilder.m
// //  Segment-Taplytics
// //
// //  Created by William Johnson on 4/26/16.
// //  Copyright © 2016 wcjohnson11. All rights reserved.
// //

#import "SEGPayloadBuilder.h"


@implementation SEGPayloadBuilder

+ (SEGTrackPayload *)track:(NSString *)event
{
    return [[SEGTrackPayload alloc] initWithEvent:event properties:@{} context:@{} integrations:@{}];
}

+ (SEGTrackPayload *)track:(NSString *)event withProperties:(NSDictionary *)properties
{
    return [[SEGTrackPayload alloc] initWithEvent:event properties:properties context:@{} integrations:@{}];
}

+ (SEGScreenPayload *)screen:(NSString *)name
{
    return [[SEGScreenPayload alloc] initWithName:name properties:@{} context:@{} integrations:@{}];
}

+ (SEGIdentifyPayload *)identify:(NSString *)userId
{
    return [[SEGIdentifyPayload alloc] initWithUserId:userId anonymousId:@"" traits:@{} context:@{} integrations:@{}];
}

+ (SEGIdentifyPayload *)identify:(NSString *)userId withTraits:(NSDictionary *)traits
{
    return [[SEGIdentifyPayload alloc] initWithUserId:userId anonymousId:@"" traits:traits context:@{} integrations:@{}];
}

+ (SEGAliasPayload *)alias:(NSString *)newId
{
    return [[SEGAliasPayload alloc] initWithNewId:newId context:@{} integrations:@{}];
}

@end
