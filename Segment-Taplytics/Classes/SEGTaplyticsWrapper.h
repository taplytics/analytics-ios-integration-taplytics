
#import <Foundation/Foundation.h>


@interface SEGTaplyticsWrapper : NSObject

- (instancetype)startTaplyticsAPIKey:(NSDictionary *)settings;

- (void)logEvent:(NSString *)event value:(NSNumber *)eventValue metaData:(NSDictionary *)eventProps;

- (void)logRevenue:(NSString *)event revenue:(NSNumber *)eventRevenue metaData:(NSDictionary *)eventProps;

- (void)resetUser;

@end