//
//  ArrayThreadSafe.h
//  ThreadSafeArray
//
//  Created by Nguyen Le Trong Nhan on 4/26/16.
//  Copyright © 2016 Trong Nhan Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayThreadSafe : NSObject

- (void)addObject:(id)anObject;
- (id) getObjectAtIndex:(NSInteger)index;
- (void)replaceObjectWithObjectAtIndex:(id)anObject AtIndex:(NSInteger)index;
- (NSMutableArray*)getAllObject;
- (void)removeAllObject;
@end
