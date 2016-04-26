//  OCHamcrest by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 hamcrest.org. See LICENSE.txt

#import "HCCollect.h"

#import "HCWrapInMatcher.h"

/*!
 * @abstract Returns an array of wrapped items from a variable-length comma-separated list
 * terminated by <code>nil</code>.
 * @discussion Each item is transformed by passing it to the specified <em>wrap</em> function.
 */
static NSArray * HCCollectWrappedItems(id item, va_list args, id (*wrap)(id))
{
    NSMutableArray *list = [NSMutableArray arrayWithObject:wrap(item)];

    id nextItem = va_arg(args, id);
    while (nextItem)
    {
        [list addObject:wrap(nextItem)];
        nextItem = va_arg(args, id);
    }

    return list;
}

static id passThrough(id value)
{
    return value;
}

NSArray * HCCollectItems(id item, va_list args)
{
    return HCCollectWrappedItems(item, args, passThrough);
}

NSArray * HCCollectMatchers(id item, va_list args)
{
    return HCCollectWrappedItems(item, args, HCWrapInMatcher);
}

NSArray * HCWrapIntoMatchers(NSArray *items)
{
    NSMutableArray *matchers = [[NSMutableArray alloc] init];
    for (id item in items)
        [matchers addObject:HCWrapInMatcher(item)];
    return matchers;
}
