#import <assert.h>
#import <Foundation/NSThread.h>
#import <Foundation/NSOperation.h>
#import "NSNotificationCenter+AnyPromise.h"


@implementation NSNotificationCenter (PromiseKit)

+ (AnyPromise *)once:(NSString *)name {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        __block id identifier = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [[NSNotificationCenter defaultCenter] removeObserver:identifier name:name object:nil];
            resolve(PMKManifold(note, note.userInfo));
        }];
    }];
}

@end
