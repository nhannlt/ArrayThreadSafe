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

    if (anObject) { // 1
        dispatch_barrier_async(queue, ^{ // 2
            [arrayList addObject:anObject]; // 3
           
        });
    }
    
}
- (void)replaceObjectWithObjectAtIndex:(id)anObject AtIndex:(NSInteger)index{

    if (anObject) { // 1
        dispatch_barrier_async(queue, ^{ // 2
            [arrayList replaceObjectAtIndex:index withObject:anObject];
            
        });
    }

}

- (id) getObjectAtIndex:(NSInteger)index{

    __block id object;
    dispatch_sync(queue, ^{
        object = [arrayList objectAtIndex:index];
    });
    return object;


}
- (NSMutableArray*)getAllObject{
    __block NSMutableArray *array; // 1
    dispatch_sync(queue, ^{ // 2
        array = [NSMutableArray arrayWithArray:arrayList]; // 3
    });
    return array;

}
- (void)removeAllObject{
    dispatch_barrier_async(queue, ^{ // 2
        [arrayList removeAllObjects]; // 3
        
    });

}

@end
