//
//  ArrayThreadSafe.m
//  ThreadSafeArray
//
//  Created by Nguyen Le Trong Nhan on 4/26/16.
//  Copyright © 2016 Trong Nhan Nguyen. All rights reserved.
//

#import "ArrayThreadSafe.h"

@interface ArrayThreadSafe()
{
    dispatch_queue_t queue;
    NSMutableArray *arrayList;

}

@end

@implementation ArrayThreadSafe

- (instancetype)init {

    self = [super init];
    if (self) {
    
        queue = dispatch_queue_create([[NSString stringWithFormat:@"com.threadsafe.queue"] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        arrayList = [NSMutableArray new];
    }
    return self;
}


- (void) addObject:(id) anObject{
    
    if (anObject) {
        
        dispatch_barrier_async(queue, ^{
            [arrayList addObject:anObject];
            //NSLog(@"Add Object: %d",[anObject integerValue]);
        });
    }
    
}
- (void)replaceObjectWithObjectAtIndex:(id)anObject AtIndex:(NSInteger)index{
    
    if (anObject) {
        if (arrayList.count > index) {
            dispatch_barrier_async(queue, ^{ 
                [arrayList replaceObjectAtIndex:index withObject:anObject];
                
            });
        }
    }
    
}

- (id) getObjectAtIndex:(NSInteger)index{
    if (arrayList.count > index) {
        __block id object;
        dispatch_sync(queue, ^{
            object = [arrayList objectAtIndex:index];
            //NSLog(@"getObjectAtIndex: %i",[object integerValue]);
        });
        return object;
    } else {
        return @(0);
    }
}
- (NSMutableArray*)getAllObject{
    __block NSMutableArray *array;
    dispatch_sync(queue, ^{
        array = [NSMutableArray arrayWithArray:arrayList];
    });
    return array;

}
- (void)removeAllObject{
    dispatch_barrier_async(queue, ^{
        [arrayList removeAllObjects];
        
    });

}
- (void)removObjectAtIndex:(NSInteger)index{
    
    dispatch_barrier_async(queue, ^{
        if (arrayList.count > index) {
        [arrayList removeObjectAtIndex:index];
        }
        
    });
    
}
- (void)setObjectWithIndex:(id)anObject AtIndex:(NSInteger)index{
    if (anObject) {
        if (arrayList.count > index) {
            dispatch_barrier_async(queue, ^{
                arrayList[index] = anObject;
                
            });
        }
    }
}

@end
